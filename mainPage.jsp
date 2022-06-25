<%@ page contentType="text/html;charset=utf-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head><title>저장 결과</title>
<style>
td {text-align: center;}
a {text-decoration-line: none;}
a:link {
  color : white;
}
a:visited {
  color : white;
}
a:hover {
  color : white;
}
a:active {
  color : white;
}
table{width: 1000px; border-collapse:collapse; position: relative; margin:0 auto; top: 180px; border-top: 3px solid #A6CFE2;}
td, th{border-bottom:1px solid #A6CFE2; text-align: center;}
</style>
</head>
<body>
<%
Class.forName("org.mariadb.jdbc.Driver");
String DB_URL = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
String DB_USER = "admin";
String DB_PASSWORD= "1234";

Connection con=null;
PreparedStatement pstmt = null;
ResultSet rs=null;
try {
	//DB 연결자 정보를 획득한다.
	con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	
	// member 테이블에서 모든 필드의 레코드를 가져오는 퀴리 문자열을 구성한다. 
	String sql = "select * from webtoondb";
	
	// sql문을 실행하기 위한 PreparedStatement 객체를 생성한다.
	pstmt = con.prepareStatement(sql);

	//쿼리 실행
	rs = pstmt.executeQuery();
%>
    <h1 style="display:inline; position:relative; top: 70px; font-weight: 2000; left:40px;"><a href="mainPage.jsp" style="color:black;">웹툰관리하기사이트</a></h1> 
    <input type="text" placeholder="   검색어를 입력하세요" style="position:absolute; right: 100px; top: 90px; width: 270px; height:30px;  border:1 solid black; border-radius:30px;">
    <input type type="text" style="position:absolute; right: 30px; top: 90px; width: 40px; height:10px;  border:1px; border-radius:30px; color:black"><a href="search_result.jsp">검색</a></input>
    <hr style="position: relative; top: 80px; width:100%; border:1px color= #595959;">
    <button style="outline:none; color:#fff;background: #A6CFE2;font-size: 30px; font-weight: bold; border:none;
	border-radius: 10px; position: absolute; right: 50px; top: 190px; width: 270px; height: 50px;"><a href="webtoon_add.jsp">웹툰 등록하기</a></button>
<h2 style = " position:absolute; top: 260px; left:300px;">웹툰 목록</h1>    
<table style = " position:relative; top: 260px;  margin-left:auto; margin-right:auto;  width: 1000px; border-collapse:collapse;">
	<tr>
		<th>이미지</th>
		<th>제목</th>
		<th>작가</th>
		<th>장르</th>
		<th>비고</th>
	</tr>
<%
	while(rs.next()) {
%>
		<tr>
		<td>
				<!-- upload 디렉토리에 저장된 파일의 그림 출력 -->
				<img src="./upload/<%=rs.getString("savedFileName") %>" width="80" height="80">
			</td>
			<td><a href="result_webtoon.jsp?webtoonIdx=<%=rs.getInt("webtoonIdx")%>" style="color:black;"><%=rs.getString("webtoonTitle")%></a> </td>
			<td><%= rs.getString("author")%></td>
			<td><%= rs.getString("genre")       /*[문6]. name값 출력*/ %> </td>
			
			<td>
			<!-- 삭제와 수정 링크 추가 -->
				<a href="webtoon_delete_do.jsp?webtoonIdx=<%=rs.getInt("webtoonIdx")%>" style="color:black;">삭제 &nbsp; | &nbsp;</a>
				<a href="webtoon_modify.jsp?webtoonIdx=<%=rs.getInt("webtoonIdx")%>" style="color:black;">수정</a>
			</td>
		</tr>
<%
	}
	rs.close();
	pstmt.close();
	con.close();
}catch(SQLException e) {
	out.println(e);
}
%>
</table>
<br>
<br>
<br>
<br>
<br>
</body>
</html>