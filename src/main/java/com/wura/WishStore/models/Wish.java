package com.wura.WishStore.models;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="wishes")
public class Wish {
	
	@Id
	@GeneratedValue
	private Long id;
	private String name;
	private String price;
	private String image;
	private Boolean status;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "owner_id")
	private User owner;

	private String genie;
	private Long genieId;
	
	public Wish() {}
	public Wish(String name, String price, String image, Boolean status) {
		this.name = name;
		this.price = price;
		this.image = image;
		this.status = status;
	}
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public User getOwner() {
		return owner;
	}

	public void setOwner(User owner) {
		this.owner = owner;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

	public String getGenie() {
		return genie;
	}

	public void setGenie(String genie) {
		this.genie = genie;
	}
	public Long getGenieId() {
		return genieId;
	}
	public void setGenieId(Long genieId) {
		this.genieId = genieId;
	}
	

}
