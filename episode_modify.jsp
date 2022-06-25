<%@ page contentType="text/html;charset=utf-8"
		import="java.sql.*" errorPage="error.jsp" %>
<%-- [문1] error.jsp 파일 생성 --%>
<%
request.setCharacterEncoding("utf-8");
int idx = Integer.parseInt(request.getParameter("episodeIdx"));

Class.forName("org.mariadb.jdbc.Driver");
String url = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";

Connection con = DriverManager.getConnection(url, "admin", "1234");

//테이블에서 idx에 해당하는 레코드 검색하기 위한 SQL문 구성 
String sql = "SELECT episodeIdx, episodeTitle, originalFileName2, savedFileName2, originalFileName3, savedFileName3 from episodedb where episodeIdx=?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setInt(1, idx);

ResultSet rs = pstmt.executeQuery();

rs.next();

%>		
<!DOCTYPE html>
<html>
<head><title>회차 정보 수정</title></head>
<body>
<form method="POST" action="episode_modify_do.jsp" enctype="multipart/form-data">
<h1 style="display:inline; position:relative; top: 70px; font-weight: 2000; left:40px;">웹툰관리하기사이트</h1> 
    <input type="text" placeholder="   검색어를 입력하세요" style="position:absolute; right: 50px; top: 90px; width: 270px; height:30px;  border:1 solid black; border-radius:30px;">
    <hr style="position: relative; top: 80px; width:100%; border:1px color= #595959;">
<h1 style="display:inline; position:relative; top: 90px; font-weight: 2000; left:40px;">회차 수정하기</h1> 

<!-- 수정할 정보 입력하는 공간 -->
<div style =" margin-left:auto; margin-right:auto; text-align:center; position:relative; top: 110px; width:800px;">
<p style="position: absolute; left:0px; top:0px;">회차제목</p>
<input type="text" name="episodeTitle" value="<%=rs.getString("episodeTitle")%>" style="position: absolute; right:0px; top:0px; height:30px; width:600px;"> <br><br>
<p style="position: absolute; left:0px; top:50px;">썸네일</p>
<p style="position:absolute; top:50px; left:200px;"><img src="./upload/<%=rs.getString("savedFileName2") %>" width="80" height="80"></p>
<p style="position: absolute; left:0px; top:150px;">변경할 썸네일</p> 
<input type="file" name="fileName" style="position:absolute;top: 170px; left:200px;">
<p style="position: absolute; left:0px; top:220px;">만화그림</p>
<p style="position:absolute; top:220px; left:200px;"><img src="./upload/<%=rs.getString("savedFileName3") %>" width="80" height="80"></p>
<p style="position: absolute; left:0px; top:320px;">변경할 만화그림</p> 
<input type="file" name="fileName2" style="position:absolute;top: 340px; left:200px;">

</div>
<input type="submit" value="수  정" style="position:absolute; top:600px; right:150px; right:250px; width:200px; height:70px; border:none;
	border-radius: 10px; color:#fff;background: #A6CFE2; font-size: 30px; font-weight: bold;">
</form>
</body>
</html>
<%
rs.close();
pstmt.close();
con.close();
%>