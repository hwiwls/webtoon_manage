<%@ page contentType="text/html;charset=utf-8"
	import="java.sql.*, java.io.*"%>
<%
request.setCharacterEncoding("utf-8");
 
try {
	String idx = request.getParameter("webtoonIdx");
 
	Class.forName("org.mariadb.jdbc.Driver");
	
  
	String DB_URL = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
	String DB_USER = "admin";
	String DB_PASSWORD= "1234";
 
	Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);  
	
	// idx에 해당하는 삭제할 파일명 savedFileName을 테이블에서 알아내기 위한 쿼리 문자열 구성
	String sql = "select savedFileName from webtoondb where webtoonIdx=?";
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	//PreparedStatement 객체의 쿼리 문자열 중 첫번째인  idx 값 설정하기
	pstmt.setInt(1, Integer.parseInt(idx));
	
	//쿼리 실행
	ResultSet rs = pstmt.executeQuery();
	
	rs.next();
	
	//삭제할 savedFileName 필드의 값 알아내기
	String filename = rs.getString("savedFileName");
	 
	ServletContext context = getServletContext();
	String realFolder = context.getRealPath("upload");
	
	// 앞에서 알아낸 서버의 경로명과 파일명으로 파일 객체 생성하기
	File file = new File(realFolder+File.separator+filename);
	
	file.delete();
	
	//테이블에서 지정한 idx의 레코드를 삭제하기 위한 쿼리 문자열 구성하기
	sql = "delete from webtoondb where webtoonIdx=?";
	
	pstmt = con.prepareStatement(sql);
	
	// PreparedStatement 객체의 쿼리 문자열 중 첫번째인  idx 값 설정하기
	pstmt.setInt(1, Integer.parseInt(idx));
	
	pstmt.executeUpdate();
	
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

response.sendRedirect("mainPage.jsp");   
%>
