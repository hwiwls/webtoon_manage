<%@ page contentType="text/html; charset=UTF-8" 
		import="java.util.*,myBean.multipart.*"
		import="java.sql.*, java.io.*"
		errorPage="error.jsp"
%>
<%
request.setCharacterEncoding("utf-8");

int episodeIdx = Integer.parseInt(request.getParameter("episodeIdx"));
String episodeTitle = request.getParameter("episodeTitle");

ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");

Collection<Part> parts = request.getParts();
MyMultiPart multiPart = new MyMultiPart(parts, realFolder);
MyMultiPart multiPart2 = new MyMultiPart(parts, realFolder);

Class.forName("org.mariadb.jdbc.Driver");
String url = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
Connection con = DriverManager.getConnection(url, "admin", "1234");
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql = null;

if(multiPart.getMyPart("fileName") != null ) {
	// 테이블에 저장된 idx의 파일명을 알아내서 파일을 삭제
	sql = "select savedFileName2 from episodedb where episodeIdx=?"; 
	pstmt=con.prepareStatement(sql);
	pstmt.setInt(1, episodeIdx);
	rs = pstmt.executeQuery();
	rs.next();
	String oldFileName = rs.getString("savedFileName2");
	
	File oldFile = new File(realFolder+File.separator+oldFileName);
	oldFile.delete();
	//테이블 수정
	sql = "update episodedb set episodeTitle=?, originalFileName2=?,"+"savedFileName2=?where episodeIdx=?";
	pstmt = con.prepareStatement(sql);
	
	pstmt.setString(1, episodeTitle);
	pstmt.setString(2, multiPart.getOriginalFileName("fileName"));
	pstmt.setString(3, multiPart.getSavedFileName("fileName"));
} 
else if(multiPart2.getMyPart("fileName2") != null){
	sql = "select savedFileName3 from episodedb where episodeIdx=?"; 
	pstmt=con.prepareStatement(sql);
	pstmt.setInt(1, episodeIdx);
	rs = pstmt.executeQuery();
	rs.next();
	String oldFileName = rs.getString("savedFileName3");
	
	File oldFile = new File(realFolder+File.separator+oldFileName);
	oldFile.delete();
	//테이블 수정
	sql = "update episodedb set episodeTitle=?, originalFileName3=?,"+"savedFileName3=?where episodeIdx=?";
	pstmt = con.prepareStatement(sql);
	
	pstmt.setString(1, episodeTitle);
	pstmt.setString(2, multiPart.getOriginalFileName("fileName2"));
	pstmt.setString(3, multiPart.getSavedFileName("fileName2"));
} 
else { 
	//파일명을 제외한 정보 수정
	sql = "update episodedb set episodeTitle=? where episodeIdx=?";
    pstmt = con.prepareStatement(sql);
    pstmt.setString(1, episodeTitle);
}

pstmt.executeUpdate(); 

if(pstmt != null) pstmt.close();
if(rs != null) rs.close();
if(con != null) con.close();

response.sendRedirect("result_webtoon.jsp");
%>