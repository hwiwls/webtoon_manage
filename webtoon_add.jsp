<%@ page contentType="text/html;charset=utf-8" %>
<!DOCTYPE html>
<html>
<head><title>웹툰 추가 등록</title></head>
<body>
<form method="post" action="webtoon_add_do.jsp" enctype="multipart/form-data">
<h1 style="display:inline; position:relative; top: 70px; font-weight: 2000; left:40px;">웹툰관리하기사이트</h1> 
    <input type="text" placeholder="   검색어를 입력하세요" style="position:absolute; right: 50px; top: 90px; width: 270px; height:30px;  border:1 solid black; border-radius:30px;">
    <hr style="position: relative; top: 80px; width:100%; border:1px color= #595959;">
<h1 style="display:inline; position:relative; top: 100px; font-weight: 2000; left:40px;">새 웹툰 등록하기</h1> 

<!-- 추가할 정보 입력 공간 -->
<div style =" margin-left:auto; margin-right:auto; text-align:center; position:relative; top: 130px; width:800px;">
<p style="position: absolute; left:0px">웹툰타이틀</p>
<input type="text" name="webtoonTitle" style="position: absolute; right:0px; top:10px; height:30px; width:600px;"> <br><br>
<p style="position: absolute; left:0px; top:50px; ">작가명</p>
<input type="text" name="author" style="position: absolute; right:0px; top:60px; height:30px; width:600px;"> <br><br>
<p style="position: absolute; left:0px; top:100px; ">장르</p>
<input type="text" name="genre" style="position: absolute; right:0px; top:110px; height:30px; width:600px;"> <br><br>
<p style="position: absolute; left:0px; top:150px; ">줄거리</p>
<input type="text" name=summary" style="position: absolute; right:0px; top:160px; height:30px; width:600px;"> <br><br>
<p style="position: absolute; left:0px; top:200px; ">작가의말</p>
<input type="text" name="authorSays" style="position: absolute; right:0px; top:210px; height:30px; width:600px;"> <br><br>
<p style="position: absolute; left:0px; top:250px; ">대표이미지</p>
<input type="file" name="fileName" style="position: absolute; right:0px; top:265px; height:30px; width:600px;"> <br><br>
</div>

<input type="submit" value="추가" style="position:absolute; top:580px; right:250px; width:200px; height:70px; border:none;
	border-radius: 10px; color:#fff;background: #A6CFE2; font-size: 30px; font-weight: bold;">

</form>
</body>
</html>