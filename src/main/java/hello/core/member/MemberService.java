package hello.core.member;

/*
public interface MemberService {
    void join(Member member);

    Member findMember(Long memberId);
}
*/

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@RequiredArgsConstructor
@Component
public class MemberService {

    private final MemberRepository memberRepository;

}
