<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>E-Lib Manager</title>
<script>
function validateForm() {
	let x = document.forms["form1"]["username"].value;
	let y = document.forms["form1"]["password"].value;
	if (x == "" || y == "") {
		alert("UserName and Password must be filled out");
		return false;
	}
}
</script>
</head>
<body>
<% 
	if ("POST".equalsIgnoreCase(request.getMethod())) {
		String uname=request.getParameter("username");
		String pwd=request.getParameter("password");
		try
		{ Class.forName("com.mysql.cj.jdbc.Driver");
		 	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/libmanag","root","root");
			PreparedStatement stmt = con.prepareStatement("select * from user where user_name=? and password=? and status=1");
			stmt.setString(1,uname);
			stmt.setString(2,pwd);
			ResultSet rs = stmt.executeQuery();
			if(rs.next())
			{
			// out.println("Valid User,Logged In Successfully");
			// out.println("Username is "+rs.getString("user_name"));
			// out.println("UserType is "+rs.getInt("user_type"));
					
			session.setAttribute("um",uname);
			session.setAttribute("ut",rs.getInt("user_type"));
			
			response.sendRedirect("userHome.jsp");
			
			}else { out.println("Invalid Credentials");}
		}
		catch(Exception e) {out.println(e.toString());}
			}
	else {
		%>
		    <form action="Login.jsp" name="form1"  method="post">
			<label>User Name</label>
			<input type="text" name="username" required>
			
			<br><br>
			<label>Password</label>
			<input type="password" name="password" required>
			<br><br>
			<input type="submit" value="login">
			<input type="reset" value="cancel">
			</form>
		<%
	}
%>
</body>
</html>