<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--패키지 가져오기--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "com.oreilly.servlet.*" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.board.boardjsp.*" %>
<%@ page import="java.io.File" %>
<%
    BoardVO boardVO = new BoardVO();
    BoardDAO boardDAO = new BoardDAO();
    int boardNum = Integer.parseInt(request.getParameter("board_num"));
    String boardPassword = request.getParameter("board_password");
    boardVO.setBoard_num(boardNum);
    boardVO.setBoard_writer(request.getParameter("board_writer"));
    boardVO.setBoard_title(request.getParameter("board_title"));
    boardVO.setBoard_content(request.getParameter("board_content"));

    int check = boardDAO.boardPasswordCheck(boardNum,boardPassword);
    if(check == 0){ %>
    <script>
        alert("비밀번호 불일치");
        location.href= "/board/modify.jsp?boardNum="+<%=boardNum %>;
    </script>
    <% } else {
        boardDAO.boardModify(boardVO);
        response.sendRedirect("/board/view.jsp?boardNum="+boardNum);
    } %>
%>