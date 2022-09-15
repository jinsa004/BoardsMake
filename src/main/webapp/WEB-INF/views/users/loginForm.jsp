<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp"%>

<div class="container">
	<form>
		<div class="mb-3 mt-3">
			<input id="username" type="text" class="form-control" placeholder="Enter username">
		</div>
		<div class="mb-3">
			<input id="password" type="password" class="form-control" placeholder="Enter password"
				name="password">
		</div>
		<button id="btnLogin" type="button" class="btn btn-primary">로그인</button>
	</form>
</div>

<script>
	$("#btnLogin").click(()=>{	
		let data = {
			   username : $("#username").val(),
			   password : $("#password").val()
			   };

		   $.ajax("/login",{
			   type : "POST",
			   dataType : "json", // 응답데이터(제이슨으로 주면 좋겠어) 데이터타입을 json으로 받을 수 있게 위의 http주소 값의 컨트롤러로 돌아가서 리턴값을 바꿔준다.
			   data : JSON.stringify(data), // 데이터를 보낼때 제이슨으로 바꿔주기 위해서 자바 오브젝트인 let data를 JSON.stringify를 통해 바꿔주는 행위임.
			   headers :{
				   "Content-Type" : "application/json; charset=utf-8" //헤더에 바디의 데이터가 json이라는 것을 담아주는 것, MIME 타입 검색해서 보기
			   }
		   }).done((res)=>{
			   if(res.code == 1 ){
				   location.href = "/";
			   }else{
				   alert("로그인 실패, 유저네임 패스워드를 확인해주세요.")
			   }
		   });
	});
</script>



<%@ include file="../layout/footer.jsp"%>

