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
<script type="text/javascript" src="js/toggle.js"></script>
<title>Pay the order</title>
</head>
<body>

<%
	String id = request.getParameter("id");
	ClientConfig cconfig = new DefaultClientConfig();
	Client client = Client.create(cconfig);
	WebResource service = client.resource(UriBuilder.fromUri("http://localhost:8080/CafeRESTfulServices").build());
	String result = service.path("rest").path("orders/" + id).accept(MediaType.APPLICATION_JSON).get(String.class);
	JSONObject json = new JSONObject(result);
	String cost = json.getString("cost");
	String cafeType = json.getString("type");
	String additions = json.getString("additions");
%>

<form id="paymentForm" method="post" onsubmit="return validatePaymentForm()">
<table>
	<tr>
		<td>Order ID:</td>
		<td><%=id %></td>
	</tr>
	<tr>
		<td>Cafe type: </td>
		<td><%=cafeType %></td>
	</tr>
	<tr>
		<td>Additions: </td>
		<td><%=additions %></td>
	</tr>
	<tr>
		<td>Payment amount:</td>
		<td><%=cost %></td>
	</tr>
	<tr>
		<td>Payment type:</td>
		<td>
			<select name="type" onchange="javascript:selectCard(this)">
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
		<td>Card Number: </td>
		<td><input name="cardNO" type="text"></td>
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

</body>
</html>