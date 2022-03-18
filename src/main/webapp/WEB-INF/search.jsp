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
	<h1>Search Question</h1>
	<form:form action="/search" modelAttribute="search">
		<form:label path="question">Search: </form:label>
		<form:errors path="question"></form:errors>
		<form:input path="question"/>
		
		<input type="submit">
	</form:form>
	
	<c:forEach items="${searchList}" var="Q">
		<p><a href="/display/question/${Q.id}"><c:out value="${Q.question}"></c:out></a></p>
	</c:forEach>
</div>
</body>
</html>