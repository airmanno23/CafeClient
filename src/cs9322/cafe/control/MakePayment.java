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
 * Servlet implementation class MakePayment
 */
public class MakePayment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MakePayment() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String oid = request.getParameter("oid");
		String amount = request.getParameter("amount");
		String paymentType = request.getParameter("paymentType");
		String cardNumber = request.getParameter("cardNumber");
		
		HttpSession session = request.getSession();
		String paymentURI = (String) session.getAttribute("paymentURI");
		String url = paymentURI.substring(0, paymentURI.indexOf("rest") - 1);
		paymentURI = paymentURI.substring(paymentURI.indexOf("rest"), paymentURI.length());
		session.removeAttribute("paymentURI");
		
		ClientConfig config = new DefaultClientConfig();
		Client client = Client.create(config);
		WebResource service = client.resource(getBaseURI(url));
		
		// change the paidStatus of order
		Form orderForm = new Form();
		orderForm.add("paidStatus", "2");
		service.path("rest/orders/" + oid).type(MediaType.APPLICATION_FORM_URLENCODED).put(ClientResponse.class, orderForm);
		
		// add new payment
		Form form = new Form();
		form.add("id", oid);
		form.add("amount", amount);
		form.add("type", paymentType);
		form.add("cardNumber", cardNumber);
		
		ClientResponse clientRsp = service.path(paymentURI).type(MediaType.APPLICATION_FORM_URLENCODED).put(ClientResponse.class, form);
		
		String payResponse = clientRsp.toString() + "\n" + clientRsp.getEntity(String.class);
		session.setAttribute("payResponse", payResponse);
		
		response.sendRedirect("orders.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}
	
	private static URI getBaseURI(String url) {
		return UriBuilder.fromUri(url).build();
	}
}
