package com.lanyotech.pps.mvc;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.disco.container.annonation.Action;
import cn.disco.container.annonation.Inject;
import cn.disco.core.support.query.QueryObject;
import cn.disco.util.CommUtil;
import cn.disco.web.Module;
import cn.disco.web.Page;
import cn.disco.web.WebForm;
import cn.disco.web.core.AbstractPageCmdAction;
import cn.disco.web.tools.IPageList;
import com.lanyotech.pps.domain.Department;
import com.lanyotech.pps.service.IDepartmentService;

/**
 * DepartmentAction
 * @author Disco Framework
 */
@Action
public class DepartmentAction extends AbstractPageCmdAction {
	
	@Inject
	private IDepartmentService service;
	/*
	 * set the current service
	 * return service
	 */
	public void setService(IDepartmentService service) {
		this.service = service;
	}
	
	public Page doIndex(WebForm f, Module m) {
		return page("list");
	}

	public Page doList(WebForm form) {
		QueryObject qo = form.toPo(QueryObject.class);
		String parent=CommUtil.null2String(form.get("parent"));
		if("root".equals(parent)||"".equals(parent)){
			//只查询顶级节点
			qo.addQuery("obj.parent is EMPTY", null);
		}
		else {
			qo.addQuery("obj.parent.id", new Long(parent), "=");
		}
		IPageList pageList = service.getDepartmentBy(qo);
		form.jsonResult(pageList);
		return Page.JSONPage;
	}

	public Page doGetTree(WebForm form){
		QueryObject qo = form.toPo(QueryObject.class);
		String parent=CommUtil.null2String(form.get("parent"));
		if("root".equals(parent)||"".equals(parent)){
			//只查询顶级节点
			qo.addQuery("obj.parent is EMPTY", null);
		}
		else {
			qo.addQuery("obj.parent.id", new Long(parent), "=");
		}
		List list= service.getDepartmentBy(qo).getResult();
		List ret=new java.util.ArrayList();
		if(list!=null){
			for(int i=0;i<list.size();i++){
				Department dept=(Department)list.get(i);
				Map map=new HashMap();
				map.put("text", dept.getName());
				map.put("id", dept.getId());
				if(dept.getChildren()==null||dept.getChildren().isEmpty()){
					map.put("leaf", true);
				}
				ret.add(map);
			}
		}
		form.jsonResult(ret);
		return Page.JSONPage;
	}
	
	public Page doRemove(WebForm form) {
		Long id = new Long(CommUtil.null2String(form.get("id")));
		service.delDepartment(id);
		return pageForExtForm(form);
	}

	public Page doSave(WebForm form) {
		Department object = form.toPo(Department.class);
		if (!hasErrors())
			service.addDepartment(object);
		return pageForExtForm(form);
	}
	
	public Page doUpdate(WebForm form) {
		Long id = new Long(CommUtil.null2String(form.get("id")));
		Department object = service.getDepartment(id);
		form.toPo(object, true);
		if (!hasErrors())
			service.updateDepartment(id, object);
		return pageForExtForm(form);
	}
}