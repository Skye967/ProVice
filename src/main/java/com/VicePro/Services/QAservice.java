package com.VicePro.Services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.VicePro.Models.Answer;
import com.VicePro.Models.Comment;
import com.VicePro.Models.Profession;
import com.VicePro.Models.QuestTag;
import com.VicePro.Models.Question;
import com.VicePro.Models.Tag;
import com.VicePro.Models.User;
import com.VicePro.Models.UserProfession;
import com.VicePro.Repositories.AnswerRepo;
import com.VicePro.Repositories.CommentRepo;
import com.VicePro.Repositories.ProfessionRepo;
import com.VicePro.Repositories.QuestTagRepo;
import com.VicePro.Repositories.QuestionRepo;
import com.VicePro.Repositories.TagRepo;
import com.VicePro.Repositories.UserProfessionRepo;

@Service
public class QAservice {
	private final AnswerRepo answerRepo;
	private final CommentRepo commentRepo;
	private final QuestionRepo questionRepo;
	private final TagRepo tagRepo;
	private final QuestTagRepo questTagRepo;
	private final ProfessionRepo professionRepo;
	private final UserProfessionRepo userProRepo;
	
	public QAservice(AnswerRepo answerRepo, CommentRepo commentRepo, QuestionRepo questionRepo, TagRepo tagRepo, QuestTagRepo questTagRepo, ProfessionRepo professionRepo, UserProfessionRepo userProRepo) {
		super();
		this.answerRepo = answerRepo;
		this.commentRepo = commentRepo;
		this.questionRepo = questionRepo;
		this.tagRepo = tagRepo;
		this.questTagRepo = questTagRepo;
		this.professionRepo = professionRepo;
		this.userProRepo = userProRepo;
	}

	public Answer createAnswer(Answer answer) {
		return answerRepo.save(answer);
	}
	
	public Comment createComment(Comment comment) {
		return commentRepo.save(comment);
	}
	
	public Question createQuestion(Question question) {
		return questionRepo.save(question);
	}
	
	public Tag createTag(Tag tag) {
		return tagRepo.save(tag);
	}
	
	public QuestTag createQuestTag(Question Q, Tag T) {
		QuestTag newQT = new QuestTag();
		newQT.setQuestion(Q);
		newQT.setTag(T);
		return questTagRepo.save(newQT);
	}

	public List<Tag> allTags() {
		List<Tag> tags = tagRepo.findAll();
		return tags;
	}

	public Tag findTagByTag(String val) {
		return tagRepo.findBytag(val);
	}

	public boolean findProfessionByString(String profession) {
		boolean exists = professionRepo.existsByProfession(profession);
		return exists;
	}

	public Profession createProfession(Profession profession) {
		return professionRepo.save(profession);
	}

	public Profession getProfessionByString(String profession) {
		return professionRepo.getByProfession(profession);
	}

	public void createUserProfession(User U, Profession P) {
		UserProfession newUP = new UserProfession();
		newUP.setProfession(P);
		newUP.setUser(U);
		userProRepo.save(newUP);
	}

	public List<Question> allQuestions() {
		return questionRepo.findAll();
	}

	public Question findQuestionById(long questionId) {
		Question question = questionRepo.findByid(questionId);
		return question;
	}

	public List<Question> searchQuestions(String question) {
		return questionRepo.findAllByQuestionContaining(question);
	}

	public List<UserProfession> getProfessionsById(Long id) {
		List<UserProfession> professions = userProRepo.findAllByUser_id(id);
		return professions;
	}
}







