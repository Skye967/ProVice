<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box;}

/* Button used to open the contact form - fixed at the bottom of the page */
.open-button {
  background-color: #555;
  color: white;
  border: none;
  cursor: pointer;
}

/* The popup form - hidden by default */
.form-popup {
  display: none;
  position: fixed;
  bottom: 0;
  right: 15px;
  border: 3px solid #f1f1f1;
  z-index: 9;
}

/* Add styles to the form container */
.form-container {
  max-width: 300px;
  padding: 10px;
  background-color: white;
}


/* When the inputs get focus, do something */
.form-container input[type=text]:focus, .form-container input[type=password]:focus {
  background-color: #ddd;
  outline: none;
}

/* Set a style for the submit/login button */
.form-container .btn {
  background-color: #04AA6D;
  color: white;
  padding: 16px 20px;
  border: none;
  cursor: pointer;
  width: 100%;
  margin-bottom:10px;
  opacity: 0.8;
}

/* Add a red background color to the cancel button */
.form-container .cancel {
  background-color: red;
}

/* Add some hover effects to buttons */
.form-container .btn:hover, .open-button:hover {
  opacity: 1;
}

.comment{
	font-size: 12px;
	font-style: italic;
	color: grey;
}

.comment_container{
	width: 100px;
	margin-left: 40px;
}

.tag{
	border: 1px solid black;
	margin: 5px;
	padding: 5px;
	font-size: 12px;
}

</style>
</head>
<body>
	<h1>Display Question</h1>
	<a href="/home">Dashboard</a>
	<div>
		<div style="display: flex">
			<label>Tags: </label>
			<c:forEach items="${thisQuestion.tags}" var="T">
				<p class="tag"><c:out value="${T.tag}"></c:out></p>
			</c:forEach>
		</div>
		<p><c:out value="${thisQuestion.question}"></c:out></p>
		
		<div class="comment_container">
			<c:forEach items="${thisQuestion.comments}" var="Q">
				<p class="comment"><c:out value="${Q.comment}"></c:out></p>
			</c:forEach>
		</div>
		<p><button class="open-button" onclick="openForm()">Comment</button></p>
	</div>
	
	
	<div class="form-popup" id="myForm">
	  	<form:form action="/comment/${thisQuestion.id}" class="form-container" modelAttribute="thisComment">
		    <h1>Comment</h1>
		    <form:input type="hidden" path="user" value="${thisUser.id}"></form:input>
		    <form:input type="hidden" path="question" value="${thisQuestion.id}"></form:input>
		
		    <form:label path="comment"><b>Comment:</b></form:label>
		    <form:input type="text" path="comment"></form:input>

		    <button type="submit" class="btn">Submit</button>
		    <button type="button" class="btn cancel" onclick="closeForm()">Close</button>
	  	</form:form>
	</div>
	
	<div style="border: 5px solid black; width: 400px; padding: 20px; margin: 20px;">
		<c:forEach items="${thisQuestion.answers}" var="A">
			<p><c:out value="${A.answer}"></c:out></p>
				<div class="comment_container">
					<c:forEach items="${A.comments}" var="C">
						<p class="comment"><c:out value="${C.comment}"></c:out><p>
					</c:forEach>
				</div>
			<p><a href="#popup${A.id}" style="cursor: pointer; transition: all 0.3s ease-out;">Comment</a></p>
			<style>
				.overlay {
				  transition: opacity 500ms;
				  visibility: hidden;
				  opacity: 0;
				  position: fixed;
				  top: 0;
				  bottom: 0;
				  left: 0;
				  right: 0;
				  z-index: 3;
				  background-color: white;
				  height: 200px;
				  width: 400px;
				  border: 2px solid black;
				  padding: 20px;
				}
				.overlay:target {
				  visibility: visible;
				  opacity: 1;
				}
				.popup {
				  transition: all 5s ease-in-out;
				  background-color: white;
				}
				.popup .close {
				  transition: all 200ms;
				}
			</style>
			<div id="popup${A.id}" class="overlay">
		  		<form:form class="popup" action="/comment/${thisQuestion.id}"  modelAttribute="thisComment">
				    <h1>Comment</h1>
				    <form:input type="hidden" path="answer" value="${A.id}"></form:input>
				    <form:input type="hidden" path="user" value="${thisUser.id}"></form:input>
				
				    <form:label path="comment"><b>Comment:</b></form:label>
				    <form:input type="text" path="comment"></form:input>
		
				    <button type="submit">Submit</button>
				    <a class="close" href="#" type="button">Close</a>
		  		</form:form>
			</div>
		</c:forEach>
	</div>
	
	<form:form action="/new/answer" modelAttribute="thisAnswer">
		<form:input type="hidden" path="question" value="${thisQuestion.id}"/>
		
		<form:label path="answer">Your Answer: </form:label>
		<form:errors path="answer">Invalid Answer</form:errors>
		<form:textarea path="answer" rows="4" cols="50"/>
		
		<input type="submit">
	</form:form>
<script>
function openForm() {
  document.getElementById("myForm").style.display = "block";
}

function closeForm() {
  document.getElementById("myForm").style.display = "none";
}
</script>
</body>
</html>