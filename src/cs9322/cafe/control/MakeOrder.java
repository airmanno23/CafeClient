package cs9322.cafe.control;

import java.io.IOException;
import java.net.URI;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriBuilder;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.representation.Form;


/**
 * Servlet implementation class MakeOrder
 */
public class MakeOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MakeOrder() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("type");
		String additions = request.getParameter("additions");
		ClientConfig config = new DefaultClientConfig();
		Client client = Client.create(config);
		WebResource service = client.resource(getBaseURI());
		Form form = new Form();
		form.add("type", type);
		form.add("additions", additions);
		ClientResponse clientRsp = service.path("rest/orders").type(MediaType.APPLICATION_FORM_URLENCODED).post(ClientResponse.class, form);
		
		HttpSession session = request.getSession();
		String content = clientRsp.getEntity(String.class);
		String[] URIs = content.split("#");
		String newResponse = clientRsp.toString() + "\n" + URIs[0] + "\n" + URIs[1];
		
		session.setAttribute("paymentURI", URIs[1]);
		session.setAttribute("newResponse", newResponse);
		
		response.sendRedirect("orders.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	private static URI getBaseURI() {
		return UriBuilder.fromUri("http://localhost:8080/CafeRESTfulServices").build();
	}

}
