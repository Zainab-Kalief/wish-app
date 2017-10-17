package com.wura.WishStore.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.wura.WishStore.models.User;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {
	public User findByEmail(String email);
}
