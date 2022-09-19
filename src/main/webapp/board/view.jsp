<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--패키지 가져오기--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.board.boardjsp.*" %>
<%
    BoardDAO boardDAO = new BoardDAO();
    BoardVO boardVO = new BoardVO();
    int boardNum = Integer.parseInt(request.getParameter("boardNum"));

    boardDAO.boardCount(boardNum);

    boardVO = boardDAO.boardRead(boardNum);
    List<BoardVO> filelist = boardDAO.fileList(boardNum);
    String boardWriter = boardVO.getBoard_writer();
    String boardTittle = boardVO.getBoard_title();
    String boardDate = boardVO.getBoard_date();
    String boardUpdate = boardVO.getBoard_update();
    int boardCount = boardVO.getBoard_count();
    String boardContent = boardVO.getBoard_content();
    String categoryName = boardVO.getCategory_name();

    List<BoardVO> boardCommentsList = boardDAO.boardCommentsList(boardNum);
    int boardCommentsCount = boardDAO.boardCommentsCount(boardNum);

    /*// 한 페이지에 출력될 글 수
    int pageSize = 5;
    //현 페이지 정보 설정
    String pagNum = request.getParameter("pageNum");
    if(pagNum == null) {
        pagNum = "1";
    }
    //첫 행번호 계산
    int currentPage = Integer.parseInt(pagNum);
    int startRow = (currentPage-1) * pageSize + 1;*/
%>
<html>
<head>
    <title>게시판 - 보기</title>
</head>
<body>
<h1>게시판 - 보기</h1>
<hr/>
작성자 : <%=boardWriter%>
<hr/>
[<%=categoryName%>]<%=boardTittle%> 조회수 : <%=boardCount%>
<hr/>
등록일시 : <%=boardDate%>
수정일시 : <% if (boardUpdate == null) { %>
-
<% } else { %>
<%=boardUpdate %>
<% } %>
<hr/>
<textarea rows="10" cols="150" minlength="4" maxlength="1999" readonly><%=boardContent%></textarea>
<hr/>
<%
    for (BoardVO boardVO1 : filelist){
%>
<%=boardVO1.getFile_name()%><br/>
<%
    }
%>
<hr/>
<br/>
<% if(boardCommentsList == null) { %>
    댓글이 출력됩니다.
<% } else { %>
    <%
        for (BoardVO comments : boardCommentsList){
    %>
    작성자 : <%=comments.getComment_writer()%>       <%=comments.getComment_date()%>
    <br/>
    <%=comments.getComment_content()%>
    <hr/>
    총 댓글 : <%=boardCommentsCount %> 개
    <%
        }
    %>
<% } %>

<%--<div id="page_control">
    <%
        if(boardCommentsCount != 0) {
            // 페이징 처리
            // 전체 페이지수 계산
            int pageCount = boardCommentsCount / pageSize + (boardCommentsCount%pageSize==0?0:1);

            // 한 페이지에 보여줄 페이지 블록
            int pageBlock = 5;

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
</div>--%>
<form action="/board/comments_save.jsp" method="post">
    <input type="hidden" name="board_num" value="<%=boardNum %>">
    댓글 작성자 : <input type="text" name="comments_writer" minlength="1" maxlength="5" required/>
    <br/>
    <textarea rows="3" cols="150" name="comments_content" minlength="1" maxlength="200" placeholder="댓글을 입력해 주세요." required></textarea>
    <br/>
    <input type="submit" value="등록">
</form>
<hr/>
<a href="/board/list.jsp"><button>목록</button></a><a><button>수정</button></a><a href="/board/deletePage.jsp?boardNum=<%=boardNum%>"><button>삭제</button></a>
</body>
</html>
