<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp"%>
<div class="container">
	<br /> <br />
	<c:if test="${principal.id == boards.usersId}">
		<div class="d-flex">
			<a href="/boards/${boards.id}/updateForm" class="btn btn-warning">수정하러가기</a>
			<form>
			<input id="id" type="hidden" value="${boards.id}" />
			<input id="page" type="hidden" value="${sessionScope.referer.page}" />
			<input id="keyword" type="hidden" value="${sessionScope.referer.keyword}" />
				<button id="btnRemove" type="button" class="btn btn-danger">삭제</button>
			</form>
		</div>
	</c:if>
	<br />
	<div class="d-flex justify-content-between">
		<h3>${boards.title}</h3>
		<div>좋아요 수 : 10 <i id="iconHeart" class="fa-solid fa-heart"></i></div>
	</div>
	<hr />
	<div>${boards.content}</div>
</div>

<script>

$("#btnRemove").click(()=>{
	remove();
});

function remove(){
	let id = $("#id").val()
	let keyword = $("#keyword").val()
	let page = $("#page").val()
	
	$.ajax("/boards/" + id, {
		type: "DELETE",
		dataType: "json"
	}).done((res) => {
		if (res.code == 1) {
			alert("게시글 삭제완료")
			// document.referer 로 찾으면 제일 쉬움
			location.href = "/?page="+page+"&keyword="+keyword; // 세션을 이용한 기능구현
		}
	});
}

 $("#iconHeart").click((event)=>{
	let check = $("#iconHeart").hasClass("fa-regular");
	
	if(check == true){
		$("#iconHeart").removeClass("fa-regular");
		$("#iconHeart").addClass("fa-solid");
		$("#iconHeart").css("color","red");
	}else{
		$("#iconHeart").removeClass("fa-solid");
		$("#iconHeart").addClass("fa-regular");
		$("#iconHeart").css("color","black");
	}
 });
</script>

<%@ include file="../layout/footer.jsp"%>

