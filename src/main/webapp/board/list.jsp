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
    //페이징 변수 선언

    // 한 페이지에 출력될 글 수
    int pageSize = 10;
    //현 페이지 정보 설정
    String pagNum = request.getParameter("pageNum");
    if(pagNum == null) {
        pagNum = "1";
    }
    //첫 행번호 계산
    int currentPage = Integer.parseInt(pagNum);
    int startRow = (currentPage-1) * pageSize + 1;

    BoardDAO boardDAO = new BoardDAO();
    List<BoardVO> list = boardDAO.boardList(startRow, pageSize);
    List<BoardVO> categoryList = boardDAO.boardCategory();
    //게시글 글 개수
    int boardCount = boardDAO.boardCount();
%>
<h1>게시판 - 목록 </h1>
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
<h3>총 <%= boardCount %>건</h3>
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
<div id="page_control">
    <%
        if(boardCount != 0) {
            // 페이징 처리
            // 전체 페이지수 계산
            int pageCount = boardCount / pageSize + (boardCount%pageSize==0?0:1);

            // 한 페이지에 보여줄 페이지 블록
            int pageBlock = 10;

            // 한 페이지에 보여줄 페이지 블록 시작번호 계산
            int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;

            // 한 페이지에 보여줄 페이지 블럭 끝 번호 계산
            int endPage = startPage + pageBlock -1;
            if (endPage > pageCount) {
                endPage = pageCount;
            }
    %>
        <a href="/board/list.jsp?pageNum=<%=startPage%>">처음으로</a>
        <% if(startPage>pageBlock) {%>
            <a href="/board/list.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>
        <% }%>
        <% for(int i = startPage; i<=endPage; i++) { %>
            <a href="/board/list.jsp?pageNum=<%=i%>"><%=i%></a>
        <% }%>
        <% if(endPage<pageCount) {%>
            <a href="/board/list.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
        <% }%>
            <a href="/board/list.jsp?pageNum=<%=endPage%>">마지막</a>
    <%} // eno of if %>
</div>
<a href="/board/write.jsp">글작성</a>
</body>
</html>