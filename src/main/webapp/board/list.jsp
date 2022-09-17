<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--패키지 가져오기--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.board.boardjsp.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>게시판 - 목록</title>
</head>
<body>
<%
    BoardDAO boardDAO = new BoardDAO();
    List<BoardVO> list = boardDAO.boardList();
    List<BoardVO> categoryList = boardDAO.boardCategory();
%>
<h1> 게시판 - 목록 </h1>
<hr/>
<form action="/board/search.jsp" method="post">
등록일 <input type="date" name="board_date_start"> ~ <input type="date" name="board_date_end">
<select name="category_num">
    <%
        for (BoardVO boardVO : categoryList){
    %>
    <option value="<%=boardVO.getCategory_num() %>"><%=boardVO.getCategory_name() %></option>
    <%
        }
    %>
</select>
<input type="text" name="board_search_text" placeholder="검색어를 입력해 주세요. (제목, 작성자, 내용)" size="50">
<input type="submit" value="검색">
</form>
<hr/>
<h3>총 건</h3>
<br/>
<table border="1">
    <thead>
    <tr>
        <th>카테고리</th>
        <th>제목</th>
        <th>작성자</th>
        <th>조회수</th>
        <th>등록 일시</th>
        <th>수정 일시</th>
    </tr>
    </thead>
    <%
        for (BoardVO boardVO : list) {
    %>
    <tr>
        <td><%=boardVO.getCategory_name() %></td>
        <td><%=boardVO.getBoard_title() %></td>
        <td><%=boardVO.getBoard_writer() %></td>
        <td><%=boardVO.getBoard_count() %></td>
        <td><%=boardVO.getBoard_date() %></td>
        <td style="text-align: center">
        <% if (boardVO.getBoard_update() == null) { %>
             -
        <% } else { %>
            <%=boardVO.getBoard_update() %>
        <% } %>
        </td>
    </tr>
    <%
        }
    %>
</table>
<a href="hello-servlet">Hello Servlet</a>
<a href="/board/write.jsp">글작성</a>

</body>
</html>