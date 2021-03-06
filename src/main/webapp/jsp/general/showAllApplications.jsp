<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="datetag" uri="https://epam.by/datetag" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">

<fmt:bundle basename="page_content">
    <fmt:message key="show_all_applications.title" var="title"/>
    <fmt:message key="show_all_applications.number" var="number"/>
    <fmt:message key="show_all_applications.faculty" var="faculty"/>
    <fmt:message key="show_all_applications.places" var="places"/>
    <fmt:message key="show_all_applications.passing_points" var="passing_points"/>
    <fmt:message key="show_all_applications.first_name" var="first_name"/>
    <fmt:message key="show_all_applications.last_name" var="last_name"/>
    <fmt:message key="show_all_applications.certificate" var="certificate"/>
    <fmt:message key="show_all_applications.marks" var="marks"/>
    <fmt:message key="show_all_applications.status" var="status"/>
    <fmt:message key="show_all_applications.date_of_register" var="date_of_register"/>
    <fmt:message key="show_all_applications.process_applications" var="process_applications"/>
</fmt:bundle>

<html>
    <head>
        <title>${pageScope.title}</title>
    </head>

    <body class="page">

        <div>
           <%@ include file="/jsp/common/header.jsp"%>
        </div>

        <div>
           <%@ include file="/jsp/common/mainMenu.jsp"%>
        </div>


    <div class="table">
    <table>
        <tr>
            <th>${pageScope.number}</th>
            <th>${pageScope.faculty}</th>
            <th>${pageScope.places}</th>
            <th>${pageScope.passing_points}</th>
                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                    <th>${pageScope.first_name}</th>
                    <th>${pageScope.last_name}</th>
                </c:if>
            <th>${pageScope.certificate}</th>
            <th>${pageScope.marks}</th>
            <th>${pageScope.status}</th>
            <th>${pageScope.date_of_register}</th>
        </tr>

        <c:forEach items="${showAllApplications}" var="application" begin="0" varStatus="loop">
            <tr>
                <td> ${loop.begin + loop.count}</td>
                <td> ${application.faculty.name}</td>
                <td> ${application.faculty.places}</td>
                <td> ${application.faculty.passingPoints}</td>
                    <c:if test="${sessionScope.user.role == 'ADMIN'}">
                        <td> ${application.student.firstName}</td>
                        <td> ${application.student.lastName}</td>
                    </c:if>
                <td> ${application.student.certificate}</td>
                <td> ${application.student.marks}</td>
                <td> ${application.status}</td>
                <td> <datetag:formatDate dateTime="${application.dateTime}"/> </td>
            </tr>
        </c:forEach>
        <c:if test="${sessionScope.user.role == 'ADMIN'}">
            <th class="button" colspan="2">
            <form name="button" method="POST" action="controller">
            <input type="hidden" name="command" value="process_applications" />
            <input type="submit" value="${pageScope.process_applications}"/>
            </th>
        </c:if>
    </table>
    </div>
    </body>
</html>
