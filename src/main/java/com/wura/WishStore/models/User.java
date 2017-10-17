package com.wura.WishStore.models;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.JoinColumn;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;

@Entity
@Table(name="users") 
public class User {
	
	@Id
	@GeneratedValue
	private Long id;
	
	@Size(min=2, message="Please enter a valid name")
	private String fullName;
	
	@Email
	private String email;
	
	@Size(min=5, message="Your password must be more than 5 characters")
	private String password;
	
	@Transient
	private String confirmPassword;
	
	private String gender;
	
	@OneToMany(mappedBy="owner", fetch = FetchType.LAZY)
	private List<Wish> wishes;
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
		name = "following",
		joinColumns = @JoinColumn(name = "user_id"),
		inverseJoinColumns = @JoinColumn(name = "other_user_id")
			)
	private List<User> following;  //people that I follow
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
		name = "following",
		joinColumns = @JoinColumn(name = "other_user_id"),
		inverseJoinColumns = @JoinColumn(name = "user_id")
		
			)
	private List<User> followers; //people that follow me
		
	
	public User() {}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	public List<Wish> getWishes() {
		return wishes;
	}

	public void setWishes(List<Wish> wishes) {
		this.wishes = wishes;
	}

	public List<User> getFollowing() {
		return following;
	}

	public void setFollowing(List<User> following) {
		this.following = following;
	}

	public List<User> getFollowers() {
		return followers;
	}

	public void setFollowers(List<User> followers) {
		this.followers = followers;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}
	
	
	
}
