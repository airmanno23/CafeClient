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
<script type="text/javascript" src="js/toggle.js"></script>
<link rel="stylesheet" type="text/css" href="css/stylesheet.css"/>
<title>Pay the order</title>
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
	ClientResponse clientRsp = service.path("rest").path("orders/" + id).accept(MediaType.APPLICATION_JSON).get(ClientResponse.class);
	String result = clientRsp.getEntity(String.class);
	JSONObject json = new JSONObject(result);
	String cost = json.getString("cost");
	String cafeType = json.getString("type");
	String additions = json.getString("additions");
	
	String rsp = clientRsp.toString() + "\n" + result;
%>

<table align="left">
<tr>
<td width="100px"></td>
<td>

<form id="paymentForm" method="post" onsubmit="return validatePaymentForm()" action="MakePayment">
<table>
	<tr>
		<td class="response" colspan="2">Pay the Order:</td>
	</tr>
	<tr>
		<td class="name" width="180px">Order ID:</td>
		<td width="180px"><input name="oid" type="text" class="readonly" readonly="readonly" value="<%=id %>"></td>
	</tr>
	<tr>
		<td class="name">Cafe type: </td>
		<td><input name="cafeType" type="text" class="readonly" readonly="readonly" value="<%=cafeType %>"></td>
	</tr>
	<tr>
		<td class="name">Additions: </td>
		<td><input name="additions" type="text" class="readonly" readonly="readonly" value="<%=additions %>"></td>
	</tr>
	<tr>
		<td class="name">Payment amount:</td>
		<td><input name="amount" type="text" class="readonly" readonly="readonly" value="<%=cost %>"></td>
	</tr>
	<tr>
		<td class="name">Payment type:</td>
		<td>
			<select name="paymentType" onchange="javascript:selectCard(this)">
				<option value="None">---SELECT---</option>
				<option value="Cash">Cash</option>
				<option value="Card">Card</option>
			</select>
		</td>
	</tr>
</table>

<div id="cardDetail" style="display:none;">
<table>
	<tr>
		<td class="name" width="180px">Card Number: </td>
		<td width="180px"><input name="cardNumber" type="text" value=""></td>
	</tr>
</table>
</div>
<table>
	<tr>
		<td><input name="cancel" type="button" value="Cancel" onclick="window.location='orders.jsp'"></td>
		<td><input name="submit" type="submit" value="Submit"></td>
	</tr>
</table>
</form>

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