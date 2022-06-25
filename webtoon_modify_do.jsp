<%@ page contentType="text/html; charset=UTF-8" 
		import="java.util.*,myBean.multipart.*"
		import="java.sql.*, java.io.*"
		errorPage="error.jsp"
%>
<%
request.setCharacterEncoding("utf-8");

int webtoonIdx = Integer.parseInt(request.getParameter("webtoonIdx"));
String webtoonTitle = request.getParameter("webtoonTitle");
String author = request.getParameter("author");
String genre = request.getParameter("genre");
String summary = request.getParameter("summary");
String authorSays = request.getParameter("authorSays");

ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");

Collection<Part> parts = request.getParts();
MyMultiPart multiPart = new MyMultiPart(parts, realFolder);


Class.forName("org.mariadb.jdbc.Driver");
String url = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
Connection con = DriverManager.getConnection(url, "admin", "1234");
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql = null;

if(multiPart.getMyPart("fileName") != null) { 
	//테이블에 저장된 idx 레코드의 파일명을 알아내어, 물리적 파일을 삭제함.
	sql = "select savedFileName from webtoondb where webtoonIdx=?"; 
	pstmt=con.prepareStatement(sql);
	pstmt.setInt(1, webtoonIdx);
	rs = pstmt.executeQuery();
	rs.next();
	String oldFileName = rs.getString("savedFileName");
	
	File oldFile = new File(realFolder+File.separator+oldFileName);
	oldFile.delete();
	//새로운 파일명(original file name, UUID 적용 file name)과 데이터로 테이블 수정
	sql = "update webtoondb set webtoonTitle=?, author=?, genre=?, summary=?, authorSays=?, originalFileName=?,"+"savedFileName=? where webtoonIdx=?";
	pstmt = con.prepareStatement(sql);
	
	pstmt.setString(1, webtoonTitle);
	pstmt.setString(2, author);
	pstmt.setString(3, genre);
	pstmt.setString(4, summary);
	pstmt.setString(5, authorSays);
	pstmt.setString(6, multiPart.getOriginalFileName("fileName"));
	pstmt.setString(7, multiPart.getSavedFileName("fileName"));
	pstmt.setInt(8, webtoonIdx);
} else { 
	// 파일명을 제외한 정보 수정
	sql = "update webtoondb set webtoonTitle=?, author=?, genre=?, summary=?, authorSays=? where webtoonIdx=?";
    pstmt = con.prepareStatement(sql);
    pstmt.setString(1, webtoonTitle);
	pstmt.setString(2, author);
	pstmt.setString(3, genre);
	pstmt.setString(4, summary);
	pstmt.setString(5, authorSays);  /* 작가의말 */
	pstmt.setInt(6, webtoonIdx);
	
}

pstmt.executeUpdate(); // 쿼리 실행

if(pstmt != null) pstmt.close();
if(rs != null) rs.close();
if(con != null) con.close();

response.sendRedirect("mainPage.jsp");
%>