<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	function checkForm(){
		var studentNumber = document.getElementById("studentNumber").value;
		var detail = document.getElementById("detail").value;
		if(studentNumber==""||detail==""){
			document.getElementById("error").innerHTML="信息填写不完整！";
			return false;
		}
		return true;
	}
	
	$(document).ready(function(){
		$("ul li:eq(2)").addClass("active");
	});
</script>
<div class="data_list">
		<div class="data_list_title">
		<c:choose>
			<c:when test="${student.studentId!=null }">
				Modification of absence records
			</c:when>
			<c:otherwise>
				Add absence records
			</c:otherwise>
		</c:choose>
		</div>
		<form action="record?action=save" method="post" onsubmit="return checkForm()">
			<div class="data_form" >
				<input type="hidden" id="recordId" name="recordId" value="${record.recordId }"/>
					<table align="center">
						<tr>
							<td><font color="red">*</font>stunum：</td>
							<td><input type="text" id="studentNumber"  name="studentNumber" value="${record.studentNumber==null?studentNumber:record.studentNumber }"  style="margin-top:5px;height:30px;" ${studentNumber!=null?'readonly':'' }/></td>
						</tr>
						<tr>
							<td><font color="red">*</font>data：</td>
							<td><input type="text" id="date"  name="date" value="${record.date==null?date:record.date }"  style="margin-top:5px;height:30px;" readonly="readonly" /></td>
						</tr>
						<tr>
							<td><font color="red">*</font>note：</td>
							<td><input type="text" id="detail"  name="detail" value="${record.detail }"  style="margin-top:5px;height:30px;" /></td>
						</tr>
					</table>
					<div align="center">
						<input type="submit" class="btn btn-primary" value="save"/>
						&nbsp;<button class="btn btn-primary" type="button" onclick="javascript:window.location='record'">back</button>
					</div>
					<div align="center">
						<font id="error" color="red">${error }</font>
					</div>
			</div>
		</form>
</div>