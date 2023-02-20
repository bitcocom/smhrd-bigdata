package kr.smhrd.entity;

import lombok.Data;

// 페이징처리에 필요한 값들을 저장하는 클래스:[1][2][3]....
@Data
public class PageMaker {
  private Criteria cri;
  private int totalCount;// 전체게시글의 수
  private int startPage; // 시작페이지번호
  private int endPage;// 끝페이지번호(조정)
  private boolean prev; // 이전버튼(true, false)
  private boolean next; // 다음버튼(true, false)
  private int displayPageNum=10; // 1 2 3 4 5 6 7 8 9 10
  public void setTotalCount(int totalCount) {
	  this.totalCount=totalCount;
	  makePaging();
  }
  private void makePaging() {
	// 1.화면에 보여질 마지막 페이지 번호
	endPage=(int)(Math.ceil(cri.getPage()/(double)displayPageNum)*displayPageNum);  
	// 2.화면에 보여질 시작 페이지 번호
	startPage=(endPage-displayPageNum)+1;
	if(startPage<=0) startPage=1;
	// 3.전체 마지막 페이지 계산
	int realPageTemp=(int)(Math.ceil(totalCount/(double)cri.getPerPageNum()));
    // 4.화면에 보여질 마지막 페이지 조정단계
	if(realPageTemp<endPage) {
		endPage=realPageTemp;
	}
	// 5.이전페이지 버튼 존재 여부
	prev=(startPage==1) ? false : true;
	// 6.다음페이지 버튼 존재 여부
	next=(endPage<realPageTemp) ? true : false;	
  }  
}
