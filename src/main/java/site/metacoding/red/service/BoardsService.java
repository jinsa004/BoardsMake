package site.metacoding.red.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;

import lombok.RequiredArgsConstructor;
import site.metacoding.red.domain.boards.Boards;
import site.metacoding.red.domain.boards.BoardsDao;
import site.metacoding.red.domain.loves.Loves;
import site.metacoding.red.domain.loves.LovesDao;
import site.metacoding.red.domain.users.Users;
import site.metacoding.red.web.dto.request.boards.UpdateDto;
import site.metacoding.red.web.dto.request.boards.WriteDto;
import site.metacoding.red.web.dto.response.boards.DetailDto;
import site.metacoding.red.web.dto.response.boards.MainDto;
import site.metacoding.red.web.dto.response.boards.PagingDto;

@RequiredArgsConstructor
@Service
public class BoardsService {

	private final BoardsDao boardsDao;
	private final LovesDao lovesDao;

	public void 좋아요취소(Integer lovesId) {
		lovesDao.deleteById(lovesId);
	}

	public Loves 좋아요(Loves loves) {
		lovesDao.insert(loves);
		return loves;
	}

	public PagingDto 게시글목록보기(Integer page, String keyword) {
		if (page == null) {
			page = 0;
		}
		int startNum = page * 5;
		List<MainDto> boardsList = boardsDao.findAll(startNum, keyword);
		PagingDto pagingDto = boardsDao.paging(page, keyword);
		if (boardsList.size() == 0)
		pagingDto.setNotResult(true);
		pagingDto.makeBlockInfo(keyword);
		pagingDto.setMainDtos(boardsList);

		return pagingDto;
	}

   public DetailDto 게시글상세보기(Integer id, Integer principalId) {
		      return boardsDao.findByDetail(id, principalId);
		   }

	public Boards 게시글수정화면데이터가져오기(Integer id) {
		return boardsDao.findById(id);
	}

	public String 게시글수정하기(Integer id, UpdateDto updateDto) {
		Boards boardsPS = boardsDao.findById(id);
		boardsPS.글수정(updateDto);
		boardsDao.update(boardsPS);
		return "redirect:/boards/" + id;
	}

	public String 게시글삭제하기(@PathVariable Integer id) {
		Boards boardsPS = boardsDao.findById(id);
		boardsDao.deleteById(id);
		return "redirect:/";
	}

	public String 게시글쓰기(WriteDto writeDto, Users principal) {
		boardsDao.insert(writeDto.toEntity(principal.getId()));
		return "redirect:/";
	}
}
