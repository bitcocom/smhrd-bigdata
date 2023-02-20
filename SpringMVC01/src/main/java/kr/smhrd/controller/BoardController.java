package kr.smhrd.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.smhrd.entity.Board;
import kr.smhrd.mapper.BoardMapper;

@Controller
public class BoardController{

	@Autowired
	private BoardMapper mapper;
	// /boardList.do --> Method
	@RequestMapping("/boardList.do")
	public String boardList(HttpServletRequest request){
		List<Board> list=mapper.boardList();
		request.setAttribute("list", list);
		// 객체바인딩
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
	public String content(@RequestParam("idx") int idx, Model model) {
	    Board vo=mapper.content(idx);
	    model.addAttribute("vo", vo);
	    // 객체바인딩(request, session,......)
	    return "board/content"; // content.jsp(상세보기)
	}
	@GetMapping("/boardDelete.do")
	public String boardDelete(int idx) {
		mapper.remove(idx);
		return "redirect:/boardList.do";
	}
	@GetMapping("/boardUpdate.do")
	public String boardUpdate(int idx, Model model) {
		Board vo=mapper.content(idx);
		model.addAttribute("vo", vo);
		return "board/boardUpdate"; //boardUpdate.jsp
	}
	@PostMapping("/boardUpdate.do")
	public String boardUpdate(Board vo) {
		mapper.modify(vo);
		return "redirect:/content.do?idx="+vo.getIdx();
	}
}








