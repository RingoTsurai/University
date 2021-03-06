<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/lib/css/font-awesome.min.css">

<fmt:bundle basename="page_content">
    <fmt:message key="menu.title" var="title"/>
    <fmt:message key="menu.english" var="english"/>
    <fmt:message key="menu.russian" var="russian"/>
    <fmt:message key="menu.hello" var="hello"/>
    <fmt:message key="menu.hello_guest" var="hello_guest"/>
    <fmt:message key="menu.login" var="login"/>
    <fmt:message key="menu.register" var="register"/>
    <fmt:message key="menu.logout" var="logout"/>
</fmt:bundle>

<html>
    <body>
        <header class="header">
            <h1 class="top">${pageScope.title}</h1>
            <div class="change_level">
                <ul>
                    <li>
                        <a href="${pageContext.request.contextPath}/controller?command=common_change_language&locale=ru">
                        ${pageScope.russian}</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/controller?command=common_change_language&locale=en">
                        ${pageScope.english}</a>
                    </li>
                </ul>
            </div>

            <div class="hello_message">
                <c:choose>
                    <c:when test="${sessionScope.user == null}">
                        <span class="hello_text">${pageScope.hello_guest}</span>
                        <a class="logout_a"
                           href="${pageContext.request.contextPath}/jsp/common/login.jsp">${pageScope.login}</a>
                        <a class="register_login_a"
                           href="${pageContext.request.contextPath}/jsp/common/register.jsp">${pageScope.register}</a>
                    </c:when>

                    <c:when test="${sessionScope.user != null}">
                        <span class="hello_text">${pageScope.hello} ${sessionScope.user.login}</span>
                        <a class="register_login_a"
                           href="${pageContext.request.contextPath}/controller?command=logout">${pageScope.logout}</a>
                    </c:when>
                </c:choose>
            </div>
        </header>
    </body>
</html>