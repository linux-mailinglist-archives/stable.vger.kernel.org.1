Return-Path: <stable+bounces-59208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 960A293010A
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 21:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541F22818BD
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 19:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC38E381BA;
	Fri, 12 Jul 2024 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cktrqCsx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AF52032A;
	Fri, 12 Jul 2024 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720813334; cv=none; b=R2VzcApKeqJeNMwI90+HN+lF0Qm1wqFuF2gy6UQL+OTWHNvkj6D9oJkfFi/zfUg2kIjfFfQD7m6ExnJ0xKo32xJDLzu4bALT0dP4PlLHhzEM5g0/mYxyuIa+bEvu38rRtNuEsiJg2q04TAokhlzlHP3+1HVd3Cdsad1OV21MlH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720813334; c=relaxed/simple;
	bh=TgRCdc2jdk93faAJSlXtDv3nImud6PYYBQfTIb7ydxE=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=DC1qeBT2qhlNumxAUUxDIHZZJZN/OTnu6/sz5iaicB3/AdD/egImUTCmW/MQB56bU+korZkABcJ/UPu4316k/YMbd3YP005BDcSbk660qKFjJnsSw8bDmg0AOaKzUCfF+Cc4HYRcx8xkz1S9DjCnbs07IDVlQEt4ij2H07WXEc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cktrqCsx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720813332; x=1752349332;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TgRCdc2jdk93faAJSlXtDv3nImud6PYYBQfTIb7ydxE=;
  b=cktrqCsxk6s/BTAqzq5X094L3D/Eguh5LF3Vf7N62aAYm0O4trwuUINI
   iI7Cuzrqy22piQ61cnKj3FwNqupP+8608iWZ11K+VROsiqfRwkddFzViv
   tcYVKdyPKhIZSLRaOyF9LL2HtVUU+dkD39FhRPsdyFrXuu8ToqvFRK6Ns
   b7Xe3/Xs4iUrtslUzA6eWkHZqbxdo5OklMg6WhEchNirIF032oxTlJ7lP
   x4mRn4u3hb40bYD5LwqMPprQdxARU05vkAIKDYh9ddwe8lZGeN+W/GbnI
   85hKaBY9QysM3PHLl1wqzJDBFmP6wbLCTLoZTeG+Xwnh9PyNuP2md1xiQ
   Q==;
X-CSE-ConnectionGUID: YeMiUY/1SmSRffp0DNnr2g==
X-CSE-MsgGUID: uuWnC/y5Rju/cQ+sNasEow==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="35813289"
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="35813289"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 12:42:12 -0700
X-CSE-ConnectionGUID: +FGsCYj1TGWmcg4WjdjiCg==
X-CSE-MsgGUID: vjGVLZT5TvaFY6q+LMl7qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="53366204"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.110.177])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 12:42:11 -0700
Subject: [PATCH] driver core: Fix uevent_show() vs driver detach race
From: Dan Williams <dan.j.williams@intel.com>
To: gregkh@linuxfoundation.org
Cc: syzbot+4762dd74e32532cda5ff@syzkaller.appspotmail.com,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, stable@vger.kernel.org,
 Ashish Sangwan <a.sangwan@samsung.com>, Namjae Jeon <namjae.jeon@samsung.com>,
 Dirk Behme <dirk.behme@de.bosch.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Date: Fri, 12 Jul 2024 12:42:09 -0700
Message-ID: <172081332794.577428.9738802016494057132.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

uevent_show() wants to de-reference dev->driver->name. There is no clean
way for a device attribute to de-reference dev->driver unless that
attribute is defined via (struct device_driver).dev_groups. Instead, the
anti-pattern of taking the device_lock() in the attribute handler risks
deadlocks with code paths that remove device attributes while holding
the lock.

This deadlock is typically invisible to lockdep given the device_lock()
is marked lockdep_set_novalidate_class(), but some subsystems allocate a
local lockdep key for @dev->mutex to reveal reports of the form:

 ======================================================
 WARNING: possible circular locking dependency detected
 6.10.0-rc7+ #275 Tainted: G           OE    N
 ------------------------------------------------------
 modprobe/2374 is trying to acquire lock:
 ffff8c2270070de0 (kn->active#6){++++}-{0:0}, at: __kernfs_remove+0xde/0x220

 but task is already holding lock:
 ffff8c22016e88f8 (&cxl_root_key){+.+.}-{3:3}, at: device_release_driver_internal+0x39/0x210

 which lock already depends on the new lock.


 the existing dependency chain (in reverse order) is:

 -> #1 (&cxl_root_key){+.+.}-{3:3}:
        __mutex_lock+0x99/0xc30
        uevent_show+0xac/0x130
        dev_attr_show+0x18/0x40
        sysfs_kf_seq_show+0xac/0xf0
        seq_read_iter+0x110/0x450
        vfs_read+0x25b/0x340
        ksys_read+0x67/0xf0
        do_syscall_64+0x75/0x190
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #0 (kn->active#6){++++}-{0:0}:
        __lock_acquire+0x121a/0x1fa0
        lock_acquire+0xd6/0x2e0
        kernfs_drain+0x1e9/0x200
        __kernfs_remove+0xde/0x220
        kernfs_remove_by_name_ns+0x5e/0xa0
        device_del+0x168/0x410
        device_unregister+0x13/0x60
        devres_release_all+0xb8/0x110
        device_unbind_cleanup+0xe/0x70
        device_release_driver_internal+0x1c7/0x210
        driver_detach+0x47/0x90
        bus_remove_driver+0x6c/0xf0
        cxl_acpi_exit+0xc/0x11 [cxl_acpi]
        __do_sys_delete_module.isra.0+0x181/0x260
        do_syscall_64+0x75/0x190
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

The observation though is that driver objects are typically much longer
lived than device objects. It is reasonable to perform lockless
de-reference of a @driver pointer even if it is racing detach from a
device. Given the infrequency of driver unregistration, use
synchronize_rcu() in module_remove_driver() to close any potential
races.  It is potentially overkill to suffer synchronize_rcu() just to
handle the rare module removal racing uevent_show() event.

Thanks to Tetsuo Handa for the debug analysis of the syzbot report [1].

Fixes: c0a40097f0bc ("drivers: core: synchronize really_probe() and dev_uevent()")
Reported-by: syzbot+4762dd74e32532cda5ff@syzkaller.appspotmail.com
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Closes: http://lore.kernel.org/5aa5558f-90a4-4864-b1b1-5d6784c5607d@I-love.SAKURA.ne.jp [1]
Link: http://lore.kernel.org/669073b8ea479_5fffa294c1@dwillia2-xfh.jf.intel.com.notmuch
Cc: stable@vger.kernel.org
Cc: Ashish Sangwan <a.sangwan@samsung.com>
Cc: Namjae Jeon <namjae.jeon@samsung.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/core.c   |   13 ++++++++-----
 drivers/base/module.c |    4 ++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2b4c0624b704..b5399262198a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -25,6 +25,7 @@
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/netdevice.h>
+#include <linux/rcupdate.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/string_helpers.h>
@@ -2640,6 +2641,7 @@ static const char *dev_uevent_name(const struct kobject *kobj)
 static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 {
 	const struct device *dev = kobj_to_dev(kobj);
+	struct device_driver *driver;
 	int retval = 0;
 
 	/* add device node properties if present */
@@ -2668,8 +2670,12 @@ static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 	if (dev->type && dev->type->name)
 		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
 
-	if (dev->driver)
-		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
+	/* Synchronize with module_remove_driver() */
+	rcu_read_lock();
+	driver = READ_ONCE(dev->driver);
+	if (driver)
+		add_uevent_var(env, "DRIVER=%s", driver->name);
+	rcu_read_unlock();
 
 	/* Add common DT information about the device */
 	of_device_uevent(dev, env);
@@ -2739,11 +2745,8 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
 	if (!env)
 		return -ENOMEM;
 
-	/* Synchronize with really_probe() */
-	device_lock(dev);
 	/* let the kset specific function add its keys */
 	retval = kset->uevent_ops->uevent(&dev->kobj, env);
-	device_unlock(dev);
 	if (retval)
 		goto out;
 
diff --git a/drivers/base/module.c b/drivers/base/module.c
index a1b55da07127..b0b79b9c189d 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -7,6 +7,7 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/rcupdate.h>
 #include "base.h"
 
 static char *make_driver_name(struct device_driver *drv)
@@ -97,6 +98,9 @@ void module_remove_driver(struct device_driver *drv)
 	if (!drv)
 		return;
 
+	/* Synchronize with dev_uevent() */
+	synchronize_rcu();
+
 	sysfs_remove_link(&drv->p->kobj, "module");
 
 	if (drv->owner)


