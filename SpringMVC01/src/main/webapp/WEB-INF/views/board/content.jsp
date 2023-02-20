<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="${cpath}/resources/css/style.css">
  <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script type="text/javascript">
    $(document).ready(function(){
    	$("button").on("click", function(e){
    		 var formData=$("#frm");
    		 var btn=$(this).data("btn"); // data-btn
    		 if(btn=="list"){
    			 formData.attr("action","${cpath}/boardList.do");
    			 formData.attr("method","post");
    			 formData.find("#idx").remove();
    		 }else if(btn=="remove"){
    			 formData.attr("action","${cpath}/boardDelete.do");
    			 formData.attr("method","get"); // idx=3
    		 }else if(btn=="modify"){
    			 formData.attr("action","${cpath}/boardUpdate.do");
    			 formData.attr("method","get"); // idx=3
    		 }
    		 formData.submit(); // 전송
    	});    	
    });  
  </script>
</head>
<body>
 
  <div class="card">
    <div class="card-header">
	    <div class="jumbotron jumbotron-fluid">
		  <div class="container">
		    <h1>Spring Framework!</h1>
		    <p>Bootstrap is the most popular HTML, CSS...</p>
		  </div>
		</div>    
    </div>
    <div class="card-body">
      <div class="row">
         <div class="col-lg-2">
           <jsp:include page="left.jsp"/>
         </div>
         <div class="col-lg-7">
         <h4 class="card-title">CONTENT</h4>
           <table class="table table-bordered">
              <tr>
                <td width="150px">제목</td>
                <td>${vo.title}</td>
              </tr>
              <tr>
                <td>내용</td>
                <td>${fn:replace(vo.content,newLineChar,"<br/>")}</td>
              </tr>
              <tr>
                <td>작성자</td>
                <td>${vo.writer}</td>
              </tr>
              <tr>
                <td>작성일</td>
                <td><fmt:formatDate value="${vo.indate}" pattern="yyyy-MM-dd"/></td>
              </tr>
              <tr>
                <td colspan="2" align="center">
                   <button data-btn="reply" class="btn btn-sm btn-primary">답글</button>
                   <c:if test="${!empty mvo && mvo.memId eq vo.memId}">
                    <button data-btn="modify" class="btn btn-sm btn-success">수정</button>
                    <button data-btn="remove" class="btn btn-sm btn-warning">삭제</button>
                   </c:if>
                   <c:if test="${empty mvo || mvo.memId ne vo.memId}">
                    <button disabled="disabled" data-btn="modify" class="btn btn-sm btn-success">수정</button>
                    <button disabled="disabled" data-btn="remove" class="btn btn-sm btn-warning">삭제</button>
                   </c:if>                   
                   <button data-btn="list" class="btn btn-sm btn-info">목록</button>
                </td>
              </tr>
           </table>
           <form id="frm">
              <input type="hidden" id="idx" name="idx" value="${vo.idx}"/>              
           </form>
         </div>  
         <div class="col-lg-3">
           <jsp:include page="right.jsp"/>
         </div>
      </div>
    </div> 
    <div class="card-footer">지능형 빅데이터 분석서비스 개발자과정(박매일)</div>
  </div>
</body>
</html>