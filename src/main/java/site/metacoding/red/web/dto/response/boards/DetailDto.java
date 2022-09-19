package site.metacoding.red.web.dto.response.boards;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class DetailDto {
	   private Integer id; // boardsId
	   private String title;
	   private String content;
	   private Integer usersId;
	   private Timestamp createdAt;
	   private Integer loveCount;
	   private boolean isLoved;
	   private Integer lovesId;
}
