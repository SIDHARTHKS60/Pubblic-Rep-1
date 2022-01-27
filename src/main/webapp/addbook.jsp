<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Books</title>
</head>
<body>
<%@ include file="userHome.jsp" %>
<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
	
	String title=request.getParameter("title");
	String author=request.getParameter("author");
	String publication=request.getParameter("publication");
	String edition=request.getParameter("edition");
     int price=Integer.parseInt(request.getParameter("price"));
	
try
{ Class.forName("com.mysql.cj.jdbc.Driver");
 	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/libmanag","root","root");
 	
        	 PreparedStatement stmt=con.prepareStatement("insert into books(author,title,Edition,Price,Publication) values(?,?,?,?,?)");
                    	 stmt.setString(1,author);
                    	 stmt.setString(2,title);
                    	 stmt.setString(3,edition);
                    	 stmt.setInt(4,price);
                    	 stmt.setString(5,publication);
                    	                    	
                    	 stmt.executeUpdate();
                    	 out.println("<div align='center'><h1>BOOK INSERTED SUCCESSFULLY</h1></div>");
                     
}catch(Exception e){out.println(e.toString());}
}	
else{ %>
<form action="addbook.jsp" method="post">
<label>Title : <input type="text" name="title" required/></label><br><br>
<label>Author : <input type="text" name="author" required/></label><br><br>
<label>Publication : <input type="text" name="publication"/></label><br><br>
<label>Edition : <input type="text" name="edition"/></label><br><br>
<label>Price : <input type="number" name="price"/></label><br><br>
<input type="submit" value="ADD"/><br>
<input type="reset" value="CANCEL"/>   
</form>
<% }%>
</body>
</html>