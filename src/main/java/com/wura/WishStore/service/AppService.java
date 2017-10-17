package com.wura.WishStore.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Service;

import com.wura.WishStore.models.User;
import com.wura.WishStore.models.Wish;
import com.wura.WishStore.repositories.UserRepository;
import com.wura.WishStore.repositories.WishRepository;

@Service
public class AppService {
	private UserRepository userRepo;
	private WishRepository wishRepo;
	private static UserRepository userRepo2;
	
	public AppService(UserRepository userRepo, WishRepository wishRepo) {
		this.userRepo = userRepo;
		this.wishRepo = wishRepo;
	}
	
	//user 
	public void addUser(User user) {
		this.userRepo.save(user);
	}
	public User findUserById(Long id) {
		return userRepo.findOne(id);
	}
	public User findUserByEmail(String email) {
		return userRepo.findByEmail(email);
	}
	public List<User> allUsers(User user) { //all users except current users, reversed and limited to 4
		List<User> all = new ArrayList<>();
		for(User val:userRepo.findAll()) {
			if(!val.getId().equals(user.getId())) {
				all.add(val);
			}
		}
		Collections.reverse(all);
		return all.subList(0, 4);
	}
	public static void findUser(Long id) {
		System.out.println(userRepo2.findOne(id)); 
	}
	
	
	//wishes
	public void addWish(Wish wish, User owner) {
		wish.setOwner(owner);
		this.wishRepo.save(wish);
	}
	public void removeWish(Long id) {
			wishRepo.delete(id);		
	}
	public Wish findWish(Long id) {
		return wishRepo.findOne(id);
	}
	public void favWish(Long id) {
		Wish wish = wishRepo.findOne(id);
		wish.setStatus(true);
		wishRepo.save(wish);
	}
	public void unFavWish(Long id) {
		Wish wish = wishRepo.findOne(id);
		wish.setStatus(false);
		wishRepo.save(wish);
	}
	public List<Wish> favWishes(User user) {
		List<Wish> wishes = new ArrayList<>();
		for(Wish wish:user.getWishes()) {
			if(wish.getStatus().equals(true)) {
				wishes.add(wish);
			}
		}
		return wishes;
	}
	public void grantWish(Long wishId, String name, Long genieId) {
		Wish wish = wishRepo.findOne(wishId);
		wish.setGenie(name);
		wish.setGenieId(genieId);
		wishRepo.save(wish);
	}
	public void denyWish(Long wishId) {
		Wish wish = wishRepo.findOne(wishId);
		wish.setGenie(null);
		wish.setGenieId(null);
		wishRepo.save(wish);
	}
	public List<Wish> allWishes() {
		return (List<Wish>) wishRepo.findAll();
	}
	
	//following 
	public void follow(User user, User otherUser) {
		user.getFollowing().add(otherUser);
		userRepo.save(user);
	}
	public void unfollow(User user, User otherUser) {
		user.getFollowing().remove(otherUser);
		userRepo.save(user);
	}
	
	
}
