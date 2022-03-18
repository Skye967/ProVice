package com.VicePro.Repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.VicePro.Models.Profession;

@Repository
public interface ProfessionRepo extends CrudRepository<Profession, Long>{
	List<Profession> findAll();
	boolean existsByProfession(String profession);
	Profession getByProfession(String profession);
}
