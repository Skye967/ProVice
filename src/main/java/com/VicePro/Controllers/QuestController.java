package com.VicePro.Controllers;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.VicePro.Models.Answer;
import com.VicePro.Models.Comment;
import com.VicePro.Models.Profession;
import com.VicePro.Models.QuestTag;
import com.VicePro.Models.Question;
import com.VicePro.Models.Tag;
import com.VicePro.Models.User;
import com.VicePro.Services.QAservice;

@Controller
public class QuestController {
	private List<String> tagList = new ArrayList<>();
	private final QAservice qaService;
	
	public QuestController(QAservice qaService) {
		this.qaService = qaService;
	}
	
	@RequestMapping(value="/add/profession", method=RequestMethod.GET)
	public String addProfession(@RequestParam("profession") String profession, HttpSession session) {
		boolean exists = qaService.findProfessionByString(profession);
		if(profession == "") {
			return "redirect:/home";
		}
		if(exists == false) {
			Profession newProfession = new Profession();
			newProfession.setProfession(profession);
			qaService.createProfession(newProfession);
			User thisUser = (User) session.getAttribute("currentUser");
			qaService.createUserProfession( thisUser, qaService.getProfessionByString(profession));
			return "redirect:/home";
		}else {
			User thisUser = (User) session.getAttribute("currentUser");
			qaService.createUserProfession( thisUser, qaService.getProfessionByString(profession));
			return "redirect:/home";
		}
	}
	
	@RequestMapping("/new/question")
	public String newQuestion(@ModelAttribute("newQuestion") Question newQuestion, Model model, HttpSession session) {
		model.addAttribute("thisUser", session.getAttribute("currentUser"));
		return "newQuestion.jsp";
	}
	
	@SuppressWarnings("unlikely-arg-type")
	@RequestMapping(value="/create/question", method=RequestMethod.POST)
	public String createQuestion(@Valid @ModelAttribute("newQuestion") Question question, BindingResult result, @RequestParam("tag") String tag) {
		if(result.hasErrors()) {
			return "redirect:/new/question";
		}
		String tagString = "";
		for(int i = 0; i < tag.length(); i++) {
			if(tag.charAt(i) != ' ' && tag.charAt(i) != ',' ) {
				tagString += tag.charAt(i);
			} 
			if(tag.charAt(i) == ',' || i == tag.length() - 1 ) {
				this.tagList.add(tagString.toLowerCase());
				tagString = "";
			}
		}
		Set<String> hash = new HashSet<>();
		hash.addAll(this.tagList);
		this.tagList.clear();
		this.tagList.addAll(hash);
		Question saveQuestion = qaService.createQuestion(question);
		for(String val:this.tagList) {
			if(qaService.allTags().contains(val) == false) {
				Tag addTag = new Tag();
				addTag.setTag(val);
				qaService.createTag(addTag);
				QuestTag testQT = qaService.createQuestTag(saveQuestion, addTag);
			}else {
				qaService.createQuestTag(saveQuestion, qaService.findTagByTag(val));
			}
		}
		this.tagList.clear();
		return "redirect:/home";
	}	
	
	@RequestMapping("/questions")
	public String questionList(Model model, @ModelAttribute("search") Question search) {
		model.addAttribute("questionList", qaService.allQuestions());
		return "questionList.jsp";
	}
	
	@RequestMapping("/search")
	public String search(@ModelAttribute("search") Question search, Model model){
		List<Question> searching = qaService.searchQuestions(search.getQuestion());
		model.addAttribute("searchList", searching);
		return "search.jsp";
	}
	
	@RequestMapping("/display/question/{questionId}")
	public String displayQuestion(@PathVariable("questionId") long questionId, Model model, @ModelAttribute("thisAnswer") Answer answer, @ModelAttribute("thisComment") Comment comment, HttpSession session) {
		model.addAttribute("thisQuestion", qaService.findQuestionById(questionId));
		model.addAttribute("thisUser", session.getAttribute("currentUser"));
		return "displayQuestion.jsp";
				
	}
	
	@RequestMapping(value="/new/answer",method=RequestMethod.POST)
	public String newAnswer(@ModelAttribute("thisAnswer") Answer answer, BindingResult result) {
		if(result.hasErrors()) {
			System.out.println("error");
			return "displayQuestion.jsp";
		}
		qaService.createAnswer(answer);
		return "redirect:/display/question/" + answer.getQuestion().getId();
	}
	
	@RequestMapping(value="/comment/{questionId}", method=RequestMethod.POST)
	public String newComment(@ModelAttribute("thisComment") Comment comment, BindingResult result, @PathVariable("questionId") long questionId ) {
		if(result.hasErrors()) {
			return "redirect:/display/question/" + questionId;
		}
		qaService.createComment(comment);
		return "redirect:/display/question/" + questionId;
	}
	

}






