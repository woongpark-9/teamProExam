<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="view/color.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="${bodyback_c}">
	<div align="center">
		<strong>글목록(전체 글:${count}) </strong>
		<table width="700">
			<tr>
				<td align="right" bgcolor="${value_c}">
					<a href="/teamPro03/board/writeForm.do">글쓰기 </a>
				</td>
		</table>
		<c:if test="${count eq 0}">
			<table width="700" border="1" cellpadding="0" cellspacing="0">
				<tr>
					<td align="center">게시판에 저장된 글이 없습니다.</td>
			</table>
		</c:if>
		<c:if test="${count gt 0}">
			<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
				<tr height="30" bgcolor="${value_c}">
					<td align="center" width="50">번 호</td>
					<td align="center" width="250">제 목</td>
					<td align="center" width="100">작성자</td>
					<td align="center" width="150">작성일</td>
					<td align="center" width="50">조 회</td>
					<td align="center" width="100">IP</td>
				</tr>
				<!-- $안에 number을 사용하면 계속 number만 출력되기 때문에 forEach문으로 number을 계속 1씩 감소시켜야 한다. -->
				<c:forEach var="article" items="${articleList}">
					<tr height="30">
						<td align="center" width="50">
							<c:out value="${number}" />
							<c:set var="number" value="${number - 1}" />
						</td>
						<td width="250">
							<c:if test="${article.depth gt 0}">
								<img src="images/level.gif" width="${5 * article.depth}" height="16">
								<img src="images/re.gif">
							</c:if>
							<c:if test="${article.depth eq 0}">
								<img src="images/level.gif" width="${5 * article.depth}" height="16">
							</c:if>
							<a href="/teamPro03/board/content.do?num=${article.getNum()}&pageNum=${currentPage}"> ${article.subject } </a>
							<c:if test="${article.readcount ge 20}">
								<img src="images/hot.gif" border="0" height="16">
							</c:if>
						</td>
						<td align="center" width="100">
							<a href="mailto:${article.email}">${article.writer} </a>
						</td>
						<td align="center" width="150">
							<fmt:formatDate value="${article.regdate }" pattern="yyyy.MM.dd" />
						</td>
						<td align="center" width="50">${article.readcount}</td>
						<td align="center" width="100">${article.ip}</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
		<!-- 페이지 소스를 작성한다 -->
		<c:if test="${count gt 0}">
			<c:set var="imsi" value="${count % pageSize == 0 ? 0 : 1 }" />
			<c:set var="pageCount" value="${count / pageSize + imsi}" />
			<!-- 화면에 보여질 페이지 처리 숫자를 표현 -->
			<c:set var="pageBlock" value="${3 }" />
			<!-- 결과를 정수형으로 리턴받아야 하기에 fmt태그를 사용 -->
			<fmt:parseNumber var="result" value="${(currentPage -1) / pageBlock}" integerOnly="true" />
			<c:set var="startPage" value="${result * pageBlock + 1}" />
			<c:set var="endPage" value="${startPage + pageBlock - 1 }" />
			<c:if test="${endPage gt pageCount}">
				<c:set var="endPage" value=" ${pageCount}" />
			</c:if>
			<!-- 3보다 페이지가 크면 "이전" 이라는 링크를 걸지 파악하는 구문-->
			<c:if test="${startPage gt pageBlock}">
				<a href="/teamPro03/board/list.do?pageNum=${startPage - pageBlock }">[이전]</a>
			</c:if>
			<!-- 페이징 처리 -->
			<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<a href="/teamPro03/board/list.do?pageNum=${i}">[${i}]</a>
			</c:forEach>
			<c:if test="${endPage lt pageCount}">
				<a href="/teamPro03/board/list.do?pageNum=${startPage + pageBlock}">[다음]</a>
			</c:if>
		</c:if>
	</div>
</body>
</html>