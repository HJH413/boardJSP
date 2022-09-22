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
    String uploadPath = "C:\\boardStudy\\boardJSP\\src\\main\\webapp\\file";		// 업로드 경로
    int maxFileSize = 1024 * 1024 * 2000;	// 업로드 제한 용량 = 20MB
    String encoding = "utf-8";			// 인코딩

    MultipartRequest multi = new MultipartRequest(
            request,
            uploadPath,
            maxFileSize,
            encoding,
            new DefaultFileRenamePolicy()
    );

    BoardVO boardVO = new BoardVO();
    BoardDAO boardDAO = new BoardDAO();
    int boardNum = Integer.parseInt(multi.getParameter("board_num"));
    String boardPassword = multi.getParameter("board_password");
    boardVO.setBoard_num(boardNum);
    boardVO.setBoard_writer(multi.getParameter("board_writer"));
    boardVO.setBoard_title(multi.getParameter("board_title"));
    boardVO.setBoard_content(multi.getParameter("board_content"));

    int check = boardDAO.boardPasswordCheck(boardNum,boardPassword);
    if(check == 0){ %>
    <script>
        alert("비밀번호 불일치");
        location.href= "/board/modify.jsp?boardNum="+<%=boardNum %>;
    </script>
    <% } else {
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
                    boardDAO.boardModify(boardVO);
                }//if end
            }//if end
            idx++;
        }//while end
        response.sendRedirect("/board/view.jsp?boardNum="+boardNum);
    } %>
%>