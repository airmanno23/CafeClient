<%@ page import="com.sun.jersey.api.client.Client" %>
<%@ page import="com.sun.jersey.api.client.WebResource" %>
<%@ page import="com.sun.jersey.api.client.config.ClientConfig" %>
<%@ page import="com.sun.jersey.api.client.config.DefaultClientConfig" %>
<%@ page import="javax.ws.rs.core.UriBuilder" %>
<%@ page import="javax.ws.rs.core.MediaType" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="5" />
<link rel="stylesheet" type="text/css" href="css/stylesheet.css"/>
<title>Barista</title>
</head>
<body marginheight="0" leftmargin="0" rightmargin="0">
<table border="0" cellpadding="0" cellspacing="0" align="center" class="back">
<tr><td align="center" valign="top" height="280px"><img alt="" src="images/cafe-banner1.jpg"></td></tr>
<tr>
<td align="center" valign="top" height="520px">	
<div class="content">
<table align="left" style="margin-top: 8px">
<tr>
<td width="60px"></td>
<td>
	<%
		ClientConfig cconfig = new DefaultClientConfig();
		Client client = Client.create(cconfig);
		WebResource service = client.resource(UriBuilder.fromUri(
				"http://localhost:8080/CafeRESTfulServices").build());
		String results = service.path("rest/orders")
				.accept(MediaType.APPLICATION_JSON).get(String.class);
		JSONObject json = null;

		if (!results.equals("null"))
			json = new JSONObject(results);
		JSONArray orders = null;
		if (json != null && json.has("order")
				&& json.toString().contains("["))
			orders = json.getJSONArray("order");
	%>
	<table align="left">
	<tr>
	   <td><a class="newOrder" href="barista.jsp">Refresh</a></td>
	</tr>
	<tr class="title">
		<td>Orders</td>
		<td>Operations</td>
	</tr>
	<% if (orders != null) {
	      for (int i=0; i < orders.length(); ++i) { 
	    	  JSONObject jsObject = new JSONObject(orders.getString(i));
	    	  if (jsObject.getString("baristaStatus").equals("3"))
	    		  continue;
	    	  String id = jsObject.getString("id");
	%>
		<tr>
			<td width="190px" align="left"><a class="order" href="orderDetail.jsp?ref=barista.jsp&id=<%=id %>">Coffee Order <%=id %></a></td>
			<td width="60px" align="center"><a class="cancel" href="UpdateOrderStatus?baristaStatus=2&id=<%=id %>">Prepare</a></td>
			<td width="130px" align="center"><a class="update" href="CheckPayment?id=<%=id %>">Check Payment</a></td>
			<td width="60px" align="center"><a class="pay" href="UpdateOrderStatus?baristaStatus=3&id=<%=id %>">Release</a></td>
		</tr>
	<%   } //end for
	  } //end if
	%>
	</table>
	</td>
<td align="left" valign="top" width="380px" class="response">
<div align="right"><a class="order" href="orders.jsp">Cashier</a></div>
<div>Response: </div>
<div align="right"><textarea readonly="readonly" class="readonly" cols="50" rows="10"></textarea>
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