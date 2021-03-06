##set ($domain = $!domainName.toLowerCase())
package $!{packageName}.service.impl;
import java.io.Serializable;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.eastinno.otransos.core.support.query.IQueryObject;
import com.eastinno.otransos.core.support.query.QueryUtil;
import com.eastinno.otransos.web.tools.IPageList;

import $!{packageName}.domain.$!{domainName};
import $!{packageName}.service.I$!{domainName}Service;
import $!{packageName}.dao.I$!{domainName}DAO;

#macro (upperCase $str)
#set ($upper=$!str.substring(0,1).toUpperCase())
#set ($l=$!str.substring(1))
$!upper$!l#end

/**
 * $!{domainName}ServiceImpl
 * @author Disco Framework
 */
@Service
public class $!{domainName}ServiceImpl implements I$!{domainName}Service{
	@Resource
	private I$!{domainName}DAO $!{domain}Dao;
	
	public void set#upperCase($!{domain})Dao(I$!{domainName}DAO $!{domain}Dao){
		this.$!{domain}Dao=$!{domain}Dao;
	}
	
	public Long add$!{domainName}($!{domainName} $!{domain}) {	
		this.$!{domain}Dao.save($!{domain});
		if ($!{domain} != null && $!{domain}.get$!{id}() != null) {
			return $!{domain}.get$!{id}();
		}
		return null;
	}
	
	public $!{domainName} get$!{domainName}(Long id) {
		$!{domainName} $!{domain} = this.$!{domain}Dao.get(id);
		if ($!{domain} != null) {
			return $!{domain};
		}
		return null;
	}
	
	public boolean del$!{domainName}(Long id) {	
			$!{domainName} $!{domain} = this.get$!{domainName}(id);
			if ($!{domain} != null) {
				this.$!{domain}Dao.remove(id);
				return true;
			}			
			return false;	
	}
	
	public boolean batchDel$!{domainName}s(List<Serializable> $!{domain}Ids) {
		
		for (Serializable id : $!{domain}Ids) {
			del$!{domainName}((Long) id);
		}
		return true;
	}
	
	public IPageList get$!{domainName}By(IQueryObject queryObject) {	
		return QueryUtil.query(queryObject, $!{domainName}.class,this.$!{domain}Dao);		
	}
	
	public boolean update$!{domainName}(Long id, $!{domainName} $!{domain}) {
		if (id != null) {
			$!{domain}.set$!{id}(id);
		} else {
			return false;
		}
		this.$!{domain}Dao.update($!{domain});
		return true;
	}	
	
}
