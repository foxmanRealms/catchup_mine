<%@page import="kr.catchup.mapper.BoardVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>

	<div class="container">
		<h2>Spring MVC BOARD</h2>
		<div class="panel panel-default">
			<div class="panel-heading">
				Board List <span style="float: right"> <c:choose>
						<c:when test="${not empty info}">
							${info.nick} 님 환영합니다!
							<a href="logout.do"><button class="btn btn-info btn-sm">로그아웃</button></a>
							<a href="update.do"><button class="btn btn-info btn-sm">회원정보수정</button></a>
							<c:if test="${info.id eq 'admin'}">
								<!--  <a href="memberList.do"><button class="btn btn-info btn-sm">회원정보보기</button> </a> -->
								<button style="width: 100px;" id="memberList"
									class="btn btn-info btn-sm">회원정보보기</button>
							</c:if>
						</c:when>
						<c:otherwise>
							<a href="login.do"><button class="btn btn-info btn-sm">로그인</button>
							</a>
						</c:otherwise>

					</c:choose>
				</span>

				<div id="memberView" style="width: 100%;"></div>


			</div>
			<div class="panel-body">
				<table class="table table-hover table-bordered">
					<tr class="active">
						<td>번호</td>
						<td>제목</td>
						<td>조회수</td>
						<td>작성자</td>
						<td>작성일</td>
					</tr>

					<!-- 숙제. model안에 저장해 놓은 list 안의 게시글 정보를 전부 출력하시오
    		* for문 활용. 참고로 model 안에 저장된 데이터는 
    		request객체 안에 되어있다.
    		request.getAttribute()를 통해 꺼내기 가능 
    		 -->

					<c:forEach var="vo" items="${list}" varStatus="i">

						<tr>
							<td>${i.count}</td>
							<td><a href="boardContents.do?idx=${vo.idx}">${vo.title}</a></td>
							<td>${vo.count}</td>
							<td>${vo.writer}</td>
							<td>${vo.indate}</td>

							<%--  선생님 코드 표현식으로 순번을 꺼냈을때
    			<td><%= i+1 %></td> 번호만 이렇게 뽑았다.중간에 게시글이 삭제됐을때
    			이상해지는 것을 대비
    			 --%>

						</tr>
					</c:forEach>
				</table>
				<!-- <button class="btn btn-primary btn-sm">글쓰기</button>
    	<button class="btn btn-info btn-sm">글쓰기</button> -->
				<a href="boardInsertForm.do">
					<button class="btn btn-success btn-sm">글쓰기</button>
				</a>
				<!--<button class="btn btn-warning btn-sm">글쓰기</button> -->
			</div>
			<div class="panel-body">지능형 IoT 이정명</div>
		</div>
	</div>

	<script type="text/javascript">
		$("#memberList").click(function() {
			//console.log('클릭감지')
			$.ajax({
				url : "memberList.do",
				type : "get", //관리자니까 get post 상관없다.  대소문자도 상관없다
				dataType : "JSON",
				//data :{key :value } // 보낼 데이터를 넣는 공간 
				success : resultJson, // 서버통신이 문제없이 성공했을 때 실행시킬 함수명
				error : function(e) {
					console.log(e);
				} //통신이 안됐을때

			});

		});

		function resultJson(data) {
			console.log(data);
			 
			var btn_text=$('#memberList').text();
			if(btn_text=='회원정보보기'){
				$('#memberList').text('닫기') 
			}else{
				$('#memberList').text('회원정보보기') 
			}  
			
					
			var html=" <table class='table table-hover table-bordered'>";
			html+="<tr>";
			html+="<td>번호</td><td>아이디</td><td>비밀번호</td>";
			html+="<td>닉네임</td><td>전화번호</td>";
			html+="</tr>";
			$.each(data, (index,obj) => {
				html+="<tr>";
				html+="<td>"+index +"</td>";
				html+="<td>"+obj.id +"</td>";
				html+="<td>"+obj.pw +"</td>";
				html+="<td>"+obj.nick +"</td>";
				html+="<td>"+obj.phone +"</td>";
				html+="</tr>";
			} ); // 제이쿼리 반복문 
			
			html+="</table>";
			$("#memberView").html(html);
			
			if  ( $("#memberView").css('display') =='none') {
				$("#memberView").slideDown(1500);
			}else{
				$("#memberView").slideUp(1500);
			}
			
		}
		
		
	</script>

</body>
</html>