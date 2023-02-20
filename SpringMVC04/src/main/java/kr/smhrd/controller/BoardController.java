package kr.smhrd.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.smhrd.entity.Board;
import kr.smhrd.entity.Criteria;
import kr.smhrd.entity.PageMaker;
import kr.smhrd.mapper.BoardMapper;

@Controller
public class BoardController{ // new BoardController();

	@Autowired
	private BoardMapper mapper;
	// /boardList.do --> Method
	@RequestMapping("/boardList.do")
	public String boardList(Criteria cri,Model model){
		List<Board> list=mapper.boardList(cri);
		model.addAttribute("list", list);
        // 페이징 처리에 필요한 값을 계산
		PageMaker pm=new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(mapper.totalCount());
		model.addAttribute("pm", pm);
		return "board/boardList"; // /WEB-INF/view/boardList.jsp
	}
	@GetMapping("/register.do") // get/post
	public String register() {
		return "board/register"; // register.jsp
	}	
	@PostMapping("/register.do")
	public String register(Board vo) { // 파라메터수집(VO)
		 mapper.register(vo); // 저장성공
		 // 다시 리스트페이지로 이동 : /boardList.do
		 return "redirect:/boardList.do";
	}
	@GetMapping("/content.do")
	public String content(@RequestParam("idx") int idx, Model model, Criteria cri) {
	    Board vo=mapper.content(idx);
	    model.addAttribute("vo", vo);
	    model.addAttribute("cri", cri);
	    // 객체바인딩(request, session,......)
	    mapper.countUpdate(idx); // 조회수 누적
	    return "board/content"; // content.jsp(상세보기)
	}
	@GetMapping("/boardDelete.do")
	public String boardDelete(int idx, Criteria cri, RedirectAttributes rttr) {
		mapper.remove(idx);
		rttr.addAttribute("page", cri.getPage()); // 1회성 세션으로 전달
		return "redirect:/boardList.do";
	}
	@GetMapping("/boardUpdate.do")
	public String boardUpdate(int idx, Model model, @ModelAttribute("cri") Criteria cri) {
		Board vo=mapper.content(idx);
		model.addAttribute("vo", vo);
		//model.addAttribute("cri", cri);
		return "board/boardUpdate"; //boardUpdate.jsp
	}
	@PostMapping("/boardUpdate.do")
	public String boardUpdate(Board vo,Criteria cri, RedirectAttributes rttr) {
		mapper.modify(vo);
		rttr.addAttribute("idx", vo.getIdx());
		rttr.addAttribute("page", cri.getPage());
		return "redirect:/content.do";
	}
	@GetMapping("/boardReply.do")
	public String boardReply(int idx, Model model, @ModelAttribute("cri") Criteria cri) {
		Board vo=mapper.content(idx);
		model.addAttribute("vo", vo);
		return "board/reply"; // reply.jsp
	}
	@PostMapping("/boardReply.do")
	public String boardReply(Board vo, Criteria cri,RedirectAttributes rttr) { // idx, title, content, boardGroup, boardSequence, boardLevel
		// 1. 원글의 정보를 기져오기
		Board parent=mapper.content(vo.getIdx());
		// 2. 부모글의 boardGroup->답글의 boardGroup
		vo.setBoardGroup(parent.getBoardGroup());
		// 3. 부모글의 boardSequence->답글의 boardSequence+1
		vo.setBoardSequence(parent.getBoardSequence()+1);
		// 4. 부모글의 boardLevel->답글의 boardLevle+1
		vo.setBoardLevel(parent.getBoardLevel()+1);
        // 5. 같은 boardGroup에 있는 글 중에서 부모글의 boardSequence보다 큰값들을 모두 +1
		mapper.replySeqUpdate(parent);
		// 6. 답글(vo)을 테이블에 저장
	    mapper.replyInsert(vo);	
	    rttr.addAttribute("page", cri.getPage());
	    return "redirect:/boardList.do";
	}	
}








