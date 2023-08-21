package hello.core;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class HelloLombok {

    private String name;
    private int age;

    public void setName(String name) {
        this.name = "this is set by setName : " + name;
    }

    public static void main(String[] args) {
        HelloLombok helloLombok = new HelloLombok();
        helloLombok.setName("helloworld");

        System.out.println(helloLombok.getName());
    }

}
