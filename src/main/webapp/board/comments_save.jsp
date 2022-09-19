<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--패키지 가져오기--%>
<%@ page import="com.board.boardjsp.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    int board_num = Integer.parseInt(request.getParameter("board_num"));
    String comments_writer = request.getParameter("comments_writer");
    String comments_content = request.getParameter("comments_content");

    BoardVO boardVO = new BoardVO();
    boardVO.setBoard_num(board_num);
    boardVO.setComment_content(comments_content);
    boardVO.setComment_writer(comments_writer);

    BoardDAO boardDAO = new BoardDAO();
    boardDAO.boardCommentsWrite(boardVO);
    response.sendRedirect("/board/view.jsp?boardNum="+board_num);
%>