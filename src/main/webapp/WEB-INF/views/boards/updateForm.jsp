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

<script src="/js/boards.js"></script>

<script>

	$('#content').summernote({
		height : 400
	});
</script>

<%@ include file="../layout/footer.jsp"%>

