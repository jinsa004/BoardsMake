<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp"%>

<div class="container">
	<button id="btnDelete" class="btn btn-danger">회원탈퇴</button>
	<form>
		<input id="id" type="hidden" value="${users.id}" />
		<div class="mb-3 mt-3">
			<input type="text" class="form-control" placeholder="Enter username" value="${users.username}"
				readonly="readonly">
		</div>
		<div class="mb-3">
			<input id="password" type="password" class="form-control" placeholder="Enter password"
				value="${users.password}">
		</div>
		<div class="mb-3">
			<input id="email" type="email" class="form-control" placeholder="Enter email"
				value="${users.email}">
		</div>
		<button id="btnUpdate" type="button" class="btn btn-primary">회원수정완료</button>
	</form>
</div>

<script>
	$("#btnDelete").click(()=>{
		
		let id = $("#id").val()
		
		$.ajax("/users/"+id,{
			   type : "DELETE",
			   dataType : "json" // 데이터타입을 json으로 받을 수 있게 위의 http주소 값의 컨트롤러로 돌아가서 리턴값을 바꿔준다.
		   }).done((res)=>{
			   if(res.code == 1 ){
				   alert("회원 탈퇴완료")
				   location.href="/";
			   }else{
				   alert("회원 탈퇴에 실패하였습니다.");
			   }
		   });
	});

	$("#btnUpdate").click(()=>{
		let data = {
				password : $("#password").val(),
				email : $("#email").val()
		};
		let id = $("#id").val()
		
		$.ajax("/users/"+id,{
			   type : "PUT",
			   dataType : "json", // 데이터타입을 json으로 받을 수 있게 위의 http주소 값의 컨트롤러로 돌아가서 리턴값을 바꿔준다.
			   data : JSON.stringify(data), // 데이터를 보낼때 제이슨으로 바꿔주기 위해서 자바 오브젝트인 let data를 JSON.stringify를 통해 바꿔주는 행위임.
			   headers :{
				   "Content-Type" : "application/json" //헤더에 바디의 데이터가 json이라는 것을 담아주는 것, MIME 타입 검색해서 보기
			   }
		   }).done((res)=>{
			   if(res.code == 1 ){
				   alert("회원 수정완료")
				   location.reload(); //f5
			   }else{
				   alert("업데이트에 실패하였습니다.");
			   }
		   });
	});
</script>

<%@ include file="../layout/footer.jsp"%>

