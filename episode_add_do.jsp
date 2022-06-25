<%@ page  contentType="text/html; charset=UTF-8" import="java.sql.*" 
	import="java.util.*, myBean.multipart.*" 
    %>
<%
request.setCharacterEncoding("utf-8");

Class.forName("org.mariadb.jdbc.Driver");
String DB_URL = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
String DB_USER = "admin";
String DB_PASSWORD= "1234";

// 사용자가 파라미터에 전송한 값 알아내기
int webtoonIdx = Integer.parseInt(request.getParameter("webtoonIdx"));
String episodeTitle = request.getParameter("episodeTitle");
String date = request.getParameter("date");

//upload 이름을 가지는 실제 서버의 경로명 알아내기 
ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");

//multipart/form-data 유형의 클라이언트 요청에 대한 모든 Part 구성요소를 가져옴.
Collection<Part> parts = request.getParts();
MyMultiPart multiPart = new MyMultiPart(parts, realFolder);

String originalFileName2="";
String savedFileName2="";
String originalFileName3="";
String savedFileName3="";

if(multiPart.getMyPart("fileName") != null) {  
	originalFileName2 = multiPart.getOriginalFileName("fileName");
	savedFileName2 =  multiPart.getSavedFileName("fileName");
}
if(multiPart.getMyPart("fileName2") != null) {  
	originalFileName3 = multiPart.getOriginalFileName("fileName2");
	savedFileName3 =  multiPart.getSavedFileName("fileName2");
}
//DB 연결자 생성
Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	
//webtoonIdx, episodeTitle, date, originalFileName2, savedFileName2, originalFileName3, savedFileName3을 저장하기 위한 insert 문자열 구성
String sql = "insert into episodedb(webtoonIdx, episodeTitle, date, originalFileName2, savedFileName2, originalFileName3, savedFileName3) "+"VALUES(?,?,?,?,?,?,?)";
	
PreparedStatement pstmt = con.prepareStatement(sql);

//pstmt의 SQL 쿼리 구성
pstmt.setInt(1, webtoonIdx);
pstmt.setString(2, episodeTitle);
pstmt.setString(3, date);
pstmt.setString(4, originalFileName2);
pstmt.setString(5, savedFileName2);
pstmt.setString(6, originalFileName3);
pstmt.setString(7, savedFileName3);
 
//쿼리 실행
pstmt.executeUpdate();


pstmt.close();
con.close();

response.sendRedirect("result_webtoon.jsp");
%>