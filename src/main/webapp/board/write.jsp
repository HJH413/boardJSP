<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--패키지 가져오기--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.board.boardjsp.*" %>

<%
    BoardDAO boardDAO = new BoardDAO();
    List<BoardVO> categoryList = boardDAO.boardCategory();
%>
<html>
<head>
    <title>게시판 - 등록</title>
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
        const board_password_check = () => {
            let board_password = document.getElementById('board_password').value;
            let board_password_check = document.getElementById('board_password_check').value;
            let check = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{4,16}$/ //  영문자 특문
            if(board_password != board_password_check){
                alert("비밀번호 확인")
            } else if (!(check.test(board_password))){
                alert("영문/숫자/특문 포함해야 및 4자리 이상 16자리 미만")
            } else {
                return true
            }
        }
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
    <h1> 게시판 - 등록</h1>
    <form id="write_from" action="/board/save.jsp" method="post" enctype="multipart/form-data">
        <table width="100%" style="border : none;" id="board_table">
            <tr>
                <td class="td_name">카테고리</td>
                <td class="td_content">
                    <select name="category_num" required>
                        <%
                            for (BoardVO boardVO : categoryList){
                        %>
                        <option value="<%=boardVO.getCategory_num() %>"><%=boardVO.getCategory_name() %></option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="td_name">작성자</td>
                <td class="td_content"><input type="text" id="board_writer" name="board_writer" minlength="3" maxlength="4" required></td>
            </tr>
            <tr>
                <td class="td_name">비밀번호</td>
                <td class="td_content">
                    <input type="password" id="board_password" name="board_password" minlength="4" maxlength="15" required>
                    <input type="password" id="board_password_check" name="board_password_check" minlength="4" maxlength="15" onblur="board_password_check()" required>
                </td>
            </tr>
            <tr>
                <td class="td_name">제목</td>
                <td class="td_content"><input type="text" size="148" id="board_title" name="board_title" minlength="4" maxlength="99" required></td>
            </tr>
            <tr>
                <td class="td_name">내용</td>
                <td class="td_content">
                    <textarea rows="10" cols="150" id="board_content" name="board_content" minlength="4" maxlength="1999" required></textarea>
                </td>
            </tr>
                <%--파일 업로드시 필수 사용 enctype="multipart/form-data"--%>
            <tr>
                <td class="td_name">파일 첨부</td>
                <td class="td_content"><input type="file" name="board_file1"></td>
            </tr>

        </table>
        <input type="button" id="board_file_extend" name="board_file_extend" onclick="board_file_add()" value="파일 추가 첨부 버튼">
        <input type="submit" id="save" name="save" value="저장">
    </form>
    <a href="/board/list.jsp"><button type="button">취소</button></a>

    </body>
</html>
