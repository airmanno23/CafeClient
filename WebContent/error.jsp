<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css"/>
<title>Error</title>
</head>
<body marginheight="0">

<%
	String rsp = "";
	String deleteResponse = (String)session.getAttribute("deleteResponse");
	String updateResponse = (String)session.getAttribute("updateResponse");
	String payResponse = (String)session.getAttribute("payResponse");
	session.removeAttribute("deleteResponse");
	session.removeAttribute("updateResponse");
	session.removeAttribute("payResponse");
	if(deleteResponse != null)
		rsp = deleteResponse;
	if(updateResponse != null)
		rsp = updateResponse;
	if(payResponse != null)
		rsp = payResponse;
	String id = request.getParameter("id");
	String errorMsg = "";
	if(id != null) {
		if(id.equals("1"))
			errorMsg = "Oops, you can not cancel this order.";
		if(id.equals("2"))
			errorMsg = "Oops, you can not update this order.";
		if(id.equals("3"))
			errorMsg = "Oops, you can not pay this order.";
	}

%>

<table border="0" cellpadding="0" cellspacing="0" align="center" class="back">
<tr><td align="center" valign="top" height="280px"><img alt="" src="images/cafe-banner1.jpg"></td></tr>
<tr>
<td align="center" valign="top" height="520px">	
<div class="content">

<table align="left">
<tr>
<td width="60px"></td>
<td valign="middle" width="400px" class="error">
<div><%=errorMsg %></div>
<div align="right"><input value="Back" type="button" onclick="window.location='orders.jsp'"></div>
</td>
<td align="left" valign="top" width="400px" class="response">
<div>Response: </div>
<div align="right"><textarea readonly="readonly" class="readonly" cols="50" rows="10"><%=rsp %></textarea>
</div></td>
</tr></table>

</div>
<div class="footer">
	Copyright ©2011-2012 SPECTACULAR All Right Reserved
</div>
</td>
</tr>
</table>
</body>
</body>
</html>