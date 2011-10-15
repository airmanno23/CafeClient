/**
 * hide a div
 */
function toggle() {
	var ele = document.getElementById("NewOrder");
	var text = document.getElementById("displayText");
	if (ele.style.display == "block") {
		ele.style.display = "none";
		text.innerHTML = "New Order";
	} else {
		ele.style.display = "block";
		text.innerHTML = "Hide";
	}
}

function validateForm() {
	var x = document.forms["NewOrderForm"]["type"].value;
	if (x == null || x == "null") {
		alert("Please choose the type of cafe.");
		return false;
	}
}