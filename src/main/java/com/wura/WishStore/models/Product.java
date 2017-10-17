package com.wura.WishStore.models;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Product {
	
	@JsonProperty("name")
	private String name;
	
	@JsonProperty("price")
	private String price;
	
	@JsonProperty("image")
	private String image;
	
	public Product() {}
	public Product(String name, String price, String image) {
		this.name = name;
		this.price = price;
		this.image = image;
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

}
