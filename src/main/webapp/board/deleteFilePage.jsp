<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>게시글 삭제 페이지</title>
    <%
      request.setCharacterEncoding("UTF-8");
    int boardNum = Integer.parseInt(request.getParameter("boardNum"));
    String boardFileName = request.getParameter("fileName");
    %>
  </head>
  <body>
  <form action="/board/deleteFile.jsp" method="post">
    <input type="hidden" name="board_num" value="<%=boardNum%>">
    <input type="hidden" name="board_file_name" value="<%=boardFileName%>">
    <%System.out.println(boardFileName+"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"); %>
    비밀번호 입력 : <input type="password" name="board_password" placeholder="비밀번호를 입력하세요." required>
    <br/><input type="submit" value="확인">
  </form>
  <a href="/board/modify.jsp?boardNum=<%=boardNum%>"><button>취소</button></a>
  </body>
</html>
