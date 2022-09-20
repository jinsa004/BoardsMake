$("#btnSave").click(() => {
	save();
});

$("#btnUpdate").click(() => {
	update();
});

$("#btnDelete").click(() => {
	deleteById();
});

$("#iconLove").click(() => {
	let isLovedState = $("#iconLove").hasClass("fa-solid");
	if (isLovedState) {
		deleteLove();
	} else {
		insertLove();
	}
});

// DB에 insert 요청하기
function insertLove() {
	let id = $("#id").val();

	$.ajax("/s/api/boards/" + id + "/loves", {
		type: "POST",
		dataType: "json"
	}).done((res) => {
		if (res.code == 1) {
			renderLoves();
			let count = $("#countLove").text();
			$("#countLove").text(Number(count) + 1);
			$("#lovesId").val(res.data.id);
			console.log(res);
		} else {
			alert("좋아요 실패했습니다");
			alert(res.msg);
		}
	});
}

// DB에 delete 요청하기
function deleteLove() {
	let id = $("#id").val();
	let lovesId = $("#lovesId").val();

	$.ajax("/s/api/boards/" + id + "/loves/" + lovesId, {
		type: "DELETE",
		dataType: "json"
	}).done((res) => {
		if (res.code == 1) {
			renderCancelLoves();
			let count = $("#countLove").text();
			$("#countLove").text(Number(count - 1));
			console.log(res);
		} else {
			alert("좋아요 취소에 실패했습니다");
		}
	});
}

// 빨간색 하트 그리기
function renderLoves() {
	$("#iconLove").removeClass("fa-regular");
	$("#iconLove").addClass("fa-solid");
}

// 검정색 하트 그리기
function renderCancelLoves() {
	$("#iconLove").removeClass("fa-solid");
	$("#iconLove").addClass("fa-regular");
}

function save() {
	let data = {
		title: $("#title").val(),
		content: $("#content").val()
	}

	$.ajax("/s/api/boards", {
		type: "POST",
		dataType: "json", // 데이터타입을 json으로 받을 수 있게 위의 http주소 값의 컨트롤러로 돌아가서 리턴값을 바꿔준다.
		data: JSON.stringify(data), // 데이터를 보낼때 제이슨으로 바꿔주기 위해서 자바 오브젝트인 let data를 JSON.stringify를 통해 바꿔주는 행위임.
		headers: {
			"Content-Type": "application/json" //헤더에 바디의 데이터가 json이라는 것을 담아주는 것, MIME 타입 검색해서 보기
		}
	}).done((res) => {
		if (res.code == 1) {
			location.href = "/";
		};
	});
}

function update() {
	let data = {
		title: $("#title").val(),
		content: $("#content").val()
	}
	let id = $("#id").val()
	let keyword = $("#keyword").val()
	let page = $("#page").val()

	$.ajax("/s/api/boards/" + id, {
		type: "PUT",
		dataType: "json",
		data: JSON.stringify(data),
		headers: {
			"Content-Type": "application/json"
		}
	}).done((res) => {
		if (res.code == 1) {
			location.href = "/?page=" + page + "&keyword=" + keyword;
		};
	});
}

function deleteById() {
	let id = $("#id").val();

	let page = $("#page").val();
	let keyword = $("#keyword").val();

	$.ajax("/s/api/boards/" + id, {
		type: "DELETE",
		dataType: "json" // 응답 데이터
	}).done((res) => {
		if (res.code == 1) {
			//location.href = document.referrer;
			location.href = "/?page="+page+"&keyword="+keyword;  //  /?page=?&keyword=?
		} else {
			alert("글삭제 실패");
		}
	});
}