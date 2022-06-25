<%@ page  contentType="text/html; charset=UTF-8" import="java.sql.*, java.io.*"
    %>
<%
request.setCharacterEncoding("utf-8");
 
try {
	// 사용자가 get방식으로 전달한 idx값 알아내기 
	String idx = request.getParameter("episodeIdx");
 
	Class.forName("org.mariadb.jdbc.Driver");
	
  
	String DB_URL = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
	String DB_USER = "admin";
	String DB_PASSWORD= "1234";
 
	//연결자 정보 획득
	Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);  
	
	//idx에 해당하는 삭제할 파일명 savedFileName2,3을 테이블에서 알아내기 위한 쿼리 문자열 구성
	String sql = "select savedFileName2 from episodedb where episodeIdx=?";
	String sql2 = "select savedFileName3 from episodedb where episodeIdx=?";
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	PreparedStatement pstmt2 = con.prepareStatement(sql2);
	
	pstmt.setInt(1, Integer.parseInt(idx));
	pstmt2.setInt(1, Integer.parseInt(idx));
	
	ResultSet rs = pstmt.executeQuery();
	rs.next();
	ResultSet rs2 = pstmt2.executeQuery();
	rs2.next();
	
	
	String filename = rs.getString("savedFileName2");
	String filename2 = rs2.getString("savedFileName3");
	 
	ServletContext context = getServletContext();
	String realFolder = context.getRealPath("upload");
	
	File file = new File(realFolder+File.separator+filename);
	File file2 = new File(realFolder+File.separator+filename2);
	
	file.delete();
	file2.delete();
	
	sql = "delete from episodedb where episodeIdx=?";
	
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(idx));
	pstmt2 = con.prepareStatement(sql2);
	pstmt2.setInt(1, Integer.parseInt(idx));
	
	pstmt.executeUpdate();
	pstmt2.executeUpdate();
	
	rs.close();
	pstmt.close();
	con.close();
} catch (SQLException e) {
	out.println(e.toString());
	return;
} catch (Exception e) { 
	out.println(e.toString());
	return;
}

response.sendRedirect("result_webtoon.jsp");   
%>
