package com.wura.WishStore.controllers;

import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.wura.WishStore.models.Product;
import com.wura.WishStore.models.User;
import com.wura.WishStore.models.Wish;
import com.wura.WishStore.service.AppService;

@Controller
public class WishController {
	private final AppService service;
	public WishController(AppService service) {
		this.service = service;
	}
	
	
	
	@RequestMapping("/")
	public String index(Model model) {
		model.addAttribute("wishes", service.allWishes());
		return "index";
	}
	
	@RequestMapping("/user")  //log in - sign up page
	public String user(@ModelAttribute("newUser") User user) {
		return "user";
	}
	
	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User user, BindingResult result, Model model, @RequestParam("gender") String gender, HttpSession session)  {
		if(result.hasErrors()) {
			return "user";
		}
		if(user.getPassword().equals(user.getConfirmPassword()) == false) {
			model.addAttribute("match", "Passwords dont match");
			return "user";
		}
		if( service.findUserByEmail(user.getEmail()) != null ) {
			model.addAttribute("email", "Email already taken");
			return "user";
		}
		session.setAttribute("email", user.getEmail());
		user.setGender(gender);
		service.addUser(user);
		return "redirect:/home";
	}
	
	@PostMapping("/login")
	public String login(@RequestParam("email") String email, @RequestParam("password") String password, Model model, HttpSession session) {
		User user = service.findUserByEmail(email);
		if(user != null) {
			if(user.getPassword().equals(password)) {
				session.setAttribute("email", user.getEmail());
				return "redirect:/home"; 
			}
		}
		
		model.addAttribute("invalid", "Invalid Credentials");
		return "redirect:/user";
	}
	
	@RequestMapping("/home")
	public String home(HttpSession session, Model model) {
		if(session.getAttribute("email").equals("null")) {
			return "redirect:/"; 
		}
		List<String> categories = new ArrayList<>();
		session.setAttribute("searchName", "");
		session.setAttribute("searchBrand", "");
		session.setAttribute("categories", categories);
		User user = service.findUserByEmail((String) session.getAttribute("email"));
		model.addAttribute("user", user);
		List<User> allUsers = service.allUsers(user);
		
		model.addAttribute("users", allUsers );
		return "home";
	}
	
	@PostMapping("/search")
	public String search(@RequestParam("name") String searchName, @RequestParam("brand") String searchBrand, @RequestParam("category") String category, HttpSession session) {
		if(searchName.length() > 0) {
			session.setAttribute("searchName", searchName);
		}
		if(searchBrand.length() > 0) {
			session.setAttribute("searchBrand", searchBrand);
		}
		
		List<String> categories = new ArrayList<>();
		String word = "";
		if(category.length() > 0) {
			for(char val:category.toCharArray()) {
				if(val == ',') {
					categories.add(word);
					word = "";
					continue;
				}
				word += Character.toString(val);
			}
			categories.add(word);
		}
		if(categories.size() > 0) {
			categories.remove(categories.size() -1); //remove the hidden space
		}
		session.setAttribute("categories", categories);
		return "redirect:/search";
	}
	
	@RequestMapping("/search")
	public String searchPage(Model model, HttpSession session)  throws IOException {
		if(session.getAttribute("email").equals("null")) {
			return "redirect:/"; 
		}
		if (session.getAttribute("searchBrand").toString().length() <= 0) {
			model.addAttribute("inputTwo", "");
		} else {
			model.addAttribute("inputTwo", session.getAttribute("searchBrand"));
		}
		if (session.getAttribute("searchName").toString().length() > 0) {
			model.addAttribute("inputOne", session.getAttribute("searchName"));
			String formattedName = "";
			for(char val:((String) session.getAttribute("searchName")).toCharArray()) {
				if(val == ' ') {
					formattedName += "%20";
				} else {
					formattedName += val;
				}
			}
			String formattedBrand = "";
			for(char val:((String) session.getAttribute("searchBrand")).toCharArray()) {
				if(val == ' ') {
					formattedBrand += "%20";
				} else {
					formattedBrand += val;
				}
			}
			String formattedCategories = "";
			if ( ((List<String>) session.getAttribute("categories")).size() > 0) {
				for(String val:(List<String>) session.getAttribute("categories") ) {
					formattedCategories += val;
					formattedCategories += "%20";
				}
			}
			String URL = "http://localhost:8000/dress?" + "name=" + formattedName + "&brand=" + formattedBrand + "&categories=" + formattedCategories;
			URL obj = new URL(URL);
			HttpURLConnection connection = (HttpURLConnection) obj.openConnection();
			connection.setRequestMethod("GET");
			connection.setRequestProperty("User-Agent", "Mozilla/5.0");
			BufferedReader in = new BufferedReader( new InputStreamReader(connection.getInputStream()) );
			String inputLine;
			StringBuffer response = new StringBuffer();
			while((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();	
			String responseStripped = response.toString().substring(1, response.length() - 1);		
			String[] responseSplit = responseStripped.split(">\\?<");
			Integer size = responseSplit.length / 3;
			
			List<Map> all = new ArrayList<>();
			Integer first = 0, second = 1, third = 2;
			while(size > 0) {
				Map<String, String> result = new HashMap<>();
				result.put("name", responseSplit[first]);
				result.put("price", responseSplit[second]);
				if(responseSplit[third].contains("undefined")) {
					result.put("image", "http://placehold.it/500x325");	
				} else {
					result.put("image", responseSplit[third]);
				}
				all.add(result);
				size --;
				first += 3;
				second += 3;
				third += 3;
			}	
//			model.addAttribute("products", all);
			session.setAttribute("products", all);
		} else {
			model.addAttribute("inputOne", "");
		}
		session.getAttribute("products");
		User user = service.findUserByEmail((String) session.getAttribute("email"));
		model.addAttribute("user", user);
		return "search";
	}
	
	@RequestMapping("/wish") 
	public String wish(@RequestParam("image") String image, @RequestParam("name") String name,  @RequestParam("price") String price,HttpSession session) {
		if(session.getAttribute("email").equals(null)) {
			return "redirect:/"; 
		}
		List<String> categories = new ArrayList<>();
		session.setAttribute("searchName", "");
		session.setAttribute("searchBrand", "");
		session.setAttribute("categories", categories);
		User user = service.findUserByEmail((String) session.getAttribute("email"));
		Wish wish = new Wish(name, price, image, false);
		service.addWish(wish, user);
		return "redirect:/search"; 
	}
	
	@RequestMapping("/myWishes")
	public String userWishes(Model model, HttpSession session) {
		if(session.getAttribute("email").equals(null)) {
			return "redirect:/"; 
		}
		User user = service.findUserByEmail((String) session.getAttribute("email"));
		model.addAttribute("user", user);
		model.addAttribute("wishes", service.favWishes(user));
		return "userWishes";
	}
	
	@RequestMapping("/fav/{id}")
	public String favWish(@PathVariable("id") Long id, Model model, HttpSession session) {
		if(session.getAttribute("email").equals(null)) {
			return "redirect:/"; 
		}
		service.favWish(id);
		return "redirect:/myWishes";
	}
	
	@RequestMapping("/unfav/{id}")
	public String unFavWish(@PathVariable("id") Long id, Model model, HttpSession session) {
		if(session.getAttribute("email").equals(null)) {
			return "redirect:/"; 
		}
		service.unFavWish(id);		
		return "redirect:/myWishes";
	}
	@RequestMapping("/remove/{id}")
	public String remove(@PathVariable("id") Long id, Model model, HttpSession session) {
		if(session.getAttribute("email").equals(null)) {
			return "redirect:/"; 
		}
		service.removeWish(id);		
		return "redirect:/myWishes";
	}
	
	@RequestMapping("/person/{id}") 
	public String otherUser(@PathVariable("id") Long id,  Model model, HttpSession session) {
		if(session.getAttribute("email").equals(null)) {
			return "redirect:/"; 
		}
		User otherUser = service.findUserById(id);
		User user = service.findUserByEmail((String) session.getAttribute("email"));
		model.addAttribute("user", user);
		model.addAttribute("otherUser", otherUser);
		model.addAttribute("wishes", service.favWishes(otherUser));
		return "otherUserWishes";
	}
	
	@RequestMapping("/follow/{id}")
	public String follow(@PathVariable("id") Long id,  Model model, HttpSession session) {
		if(session.getAttribute("email").equals(null)) {
			return "redirect:/"; 
		}
		User otherUser = service.findUserById(id);
		User user = service.findUserByEmail((String) session.getAttribute("email"));
		service.follow(user, otherUser);
		return "redirect:/home"; 
	}
	@RequestMapping("/unfollow/{id}")
	public String unFollow(@PathVariable("id") Long id,  Model model, HttpSession session) {
		if(session.getAttribute("email").equals(null)) {
			return "redirect:/"; 
		}
		User otherUser = service.findUserById(id);
		User user = service.findUserByEmail((String) session.getAttribute("email"));
		service.unfollow(user, otherUser);
		return "redirect:/home"; 
	}
	
	@RequestMapping("/grantWish/{id}")
	public String grantWish(@PathVariable("id") Long id,  Model model, HttpSession session) {
		if(session.getAttribute("email").equals(null)) {
			return "redirect:/"; 
		}
		User user = service.findUserByEmail((String) session.getAttribute("email"));
		service.grantWish(id, user.getFullName(), user.getId());
		return "redirect:/home";  
	}
	@RequestMapping("/denyWish/{id}")
	public String denyWish(@PathVariable("id") Long id,  Model model, HttpSession session) {
		if(session.getAttribute("email").equals(null)) {
			return "redirect:/"; 
		}
		service.denyWish(id);
		return "redirect:/home";  
	}
	
	
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.setAttribute("email", "null");
		return "redirect:/";
	}
	
	
//	@RequestMapping("/x")
//	public String xxx() throws IOException {
//		String URL = "http://localhost:8000/wishes";
//		URL obj = new URL(URL);
//		HttpURLConnection connection = (HttpURLConnection) obj.openConnection();
//				
//		connection.setRequestMethod("GET");
//		connection.setRequestProperty("User-Agent", "Mozilla/5.0");
//		
//		BufferedReader in = new BufferedReader( new InputStreamReader(connection.getInputStream()) );
//		String inputLine;
//		StringBuffer response = new StringBuffer();
//		
//		while((inputLine = in.readLine()) != null) {
//			response.append(inputLine);
//		}
//		
//		in.close();	
////		Product product = in;
//		System.out.println(response);
//		return "redirect:/";
//	}
	
	
//	HashMap<String, String> x = new HashMap<>();
//	x.put("name", "Slick Dress");
//	x.put("price", "105.99");
//	x.put("image", "http://www.forever21.com/images/default_330/00112601-02.jpg");
//	
//	HashMap<String, String> x2 = new HashMap<>();
//	x2.put("name", "Future Graphic Tee");
//	x2.put("price", "25");
//	x2.put("image", "https://www.forever21.com/images/1_front_750/00224360-01.jpg");
//	
//	HashMap<String, String> x3 = new HashMap<>();
//	x3.put("name", "Wrap Dress");
//	x3.put("price", "260");
//	x3.put("image", "http://www.forever21.com/images/default_330/00125885-02.jpg");
//	
//	HashMap<String, String> x4 = new HashMap<>();
//	x4.put("name", "Retro Fur");
//	x4.put("price", "63.99");
//	x4.put("image", "https://www.forever21.com/images/1_front_750/00197624-02.jpg");
//	
//	HashMap<String, String> x5 = new HashMap<>();
//	x5.put("name", "Club Dress");
//	x5.put("price", "190");
//	x5.put("image", "https://www.forever21.com/images/default_330/00206144-02.jpg");
//	
//	HashMap<String, String> x6 = new HashMap<>();
//	x6.put("name", "Boy Faux Fur");
//	x6.put("price", "54.90");
//	x6.put("image", "https://www.forever21.com/images/1_front_750/00188211-02.jpg");
//	
//	HashMap<String, String> x7 = new HashMap<>();
//	x7.put("name", "Mud Mask");
//	x7.put("price", "1.89");
//	x7.put("image", "https://www.forever21.com/images/1_front_750/00197587-01.jpg");
//	
//	HashMap<String, String> x8 = new HashMap<>();
//	x8.put("name", "Girls Faux Fur");
//	x8.put("price", "17.99");
//	x8.put("image", "https://www.forever21.com/images/1_front_750/00148290-03.jpg");
//	
//	List<HashMap> products = new ArrayList<>(Arrays.asList(x, x2, x3, x4, x5, x6, x7, x8));
	
}
