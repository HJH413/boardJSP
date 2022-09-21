<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--패키지 가져오기--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.board.boardjsp.*" %>

<%
    int boardNum = Integer.parseInt(request.getParameter("boardNum"));
    BoardDAO boardDAO = new BoardDAO();
    BoardVO boardVO = new BoardVO();
    List<BoardVO> categoryList = boardDAO.boardCategory();

    boardVO = boardDAO.boardRead(boardNum);

    String boardWriter = boardVO.getBoard_writer();
    String boardTittle = boardVO.getBoard_title();
    String boardDate = boardVO.getBoard_date();
    String boardUpdate = boardVO.getBoard_update();
    int boardCount = boardVO.getBoard_count();
    String boardContent = boardVO.getBoard_content();
    String categoryName = boardVO.getCategory_name();
    %>
<html>
<head>
    <title>게시판 - 수정</title>
    <style>
        .td_name {
            text-align: center;
            width: 10%;
            background-color: skyblue;
            height: 35px;
            font-style: inherit;
        }
        .td_content {
            text-align: left;
        }
    </style>
    <script type="text/javascript">
        let i = 2;
        const board_file_add = () => {
            const table = document.getElementById('board_table');
            const newRow = table.insertRow(); // 행 추가
            const newCell1 = newRow.insertCell(0);
            const newCell2 = newRow.insertCell(1);
            // Cell에 텍스트 추가
            newCell1.setAttribute("class", "td_name");
            newCell1.innerText = '파일 첨부';
            newCell2.innerHTML = '<input type="file" name="board_file' + i + '">';
            i += 1
        }
    </script>
</head>
<body>
<h1> 게시판 - 수정</h1>
<form id="write_from" action="/board/modifySave.jsp" method="post">
    <input type="hidden" name="board_num" value="<%=boardNum%>"/>
    <table width="100%" style="border : none;" id="board_table">
        <tr>
            <td class="td_name">카테고리</td>
            <td class="td_content">
                <%= categoryName %>
            </td>
        </tr>
        <tr>
            <td class="td_name">등록일</td>
            <td class="td_content">
                <%= boardDate %>
            </td>
        </tr>
        <tr>
            <td class="td_name">수정일</td>
            <% if(boardUpdate == null) { %>
                <td class="td_content">
                   -
                </td>
            <% } else { %>
            <td class="td_content">
                <%= boardUpdate %>
            </td>
            <% } %>
        </tr>
        <tr>
            <td class="td_name">조회수</td>
            <td class="td_content">
                <%= boardCount %>
            </td>
        </tr>
        <tr>
            <td class="td_name">작성자</td>
            <td class="td_content"><input type="text" id="board_writer" name="board_writer" minlength="3" maxlength="4" value="<%=boardWriter%>" required></td>
        </tr>
        <tr>
            <td class="td_name">비밀번호</td>
            <td class="td_content">
                <input type="password" id="board_password" name="board_password" minlength="4" maxlength="15" required>
            </td>
        </tr>
        <tr>
            <td class="td_name">제목</td>
            <td class="td_content"><input type="text" size="148" id="board_title" name="board_title" value="<%=boardTittle%>" minlength="4" maxlength="99" required></td>
        </tr>
        <tr>
            <td class="td_name">내용</td>
            <td class="td_content">
                <textarea rows="10" cols="150" id="board_content" name="board_content" minlength="4" maxlength="1999" required><%=boardContent%></textarea>
            </td>
        </tr>
        <%--파일 업로드시 필수 사용 enctype="multipart/form-data"--%>
        <tr>
            <td class="td_name">파일 첨부</td>
            <td class="td_content"><input type="file" name="board_file1"></td>
        </tr>

    </table>
    <input type="button" id="board_file_extend" name="board_file_extend" onclick="board_file_add()" value="파일 추가 첨부 버튼">
    <input type="submit" id="save" name="save" onclick="board_password_check()" value="저장">
</form>
<a href="/board/list.jsp"><button type="button">취소</button></a>

</body>
</html>
