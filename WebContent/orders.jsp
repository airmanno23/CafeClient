<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.net.URL" %>
<%@ page import="com.sun.jersey.api.client.Client" %>
<%@ page import="com.sun.jersey.api.client.WebResource" %>
<%@ page import="com.sun.jersey.api.client.config.ClientConfig" %>
<%@ page import="com.sun.jersey.api.client.config.DefaultClientConfig" %>
<%@ page import="javax.ws.rs.core.UriBuilder" %>
<%@ page import="javax.ws.rs.core.MediaType" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="js/toggle.js"></script>
<link rel="stylesheet" type="text/css" href="css/stylesheet.css"/>
<title>Cafe Orders</title>
</head>
<body marginheight="0" leftmargin="0" rightmargin="0">

<table border="0" cellpadding="0" cellspacing="0" align="center" class="back">
<tr><td align="center" valign="top" height="280px"><img alt="" src="images/cafe-banner1.jpg"></td></tr>
<tr>
<td align="center" valign="top" height="520px">	
<div class="content">	

<% 
	ClientConfig cconfig = new DefaultClientConfig();
	Client client = Client.create(cconfig);
	WebResource service = client.resource(UriBuilder.fromUri("http://localhost:8080/CafeRESTfulServices").build());
	String results = service.path("rest/orders").accept(MediaType.APPLICATION_JSON).get(String.class);
	JSONObject json = null;
	
	if(!results.equals("null"))
		json = new JSONObject(results);
	JSONArray orders = null;
	JSONObject order = null;
	if(json != null && json.has("order") && json.toString().contains("["))
		orders = json.getJSONArray("order");
	
	if(json != null && json.has("order") && !json.toString().contains("[")) 
		order = json.getJSONObject("order");
	
	String t = request.getParameter("type");
	String a = request.getParameter("additions");
	String o_id = request.getParameter("id");
	
	session.setAttribute("paymentURI", "http://localhost:8080/CafeRESTfulServices/rest/payments/1");
	String rsp = "";
	String payResponse = (String)session.getAttribute("payResponse");
	String updateResponse = (String)session.getAttribute("updateResponse");
	String updateGetResponse = (String)session.getAttribute("updateGetResponse");
	String newResponse = (String)session.getAttribute("newResponse");
	String deleteResponse = (String)session.getAttribute("deleteResponse");
	String optionsResponse = (String)session.getAttribute("optionsResponse");
	session.removeAttribute("payResponse");
	session.removeAttribute("updateResponse");
	session.removeAttribute("updateGetResponse");
	session.removeAttribute("newResponse");
	session.removeAttribute("deleteResponse");
	session.removeAttribute("optionsResponse");
	if(payResponse != null)
		rsp = payResponse;
	if(updateResponse != null)
		rsp = updateResponse;
	if(updateGetResponse != null)
		rsp = updateGetResponse;
	if(newResponse != null)
		rsp = newResponse;
	if(deleteResponse != null)
		rsp = deleteResponse;
	if(optionsResponse != null)
		rsp = optionsResponse;
%>

<% 
	if(t != null && t.length() != 0) {
%>
<table align="left">
<tr>
<td width="100px"><td>
<td>
<form method="post" action="DoUpdate">
<table align="left">
	<tr><td colspan="2"><input name="id" value="<%=o_id %>" type="hidden"></td></tr>
	<tr>
		<td class="name" width="150px">Type: </td>
		<td><select id="type" name="type" style="width:120px;">
			<option value="<%=t %>"><%=t %></option>
<% 
	if(!t.equals("Mocha")) {
%>
			<option value="Mocha" label="Mocha">Mocha</option>
<%
	}
	if(!t.equals("Long Black")) {
%>
			<option value="Long Black" label="Long Black">Long Black</option>
<%
	}
	if(!t.equals("Latte")) {
%>
			<option value="Latte" label="Latte">Latte</option>
<%
	}
	if(!t.equals("Cappuccino")) {
%>
			<option value="Cappuccino" label="Cappuccino">Cappuccino</option>
<%
	}
%>
		</select></td>
	</tr>
	<tr>
		<td class="name">Additions: </td>
		<td><select name="additions" style="width:120px;">
			<option value="<%=a %>"><%=a %></option>
<% 
	if(!a.equals("None")) {
%>
			<option value="None" label="None">None</option>
<% 
	}
	if(!a.equals("Skim milk")) {
%>
			<option value="Skim milk" label="Skim milk">Skim milk</option>
<% 
	}
	if(!a.equals("Extra shot")) {
%>
			<option value="Extra shot" label="Extra shot">Extra shot</option>
<%
	}
%>
		</select></td>
	</tr>
	<tr>
		<td colspan="2" align="center"><input name="cancel" value="Cancel" type="button" onclick="window.location='orders.jsp'">
		<input name="submit" value="Submit" type="submit"></td>
	</tr>
</table>
</form>
</td></tr></table>
<% 
	}
%>

<table align="left">
<tr>
<td width="100px"><td>
<td>

<div id="NewOrder" class="newOrder">
<form id="NewOrderForm" method="post" action="MakeOrder" onsubmit="return validateForm()">
<table>
	<tr>
		<td class="name" width="150px">Type: </td>
		<td><select id="type" name="type" style="width:120px;">
			<option value="null">----SELECT----</option>
			<option value="Mocha" label="Mocha">Mocha</option>
			<option value="Long Black" label="Long Black">Long Black</option>
			<option value="Latte" label="Latte">Latte</option>
			<option value="Cappuccino" label="Cappuccino">Cappuccino</option>
		</select></td>
	</tr>
	<tr>
		<td class="name">Additions: </td>
		<td><select name="additions" style="width:120px;">
			<option value="None">----SELECT----</option>
			<option value="None" label="None">None</option>
			<option value="Skim milk" label="Skim milk">Skim milk</option>
			<option value="Extra shot" label="Extra shot">Extra shot</option>
		</select></td>
	</tr>
	<tr>
		<td colspan="2"><input name="submit" value="Submit" type="submit"></td>
	</tr>
</table>
</form>
</div>
</td></tr></table>

<table align="left">
<tr>
<td width="60px"></td>
<td valign="top">

<table align="left">
	<tr>
		<td colspan="4"><a class="newOrder" id="displayText" href="javascript:toggle()">New Order</a></td>
	</tr>
	<tr class="title">
		<td width="150px">Orders</td>
		<td width="120px">Payments</td>
		<td width="185px" colspan="4">Operations</td>
	</tr>
<%
	if(orders != null) {
		for(int i = 0; i < orders.length(); i++) {
			JSONObject o = new JSONObject(orders.getString(i));
			String id = o.getString("id");
			String paidStatus = o.getString("paidStatus");
			String payment = null;
			if(!paidStatus.equals("1")) {
				payment = service.path("rest/payments/" + id).accept(MediaType.APPLICATION_JSON).get(String.class);
			}
%>
	<tr class="order">
		<td><a class="order" href="orderDetail.jsp?ref=orders.jsp&id=<%=id %>">Coffee Order <%=id %></a></td>
<% 
			if(payment != null) {
%>
		<td><a class="order" href="paymentDetail.jsp?id=<%=id %>">Payment <%=id %></a></td>
<%
			} else {
%>
		<td>Not Paid</td>
<%
			}
%>
		<td width="50px" align="center"><a class="cancel" href="OrderCancel?id=<%=id %>">Cancel</a></td>
		<td width="50px" align="center"><a class="update" href="UpdateOrder?id=<%=id %>">Update</a></td>
		<td width="35px" align="center"><a class="pay" href="Pay.jsp?id=<%=id %>">Pay</a></td>
		<td width="50px" align="center"><a class="options" href="CheckOptions?id=<%=id %>">Options</a></td>
	</tr>
<%
		}
	}
	else if(order != null) {
		String id = order.getString("id");
		String paidStatus = order.getString("paidStatus");
		String payment = null;
		if(!paidStatus.equals("1"))
			payment = service.path("rest/payments/" + id).accept(MediaType.APPLICATION_JSON).get(String.class);
%>
		<tr class="order">
		<td><a class="order" href="orderDetail.jsp?ref=orders.jsp&id=<%=id %>">Coffee Order <%=id %></a></td>
<% 
			if(payment != null) {
%>
		<td><a class="order" href="paymentDetail.jsp?id=<%=id %>">Payment <%=id %></a></td>
<%
			} else {
%>
		<td>Not Paid</td>
<%
			}
%>
		<td width="50px" align="center"><a class="cancel" href="OrderCancel?id=<%=id %>">Cancel</a></td>
		<td width="50px" align="center"><a class="update" href="UpdateOrder?id=<%=id %>">Update</a></td>
		<td width="35px" align="center"><a class="pay" href="Pay.jsp?id=<%=id %>">Pay</a></td>
		<td width="50px" align="center"><a class="options" href="CheckOptions?id=<%=id %>">Options</a></td>
	</tr>
<%
	}
%>
</table>

</td>
<td align="left" valign="top" width="380px" class="response">
<div align="right"><a class="order" href="barista.jsp">Barista</a></div>
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