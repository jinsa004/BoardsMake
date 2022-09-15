package site.metacoding.red.web.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class CMRespDto<T> { // 공통 응답 DTO
	private Integer code; // 1정상, -1실패
	private String msg; // 성공이유, 실패이유
	private T data; // 리턴하는 데이터의 모양이 다 다르기때문에 제네릭으로 설정해줌
}
