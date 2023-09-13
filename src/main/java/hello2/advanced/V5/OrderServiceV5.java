package hello2.advanced.V5;

import hello2.advanced.trace.callback.TraceTemplate;
import hello2.advanced.trace.logtrace.LogTrace;
import org.springframework.stereotype.Service;

@Service
public class OrderServiceV5 {

    private final OrderRepositoryV5 orderRepository;
    private final TraceTemplate traceTemplate;

    public OrderServiceV5(OrderRepositoryV5 orderRepository, LogTrace trace) {
        this.orderRepository = orderRepository;
        this.traceTemplate = new TraceTemplate(trace);
    }

    public void orderItem(String itemId) {
        traceTemplate.execute("OrderController.request()", () -> {
            orderRepository.save(itemId);
            return null;
        });
    }
}
