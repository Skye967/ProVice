<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New Question</title>
	<style>
		.container{
		margin: 40px;
		}
		
		.nav_bar{
			display: flex;
			justify-content: space-between;
			align-items: center;
			background-color: darkgrey;
			border: 5px solid black;
			padding: 10px;
		}
		.nav_bar a {
			color: whitesmoke;
			margin: 40px;
			text-decoration: none;
		}		
	</style>
</head>
<body>
	<div class="nav_bar">
		<p><a href="/logout">Logout</a></p>
		<p><a href="/home">Dashboard</a></p>
		<p><a href="/new/question">Ask a Question</a></p>
		<p><a href="/questions">Answer a Question</a></p>
	</div>
	<div class="container">
		
		<h1>What is your Question?</h1>
		
		<form:form action="/create/question" modelAttribute="newQuestion">
		
			<form:input type="hidden" path="user" value="${thisUser.id}"/>
			
			<p><form:label path="question">Question: </form:label>
			<form:errors path="question">Invalid Question</form:errors>
			<form:textarea path="question" row="4" cols="50"/></p>
			
			<p><label for="tag">Enter Tags<span style="font-style: italic;">(comma separated)</span>:</label>
			<input type="text" name="tag"></p>
			
			<input type="submit">
		
		</form:form>
	</div>
</body>
</html>