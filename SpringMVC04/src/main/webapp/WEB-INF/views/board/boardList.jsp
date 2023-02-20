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
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=238cc02e52807759af66bdbe9487104f"></script>
  <script type="text/javascript">
    $(document).ready(function(){
      $("#mapBtn").click(function(){
    	  var address=$("#address").val();
    	  if(address==""){
    		  alert("주소를 입력하세요.");
    		  return false;
    	  }    	  
    	  // kakao map openAPI(키=key) : 주소->위도,경도 추출 : openAPI
    	  $.ajax({
    		  url : "https://dapi.kakao.com/v2/local/search/address.json",
    		  headers : {"Authorization":"KakaoAK ddcaeaee21f163c58818ca2db1820c67"},
    		  type : "get",
    		  data : {"query" : address},
    		  dataType : "json",
    		  success : mapView,
    		  error : function(){ alert("error"); }    		  
    	  });    	  
      });
      $("#search").click(function(){
    	   var bookname=$("#bookname").val();
    	   if(bookname==""){
    		   alert("책 제목을 입력하세요.");
    		   return false;
    	   }
    	   $.ajax({
    		   url : "https://dapi.kakao.com/v3/search/book?target=title",
    		   headers : {"Authorization":"KakaoAK ddcaeaee21f163c58818ca2db1820c67"},
    		   type : "get",
    		   data : {"query" : bookname},
    		   dataType : "json",
    		   success : bookPrint,
    		   error : function() { alert("error"); }
    	   }); 
    	   $(document).ajaxStart(function(){ $(".loading-progress").show(); });
     	   $(document).ajaxStop(function(){ $(".loading-progress").hide(); });    	   
      });      
    });
    function bookPrint(data){
    	var bList="<table class='table table-hover'>";
    	bList+="<thead>";
    	bList+="<tr>";
    	bList+="<th>책이미지</th>";
    	bList+="<th>가격</th>";
    	bList+="</tr>";
    	bList+="</thead>";
    	bList+="<tbody>";
    	$.each(data.documents, function(index, obj){
    		var image=obj.thumbnail;
    		var price=obj.price;
    		var url=obj.url;
    		bList+="<tr>";
    		bList+="<td><a href='"+url+"'><img src='"+image+"' width='50px' height='60px'/></a></td>";
    		bList+="<td>"+price+"</td>";
    		bList+="</tr>";
    	});
    	bList+="</tbody>";
    	bList+="</table>";
    	$("#bookList").html(bList);
    }
    function mapView(data){ // json(object)
    	console.log(data);
    	var x=data.documents[0].x; // 경도
    	var y=data.documents[0].y; // 위도
    	// 지도 출력
    	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = { 
            center: new kakao.maps.LatLng(y, x), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };
        // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
        var map = new kakao.maps.Map(mapContainer, mapOption); 
        // 마커가 표시될 위치입니다 
        var markerPosition  = new kakao.maps.LatLng(y, x); 
        // 마커를 생성합니다
        var marker = new kakao.maps.Marker({
            position: markerPosition
        });
        // 마커가 지도 위에 표시되도록 설정합니다
        marker.setMap(map);
        // 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
      	var iwContent = '<div style="padding:5px;">${mvo.memName}</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
      	    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
      	// 인포윈도우를 생성합니다
      	var infowindow = new kakao.maps.InfoWindow({
      	    content : iwContent,
      	    removable : iwRemoveable
      	});
      	// 마커에 클릭이벤트를 등록합니다
      	kakao.maps.event.addListener(marker, 'click', function() {
      	      // 마커 위에 인포윈도우를 표시합니다
      	      infowindow.open(map, marker);  
      	});
        
    }
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