Return-Path: <stable+bounces-59229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5060593040B
	for <lists+stable@lfdr.de>; Sat, 13 Jul 2024 08:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055781F234DD
	for <lists+stable@lfdr.de>; Sat, 13 Jul 2024 06:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981FA20328;
	Sat, 13 Jul 2024 06:05:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26BB1BC3F;
	Sat, 13 Jul 2024 06:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720850756; cv=none; b=ib9zF/v70PMmmTXnv5fd/l1t6SxpnkHqlnkieR55sH9F/V4h+77Sg+4QJFF+jPxatg56QWGH0Rd4HKS9dtDcS6mPGUK/LQRiIFM9NYDyzpW4ZpWub2OLiX50Ui2MxAVWrPsDjfZ+pIxJbrhY8muT+UcqAtoBjgiQE3yoDRXzWA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720850756; c=relaxed/simple;
	bh=K2A3fNtbN6zhjfJlhkdlCGhsFi26ZBg/y12J88LRJnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+IvypcSsqPVAbEpThqy4ATzQYWwyyM4nx+IoVR1WbQ/GB1B6CNt3XYO9FpqR8WPKzC4kkEW4Yvkb2JGxeMuirvjXbO5aLWP4mrSnYbSG4ONEh6u3UFE13pzxj+gA3J+NGIC2nEDlAajpDlSNj7jH5N2z+gykgH83+g/QsKNtOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46D65P7C049264;
	Sat, 13 Jul 2024 15:05:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Sat, 13 Jul 2024 15:05:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46D65Ocg049261
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 13 Jul 2024 15:05:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0b34da9e-c13f-4fab-a67d-244b0ebba394@I-love.SAKURA.ne.jp>
Date: Sat, 13 Jul 2024 15:05:24 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: Fix uevent_show() vs driver detach race
To: Dan Williams <dan.j.williams@intel.com>, gregkh@linuxfoundation.org
Cc: syzbot+4762dd74e32532cda5ff@syzkaller.appspotmail.com,
        stable@vger.kernel.org, Ashish Sangwan <a.sangwan@samsung.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org
References: <172081332794.577428.9738802016494057132.stgit@dwillia2-xfh.jf.intel.com>
 <dfcb0456-dd75-4b9f-9cc8-f0658cd9ce29@I-love.SAKURA.ne.jp>
 <6691c0f8da1dd_8e85329468@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <6691c0f8da1dd_8e85329468@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/07/13 8:49, Dan Williams wrote:
>>> +	/* Synchronize with dev_uevent() */
>>> +	synchronize_rcu();
>>> +
>>
>> this synchronize_rcu(), in order to make sure that
>> READ_ONCE(dev->driver) in dev_uevent() observes NULL?
> 
> No, this synchronize_rcu() is to make sure that if dev_uevent() wins the
> race and observes that dev->driver is not NULL that it is still safe to
> dereference that result because the 'struct device_driver' object is
> still live.

I can't catch what the pair of rcu_read_lock()/rcu_read_unlock() in dev_uevent()
and synchronize_rcu() in module_remove_driver() is for.

I think that the below race is possible.
Please explain how "/* Synchronize with module_remove_driver() */" works.

  Thread1:                Thread2:

  static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
  {
  	const struct device *dev = kobj_to_dev(kobj);
  	struct device_driver *driver;
  	int retval = 0;
  
  	(...snipped...)
  
  	if (dev->type && dev->type->name)
  		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
  
                          void module_remove_driver(struct device_driver *drv)
                          {
                          	struct module_kobject *mk = NULL;
                          	char *driver_name;
                          
                          	if (!drv)
                          		return;
                          
                          	/* Synchronize with dev_uevent() */
                          	synchronize_rcu(); // <= This can be no-op because rcu_read_lock() in dev_uevent() is not yet called.
  
  	// <= At this moment Thread1 can sleep for arbitrary duration due to preemption, can't it?
  
  	/* Synchronize with module_remove_driver() */
  	rcu_read_lock(); // <= What does this RCU want to synchronize with?
  
                          	sysfs_remove_link(&drv->p->kobj, "module");
                          
                          	if (drv->owner)
                          		mk = &drv->owner->mkobj;
                          	else if (drv->p->mkobj)
                          		mk = drv->p->mkobj;
                          	if (mk && mk->drivers_dir) {
                          		driver_name = make_driver_name(drv);
                          		if (driver_name) {
                          			sysfs_remove_link(mk->drivers_dir, driver_name);
                          			kfree(driver_name);
                          		}
                          	}
                          }

  	driver = READ_ONCE(dev->driver); // <= module_remove_driver() can be already completed even with RCU protection, can't it?
  	if (driver)
  		add_uevent_var(env, "DRIVER=%s", driver->name);
  	rcu_read_unlock();
  
  	/* Add common DT information about the device */
  	of_device_uevent(dev, env);
  
  	(..snipped...)
  }


