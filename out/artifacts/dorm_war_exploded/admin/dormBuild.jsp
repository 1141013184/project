<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
	function dormBuildDelete(dormBuildId) {
		if(confirm("Вы уверены, что хотите удалить это здание общежития?")) {
			window.location="dormBuild?action=delete&dormBuildId="+dormBuildId;
		}
	}
	$(document).ready(function(){
		$("ul li:eq(3)").addClass("active");
	});
</script>
<div class="data_list">
		<div class="data_list_title">
			общежития
		</div>
		<form name="myForm" class="form-search" method="post" action="dormBuild?action=search">
				<button class="btn btn-success" type="button" style="margin-right: 50px;" onclick="javascript:window.location='dormBuild?action=preSave'">add</button>
				<span class="data_search">
					name:&nbsp;&nbsp;<input id="s_dormBuildName" name="s_dormBuildName" type="text"  style="width:120px;height: 30px;" class="input-medium search-query" value="${s_dormBuildName }">
					&nbsp;<button type="submit" class="btn btn-info" onkeydown="if(event.keyCode==13) myForm.submit()">search</button>
				</span>
		</form>
		<div>
			<table class="table table-striped table-bordered table-hover datatable">
				<thead>
					<tr>
						<th width="15%">num</th>
						<th>name</th>
						<th>presentation</th>
						<th width="20%">operation</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach  varStatus="i" var="dormBuild" items="${dormBuildList }">
					<tr>
						<td>${i.count+(page-1)*pageSize }</td>
						<td>${dormBuild.dormBuildName }</td>
						<td>${dormBuild.detail==null||dormBuild.detail==""?"null":dormBuild.detail }</td>
						<td><button class="btn btn-mini btn-info" type="button" onclick="javascript:window.location='dormBuild?action=manager&dormBuildId=${dormBuild.dormBuildId }'">admin</button>&nbsp;
							<button class="btn btn-mini btn-info" type="button" onclick="javascript:window.location='dormBuild?action=preSave&dormBuildId=${dormBuild.dormBuildId }'">modify</button>&nbsp;
							<button class="btn btn-mini btn-danger" type="button" onclick="dormBuildDelete(${dormBuild.dormBuildId})">delete</button></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div align="center"><font color="red">${error }</font></div>
		<div class="pagination pagination-centered">
			<ul>
				${pageCode }
			</ul>
		</div>
</div>