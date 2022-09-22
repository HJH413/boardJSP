package com.board.boardjsp;

import javax.servlet.http.HttpSession;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {

    //DB접속 정보
    private final String driverClassName = "com.mysql.jdbc.Driver";
    private final String url = "jdbc:mysql://127.0.0.1:3306/board_study?characterEncoding=UTF-8&serverTimezone=UTC";
    private final String username = "root";
    private final String password = "admin1234";

    //게시글 목록
    public List<BoardVO> boardList(int startRow, int pageSize) {

        List<BoardVO> list = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        //sql 문
        String sql = "SELECT BOARD_NUM, BOARD_TITLE, BOARD_WRITER, BOARD_CONTENT, BOARD_DATE, BOARD_UPDATE, BOARD_COUNT, CATEGORY_NAME, BOARD_FILE_STATE \n" +
                "FROM board b \n" +
                "JOIN category c on c.category_num = b.category_num \n" +
                "ORDER BY board_num DESC, board_num LIMIT ?, ? ";;

        try {
            connection = this.getConnection();
            statement = connection.prepareStatement(sql);

            statement.setInt(1, startRow - 1);
            statement.setInt(2, pageSize);

            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                BoardVO boardVO = new BoardVO();
                boardVO.setBoard_num(resultSet.getInt("BOARD_NUM"));
                boardVO.setBoard_title(resultSet.getString("BOARD_TITLE"));
                boardVO.setBoard_writer(resultSet.getString("BOARD_WRITER"));
                boardVO.setBoard_content(resultSet.getString("BOARD_CONTENT"));
                boardVO.setBoard_count(resultSet.getInt("BOARD_COUNT"));
                String ymd = String.valueOf(resultSet.getDate("BOARD_DATE"));
                String hms = String.valueOf(resultSet.getTime("BOARD_DATE"));
                String uymd = String.valueOf(resultSet.getDate("BOARD_UPDATE"));
                String uhms = String.valueOf(resultSet.getTime("BOARD_UPDATE"));
                boardVO.setBoard_date(ymd + " " + hms);
                boardVO.setBoard_file_state(resultSet.getInt("BOARD_FILE_STATE"));
                if (resultSet.getDate("BOARD_UPDATE") == null) {
                    boardVO.setBoard_update(null);
                } else {
                    boardVO.setBoard_update(uymd + " " + uhms);
                }
                boardVO.setCategory_name(resultSet.getString("CATEGORY_NAME"));

                list.add(boardVO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(connection, statement, resultSet);
        }
        return list;
    }

    //게시글 검색
    public List<BoardVO> boardSearchList(BoardSearchVO boardSearchVO) {

        String startDate = boardSearchVO.getStartDate();
        String endDate = boardSearchVO.getEndDate();
        int categoryNum = boardSearchVO.getCategoryNum();
        String searchText = boardSearchVO.getSearchText();

        System.out.println(startDate);
        System.out.println(endDate);
        System.out.println(categoryNum);
        System.out.println(searchText);


        List<BoardVO> list = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        //sql 문
        String sql = "SELECT BOARD_NUM, BOARD_TITLE, BOARD_WRITER, BOARD_CONTENT, BOARD_DATE, BOARD_UPDATE, BOARD_COUNT, CATEGORY_NAME, BOARD_FILE_STATE \n" +
                "FROM board b \n" +
                "JOIN category c on c.category_num = b.category_num \n" +
                "WHERE 1=1";
        String betweenDate = " AND board_date BETWEEN ? AND ?";
        String category = " AND c.category_num = ?";
        String search = " AND (BOARD_TITLE LIKE ? or BOARD_WRITER LIKE ? or BOARD_CONTENT LIKE ?) ";
        String sqlLimit = " ORDER BY board_num DESC";
        String sqlReuslt = "";
        if (categoryNum == 0 && searchText.equals("")){
            sqlReuslt = sql + betweenDate + sqlLimit;
            System.out.println("1.  " + sqlReuslt);
        } else if(categoryNum != 0 && searchText.equals("")){
            sqlReuslt = sql + betweenDate + category + sqlLimit;
            System.out.println("2 .  " + sqlReuslt);
        } else if(categoryNum == 0 && !searchText.equals("")){
            sqlReuslt = sql + betweenDate + search + sqlLimit;
            System.out.println("3 .  " + sqlReuslt);
        }else {
            sqlReuslt = sql + betweenDate + category + search + sqlLimit;
            System.out.println("3.  " + sqlReuslt);
        }

        try {
            connection = this.getConnection();
            statement = connection.prepareStatement(sqlReuslt);
            System.out.println(statement.toString());
            if(categoryNum == 0 && searchText.equals("")){
                statement.setString(1, startDate);
                statement.setString(2, endDate);
            } else if(categoryNum != 0 && searchText.equals("")) {
                statement.setString(1, startDate);
                statement.setString(2, endDate);
                statement.setInt(3, categoryNum);
            }  else if(categoryNum == 0 && !searchText.equals("")){
                statement.setString(1, startDate);
                statement.setString(2, endDate);
                statement.setString(3, "%"+searchText+"%");
                statement.setString(4, "%"+searchText+"%");
                statement.setString(5, "%"+searchText+"%");
            }else {
                statement.setString(1, startDate);
                statement.setString(2, endDate);
                statement.setInt(3, categoryNum);
                statement.setString(4, "%"+searchText+"%");
                statement.setString(5, "%"+searchText+"%");
                statement.setString(6, "%"+searchText+"%");
            }
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                BoardVO boardVO = new BoardVO();
                boardVO.setBoard_num(resultSet.getInt("BOARD_NUM"));
                boardVO.setBoard_title(resultSet.getString("BOARD_TITLE"));
                boardVO.setBoard_writer(resultSet.getString("BOARD_WRITER"));
                boardVO.setBoard_content(resultSet.getString("BOARD_CONTENT"));
                boardVO.setBoard_count(resultSet.getInt("BOARD_COUNT"));
                String ymd = String.valueOf(resultSet.getDate("BOARD_DATE"));
                String hms = String.valueOf(resultSet.getTime("BOARD_DATE"));
                String uymd = String.valueOf(resultSet.getDate("BOARD_UPDATE"));
                String uhms = String.valueOf(resultSet.getTime("BOARD_UPDATE"));
                boardVO.setBoard_date(ymd + " " + hms);
                boardVO.setBoard_file_state(resultSet.getInt("BOARD_FILE_STATE"));
                if (resultSet.getDate("BOARD_UPDATE") == null) {
                    boardVO.setBoard_update(null);
                } else {
                    boardVO.setBoard_update(uymd + " " + uhms);
                }
                boardVO.setCategory_name(resultSet.getString("CATEGORY_NAME"));

                list.add(boardVO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(connection, statement, resultSet);
        }
        return list;
    }
    //게시글 총 건수
    public int boardCount() {

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        //sql 문
        String sql = "SELECT count(*) as Board_search_count \n" +
                "FROM board b \n" +
                "JOIN category c on c.category_num = b.category_num \n" +
                "WHERE 1=1";
        int boardSearchCount = 0;
        try {
            connection = this.getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                boardSearchCount = resultSet.getInt("Board_search_count");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(connection, statement, resultSet);
        }
        return boardSearchCount;
    }

    //카테고리 호출
    public List<BoardVO> boardCategory() {
        List<BoardVO> categoryList = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        String sql = "SELECT category_num, category_name FROM category";

        try {
            connection = this.getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                BoardVO boardVO = new BoardVO();
                boardVO.setCategory_num(resultSet.getInt("category_num"));
                boardVO.setCategory_name(resultSet.getString("category_name"));
                categoryList.add(boardVO);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(connection, statement, resultSet);
        }
        return categoryList;
    }

    //글작성
    public void boardWrite(BoardVO boardVO) {
        Connection connection = null;
        PreparedStatement statement = null;
        String sql = "INSERT INTO board(board_title, board_writer, board_password, board_content,category_num, board_date, board_count)\n" +
                "VALUES (?, ?, ?, ?, ?, now(), 0)";
        try {
            connection = this.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, boardVO.board_title);
            statement.setString(2, boardVO.board_writer);
            statement.setString(3, boardVO.board_password);
            statement.setString(4, boardVO.board_content);
            statement.setInt(5, boardVO.category_num);
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.close(connection, statement, null);
        }
    }

    //파일 정보 DB업로드
    public void fileInfo(String ofileName, String fileName, long filesize) {
        Connection connection = null;
        PreparedStatement statement = null;
        String sql = "INSERT INTO file (file_origin_name,file_change_name ,file_size, board_num) VALUES (?, ?, ?, (SELECT board_num FROM board ORDER BY board_date desc limit 1))";
        try {
            connection = this.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, ofileName);
            statement.setString(2, fileName);
            statement.setLong(3, filesize);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.close(connection, statement, null);
        }
    }

    //게시글 파일첨부 상태 변경
    public void boardFileState() {
        Connection connection = null;
        PreparedStatement statement = null;
        String sql = "UPDATE board SET board_file_state = 1 WHERE board_num = (SELECT NUM FROM (SELECT board_num as NUM FROM board ORDER BY board_date desc limit 1) A)";
        try {
            connection = this.getConnection();
            statement = connection.prepareStatement(sql);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.close(connection, statement, null);
        }
    }

    //글상세보기
    public BoardVO boardRead(int boardNum) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        BoardVO boardVO = new BoardVO();
        String sql = "SELECT board_num, board_title, board_writer, board_password, board_content, board_date, board_update, board_count, board_file_state, category_name \n" +
                "FROM board b\n" +
                "JOIN category c on b.category_num = c.category_num\n" +
                "WHERE board_num = ?";
        try {
            connection = this.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, boardNum);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                boardVO.setBoard_num(resultSet.getInt("BOARD_NUM"));
                boardVO.setBoard_title(resultSet.getString("BOARD_TITLE"));
                boardVO.setBoard_writer(resultSet.getString("BOARD_WRITER"));
                boardVO.setBoard_content(resultSet.getString("BOARD_CONTENT"));
                boardVO.setBoard_count(resultSet.getInt("BOARD_COUNT"));
                String ymd = String.valueOf(resultSet.getDate("BOARD_DATE"));
                String hms = String.valueOf(resultSet.getTime("BOARD_DATE"));
                String uymd = String.valueOf(resultSet.getDate("BOARD_UPDATE"));
                String uhms = String.valueOf(resultSet.getTime("BOARD_UPDATE"));
                boardVO.setBoard_date(ymd + " " + hms);
                boardVO.setBoard_file_state(resultSet.getInt("BOARD_FILE_STATE"));
                if (resultSet.getDate("BOARD_UPDATE") == null) {
                    boardVO.setBoard_update(null);
                } else {
                    boardVO.setBoard_update(uymd + " " + uhms);
                }
                boardVO.setCategory_name(resultSet.getString("CATEGORY_NAME"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.close(connection, statement, resultSet);
        }
        return boardVO;
    }
    //조회수 증가
    public void boardCount(int boardNum){
        Connection connection = null;
        PreparedStatement statement = null;

        String sql = "UPDATE board SET board_count = IFNULL(board_count, 0) + 1 WHERE board_num = ?";
        try {
            connection = this.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1,boardNum);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.close(connection, statement, null);
        }

    }


    //파일목록
    public List<BoardVO> fileList(int boardNum){
        List<BoardVO> fileList = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        String sql = "SELECT file_change_name, board_num FROM file WHERE BOARD_NUM = ?";

        try {
            connection = this.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, boardNum);
            resultSet = statement.executeQuery();
            while (resultSet.next()){
                BoardVO boardVO = new BoardVO();
                boardVO.setFile_name(resultSet.getString("file_change_name"));
                fileList.add(boardVO);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.close(connection, statement, resultSet);
        }

        return fileList;
    }
    //댓글작성
    public void boardCommentsWrite(BoardVO boardVO){
        Connection connection = null;
        PreparedStatement statement = null;

        String sql = "INSERT INTO comments (board_num,comments_writer, comments_content) values (?, ?, ?)";

        try {
            connection = this.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1,boardVO.getBoard_num());
            statement.setString(2,boardVO.getComment_writer());
            statement.setString(3,boardVO.getComment_content());
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.close(connection, statement, null);
        }
    }
    //댓글 리스트
    public List<BoardVO> boardCommentsList(int boardNum){
        List<BoardVO> commnetsList = new ArrayList<>();

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        String sql = "SELECT comments_num, comments_writer, comments_content, comments_time, board_num FROM comments WHERE board_num = ? ORDER BY comments_time";

        try {
            connection = this.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1,boardNum);
            resultSet = statement.executeQuery();
            while (resultSet.next()){
                BoardVO boardVO = new BoardVO();
                boardVO.setComment_writer(resultSet.getString("comments_writer"));
                boardVO.setComment_content(resultSet.getString("comments_content"));
                String ymd = String.valueOf(resultSet.getDate("comments_time"));
                String hms = String.valueOf(resultSet.getTime("comments_time"));
                boardVO.setComment_date(ymd + " " + hms);
                commnetsList.add(boardVO);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.close(connection, statement, resultSet);
        }

        return commnetsList;
    }
    //댓글 카운트
    public int boardCommentsCount(int boardNum){
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        String sql = "SELECT count(1) as comments_count FROM comments WHERE board_num = ?";
        int boardCommentsCount = 0;
        try {
            connection = this.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1,boardNum);
            resultSet = statement.executeQuery();
            while (resultSet.next()){
                boardCommentsCount = resultSet.getInt("comments_count");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.close(connection, statement, resultSet);
        }
        return boardCommentsCount;
    }

    //삭제 및 수정 전 비밀번호 채크
    public int boardPasswordCheck(int boardNum, String boardPassword){
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        String sql = "SELECT count(*) as passCheck FROM board WHERE board_num = ? and board_password = ?";
        int passCheck = 0;
        try {
            connection = this.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, boardNum);
            statement.setString(2, boardPassword);
            resultSet = statement.executeQuery();
            while(resultSet.next()){
                passCheck = resultSet.getInt("passCheck");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.close(connection, statement, resultSet);
        }


        return passCheck;
    }

    //글삭제
    public void boardDelete(int boardNum){
        Connection connection = null;
        PreparedStatement statement = null;
        String sql = "DELETE FROM board WHERE board_num = ?";
        try {
            connection = this.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1,boardNum);
            statement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.close(connection, statement, null);
        }
    }
    //파일 삭제
    public void boardFileDelete(int boardNum, String boardFileName){
        Connection connection = null;
        PreparedStatement statement = null;
        String sql = "DELETE FROM file WHERE board_num = ? and file_change_name = ?";
        try {
            connection = this.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1,boardNum);
            statement.setString(2,boardFileName);
            statement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.close(connection, statement, null);
        }
    }
    //글수정
    public void boardModify(BoardVO boardVO){
        Connection connection = null;
        PreparedStatement statement = null;

        String sql = ("UPDATE board SET board_writer = ?, board_title = ?, board_content = ?, board_update = now() WHERE board_num = ?");

        connection = this.getConnection();
        try {
            statement = connection.prepareStatement(sql);
            statement.setString(1, boardVO.getBoard_writer());
            statement.setString(2, boardVO.getBoard_title());
            statement.setString(3, boardVO.getBoard_content());
            statement.setInt(4, boardVO.getBoard_num());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.close(connection, statement, null);
        }

    }

    //커넥션
    private Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName(this.driverClassName);
            connection = DriverManager.getConnection(this.url, this.username, this.password);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    } // end of Connection

    private void close(Connection connection, Statement statement, ResultSet resultSet) {
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }// end of class
}//end of BoardDAO
