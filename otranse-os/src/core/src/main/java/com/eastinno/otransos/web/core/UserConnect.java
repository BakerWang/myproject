package com.eastinno.otransos.web.core;

import java.util.Date;

/**
 * <p>
 * Title:用户验证信息
 * </p>
 * <p>
 * Description:记录用户登录信息,判断用户登录情况
 * </p>
 * <p>
 * Copyright: Copyright (c) 2006
 * </p>
 * <p>
 * Company: www.disco.org.cn
 * </p>
 * 
 * @author lengyu
 * @version 1.0
 */
public class UserConnect {
    private String userName;

    private String ip;

    private Date firstFailureTime;

    private Date lastLoginTime;

    private int failureTimes;// 用户登录失败次数

    private int status = 0;// 用户状态0表示正常,-1表示锁定

    public int getFailureTimes() {
        return failureTimes;
    }

    public void setFailureTimes(int failureTimes) {
        this.failureTimes = failureTimes;
    }

    public Date getFirstFailureTime() {
        return firstFailureTime;
    }

    public void setFirstFailureTime(Date firstFailureTime) {
        this.firstFailureTime = firstFailureTime;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public Date getLastLoginTime() {
        return lastLoginTime;
    }

    public void setLastLoginTime(Date lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

}
