<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Members</title>
</head>
<body>
<%@ include file="userHome.jsp"%>
<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
	String uname=request.getParameter("username");
	String pwd=request.getParameter("password");
	String name=request.getParameter("uname");
	String address=request.getParameter("address");
	String email=request.getParameter("email");
	String mobileNo=request.getParameter("mob");
	char gender=request.getParameter("gender").charAt(0);
	java.util.Date date=Date.valueOf(request.getParameter("dob"));
    
	java.sql.Date d1=new java.sql.Date(date.getTime());
try
{ Class.forName("com.mysql.cj.jdbc.Driver");
 	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/libmanag","root","root");
 	
 	PreparedStatement stmt=con.prepareStatement("select * from user where user_name=?");
                 stmt.setString(1,uname);
                 
                 ResultSet rst=stmt.executeQuery();
                 
                 if(rst.next()){
                	 out.println("User name already exists, User not created");
                 }else{
                	 PreparedStatement stmt1=con.prepareStatement("insert into user (user_name,password,user_type) values(?,?,0)");
                	 stmt1.setString(1,uname);
                	 stmt1.setString(2,pwd);
                	 
                	 stmt1.executeUpdate();
                	 
                	 rst=stmt.executeQuery();
                     
                     if(rst.next()){
                    	 int uid=rst.getInt("user_id");
                    	 PreparedStatement stmt2=con.prepareStatement("insert into userdetails values(?,?,?,?,?,?,?)");
                    	 stmt2.setInt(1,uid);
                    	 stmt2.setString(2,name);
                    	 stmt2.setString(3,address);
                    	 stmt2.setString(4,email);
                    	 stmt2.setString(5,mobileNo);
                    	 stmt2.setString(6,String.valueOf(gender));
                    	 stmt2.setDate(7,d1);
                    	
                    	 stmt2.executeUpdate();
                    	 out.println("<div align='center'><h1>ADDED SUCCESSFULLY</h1></div>");
                     }
                	 
                 }   
}catch(Exception e){out.println(e.toString());}
}	
else{%>
<form action="addmember.jsp" method="post" name="form2">
<label>User Name</label>
<input type="text" name="username"/><br>
<label>Password</label>
<input type="password" name="password"/><br>
<label>Name</label>
<input type="text" name="uname"/><br>
<label>Address</label>
<textarea rows="5" cols="20"name="address"/></textarea><br>
<label>Email</label>
<input type="email" name="email"/><br>
<label>Mobile No</label>
<input type="number" name="mob"/><br>
<label>Gender</label>
<input type="radio" name="gender" value="m">Male</input>
<input type="radio" name="gender" value="f">Female</input>
<input type="radio" name="gender" value="o">Others</input>
<br>
<label>DOB</label>
<input type="date" name="dob"/><br>      

<input type="submit" value="SUBMIT"/><br>
<input type="reset" value="Cancel"/>   
</form>
<% }%>
</body>
</html>