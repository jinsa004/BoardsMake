<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp"%>

<div class="container">
	<form>
		<div class="mb-3 mt-3">
			<input id="username" type="text" class="form-control" placeholder="Enter username">
			<br/>
			<button id="btnUsernameSameCheck" class="btn btn-warning" type="button">유저네임 중복체크</button>
		</div>
		<div class="mb-3">
			<input id="password" type="password" class="form-control" placeholder="Enter password">
		</div>
		<div class="mb-3">
			<input id="isPasswordSameCheck" type="password" class="form-control" placeholder="Password check">
		</div>
		<div class="mb-3">
			<input id="email" type="email" class="form-control" placeholder="Enter email">
		</div>
		<button id="btnJoin" type="button" class="btn btn-primary">회원가입</button>
	</form>
</div>

<script>
   let isUsernameSameCheck = false;
   // 회원가입
   $("#btnJoin").click(()=>{
	   if(isUsernameSameCheck == false){
		   alert("유저네임 중복 체크를 진행해주세요.");
		   return; // 밑으로 코드가 안내려가고 끝내주기 위해 return을 기입.
	   };
	   // 0. 통신 오브젝트 생성 (Get 요청은 body가 없다.)
	let data = {
		   username : $("#username").val(),
		   password : $("#password").val(),
		   email : $("#email").val()
	   };
	let passwordCheck = $("#isPasswordSameCheck").val()
	// 비밀번호 재확인 코드
	if(passwordCheck != data.password){
		   alert("입력한 비밀번호가 다릅니다.");
		   return; // 밑으로 코드가 안내려가고 끝내주기 위해 return을 기입.
	   };
	   
	   $.ajax("/join",{
		   type : "POST",
		   dataType : "json", // 데이터타입을 json으로 받을 수 있게 위의 http주소 값의 컨트롤러로 돌아가서 리턴값을 바꿔준다.
		   data : JSON.stringify(data), // 데이터를 보낼때 제이슨으로 바꿔주기 위해서 자바 오브젝트인 let data를 JSON.stringify를 통해 바꿔주는 행위임.
		   headers :{
			   "Content-Type" : "application/json" //헤더에 바디의 데이터가 json이라는 것을 담아주는 것, MIME 타입 검색해서 보기
		   }
	   }).done((res)=>{
		   if(res.code == 1 ){
			   location.href = "/loginForm";
		   };
	   });
   });
   
   // 유저네임 중복 체크
   $("#btnUsernameSameCheck").click(()=>{

      // 1. 사용자가 적은 username 값을 가져오기
      let username = $("#username").val();   

      // 2. Ajax 통신
      $.ajax("/users/usernameSameCheck?username="+username,{
         type :"GET",
         dataType: "json",
         async: true
      }).done((res)=>{
         console.log(res);
         if(res.code == 1){ // 통신 성공
            if(res.data == false){
               alert("아이디가 중복되지 않았습니다.");
               isUsernameSameCheck = true;
            }else{
               alert("아이디가 중복되었어요. 다른 아이디를 사용해주세요.");
               isUsernameSameCheck = false;
               $("#username").val("");
            }
         }
      });
   });

</script>

<%@ include file="../layout/footer.jsp"%>
