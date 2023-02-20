package kr.smhrd.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.smhrd.entity.Board;
import kr.smhrd.entity.Member;

public interface BoardMapper {
    // Connection - X
	// CRUD Logic    	
	// 게시판 전체 리스트 가져오기~
	//@Select("select ~")
	public List<Board> boardList(); // SQL연결 : SQL Mapper File
	public void register(Board vo); // 1, 0
	public Board content(int idx);
	
	@Delete("delete from board where idx=#{idx}")
	public void remove(int idx);
	
	@Update("update board set title=#{title},content=#{content} where idx=#{idx}")                                  
	public void modify(Board vo);
	
	@Select("select * from member where memId=#{memId} and memPwd=#{memPwd}")
	public Member loginCheck(Member vo);
}
