package chat.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import chat.utils.ConstanceUtil;
import chat.utils.CookieUtil;

public class IndexInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		Cookie cookie = CookieUtil.getCookies(request, ConstanceUtil.CURRENT_USER_COOKIE);
		if (cookie == null || cookie.getValue() == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return false;
		}
		return true;
	}
}