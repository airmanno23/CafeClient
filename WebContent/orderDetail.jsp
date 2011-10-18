<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URL" %>
<%@ page import="com.sun.jersey.api.client.Client" %>
<%@ page import="com.sun.jersey.api.client.WebResource" %>
<%@ page import="com.sun.jersey.api.client.config.ClientConfig" %>
<%@ page import="com.sun.jersey.api.client.config.DefaultClientConfig" %>
<%@ page import="javax.ws.rs.core.UriBuilder" %>
<%@ page import="javax.ws.rs.core.MediaType" %>    
<%@ page import="org.codehaus.jettison.json.JSONObject" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css"/>
<title>Detail of Order</title>
</head>
<body marginheight="0">

<table border="0" cellpadding="0" cellspacing="0" align="center" class="back">
<tr><td align="center" valign="top" height="280px"><img alt="" src="images/cafe-banner1.jpg"></td></tr>
<tr>
<td align="center" valign="top" height="520px">	
<div class="content">	

<%
	String id = request.getParameter("id");
	ClientConfig cconfig = new DefaultClientConfig();
	Client client = Client.create(cconfig);
	WebResource service = client.resource(UriBuilder.fromUri("http://localhost:8080/CafeRESTfulServices").build());
	String orderStr = service.path("rest").path("orders/" + id).accept(MediaType.APPLICATION_JSON).get(String.class);
	JSONObject json = new JSONObject(orderStr);
	String cafeType = json.getString("type");
	String additions = json.getString("additions");
	String cost = json.getString("cost");
	String paidStatus = json.getString("paidStatus");
	String baristaStatus = json.getString("baristaStatus");
	
	if(paidStatus.equals("1"))
		paidStatus = "Not Paid";
	else
		paidStatus = "Paid";
	
	if(baristaStatus.equals("1"))
		baristaStatus = "Not Prepared";
	else if(baristaStatus.equals("2"))
		baristaStatus = "Prepared";
	else
		baristaStatus = "Released";
	
%>

<table align="left">
<tr>
<td width="100px"></td>
<td>

<table>
	<tr>
		<td class="response" colspan="2">Detail of Order:</td>
	</tr>
	<tr>
		<td class="name" width="180px">Order ID: </td>
		<td width="180px"><input name="oid" type="text" class="readonly" readonly="readonly" value="<%=id %>"></td>
	</tr>
	<tr>
		<td class="name">Cafe Type: </td>
		<td><input name="cafeType" type="text" class="readonly" readonly="readonly" value="<%=cafeType %>"></td>
	</tr>
	<tr>
		<td class="name">Additions: </td>
		<td><input name="additions" type="text" class="readonly" readonly="readonly" value="<%=additions %>"></td>
	</tr>
	<tr>
		<td class="name">Payment Amount:</td>
		<td><input name="amount" type="text" class="readonly" readonly="readonly" value="<%=cost %>"></td>
	</tr>
	<tr>
		<td class="name">Payment Status:</td>
		<td><input name="amount" type="text" class="readonly" readonly="readonly" value="<%=paidStatus %>"></td>
	</tr>
	<tr>
		<td class="name">Barista Status:</td>
		<td><input name="amount" type="text" class="readonly" readonly="readonly" value="<%=baristaStatus %>"></td>
	</tr>
	<tr>
		<td><input type="button" value="Back" onclick="window.location='orders.jsp'"></td>
	</tr>
</table>

</td>
<td align="left" valign="top" width="400px" class="response">
<div>Response: </div>
<div align="right"><textarea readonly="readonly" class="readonly" cols="40" rows="10"></textarea>
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
</html>