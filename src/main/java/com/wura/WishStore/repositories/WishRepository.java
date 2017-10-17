package com.wura.WishStore.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.wura.WishStore.models.Wish;

@Repository
public interface WishRepository extends CrudRepository<Wish, Long> {

}
