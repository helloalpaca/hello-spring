package hello.advanced.V3;

import hello.advanced.trace.TraceStatus;
import hello.advanced.trace.logtrace.LogTrace;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class OrderControllerV3 {

    private final OrderServiceV3 orderService;
    private final LogTrace trace;

    /**
     * 동시성 이슈가 발생하는 이유
     * FieldLogTrace는 싱글톤으로 등록된 스프링 빈이다
     * 이 객체가 JVM내에 딱 하나만 존재한다는 뜻
     * 그런데 이 객체를 여러 쓰레드가 동시에 접근하기 때문에 문제가 발생한다.
     */

    @GetMapping("/v3/request")
    public String request(String itemId) {

        TraceStatus status = null;
        try {
            status = trace.begin("OrderController.request()");
            orderService.orderItem(itemId);
            trace.end(status);
            return "ok";
        } catch (Exception e) {
            trace.exception(status, e);
            throw e; //예외를 꼭 다시 던져주어야 한다.
        }
    }
}
