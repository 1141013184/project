<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
	function studentDelete(studentId) {
		if(confirm("您确定要删除这个学生吗？")) {
			window.location="student?action=delete&studentId="+studentId;
		}
	}
</script>
<div class="data_list">
		<div class="data_list_title">
			Управление студентами
		</div>
		<form name="myForm" class="form-search" method="post" action="student?action=search">
				<button class="btn btn-success" type="button" style="margin-right: 50px;" onclick="javascript:window.location='student?action=preSave'">add</button>
				<span class="data_search">
					<select id="buildToSelect" name="buildToSelect" style="width: 110px;">
					<option value="">All dormitory buildings</option>
					<c:forEach var="dormBuild" items="${dormBuildList }">
						<option value="${dormBuild.dormBuildId }" ${buildToSelect==dormBuild.dormBuildId?'selected':'' }>${dormBuild.dormBuildName }</option>
					</c:forEach>
					</select>
					<select id="searchType" name="searchType" style="width: 80px;">
					<option value="name">name</option>
					<option value="number" ${searchType eq "number"?'selected':'' }>stunum</option>
					<option value="dorm" ${searchType eq "dorm"?'selected':'' }>dormitories</option>
					</select>
					&nbsp;<input id="s_studentText" name="s_studentText" type="text"  style="width:120px;height: 30px;" class="input-medium search-query" value="${s_studentText }">
					&nbsp;<button type="submit" class="btn btn-info" onkeydown="if(event.keyCode==13) myForm.submit()">search</button>
				</span>
		</form>
		<div>
			<table class="table table-hover table-striped table-bordered">
				<tr>
					<th>num</th>
					<th>stunum</th>
					<th>name</th>
					<th>sex</th>
					<th>dormitory building</th>
					<th>dormitories</th>
					<th>phone number</th>
					<th width="15%">operation</th>
				</tr>
				<c:forEach  varStatus="i" var="student" items="${studentList }">
					<tr>
						<td>${i.count+(page-1)*pageSize }</td>
						<td>${student.userName }</td>
						<td>${student.name }</td>
						<td>${student.sex }</td>
						<td>${student.dormBuildName==null?"无":student.dormBuildName }</td>
						<td>${student.dormName }</td>
						<td>${student.tel }</td>
						<td><button class="btn btn-mini btn-info" type="button" onclick="javascript:window.location='student?action=preSave&studentId=${student.studentId }'">modify</button>&nbsp;
							<button class="btn btn-mini btn-info" type="button" onclick="javascript:window.location='student?action=record&studentId=${student.studentId }'">Absence records</button>&nbsp;
							<button class="btn btn-mini btn-danger" type="button" onclick="studentDelete(${student.studentId })">delete</button></td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div align="center"><font color="red">${error }</font></div>
		<div class="pagination pagination-centered">
			<ul>
				${pageCode }
			</ul>
		</div>
</div>