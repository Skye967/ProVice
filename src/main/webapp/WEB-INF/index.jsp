<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style type="text/css">
		body{
			background-color: darkGrey;
			color: whitesmoke;
		}
		.title{
			background-color: black;
			width: 100%;
			padding: 10px;
		}
		.container{
			display: flex;
			justify-content: center;
			align-items: center;
			padding: 20px;
			margin: 20px;
		}
		.container div{
		z-index: 3;
		background-color: white;
		color: black;
		height: 400px;
		width: 300px;
		margin: 20px;
		padding: 20px;
		}
		.register{
			border: 1px solid black;
		}
		.login{
			border: 1px solid black;
		}
	</style>
</head>
<body>
	<div class="title">
		<h1>VicePro</h1>
		<p style="font-style: italic;">"Register and Login to exchange advice with other professionals"</p>
	</div>
<div class="container" style="display: flex;">	
	<div class="register">
		<h1>Register</h1>
	    <p><form:errors path="user.*"/></p>
	    <form:form method="POST" action="/registration" modelAttribute="user">
	    
	    	<p>
	    		<form:label path="firstName">First Name:</form:label>
	    		<form:errors path="firstName">Invalid First Name</form:errors>
	    		<form:input path="firstName"/>
	    	</p>
	    	<p>
	   			<form:label path="lastName">Last Name:</form:label>
	   			<form:errors path="lastName">Invalid Last Name</form:errors>
	   			<form:input path="lastName"/>
	    	</p>
	        <p>
	            <form:label path="email">Email:</form:label>
	            <form:errors path="email">Invalid Email</form:errors>
	            <form:input type="email" path="email"/>
	        </p>
	        <p>
	            <form:label path="password">Password:</form:label>
	            <form:errors path="password">Invalid Password</form:errors>
	            <form:password path="password"/>
	        </p>
	        <p>
	            <form:label path="passwordConfirmation">Password Confirmation:</form:label>
	            <form:errors path="passwordConfirmation">Password Doesn't Match</form:errors>
	            <form:password path="passwordConfirmation"/>
	        </p>
	        <input type="submit" value="Register!"/>
	    </form:form>
	</div>
	    
	<div class="login">
	    <h1>Login</h1>
	    <p><c:out value="${error}" /></p>
	    <form method="post" action="/login">
	        <p>
	            <label for="email">Email</label>
	            <input type="text" id="email" name="email"/>
	        </p>
	        <p>
	            <label for="password">Password</label>
	            <input type="password" id="password" name="password"/>
	        </p>
	        <input type="submit" value="Login!"/>
	    </form> 
</div>  
</div>    
</body>
</html>