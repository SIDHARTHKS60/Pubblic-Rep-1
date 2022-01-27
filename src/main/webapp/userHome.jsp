<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Home</title>
<h1>HOME PAGE</h1>
</head>
<body>
<% 
   String uName=session.getAttribute("um").toString();
String userType=session.getAttribute("ut").toString();

int ut=Integer.parseInt(userType);

try
{ Class.forName("com.mysql.cj.jdbc.Driver");
  Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/libmanag","root","root");
 	
PreparedStatement stmt=con.prepareStatement("select * from user_menu where user_Role ="+ut);

ResultSet rst=stmt.executeQuery();

while(rst.next()){out.println("<a href= "+rst.getString("url")+">"+rst.getString("menu_item")+"</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");}

}
	catch(Exception e){out.println(e.toString());}
	%>
</body>
</html>