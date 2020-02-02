<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
	<%!
		//값은 주었지만 초기화 아직 안함
		Connection connection; //원래 con,stmt,set으로 줄여씀(지금은 다 적을 것)
		Statement statement;
		ResultSet resultSet;
	
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe"; //실제로 DB가 어디에 있는지
		String uid = "scott";
		String upw = "tiger";
		String query = "select * from member";
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	
	<%	//실제 DB 접근문
		try{
			//con,stmt,set 객체 만들어 주기
			Class.forName(driver);
			connection = DriverManager.getConnection(url, uid, upw);
			statement = connection.createStatement();
			resultSet = statement.executeQuery(query); //DB 자료 가지고 오는 것
			
			/*resultSet.next() (데이터가 있으면) 다음으로 이동 previous 이전 레코드로 이동
			  first() 처음으로 이동 last() 마지막으로 이동
			  getString,getInt 컬럼 값 반환(지금 커서 있는 곳)
			*/
			while(resultSet.next()){ //resultSet으로 데이터 가지고 오기
				String id = resultSet.getString("id");
				String pw = resultSet.getString("pw");
				String name = resultSet.getString("name");
				String phone = resultSet.getString("phone");
				
				out.println("아이디 : " + id + ", 비밀번호 : " + pw + ", 이름 : " + name + ", 전화번호 : " + phone + "<br>");
			}/*while end*/
			
		//DB 반드시 예외처리 설정 필요!!!
		}/*try end*/ catch(Exception e) {
			e.printStackTrace();
		}/*catch end*/ finally { //try는 이상이 없던 있던 finally 무조건 실행
			try{ //자원해제작업(null 인데 접근하면 에러나니까)
				if(resultSet != null) resultSet.close();
				if(statement != null) statement.close();
				if(connection != null) connection.close();
			}/*try end*/ catch(Exception e2){
				e2.printStackTrace();
			}/*catch2 end*/
		}/*finally end*/
	%>
	
</body>
</html>