package com.VicePro.Repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.VicePro.Models.Profession;
import com.VicePro.Models.UserProfession;

@Repository
public interface UserProfessionRepo extends CrudRepository<UserProfession, Long>{
	List<UserProfession> findAll();

	List<UserProfession> findAllByUser_id(Long id);

}
