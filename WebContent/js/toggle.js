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

function selectCard(obj) {
	var ele = document.getElementById("cardDetail");
	if(obj.value == "Card") {
		ele.style.display = "block";
	}
	else {
		ele.style.display = "none";
	}
}

function validatePaymentForm() {
	var x = document.forms["paymentForm"]["paymentType"].value;
	var y = document.forms["paymentForm"]["cardNumber"].value;
	if (x == null || x == "None") {
		alert("Please choose the type of payment.");
		return false;
	}
	else if(x == "Card" && y == "") {
		alert("Please enter your card number.");
		return false;
	}
}