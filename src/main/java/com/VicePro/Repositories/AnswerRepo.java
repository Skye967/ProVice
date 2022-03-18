package com.VicePro.Repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.VicePro.Models.Answer;
@Repository
public interface AnswerRepo extends CrudRepository<Answer, Long> {
	List<Answer> findAll();
 
}
