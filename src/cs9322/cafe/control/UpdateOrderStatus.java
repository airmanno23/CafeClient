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
import com.sun.jersey.api.representation.Form;

/**
 * Servlet implementation class UpdateOrderStatus
 */
public class UpdateOrderStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateOrderStatus() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String baristaStatus = request.getParameter("baristaStatus");
		ClientConfig config = new DefaultClientConfig();
		Client client = Client.create(config);
		WebResource service = client.resource(UriBuilder.fromUri("http://localhost:8080/CafeRESTfulServices").build());

		Form form = new Form();
		form.add("baristaStatus", baristaStatus);
		ClientResponse clientResponse = service.path("rest/orders/" + id)
				.type(MediaType.APPLICATION_FORM_URLENCODED).put(ClientResponse.class, form);
		HttpSession session = request.getSession();
		if (clientResponse.getStatus() == 403) {
			String updateStatusResponse = clientResponse.toString();
			session.setAttribute("updateStatusResponse", updateStatusResponse);
			if (baristaStatus.equals("2"))
			    response.sendRedirect("error.jsp?ref=barista.jsp&id=4");
			else
				response.sendRedirect("error.jsp?ref=barista.jsp&id=5");
		}
		else {
			String updateStatusResponse = clientResponse.toString() + "\n" + clientResponse.getEntity(String.class);
			session.setAttribute("updateStatusResponse", updateStatusResponse);
			response.sendRedirect("barista.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
