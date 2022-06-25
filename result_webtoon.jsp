<%@ page contentType="text/html;charset=utf-8" import="java.sql.*" import="java.sql.*" errorPage="error.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int webtoonIdx = Integer.parseInt(request.getParameter("webtoonIdx"));

Class.forName("org.mariadb.jdbc.Driver");
String url = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";

Connection con = DriverManager.getConnection(url, "admin", "1234");

//테이블에서 idx에 해당하는 레코드 검색하기 위한 SQL문 구성 
String sql = "SELECT episodedb.episodeIdx, webtoonIdx, webtoonTitle, author, genre, summary, authorSays, originalFileName, savedFileName, originalFileName2, savedFileName2, originalFileName3, savedFileName3, episodeTitle, date"+" from webtoondb inner join episodedb using(webtoonIdx) where webtoonIdx=?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setInt(1, webtoonIdx);

//쿼리 실행
ResultSet rs = pstmt.executeQuery();

//레코드 오프셋 커서 이동
rs.next();
%>
<!DOCTYPE html>
<html>
<style>
table{width: 1000px; border-collapse:collapse; position: relative; margin:0 auto; top: 180px; border-top: 3px solid #A6CFE2;}
td, th{border-bottom:1px solid #A6CFE2; text-align: center;}
</style>
<head>
<meta charset="UTF-8">
<title>웹툰 상세 정보 출력</title>
</head>
<body>
 <h1 style="display:inline; position:relative; top: 100px; font-weight: 2000; left:40px;"><a href="mainPage.jsp" style="color:black; text-decoration-line: none;"><a>웹툰관리하기사이트</a></h1> 
    <input type="text" placeholder="   검색어를 입력하세요" style="position:absolute; right: 50px; top: 120px; width: 270px; height:30px;  border:1 solid black; border-radius:30px;">
    <hr style="position: relative; top: 110px; width:100%; border:1px color= #595959;">

<!-- 웹툰 상세 정보 -->
 <div style="position: relative; top: 130px; margin:0 auto; width:800px; height: 180px; ">
<p style="width:170px; height:170px; float: left;"><img src="./upload/<%=rs.getString("savedFileName") %>" width="180" height="180"></p>
<p style="font-size:20px; font-weight:bold; position:absolute; left:200px; top:-5px;"><%= rs.getString("webtoonTitle")%> &nbsp;|&nbsp;
<%= rs.getString("author")%><BR></p>
<p style="font-size:15px;  position:absolute; left:195px; top:40px;"><%= rs.getString("summary")%></p><BR>
<p style="font-size:15px;  position:absolute; left:195px; top: 110px;"><%= rs.getString("authorSays")%></p>
</div>

<button style="outline:none; color:#fff;background: #A6CFE2;font-size: 30px; font-weight: bold; border:none;
	border-radius: 30px; position: absolute; right: 100px; top: 400px; width: 280px; height: 60px;">
	<a href="episode_add.jsp?webtoonIdx=<%=rs.getInt("webtoonIdx")%>" style="color:white; text-decoration-line: none;">새로운 회차 등록</a></button>

<!-- 웹툰 회차 목록 -->
<table style="position=absolute; top:250px;">
<tr style ="border-bottom: 3px solid #A6CFE2;">
<td style="padding 7 0 7 0; font-size:17px;">이미지</td>
<td style="padding: 7 0 7 0; font-size:17px;">제목</td>
<td style="padding: 7 0 7 0; font-size:17px;">등록일</td>
<td style="padding: 7 0 7 0; font-size:17px;">관리</td>
</tr>
 <%
	while(rs.next()) {
%>
		<tr>
		<td style="padding: 7 0 7 0"><img src="./upload/<%=rs.getString("savedFileName2") %>" width="50" height="50"></td>
		<td><%=rs.getString("episodeTitle")%> </td>
		<td><%=rs.getString("date")%></td>		
		<td> 
				<a href="episode_delete_do.jsp?episodeIdx=<%=rs.getInt("episodeIdx")%>" style="color:black; text-decoration-line: none;">삭제 &nbsp;|&nbsp;</a> 
				<a href="episode_modify.jsp?episodeIdx=<%=rs.getInt("episodeIdx")%>" style="color:black; text-decoration-line: none;">수정</a> 
		</td>
</tr>  
<%
	}
	rs.close();
	pstmt.close();
	con.close();

%>
</table>  
<br>
<br>
<br>
<br>
<br>
 </body>
</html>