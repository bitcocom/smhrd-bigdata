package kr.smhrd.entity;

import lombok.Data;

@Data
public class Criteria {
   private int page; // 현재페이지번호
   private int perPageNum;// 한페이지에 보여줄 게시글의 수
   private int pageStart;
   public Criteria() {
	   this.page=1;
	   this.perPageNum=10; // 조정
   }
   // 현재 페이지의 게시글의 시작번호
   public int getPageStart() {
	   return (page-1)*perPageNum;// 0, 5, 10	// limit 시작번호, 5;	                                    
   }
}
