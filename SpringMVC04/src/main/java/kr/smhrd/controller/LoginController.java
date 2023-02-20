package kr.smhrd.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.smhrd.entity.Member;
import kr.smhrd.mapper.BoardMapper;

@Controller
public class LoginController { // new LoginController();

	@Autowired
	private BoardMapper mapper;
	
	@RequestMapping("/login.do")
	public String login(Member vo, HttpSession session) {
		Member mvo=mapper.loginCheck(vo);
		if(mvo!=null) {
			// 회원인증(권한)에 성공
			session.setAttribute("mvo", mvo);
		}
		return "redirect:/boardList.do";
	}
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/boardList.do";
	}
}
