<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>게시글 삭제 페이지</title>
    <%
    int boardNum = Integer.parseInt(request.getParameter("boardNum"));
    %>
  </head>
  <body>
  <form action="/board/delete.jsp" method="post">
    <input type="hidden" value="<%=boardNum%>">
    비밀번호 입력 : <input type="password" name="board_password" required>
    <br/><input type="submit" value="확인">
  </form>
  <a href="/board/view.jsp?boardNum=<%=boardNum%>"><button>취소</button></a>
  </body>
</html>
