package com.VicePro.Repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.VicePro.Models.Comment;

@Repository
public interface CommentRepo extends CrudRepository<Comment, Long>{
	List<Comment> findAll();

}
