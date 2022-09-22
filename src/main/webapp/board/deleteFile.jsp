<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--패키지 가져오기--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.board.boardjsp.*" %>

<%
    request.setCharacterEncoding("UTF-8");
    int boardNum = Integer.parseInt(request.getParameter("board_num"));
    String boardPassword = request.getParameter("board_password");
    String boardFileName = request.getParameter("board_file_name");
    System.out.println(boardNum);
    System.out.println("@@@@@@@@@@@@@@@@@@@@@@@"+boardFileName);
    BoardDAO boardDAO = new BoardDAO();
    int check = boardDAO.boardPasswordCheck(boardNum, boardPassword); //삭제 실패시 0 성공하면 1
    if(check == 0){ %>
    <script>
        alert("비밀번호 불일치");
        location.href= "/board/modify.jsp?boardNum="+<%=boardNum %>;
    </script>
    <% } else {
        boardDAO.boardFileDelete(boardNum, boardFileName);
        response.sendRedirect("/board/modify.jsp?boardNum="+boardNum);
    } %>
