/*
 *Copyright (c) [Year] [name of copyright holder]
 *[Software Name] is licensed under Mulan PubL v2.
 *You can use this software according to the terms and conditions of the Mulan PubL v2.
 *You may obtain a copy of Mulan PubL v2 at:
 *         http://license.coscl.org.cn/MulanPubL-2.0
 *THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
 *EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
 *MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
 *See the Mulan PubL v2 for more details.
 */
package com.lamp.electron.register.consul;

import com.lamp.electron.register.api.RegisterData;
import com.lamp.electron.register.api.RegisterModel;
import com.lamp.electron.register.api.RegisterObjectFactory;
import com.lamp.electron.register.api.RegisterServer;

/**
 * consul注册工厂
 * @author jellly
 */
public class ConsulRegisterObjectFactory implements RegisterObjectFactory {

	@Override
	public RegisterModel<Object> createRegisterModel(RegisterServer<Object> registerServers, RegisterData registerData) {
		return new ConsulRegister(registerServers, registerData);
	}

	@Override
	public String registerCenterName() {
		return "consul";
	}

}
