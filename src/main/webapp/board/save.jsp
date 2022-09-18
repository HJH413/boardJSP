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
    String uploadPath = "C:/boardFile";		// 업로드 경로
    int maxFileSize = 1024 * 1024 * 20;	// 업로드 제한 용량 = 20MB
    String encoding = "utf-8";			// 인코딩

    MultipartRequest multi = new MultipartRequest(
            request,
            uploadPath,
            maxFileSize,
            encoding,
            new DefaultFileRenamePolicy()
    );

    String category_num = multi.getParameter("category_num");
    String board_writer = multi.getParameter("board_writer");
    String board_password = multi.getParameter("board_password");
    String board_title = multi.getParameter("board_title");
    String board_content = multi.getParameter("board_content");

    BoardVO boardVO = new BoardVO();
    boardVO.setCategory_num(Integer.parseInt(category_num));
    boardVO.setBoard_writer(board_writer);
    boardVO.setBoard_password(board_password);
    boardVO.setBoard_title(board_title);
    boardVO.setBoard_content(board_content);

    BoardDAO boardDAO = new BoardDAO();
    boardDAO.boardWrite(boardVO);

    //파일 업로드 (다중)
    String item="";
    String ofileName="";
    String fileName="";
    File file=null;

    Enumeration  files = multi.getFileNames();
    int idx=1;
    while(files.hasMoreElements()){				//첨부파일 끝까지 계속 반복
        item=(String)files.nextElement();
        ofileName=multi.getOriginalFileName(item); 	 //원본 파일명
        fileName=multi.getFilesystemName(item);	  	//리네임
        if(fileName!=null){
            file=multi.getFile(item); 			 //파일담기
            if(file.exists()){  			//파일이 존재하는가
                long filesize=file.length();

                boardDAO.fileInfo(ofileName, fileName, filesize);
                boardDAO.boardFileState();
            }//if end
        }//if end
        idx++;
    }//while end

    response.sendRedirect("/board/list.jsp");
%>