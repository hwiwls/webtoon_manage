<%@ page contentType="text/html;charset=utf-8" 
	import="java.sql.*"
	import="java.util.*, myBean.multipart.*" 
%>
<%--[문1]. import 속성 완성 --%>

<%
request.setCharacterEncoding("utf-8");

Class.forName("org.mariadb.jdbc.Driver");
String DB_URL = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
String DB_USER = "admin";
String DB_PASSWORD= "1234";

//사용자가 파라미터에 전송한 값 알아내기
String webtoonTitle = request.getParameter("webtoonTitle");
String author = request.getParameter("author");
String genre = request.getParameter("genre");
String summary = request.getParameter("summary");
String authorSays = request.getParameter("authorSays");

ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");

Collection<Part> parts = request.getParts();
MyMultiPart multiPart = new MyMultiPart(parts, realFolder);

String originalFileName="";
String savedFileName="";

if(multiPart.getMyPart("fileName") != null) {  
	// 클라이언트가 전송한 원래 파일명 알아내기
	originalFileName = multiPart.getOriginalFileName("fileName");
	
	// 서버에 저장된 파일 이름 알아내기
	savedFileName =  multiPart.getSavedFileName("fileName");
}

Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	
//webtoonTitle, author, genre, summary, authorSays, originalFileName, savedFileName을 저장하기 위한 insert 문자열 구성
String sql = "insert into webtoondb(webtoonTitle, author, genre, summary, authorSays, originalFileName, savedFileName) "+"VALUES(?,?,?,?,?,?,?)";
	
PreparedStatement pstmt = con.prepareStatement(sql);

pstmt.setString(1, webtoonTitle);
pstmt.setString(2, author);
pstmt.setString(3, genre);
pstmt.setString(4, summary);
pstmt.setString(5, authorSays);
pstmt.setString(6, originalFileName);
pstmt.setString(7, savedFileName);

// 쿼리 실행
pstmt.executeUpdate();


pstmt.close();
con.close();

response.sendRedirect("mainPage.jsp");
%>