package site.metacoding.red.web.dto.request.boards;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.Getter;
import lombok.Setter;
import site.metacoding.red.domain.boards.Boards;

@Setter
@Getter
public class WriteDto {
	@Size(min = 1, max = 20, message = "길이가 부적합합니다.")
	@NotBlank(message = "title이 null이거나 공백일 수 없습니다.")
	private String title;
	@NotBlank(message = "content가 null이거나 공백일 수 없습니다.")
	private String content;
	
	public Boards toEntity(Integer usersId) {
		Boards boards = new Boards(this.title, this.content, usersId);
		return boards;
	}
}
