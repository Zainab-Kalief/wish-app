<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/user.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
 <script type="text/javascript" src= 'http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js'>    </script>
<script type="text/javascript">
	$(document).ready(function() {
		
		$('#login-form-link').click(function(e) {
	    	$("#login-form").delay(100).fadeIn(100);
	 		$("#register-form").fadeOut(100);
			$('#register-form-link').removeClass('active');
			$(this).addClass('active');
			e.preventDefault();
		});
		$('#register-form-link').click(function(e) {
			$("#register-form").delay(100).fadeIn(100);
	 		$("#login-form").fadeOut(100);
			$('#login-form-link').removeClass('active');
			$(this).addClass('active');
			e.preventDefault();
		});
		
	})
</script>
</head>
<body>

<div class="container">
   <div class="row">
    <div class="col-md-6 col-md-offset-3">
      <div class="panel panel-login">
        <div class="panel-body">
          <div class="row">
            <div class="col-lg-12">
            
              <form id="login-form" action="/login" method="post" role="form" style="display: none;">
                <h1>Log In</h1>
                  <div class="form-group">
                    <input type="text" name="email" id="username" tabindex="1" class="form-control" placeholder="Email">
                  </div>
                  <div class="form-group">
                    <input type="password" name="password" id="password" tabindex="2" class="form-control" placeholder="Password">
                  </div>
                  <div class="col-xs-6 form-group pull-right">     
                        <input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login" value="D O N E">
                  </div>
              </form>
              
              <form:form method="POST" action="/register" id="register-form" role="form" style="display: block;" modelAttribute="newUser">
				<h1>Sign Up</h1>
				<div class="form-group">
					<form:errors path="fullName"/>
			     	<form:input path="fullName" id="username" tabindex="1" placeholder="Full Name"  class="form-control" />
                 </div>
                 <div class="form-group">
                  	<form:errors path="email"/>
                  	
			     	<form:input path="email" type="email" id="email" tabindex="1" class="form-control" placeholder="Email Address" />
                 </div>
			     <div class="form-group">
			     	<form:errors path="password"/>
			     	<form:input path="password" id="password" tabindex="2" class="form-control" placeholder="Password" type="password"/>
                  </div>
                  <div class="form-group">
			     	<p> <c:out value="${ match }"></c:out> </p>
			     	<form:input path="confirmPassword" type="password" id="confirm-password" tabindex="2" class="form-control" placeholder="Confirm Password"/>
                  </div>
                  <div class="btn btn-secondary gender" >
					  <label>
					    <div><input type="radio" name="gender" id="option1"  value="male"> Male</div>
					    <div><input type="radio" name="gender" id="option2" value="female"> Female</div>
					    <div><input type="radio" name="gender" id="option3" value="unicorn" checked> Unicorn</div>
					  </label>
				</div>
			     <div class="form-group">
                    <div class="row">
                      <div class="col-sm-6 col-sm-offset-3">
                        <input type="submit" name="register-submit" id="register-submit" tabindex="4" class="form-control btn btn-register" value="D O N E">
                      </div>
                    </div>
                  </div>
			 </form:form>
      
            </div>
          </div>
        </div>
        <div class="panel-heading">
          <div class="row flip-container">
            <div  id="login-container">
              <a onclick="flip('login-container', 'signup-container')"  id="login-form-link"><div class="log">LOG IN</div></a>
            </div>
            <div  id="signup-container">
              <a onclick="flip('signup-container', 'login-container')" id="register-form-link"><div class="reg">REGISTER</div></a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
	function flip(active, inactive) {
		console.log(active, inactive)
		$("#" + active).css({"background-color": "black", "color": "white"})
		$("#"+ inactive).css({"background-color": "#e8e8e8", "color": "#848c9d"})
	}
	
</script>
</body>
</html>