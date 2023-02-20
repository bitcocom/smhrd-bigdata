package kr.smhrd.entity;

import java.util.Date;

import lombok.Data;
// Lombok API
@Data
public class Board {
   private int idx; // 번호
   private String memId; // 회원ID
   private String title; // 제목
   private String content;// 내용
   private String writer; // 작성자
   private Date indate; // 작성일
   private int count; // 조회수  
   // 답글에서 필요한 변수
   private int boardGroup; // [원글+답글] 0,1,2
   private int boardSequence; // 답글의 순서
   private int boardLevel; // 들여쓰기
   private int boardAvailable; // 삭제여부(1->정상, 0->삭제)
}
