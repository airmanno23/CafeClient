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
<%@ page import="com.sun.jersey.api.client.ClientResponse" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css"/>
<title>Detail of Payment</title>
</head>
<body marginheight="0" leftmargin="0" rightmargin="0">

<table border="0" cellpadding="0" cellspacing="0" align="center" class="back">
<tr><td align="center" valign="top" height="280px"><img alt="" src="images/cafe-banner1.jpg"></td></tr>
<tr>
<td align="center" valign="top" height="520px">	
<div class="content">	

<%
	String oid = request.getParameter("id");
    String ref = request.getParameter("ref");
    if(ref == null)
    	ref = "orders.jsp";
	ClientConfig cconfig = new DefaultClientConfig();
	Client client = Client.create(cconfig);
	WebResource service = client.resource(UriBuilder.fromUri("http://localhost:8080/CafeRESTfulServices").build());
	ClientResponse orderRsp = service.path("rest").path("orders/" + oid).accept(MediaType.APPLICATION_JSON).get(ClientResponse.class);
	String orderStr = orderRsp.getEntity(String.class);
	JSONObject json = new JSONObject(orderStr);
	String cafeType = json.getString("type");
	String additions = json.getString("additions");
	
	ClientResponse paymentRsp = service.path("rest").path("payments/" + oid).accept(MediaType.APPLICATION_JSON).get(ClientResponse.class);
	String paymentStr = paymentRsp.getEntity(String.class);
	JSONObject payment = new JSONObject(paymentStr);
	String cost = payment.getString("amount");
	String paymentType = payment.getString("type");
	String cardNumber = payment.getString("cardNumber");
	
	String rsp = paymentRsp.toString() + "\n" + paymentStr;
%>

<table align="left">
<tr>
<td width="100px"></td>
<td>

<table>
	<tr>
		<td class="response" colspan="2">Detail of Payment:</td>
	</tr>
	<tr>
		<td class="name" width="180px">Order ID: </td>
		<td width="180px"><input name="oid" type="text" class="readonly" readonly="readonly" value="<%=oid %>"></td>
	</tr>
	<tr>
		<td class="name">Coffee Type: </td>
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
		<td class="name">Payment Type:</td>
		<td><input name="amount" type="text" class="readonly" readonly="readonly" value="<%=paymentType %>"></td>
	</tr>
<%
	if(!cardNumber.equals("")) {
%>
	<tr>
		<td class="name">Card Number:</td>
		<td><input name="amount" type="text" class="readonly" readonly="readonly" value="<%=cardNumber %>"></td>
	</tr>
<%
	}
%>
	<tr>
		<td><input type="button" value="Back" onclick="window.location='<%=ref %>'"></td>
	</tr>
</table>

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
</html>