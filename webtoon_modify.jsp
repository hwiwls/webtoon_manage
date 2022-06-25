<%@ page contentType="text/html;charset=utf-8"
		import="java.sql.*" errorPage="error.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int webtoonIdx = Integer.parseInt(request.getParameter("webtoonIdx"));

Class.forName("org.mariadb.jdbc.Driver");
String url = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";

Connection con = DriverManager.getConnection(url, "admin", "1234");

//테이블에서 idx에 해당하는 레코드 검색하기 위한 SQL문 구성 
String sql = "SELECT webtoonTitle, author, genre, summary, authorSays, originalFileName, savedFileName "+"from webtoondb where webtoonIdx=?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setInt(1, webtoonIdx);
ResultSet rs = pstmt.executeQuery();

rs.next();

%>		
<!DOCTYPE html>
<html>
<head><title>웹툰 정보 수정</title></head>
<body>
<form method="POST" action="webtoon_modify_do.jsp" enctype="multipart/form-data">

<h1 style="display:inline; position:relative; top: 70px; font-weight: 2000; left:40px;">웹툰관리하기사이트</h1> 
    <input type="text" placeholder="   검색어를 입력하세요" style="position:absolute; right: 50px; top: 90px; width: 270px; height:30px;  border:1 solid black; border-radius:30px;">
    <hr style="position: relative; top: 80px; width:100%; border:1px color= #595959;">
<h1 style="display:inline; position:relative; top: 90px; font-weight: 2000; left:40px;">회차 수정하기</h1> 

<!-- 수정할 정보 입력할 공간 -->
<div style =" margin-left:auto; margin-right:auto; text-align:center; position:relative; top: 110px; width:800px;">
<p style="position: absolute; left:0px">웹툰번호&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=webtoonIdx %></p>
<input type="hidden" name="webtoonIdx" value="<%=webtoonIdx %>" style="position: absolute; right:0px; top:10px; height:30px; width:600px;"><br>
<p style="position: absolute; left:0px; top:40px;">웹툰타이틀</p>
<input type="text" name="webtoonTitle" value="<%=rs.getString("webtoonTitle")%>" style="position: absolute; right:0px; top:50px; height:30px; width:600px;"> <br><br>
<p style="position: absolute; left:0px; top:80px; ">작가명</p>
<input type="text" name="author" value="<%=rs.getString("author")%>" style="position: absolute; right:0px; top:90px; height:30px; width:600px;"> <br><br>
<p style="position: absolute; left:0px; top:120px; ">장르</p>
<input type="text" name="genre" value="<%=rs.getString("genre")%>" style="position: absolute; right:0px; top:130px; height:30px; width:600px;"> <br><br>
<p style="position: absolute; left:0px; top:160px; ">줄거리</p>
<input type="text" name="summary" value="<%=rs.getString("summary")%>" style="position: absolute; right:0px; top:170px; height:30px; width:600px;"> <br><br>
<p style="position: absolute; left:0px; top:200px; ">작가의말</p>
<input type="text" name="authorSays" value="<%=rs.getString("authorSays")%>" style="position: absolute; right:0px; top:210px; height:30px; width:600px;"> <br><br>
<p style="position: absolute; left:0px; top:240px; ">대표이미지</p>
<p style="position:absolute; top:240px; left:200px;"><img src="./upload/<%=rs.getString("savedFileName") %>" width="80" height="80"></p>
<p style="position: absolute; left:0px; top:350px;">변경할 사진</p>
<input type="file" name="fileName" style="position:absolute;top: 370px; left:200px;">
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