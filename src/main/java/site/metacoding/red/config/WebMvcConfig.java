package site.metacoding.red.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import site.metacoding.red.handler.LoginIntercepter;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new LoginIntercepter())
		.addPathPatterns("/s/**");
//		.addPathPatterns("/admin/**")
//		.excludePathPatterns("/s/boards/**");//exclude 제외하는 패턴
		//실행될 로그인인터셉터가 언제 실행될 것인지를 정하는 것. /s/* => /s/boards, s/users     /s/** => /s/모든주소/모든주소/모든주소...
	}
}

