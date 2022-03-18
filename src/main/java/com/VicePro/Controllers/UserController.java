package com.VicePro.Controllers;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.VicePro.Models.Profession;
import com.VicePro.Models.User;
import com.VicePro.Models.UserProfession;
import com.VicePro.Services.QAservice;
import com.VicePro.Services.UserService;
import com.VicePro.Validator.UserValidator;

import javax.validation.Valid;


//imports removed for brevity
@Controller
public class UserController {
private final UserService examService;
private final UserValidator userValidator;
private final QAservice qaService;
 
 public UserController(UserService examService, UserValidator userValidator, QAservice qaService) {
     this.examService = examService;
     this.userValidator = userValidator;
     this.qaService = qaService;
 }
 
 @RequestMapping("/")
 public String index(@ModelAttribute("user") User user) {
	 return "index.jsp";
 }
 
 
 @RequestMapping(value="/registration", method=RequestMethod.POST)
 public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
	 userValidator.validate(user, result);
	 if(result.hasErrors()) {
		 return "index.jsp";
	 }else {
		 examService.registerUser(user);
		 if(session.getAttribute("currentUser") == null) {
			 session.setAttribute("currentUser", user);
			 return "redirect:/home";
		 }
	 }
// if result has errors, return the registration page (don't worry about validations just now)
 // else, save the user in the database, save the user id in session, and redirect them to the /home route
	 return null;
 }
 
 @RequestMapping(value="/login", method=RequestMethod.POST)
 public String loginUser(@RequestParam("email") String email, @RequestParam("password") String password, Model model, HttpSession session, RedirectAttributes flashMessages) {
	 if(examService.authenticateUser(email, password)) {
		 User loginUser = examService.findByEmail(email);
		 session.setAttribute("currentUser", loginUser);
		 return "redirect:/home";
	 } else {
		 String errors = "Incorrect Login or Password";
		 flashMessages.addFlashAttribute("error", errors);
		 return "redirect:/";
	 }
     // if the user is authenticated, save their user id in session
     // else, add error messages and return the login page
 }
 
 @RequestMapping("/home")
 public String home(HttpSession session, Model model) {
	 User user = (User) session.getAttribute("currentUser");
	 model.addAttribute("ThisUser", user);
	 List<UserProfession> professions = qaService.getProfessionsById(user.getId());
	 model.addAttribute("Pros", professions);
	 return "home.jsp";
 }
 
 @RequestMapping("/logout")
 public String logout(HttpSession session) {
	 session.invalidate();
     // invalidate session
     // redirect to login page
	 return "redirect:/";
 }
}