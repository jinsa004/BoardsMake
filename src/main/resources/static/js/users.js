let isUsernameSameCheck = false;
// 회원가입
$("#btnJoin").click(() => {
	join();
});
// 유저네임 중복 체크
$("#btnUsernameSameCheck").click(() => {
	checkUsername();
});

$("#btnLogin").click(() => {
	login();
});

$("#btnDelete").click(() => {
	resign();
});

$("#btnUpdate").click(() => {
	update();
});

function join() {
	if (isUsernameSameCheck == false) {
		alert("유저네임 중복 체크를 진행해주세요.");
		return; // 밑으로 코드가 안내려가고 끝내주기 위해 return을 기입.
	};
/** 
	if(koreanCheck() == true){
		alert("유저네임에 한글이 있으면 안됩니다.");
		return;
	}
	
	if(blankCheck() == true) {
      	alert("유저네임에 공백이 있으면 안됩니다.")
      	return;
    }
    
	if(emailCheck() != true){
		alert("이메일형식을 따라주세요.")
		return;
	}
	
	 if(capitalCheck() != true){
		alert("대문자 하나를 포함해주세요.")
		return;
	}
*/	
	let passwordCheck = $("#isPasswordSameCheck").val()
	
	// 0. 통신 오브젝트 생성 (Get 요청은 body가 없다.)
	let data = {
		username: $("#username").val(),
		password: $("#password").val(),
		email: $("#email").val()
	};
	
	if (passwordCheck != data.password) {
		alert("입력한 비밀번호가 다릅니다.");
		$("#password").val("");
		$("#isPasswordSameCheck").val("");
		return; // 밑으로 코드가 안내려가고 끝내주기 위해 return을 기입.
	};
	
	$.ajax("/api/join", {
		type: "POST",
		dataType: "json", // 데이터타입을 json으로 받을 수 있게 위의 http주소 값의 컨트롤러로 돌아가서 리턴값을 바꿔준다.
		data: JSON.stringify(data), // 데이터를 보낼때 제이슨으로 바꿔주기 위해서 자바 오브젝트인 let data를 JSON.stringify를 통해 바꿔주는 행위임.
		headers: {
			"Content-Type": "application/json" //헤더에 바디의 데이터가 json이라는 것을 담아주는 것, MIME 타입 검색해서 보기
		}
	}).done((res) => {
		if (res.code == 1) {
			location.href = "/loginForm";
		};
	});
	
}

function checkUsername() {

	// 1. 사용자가 적은 username 값을 가져오기
	let username = $("#username").val();

	// 2. Ajax 통신
	$.ajax(`/api/users/usernameSameCheck?username=${username}`, {
		type: "GET",
		dataType: "json",
		async: true
	}).done((res) => {
		console.log(res);
		if (res.code == 1) { // 통신 성공
			if (res.data == false) {
				alert("아이디가 중복되지 않았습니다.");
				isUsernameSameCheck = true;
			} else {
				alert("아이디가 중복되었어요. 다른 아이디를 사용해주세요.");
				isUsernameSameCheck = false;
				$("#username").val("");
			}
		}
	});
}

function login() {
	let data = {
		username: $("#username").val(),
		password: $("#password").val(),
		remember : $("#remember").prop("checked")
	};

	$.ajax("/api/login", {
		type: "POST",
		dataType: "json", // 응답데이터(제이슨으로 주면 좋겠어) 데이터타입을 json으로 받을 수 있게 위의 http주소 값의 컨트롤러로 돌아가서 리턴값을 바꿔준다.
		data: JSON.stringify(data), // 데이터를 보낼때 제이슨으로 바꿔주기 위해서 자바 오브젝트인 let data를 JSON.stringify를 통해 바꿔주는 행위임.
		headers: {
			"Content-Type": "application/json; charset=utf-8" //헤더에 바디의 데이터가 json이라는 것을 담아주는 것, MIME 타입 검색해서 보기
		}
	}).done((res) => {
		if (res.code == 1) {
			location.href = "/";
		} else {
			alert("로그인 실패, 유저네임 패스워드를 확인해주세요.")
		}
	});
}

function resign() {
	let id = $("#id").val()

	$.ajax("/s/users/" + id, {
		type: "DELETE",
		dataType: "json" // 데이터타입을 json으로 받을 수 있게 위의 http주소 값의 컨트롤러로 돌아가서 리턴값을 바꿔준다.
	}).done((res) => {
		if (res.code == 1) {
			alert("회원 탈퇴완료")
			location.href = "/";
		} else {
			alert("회원 탈퇴에 실패하였습니다.");
		}
	});
}

function update() {
	let data = {
		password: $("#password").val(),
		email: $("#email").val()
	};
	let id = $("#id").val()

	$.ajax("/s/api/users/" + id, {
		type: "PUT",
		dataType: "json", // 데이터타입을 json으로 받을 수 있게 위의 http주소 값의 컨트롤러로 돌아가서 리턴값을 바꿔준다.
		data: JSON.stringify(data), // 데이터를 보낼때 제이슨으로 바꿔주기 위해서 자바 오브젝트인 let data를 JSON.stringify를 통해 바꿔주는 행위임.
		headers: {
			"Content-Type": "application/json" //헤더에 바디의 데이터가 json이라는 것을 담아주는 것, MIME 타입 검색해서 보기
		}
	}).done((res) => {
		if (res.code == 1) {
			alert("회원 수정완료")
			location.reload(); //f5
		} else {
			alert("업데이트에 실패하였습니다.");
		}
	});
}

function koreanCheck() {
	let data = {
		username: $("#username").val(),
		password: $("#password").val(),
		email : $("#email").val()
	};
	
   let korRule = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
   if(korRule.test(data.username)) {
      return true;
   }
   
   if(korRule.test(data.password)) {
      return true;
   }
    
   if(korRule.test(data.email)) {
      return true;
   }else {
      return false;
   }
}

function capitalCheck(){
	let username = $("#username").val();
	let capitalRule = /[A-Z]/;
    if(capitalRule.test(username)) {
        return true;
    } else {
	    return false;
    }
}
	
function emailCheck(){
	let email = $("#email").val();
	let emailRule = /[@]/;
	if(emailRule.test(email)){
		return true;
	}else{
		return false;
	}
}

function blankCheck(){
	let data = {
		username: $("#username").val(),
		password: $("#password").val(),
		email : $("#email").val()
	};
	let blankRule = /[ ]/;
    if(blankRule.test(data.username)) {
        return true;
    }
        
    if(blankRule.test(data.password)) {
      return true;
   }
   
   if(blankRule.test(data.emaila)) {
      return true;
   }else {
      return false;
   }
}