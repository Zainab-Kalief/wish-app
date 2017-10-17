package com.wura.WishStore.custom;

import java.util.List;

import com.wura.WishStore.models.User;
import com.wura.WishStore.models.Wish;
import com.wura.WishStore.repositories.UserRepository;
import com.wura.WishStore.service.AppService;

public class Filter {
	 private static UserRepository userRepo;
//	public static Filter(AppService service) {
//		this.service = service;
//	}
	public static boolean containsUser(List<User> list, User value) {
		return list.contains(value);
	}
	
	public static boolean containWishesGranted(List<Wish> list, Wish value) {
		return list.contains(value);
	}
	
	
	
}
