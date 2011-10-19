package cs9322.cafe.control;

import java.io.IOException;
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

/**
 * Servlet implementation class CheckPayment
 */
public class CheckPayment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckPayment() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ClientConfig config = new DefaultClientConfig();
		Client client = Client.create(config);
		WebResource service = client.resource(UriBuilder.fromUri("http://localhost:8080/CafeRESTfulServices").build());
		
		String id = request.getParameter("id");
		ClientResponse clientResponse = service.path("rest/payments/" + id).accept(MediaType.APPLICATION_JSON).get(ClientResponse.class);
		String statusCode = String.valueOf((clientResponse.getStatus()));
		if (statusCode.indexOf("2") == 0) {
			response.sendRedirect("paymentDetail.jsp?ref=barista.jsp&id=" + id);
			return;
		}
		HttpSession session = request.getSession();
		String checkPaymentResponse = clientResponse.toString();
		session.setAttribute("checkPaymentResponse", checkPaymentResponse);
	    response.sendRedirect("barista.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
