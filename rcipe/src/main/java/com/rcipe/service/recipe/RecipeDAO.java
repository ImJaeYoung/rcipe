package com.rcipe.service.recipe;

import java.util.List;

import com.rcipe.service.domain.Ingredient;
import com.rcipe.service.domain.Recipe;
import com.rcipe.service.domain.RecipeDetail;

public interface RecipeDAO {
	
	public List<Ingredient> getIngredientList(String keyword)throws Exception;
	
	public boolean insertIngredient(String ingredientName)throws Exception;

public Recipe insertRecipe(Recipe recipe)throws Exception;
	
	public boolean insertRcpIng(List<Ingredient> list)throws Exception;
	
	public boolean insertRecipeDetail(List<RecipeDetail> list)throws Exception;
	
}
