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
    <%
        }
    %>
<% } %>
<form action="/board/comments_save.jsp" method="post">
    <input type="hidden" name="board_num" value="<%=boardNum %>">
    댓글 작성자 : <input type="text" name="comments_writer" minlength="1" maxlength="5" required/>
    <textarea rows="3" cols="150" name="comments_content" minlength="1" maxlength="200" placeholder="댓글을 입력해 주세요." required></textarea>
    <br/>
    <input type="submit" value="등록">
</form>
<hr/>
<a href="/board/list.jsp"><button>목록</button></a><a><button>수정</button></a><a><button>삭제</button></a>
</body>
</html>
