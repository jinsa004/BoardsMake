package site.metacoding.red.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import site.metacoding.red.domain.boards.BoardsDao;
import site.metacoding.red.domain.users.Users;
import site.metacoding.red.domain.users.UsersDao;
import site.metacoding.red.web.dto.request.users.JoinDto;
import site.metacoding.red.web.dto.request.users.LoginDto;
import site.metacoding.red.web.dto.request.users.UpdateDto;

@RequiredArgsConstructor
@Service
public class UsersService {

	private final UsersDao usersDao;
	private final BoardsDao boardsDao; // DI(의존성 주입) 코드

	public void 회원가입(JoinDto joinDto) { // username, password, email
		// 1. 디티오를 엔티티로 변경하는 코드
		Users usersPS = joinDto.toEntity();
		// 2. 엔티티로 디비 수행
		usersDao.insert(usersPS);
	}

	public Users 로그인(LoginDto loginDto) { // username, password
		Users usersPS = usersDao.findByUsername(loginDto.getUsername());
		// if로 usersPS의 password와 디티오 password 비교
		if (usersPS.getPassword().equals(loginDto.getPassword())) {
			return usersPS;
		}
		return null;
	}

	public void 회원수정(Integer id, UpdateDto updateDto) {// id, 디티오(password, email)
		// 1. 영속화
		Users usersPS = usersDao.findById(id);
		// 2. 영속화된 객체 변경
		usersPS.회원정보수정(updateDto);
		// 3. 디비 수행
		usersDao.update(usersPS);
	}

	@Transactional(rollbackFor = RuntimeException.class) // 런타임 중에 오류가 나면 트랜잭션을 롤백해줌.
	public void 회원탈퇴(Integer id) {
		usersDao.deleteById(id);
		boardsDao.updateByUsersId(id);
	} // users - delete, boards - update

	public boolean 유저네임중복확인(String username) {
		Users usersPS = usersDao.findByUsername(username);

		if (usersPS == null) {
			return false;
		} else {
			return true;
		}
		// 있으면 true, 없으면 false
	}

	public Users 회원정보보기(Integer id) {
		Users usersPS = usersDao.findById(id);
		return usersPS;
	}
}
