<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
<link rel="stylesheet" href="css/index.css">
<title>Insert title here</title>
<style>
</style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">My Wish App</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item active"> <a class="nav-link" href="#"> Home  <span class="sr-only">(current)</span> </a> </li>
            <li class="nav-item"> <a class="nav-link" href="#">About</a> </li>
            <li class="nav-item"> <a class="nav-link" href="#">Services</a> </li>
            <li class="nav-item">  <a class="nav-link" href="#">Contact</a> </li>
          </ul>
        </div>
    </div>
</nav>

<div class="container body">
      <!-- Header -->
      <header class="jumbotron my-4">
        <h2 class="display-4">Make a wish today!</h2>
        <h4 class="lead">Finally, a place where family and friends can find the right thing to buy for you on special occasions.</h4>
        <a href="/user" class="btn btn-primary btn-lg" id="get-started">Get Started!</a>
      </header>
      <!-- Main -->
      <hr>
      <h3>Recent Wishes</h3>
      <div class="row text-center">
      	
		 <c:forEach items="${ wishes }" var="wish">	
			<div class="col-lg-3 col-md-6 mb-4">
	          <div class="card">
	            <img class="card-img-top" src="${ wish.image }" alt="">
	            <div class="card-body">
	              <h4 class="card-title"> <c:out value="${ wish.name }"></c:out> </h4>
	              <p  class="card-text"> $<c:out value="${ wish.price }"></c:out> </p>
	              <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sapiente esse necessitatibus neque.</p>
	            </div>
	            <div class="card-footer">
	              <strong  class="card-text"> Made by <c:out value="${ wish.owner.fullName }"></c:out> </strong>
	            </div>
	          </div>
	        </div>    
		</c:forEach> 		
    </div>
</div>

<footer class="py-5 bg-dark">
   <div class="container"> <p class="m-0 text-center text-white">Copyright &copy; Wura's Test App 2017</p> </div>
</footer>

</body>