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
<title>Cafe Orders</title>
</head>
<body>

<% 
	ClientConfig cconfig = new DefaultClientConfig();
	Client client = Client.create(cconfig);
	WebResource service = client.resource(UriBuilder.fromUri("http://localhost:8080/CafeRESTfulServices").build());
	String results = service.path("rest/orders").accept(MediaType.APPLICATION_JSON).get(String.class);
	JSONObject json = new JSONObject(results);
	JSONArray orders = json.getJSONArray("order");
	
%>

<form method="post" action="controller">
<table>
	<tr>
		<td>ID</td>
		<td>Type</td>
		<td>Additions</td>
		<td>Cost</td>
	</tr>
<%
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
	</tr>
<%
	}
%>
</table>
</form>
</body>
</html>