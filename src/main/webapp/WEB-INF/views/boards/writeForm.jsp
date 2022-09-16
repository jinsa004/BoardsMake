<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp"%>

<div class="container">
	<form>
		<div class="mb-3 mt-3">
			<input id="title" type="text" class="form-control" placeholder="Enter title">
		</div>
		<div class="mb-3">
			<textarea id="content" class="form-control" rows="8"></textarea>
		</div>
		<button id="btnSave" type="button" class="btn btn-primary">글쓰기완료</button>
	</form>
</div>

<script>
	$("#btnSave").click(()=>{
		save();
	});
	
	function save(){
		let data = {
				title: $("#title").val(),
				content: $("#content").val()
			}

	$.ajax("/boards", {
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
	
</script>

<script>
	$('#content').summernote({
		height : 400
	});
</script>

<%@ include file="../layout/footer.jsp"%>

