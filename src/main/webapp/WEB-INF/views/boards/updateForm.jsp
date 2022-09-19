<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp"%>

<div class="container">
	<form>
	<input id="id" type="hidden" value="${boards.id}" />
	<input id="page" type="hidden" value="${sessionScope.referer.page}" />
	<input id="keyword" type="hidden" value="${sessionScope.referer.keyword}" />
		<div class="mb-3 mt-3">
			<input id="title" type="text" class="form-control" placeholder="Enter title" name="title" value="${boards.title}" required="required" maxlength="50">
		</div>
		<div class="mb-3">
			<textarea id="content" class="form-control" rows="8" name="content" required="required">${boards.content}</textarea>
		</div>
		<button id="btnUpdate" type="button" class="btn btn-primary">수정완료</button>
	</form>
</div>

<script>
	
	$("#btnUpdate").click(()=>{
		update();
	});
	
	function update(){
		let data = {
				title: $("#title").val(),
				content: $("#content").val()
			}
		let id = $("#id").val()
		let keyword = $("#keyword").val()
		let page = $("#page").val()
		
		$.ajax("/boards/"+id, {
			type: "PUT",
			dataType: "json", 
			data: JSON.stringify(data),
			headers: {
				"Content-Type": "application/json" 
			}
		}).done((res) => {
			if (res.code == 1) {
				location.href = "/?page="+page+"&keyword="+keyword;
			};
		});
	}

	$('#content').summernote({
		height : 400
	});
</script>

<%@ include file="../layout/footer.jsp"%>

