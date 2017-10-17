<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
<link rel="stylesheet" href="css/userWishes.css">
<title>Insert title here</title>
<script src="https://use.fontawesome.com/ae8fe89761.js"></script>
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
            <li class="nav-item active"> <a class="nav-link" href="/home"> Home  <span class="sr-only">(current)</span> </a> </li>
            <li class="nav-item"> <a class="nav-link" href="/myWishes">My Wishes</a> <span class="wish-count" >${fn:length(user.wishes) }</span>  </li>
            <li class="nav-item"> <a class="nav-link" href="/logout">Log Out</a> </li>
          </ul>
        </div>
    </div>
</nav>

<div class="container body">
    <h2>Favorite Wishes</h2>
    <div class="row text-center">
		 <c:forEach items="${ wishes }" var="wish">	
		 <div class="col-lg-3 col-md-6 mb-4">
	          <div class="card">
	            <img class="card-img-top" src="${ wish.image }" alt="">
	            <div class="card-body">
	              <h4 class="card-title"> <c:out value="${ wish.name }"></c:out> </h4> 
	              <p  class="card-text"> $<c:out value="${ wish.price }"></c:out>  </p> 
	              <a href="/unfav/${ wish.id }"><i class="fa fa-times-circle" aria-hidden="true" style=" font-size: 50px;"></i></a>
	              <a href="/remove/${ wish.id }"> <i class="fa fa-trash-o" aria-hidden="true" style=" font-size: 50px;"></i> </a>
	              <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sapiente esse necessitatibus neque.</p>
	            </div>
	          </div>
	        </div> 
		</c:forEach> 
    </div>
	 
	 <hr>
	 
	 <h2>Other Wishes</h2>
     <div class="row text-center">
		 <c:forEach items="${ user.wishes }" var="wish">	
		 <c:if test="${ wish.status == false }">
		 	<div class="col-lg-3 col-md-6 mb-4">
	          <div class="card">
	            <img class="card-img-top" src="${ wish.image }" alt="">
	            <div class="card-body">
	              <h4 class="card-title"> <c:out value="${ wish.name }"></c:out> </h4> 
	              <p  class="card-text"> $<c:out value="${ wish.price }"></c:out>  </p> 
	              <c:if test="${ fn:length(wishes) lt 4 }">
	              	<a href="/fav/${ wish.id }"><i class="fa fa-plus-circle" aria-hidden="true" style=" font-size: 50px;"></i></a>
	              </c:if>
	              <a href="/remove/${ wish.id }"> <i class="fa fa-trash-o" aria-hidden="true" style=" font-size: 50px;"></i> </a>
	              <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sapiente esse necessitatibus neque.</p>
	            </div>
	          </div>
	        </div>  
		</c:if>
		</c:forEach> 
    </div>
</div>

<footer class="py-5 bg-dark">
   <div class="container"> <p class="m-0 text-center text-white">Copyright &copy; Wura's Test App 2017</p> </div>
</footer>
</body>