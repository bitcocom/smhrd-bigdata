<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
  <link rel="stylesheet" href="${cpath}/resources/css/style.css">
  <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script type="text/javascript">
    function goMsg() {
		alert("삭제된 게시물입니다.");
	}
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
         <h4 class="card-title">BOARD</h4>
			<table class="table table-bordered table-hover">
			  <tr>
			    <td>번호</td>
			    <td>제목</td>
			    <td>작성자</td>
			    <td>작성일</td>
			    <td>조회수</td>
			  </tr>
			  <c:forEach var="vo" items="${list}">
			    <tr>
				    <td>${vo.idx}</td>
				    <td>
				     <c:if test="${vo.boardLevel>0}">
				       <c:forEach begin="1" end="${vo.boardLevel}">
				          <span style="padding-left: 10px"></span>
				       </c:forEach>
				       <i class="bi bi-arrow-return-right" style="color: red"></i>
				     </c:if>
				     <c:if test="${vo.boardLevel>0}">				       
                      <c:if test="${vo.boardAvailable==1}">    
				       <a href="${cpath}/content.do?idx=${vo.idx}&page=${pm.cri.page}">[RE]${vo.title}</a>
				      </c:if>
				      <c:if test="${vo.boardAvailable==0}">
				       <a href="javascript:goMsg()">[RE]삭제된 게시물입니다.</a>
				      </c:if>
				     </c:if>
				     <c:if test="${vo.boardLevel==0}">
				      <c:if test="${vo.boardAvailable==1}">  
				       <a href="${cpath}/content.do?idx=${vo.idx}&page=${pm.cri.page}">${vo.title}</a>
				      </c:if>
				      <c:if test="${vo.boardAvailable==0}">
				       <a href="javascript:goMsg()">삭제된 게시물입니다.</a>
				      </c:if>
				     </c:if>
				    </td>
				    <td>${vo.writer}</td>
				    <td><fmt:formatDate value="${vo.indate}" pattern="yyyy-MM-dd"/></td>
				    <td>${vo.count}</td>
			    </tr>
			  </c:forEach>
			  <c:if test="${!empty mvo}">
				  <tr>
				   <td colspan="5" align="right">
				     <button onclick="location.href='${cpath}/register.do'" class="btn btn-sm btn-secondary pull-right">글쓰기</button>
				   </td>
				  </tr>
			  </c:if>
			</table>
			<!-- 페이징 START -->			
			<ul class="pagination justify-content-center">
			<!-- 이전 -->
			<c:if test="${pm.prev}">
			  <li class="paginate_button previous page-item">
               <a class="page-link" href="${cpath}/boardList.do?page=${pm.startPage-1}">Previous</a>
              </li>
			</c:if>
			<!-- 페이지번호[1][2] -->
			<c:forEach var="pageNum" begin="${pm.startPage}" end="${pm.endPage}">
             <li class="paginate_button ${pm.cri.page==pageNum ? 'active' : ''} page-item"><a class="page-link" href="${cpath}/boardList.do?page=${pageNum}">${pageNum}</a></li>
            </c:forEach> 
			<!-- 다음 -->
			<c:if test="${pm.next}">
			  <li class="paginate_button next page-item">
               <a class="page-link" href="${cpath}/boardList.do?page=${pm.endPage+1}">Next</a>
              </li>
			</c:if>
			 </ul>			 	
			<!-- END -->
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