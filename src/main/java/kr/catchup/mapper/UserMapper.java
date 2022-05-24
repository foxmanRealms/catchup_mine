package kr.catchup.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.ui.Model;

@Mapper
public interface UserMapper {

	void joinInsert(UserVO vo);

	UserVO loginSelect(UserVO vo);

	UserVO logout(UserVO vo);

	void updateService(UserVO vo);

	List<UserVO> userList();

	UserVO idCheck(String user_id);
	
	//public List<BoardVO> boardList();

	//public void boardInsert(BoardVO vo);

	//public BoardVO boardContents(int idx);




}
