<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
<style type="text/css">
	.search-input { width: 500px; }
.body {  margin-top: 80px; }
.nav-link {  margin-left: 10px;
    margin-right: 10px;
    position: relative; }
.wish-count {
	position: absolute;
    top: 5px;
    margin-left: 100px;
    width: 25px;
    height: 25px;
  border-radius: 50%;
  background: red;
  color: white;
  text-align: center;
}
hr { 	margin-top: 2rem;  margin-bottom: 2rem; }
#deny-wish { background-color: grey }
.grant-wish-button {   background: -webkit-linear-gradient(left, #22d686, #24d3d3, #22d686, #24d3d3);
  background: linear-gradient(to right, #22d686, #24d3d3, #22d686, #24d3d3);
  background-size: 600% 100%;
  -webkit-animation: HeroBG 20s ease infinite;
          animation: HeroBG 20s ease infinite;  }
.grant-wish-button, #deny-wish  {
	 color: #fff;
  border-radius: 50px;
	width: 150px;
	border: none;
	    padding-top: 10px;
    padding-bottom: 10px;
}
.py-5 {  padding-top: 1rem!important;   padding-bottom: 1rem!important; }

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
	              <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sapiente esse necessitatibus neque.</p>
	              
	              <c:if test="${ not empty wish.genie }">
	              	<c:if test="${ user.id == wish.genieId }">
	              		<a href="/denyWish/${ wish.id }" class="btn btn-primary" id="deny-wish">Deny Wish</a>
	              	</c:if>
	              	<c:if test="${ user.id != wish.genieId }">
	              		<p><strong><c:out value="${ wish.genie }"></c:out> granted this wish!</strong>  </p>
	              	</c:if>
	              </c:if>
	              
	              <c:if test="${ empty wish.genie }">
	              	<a href="/grantWish/${ wish.id }" class="btn btn-primary grant-wish-button">Grant Wish</a>
	              </c:if>
	              
	            </div>
	          </div>
	        </div> 
		</c:forEach> 
    </div>
	 
	 <hr>
	 
	 <h2>Other Wishes</h2>
      <div class="row text-center">
		 <c:forEach items="${ otherUser.wishes }" var="wish">	
		 <c:if test="${ wish.status == false }">
		 	<div class="col-lg-3 col-md-6 mb-4">
	          <div class="card">
	            <img class="card-img-top" src="${ wish.image }" alt="">
	            <div class="card-body">
	              <h4 class="card-title"> <c:out value="${ wish.name }"></c:out> </h4> 
	              <p  class="card-text"> $<c:out value="${ wish.price }"></c:out>  </p> 
	              <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sapiente esse necessitatibus neque.</p>
	              
	              <c:if test="${ not empty wish.genie }">
	              	<c:if test="${ user.id == wish.genieId }">
	              		<a href="/denyWish/${ wish.id }" class="btn btn-primary" id="deny-wish">Deny Wish</a>
	              	</c:if>
	              	<c:if test="${ user.id != wish.genieId }">
	              		<p><strong><c:out value="${ wish.genie }"></c:out> granted this wish!</strong>  </p>
	              	</c:if>
	              </c:if>
	              
	              <c:if test="${ empty wish.genie }">
	              	<a href="/grantWish/${ wish.id }" class="btn btn-primary grant-wish-button">Grant Wish</a>
	              </c:if>
	              
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