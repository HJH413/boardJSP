<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--패키지 가져오기--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.board.boardjsp.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>게시판 - 목록</title>
    <script src="https://kit.fontawesome.com/97ed07bc73.js" crossorigin="anonymous"></script>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    BoardDAO boardDAO = new BoardDAO();
    BoardSearchVO boardSearchVO = new BoardSearchVO();

    String startDate = "";
    String endDate = "";
    int categoryNum = 0;
    String searchText = "";

    if (request.getParameter("board_date_start").equals("")){
        System.out.println("1");
        startDate = "1999-01-01";
    } else {
        System.out.println("2");
        startDate = request.getParameter("board_date_start");
    }
    if (request.getParameter("board_date_end").equals("")){
        System.out.println("1");
        endDate = "2999-01-01";
    } else {
        endDate = request.getParameter("board_date_end");
    }

    categoryNum = Integer.parseInt(request.getParameter("category_num"));

    if (request.getParameter("board_search_text").equals("")){
        System.out.println("1");
        searchText = "";
    } else {
        System.out.println("2");
        searchText = request.getParameter("board_search_text");
    }
    System.out.println(startDate);
    System.out.println(endDate);
    System.out.println(categoryNum);
    System.out.println(searchText);
    boardSearchVO.setStartDate(startDate);
    boardSearchVO.setEndDate(endDate);
    boardSearchVO.setCategoryNum(categoryNum);
    boardSearchVO.setSearchText(searchText);

    List<BoardVO> list = boardDAO.boardSearchList(boardSearchVO);
    List<BoardVO> categoryList = boardDAO.boardCategory();
    //게시글 글 개수
    //int boardCount = boardDAO.boardCount();
  
%>
<h1>게시판 - 목록 </h1>
<hr/>
<form action="/board/listSearch.jsp" method="post">
등록일 <input type="date" name="board_date_start"> ~ <input type="date" name="board_date_end">
<select name="category_num">
    <option value="0">==선택하세요==</option>
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
<%--<h3>총 <%= boardCount %>건</h3>--%>
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
        <td><%if(boardVO.getBoard_file_state() == 1) { %>
            <i class="fa-regular fa-file"></i>
            <%}%>
            <a href="/board/view.jsp?boardNum=<%=boardVO.getBoard_num()%>"><%=boardVO.getBoard_title() %></a></td>
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
<a href="/board/write.jsp">글작성</a>
</body>
</html>