package com.rcipe.service.recipe.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.rcipe.service.domain.Ingredient;
import com.rcipe.service.domain.Recipe;
import com.rcipe.service.domain.RecipeDetail;
import com.rcipe.service.recipe.RecipeDAO;

@Repository("recipeDAOImpl")
public  class RecipeDAOImpl  implements RecipeDAO{

	 @Autowired
	 @Qualifier("sqlSessionTemplate")
	 private  SqlSession sqlSession;
	
	public RecipeDAOImpl() {
		System.out.println(getClass()+"start....");
	}

	@Override
	public List<Ingredient> getIngredientList(String keyword) throws Exception {
		return sqlSession.selectList("RecipeMapper.getIngredientList",keyword);
	}

	@Override
	public boolean insertIngredient(String ingredientName) throws Exception {
		String str=sqlSession.selectOne("RecipeMapper.getIngredient",ingredientName);
		if(str!=null){
			return false;
		}
		return sqlSession.insert("RecipeMapper.insertIngredient",ingredientName)==1 ? true:false;
	}

	@Override
	public Recipe insertRecipe(Recipe recipe) throws Exception {
		sqlSession.insert("RecipeMapper.insertRecipe", recipe);
		return recipe;
	}

	@Override
	public boolean insertRcpIng(List<Ingredient> list) throws Exception {
		for(int i=0;i<list.size();i++){
			if(sqlSession.insert("RecipeMapper.insertRcpIng", list.get(i))!=1){
				return false;
			}
		}
		return 	true;
	}

	@Override
	public boolean insertRecipeDetail(List<RecipeDetail> list) throws Exception {
		for(int i=0;i<list.size();i++){
			if(sqlSession.insert("RecipeDetailMapper.insertRecipeDetail",list.get(i))!=1){
				return false;
			}
		}
		return 	true;
	}
}
