<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Welcome</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<style type="text/css">
		.container{
			margin: 40px;
			padding: 20px;
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
		.profession{
			border: 1px solid black;
			padding: 5px;
			margin: 5px;
			font-size: 12px;
		}
	</style>
</head>
<body>
	<div class="nav_bar">
		<p><a href="/logout">Logout</a></p>
		<p><a href="/new/question">Ask a Question</a></p>
		<p><a href="/questions">Answer a Question</a></p>
	</div>
<div class="container">
	<h1>Welcome, <c:out value="${ThisUser.firstName}"/> <c:out value="${ThisUser.lastName}"/></h1>
	<div style="display: flex">
		<c:forEach items="${Pros}" var="P">
			<p class="profession"><c:out value="${P.profession.profession}"></c:out></p>
		</c:forEach>
	</div>
	
	<label for="profession" >Add Profession: </label>
	<form action="/add/profession">
		<input type="text" name="profession">
		<input type="submit">
	</form>
</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

</html>