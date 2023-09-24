package com.helloalpaca.hellospring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HelloController {
    @GetMapping("hello")
    public String hello(Model model){
        model.addAttribute("data", "hello!!");
        return "hello";
    }

    @GetMapping("hello-mvc")
    public String helloMvc(@RequestParam("name") String name, Model model){
        model.addAttribute("name", name);
        return "hello-template";
    }

    @GetMapping("hello-string")
    @ResponseBody //HTTP BODY부분에 직접 데이터를 넣어주겠다.
    public String helloString(@RequestParam("name") String name){
        return "hello "+name;
    }

    @GetMapping("hello-api")
    @ResponseBody
    public Hello hello(@RequestParam("name") String name){
        Hello hello = new Hello(); // cmd + shift + enter하면 자동완성 쌉가능
        hello.setName(name);
        return hello;
    }

    static class Hello {
        private String name;

        // getter setter 자동완성 : cmd + N
        // JAVA Bean 표준 양식?
        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }
    }
}
