<%@ page  contentType="text/html; charset=UTF-8"  import="java.util.*, java.text.SimpleDateFormat"
    %>
 <%
request.setCharacterEncoding("utf-8");
int webtoonIdx = Integer.parseInt(request.getParameter("webtoonIdx"));
%>	 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에피소드 추가</title>
</head>
<body>
<form method="post" action="episode_add_do.jsp" enctype="multipart/form-data">
<h1 style="display:inline; position:relative; top: 70px; font-weight: 2000; left:40px;">웹툰관리하기사이트</h1> 
    <input type="text" placeholder="   검색어를 입력하세요" style="position:absolute; right: 50px; top: 90px; width: 270px; height:30px;  border:1 solid black; border-radius:30px;">
    <hr style="position: relative; top: 80px; width:100%; border:1px color= #595959;">
<h1 style="display:inline; position:relative; top: 90px; font-weight: 2000; left:40px;">회차 수정하기</h1> 

<!-- 에피소드 정보 추가하는 공간 -->
<div style =" margin-left:auto; margin-right:auto; text-align:center; position:relative; top: 110px; width:800px;">
<p style="position: absolute; left:0px">웹툰 인덱스 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=webtoonIdx %></p>
<input type="hidden" name="webtoonIdx" value="<%=webtoonIdx%>"style=" absolute; right:0px; top:10px; height:30px; width:600px;"><br>
<p style="position: absolute; left:0px; top:50px;">회차제목</p>
<input type="text" name="episodeTitle" style="position: absolute; right:0px; top:60px; height:30px; width:600px;"> <br><br>
<p style="position: absolute; left:0px; top:100px; ">썸네일</p>
<input type="file" name="fileName" style="position: absolute; right:0px; top:110px; height:30px; width:600px;"><br>
<p style="position: absolute; left:0px; top:150px; ">웹툰그림파일</p> 
<input type="file" name="fileName2" style="position: absolute; right:0px; top:160px; height:30px; width:600px;"><br>
<p style="position: absolute; left:0px; top:200px; ">등록일 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%= new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>
<input type="hidden" name="date" value="<%= new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"style=" absolute; right:0px; top:200px; height:30px; width:600px;">
</p>
</div>
<br> 
<input type="submit" value="추가" style="position:absolute; top:600px; right:150px; right:250px; width:200px; height:70px; border:none;
	border-radius: 10px; color:#fff;background: #A6CFE2; font-size: 30px; font-weight: bold;">

</form>
</body>
</html>