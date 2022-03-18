package com.VicePro.Repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.VicePro.Models.QuestTag;

@Repository
public interface QuestTagRepo extends CrudRepository<QuestTag, Long>{
	List<QuestTag> findAll();

}
