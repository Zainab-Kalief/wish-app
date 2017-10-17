<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cf" uri="/WEB-INF/tld/customFunctions.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="css/home.css">


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
            <li class="nav-item active"> <a class="nav-link" href="/home"> Home  <span class="sr-only">(current)</span> </a> </li>
            <li class="nav-item"> <a class="nav-link" href="/myWishes">My Wishes</a> <span class="wish-count" >${fn:length(user.wishes) }</span>  </li>
            <li class="nav-item"> <a class="nav-link" href="/logout">Log Out</a> </li>
          </ul>
        </div>
    </div>
</nav>

<div class="container body">

 <header class="jumbotron my-4">
        <h3 class="display-4">Hey <c:out value="${ user.fullName }"></c:out> , make a wish!</h3>
        <form id="login-form" action="/search" method="post" role="form" style="display: block;">
                  <div class="form-group search-input">
                    <input type="text" name="name" id="username"  class="col-lg-4 form-control input-one" placeholder="Name of product">
                    <input type="text" name="brand" id="username" class="col-lg-4 form-control input-two" placeholder="Name of Brand">
                  </div>
                  <div class="btn-group" data-toggle="buttons">
					  <label class="btn btn-secondary">
					    <input type="checkbox" autocomplete="off" name="category" value="home-garden"> Home
					  </label>
					  <label class="btn btn-secondary active">
					    <input type="checkbox" checked autocomplete="off" name="category" value="fashion"> Fashion
					  </label>
					  <label class="btn btn-secondary">
					    <input type="checkbox" autocomplete="off" name="category" value="electronics"> Electronics
					  </label>
					  <label class="btn btn-secondary">
					    <input type="checkbox" autocomplete="off" name="category" value="books"> Books
					  </label>
					  <label class="btn btn-secondary">
					    <input type="checkbox" autocomplete="off" name="category" value="sport"> Sport
					  </label>
					  <label class="btn btn-secondary">
					    <input type="checkbox" autocomplete="off" name="category" value="Cars"> Cars
					  </label>
					  <input type="hidden" name="category" value="">
				</div>
                  <div class="col-xs-3 form-group pull-right search-button">     
                        <input type="submit" id="search-submit" tabindex="4" class="form-control btn btn-login" value="Search">
                  </div>
          </form>
 </header>

 <section class="recent">
	<h4>Recently Added Users</h4>
	<div class="row row-users">
	 <c:forEach items="${ users }" var="person">	 	
		<div class="col-lg-3 users">
 		        <h5><a  href="/person/${ person.id }" > <c:out value="${ person.fullName }"></c:out>  </a></h5>
		           <!-- cf stands for - custom function --> 
		           <c:if test="${cf:containsUser(user.following, person) }">
						<a class="btn btn-primary follow-button" href="/unfollow/${ person.id }" role="button">Unfollow</a>
		           </c:if>
		           <c:if test="${cf:containsUser(user.following, person) == false}">
						<a class="btn btn-primary follow-button" href="/follow/${ person.id }" role="button">Follow</a>
		           </c:if>
		      </div> 
		</c:forEach>
               
   </div>
   <h6><a  href="#" id="all">View All</a></h6>
 </section>
 
<hr>

 <section id="following">
	<c:forEach items="${ user.following }" var="person">
		<h5 class="following-name"><a  href="/person/${ person.id }" > <c:out value="${ person.fullName }"></c:out>  </a></h5>
		<div class="row text-center">	
		<c:forEach items="${ person.wishes }" var="wish">	
		 <c:if test="${ wish.status == true }">
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
<hr>
	</c:forEach>
</section>
</div>

<footer class="py-5 bg-dark">
   <div class="container"> <p class="m-0 text-center text-white">Copyright &copy; Wura's Test App 2017</p> </div>
</footer>

</body>