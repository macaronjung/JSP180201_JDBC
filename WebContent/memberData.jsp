<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
	<%!
		//���� �־����� �ʱ�ȭ ���� ����
		Connection connection; //���� con,stmt,set���� �ٿ���(������ �� ���� ��)
		Statement statement;
		ResultSet resultSet;
	
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe"; //������ DB�� ��� �ִ���
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
	
	<%	//���� DB ���ٹ�
		try{
			//con,stmt,set ��ü ����� �ֱ�
			Class.forName(driver);
			connection = DriverManager.getConnection(url, uid, upw);
			statement = connection.createStatement();
			resultSet = statement.executeQuery(query); //DB �ڷ� ������ ���� ��
			
			/*resultSet.next() (�����Ͱ� ������) �������� �̵� previous ���� ���ڵ�� �̵�
			  first() ó������ �̵� last() ���������� �̵�
			  getString,getInt �÷� �� ��ȯ(���� Ŀ�� �ִ� ��)
			*/
			while(resultSet.next()){ //resultSet���� ������ ������ ����
				String id = resultSet.getString("id");
				String pw = resultSet.getString("pw");
				String name = resultSet.getString("name");
				String phone = resultSet.getString("phone");
				
				out.println("���̵� : " + id + ", ��й�ȣ : " + pw + ", �̸� : " + name + ", ��ȭ��ȣ : " + phone + "<br>");
			}/*while end*/
			
		//DB �ݵ�� ����ó�� ���� �ʿ�!!!
		}/*try end*/ catch(Exception e) {
			e.printStackTrace();
		}/*catch end*/ finally { //try�� �̻��� ���� �ִ� finally ������ ����
			try{ //�ڿ������۾�(null �ε� �����ϸ� �������ϱ�)
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