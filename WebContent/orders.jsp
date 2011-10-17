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
<body>

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
	
%>

<% 
	if(t != null && t.length() != 0) {
%>
<form method="post" action="DoUpdate">
<table>
	<tr><td><input name="id" value="<%=o_id %>" type="hidden"></td></tr>
	<tr>
		<td>Type: </td>
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
		<td>Additions: </td>
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
		<td colspan="2"><input name="submit" value="Submit" type="submit"></td>
	</tr>
</table>
</form>
<% 
	}
%>
<div id="NewOrder" class="newOrder">
<form id="NewOrderForm" method="post" action="MakeOrder" onsubmit="return validateForm()">
<table>
	<tr>
		<td>Type: </td>
		<td><select id="type" name="type" style="width:120px;">
			<option value="null">----SELECT----</option>
			<option value="Mocha" label="Mocha">Mocha</option>
			<option value="Long Black" label="Long Black">Long Black</option>
			<option value="Latte" label="Latte">Latte</option>
			<option value="Cappuccino" label="Cappuccino">Cappuccino</option>
		</select></td>
	</tr>
	<tr>
		<td>Additions: </td>
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

<form method="post" action="controller">
<table>
	<tr>
		<td colspan="4"><a id="displayText" href="javascript:toggle()">New Order</a></td>
	</tr>
	<tr>
		<td>ID</td>
		<td>Type</td>
		<td>Additions</td>
		<td>Cost</td>
	</tr>
<%
	if(orders != null) {
		for(int i = 0; i < orders.length(); i++) {
			JSONObject o = new JSONObject(orders.getString(i));
			String id = o.getString("id");
			String type = o.getString("type");
			String additions = o.getString("additions");
			String cost = o.getString("cost");
%>
	<tr>
		<td><%=id %></td>
		<td><%=type %></td>
		<td><%=additions %></td>
		<td><%=cost %></td>
		<td><a href="OrderCancel?id=<%=id %>">Cancel</a></td>
		<td><a href="UpdateOrder?id=<%=id %>">Update</a></td>
		<td><a href="Pay.jsp?id=<%=id %>">Pay</a></td>
	</tr>
<%
		}
	}
	else if(order != null) {
		String id = order.getString("id");
		String type = order.getString("type");
		String additions = order.getString("additions");
		String cost = order.getString("cost");
%>
	<tr>
		<td><%=id %></td>
		<td><%=type %></td>
		<td><%=additions %></td>
		<td><%=cost %></td>
		<td><a href="OrderCancel?id=<%=id %>">Cancel</a></td>
		<td><a href="UpdateOrder?id=<%=id %>">Update</a></td>
		<td><a href="Pay.jsp?id=<%=id %>">Pay</a></td>
	</tr>
<%
	}
%>
</table>
</form>

</body>
</html>