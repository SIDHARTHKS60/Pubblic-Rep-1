<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Change Password</title>
<script>
	function validateForm() {
		let x = document.forms["form1"]["new"].value;
		let y = document.forms["form1"]["confirm"].value;
		//alert(x===y);
		if (x===y) {
			
			return true;
		}
		else{
			
			
			return false;
		}
	}
</script>
</head>
<%@ include file="userHome.jsp" %>
<body>
	<%
	if ("POST".equalsIgnoreCase(request.getMethod())) {
		String oldPass = request.getParameter("old");
		String newPass= request.getParameter("new");
		String confirmPass = request.getParameter("confirm");
	
		String unmae=session.getAttribute("um").toString();
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/libmanag", "root", "root");

			PreparedStatement stmt = con.prepareStatement("update user set password = ? where user_name=?");
			
			
			stmt.setString(1,newPass);
			stmt.setString(2,unmae);
			
			stmt.executeUpdate();		
			out.println("<div align='center'><h1>PASSWORD CHANGED SUCCESSFULLY</h1></div>");
		}
		catch(Exception e)
		{
			out.println(e.toString());
		}
		
	}
	else{
		%>
		<form name="form1" action="password.jsp" method="post" onSubmit="return validateForm()">
		
		<label>Old Password : </label>
		<input type= "password" name="old" required/><br><br>
		
		<label>New Password : </label>
		<input type= "password" name="new" required/><br><br>
		
		<label>Confirm New Password : </label>
		<input type= "password" name="confirm" required/><br><br>
		
		<input type="submit" value="SUBMIT"/><br><br>
		<input type="reset" value="Cancel"/>
		
		</form>
		
		<%
	}

%>
</body>
</html>