package com.board.boardjsp;

import java.util.Date;

public class BoardVO {

    int board_num;
    String board_title;
    String board_writer;
    String board_password;
    String board_content;
    String board_date;
    String board_update;
    int board_count; //조회수
    int board_search_count; //검색 건수
    int category_num;
    String category_name;
    String file_name;

    public int getBoard_num() {
        return board_num;
    }

    public void setBoard_num(int board_num) {
        this.board_num = board_num;
    }

    public String getBoard_title() {
        return board_title;
    }

    public void setBoard_title(String board_title) {
        this.board_title = board_title;
    }

    public String getBoard_writer() {
        return board_writer;
    }

    public void setBoard_writer(String board_writer) {
        this.board_writer = board_writer;
    }

    public String getBoard_password() {
        return board_password;
    }

    public void setBoard_password(String board_password) {
        this.board_password = board_password;
    }

    public String getBoard_content() {
        return board_content;
    }

    public void setBoard_content(String board_content) {
        this.board_content = board_content;
    }

    public String getBoard_date() {
        return board_date;
    }

    public void setBoard_date(String board_date) {
        this.board_date = board_date;
    }

    public String getBoard_update() {
        return board_update;
    }

    public void setBoard_update(String board_update) {
        this.board_update = board_update;
    }

    public int getBoard_count() {
        return board_count;
    }

    public void setBoard_count(int board_count) {
        this.board_count = board_count;
    }

    public int getBoard_search_count() {
        return board_search_count;
    }

    public void setBoard_search_count(int board_search_count) {
        this.board_search_count = board_search_count;
    }

    public int getCategory_num() {
        return category_num;
    }

    public void setCategory_num(int category_num) {
        this.category_num = category_num;
    }

    public String getCategory_name() {
        return category_name;
    }

    public void setCategory_name(String category_name) {
        this.category_name = category_name;
    }

    public String getFile_name() {
        return file_name;
    }

    public void setFile_name(String file_name) {
        this.file_name = file_name;
    }
}