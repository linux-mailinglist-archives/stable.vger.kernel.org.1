Return-Path: <stable+bounces-90936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F279BEBBB
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A86F4B23FB0
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DB31EE015;
	Wed,  6 Nov 2024 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ld2UcbF5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BE41EE00F;
	Wed,  6 Nov 2024 12:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897254; cv=none; b=QyFRTJpHibTL055gqJ5e0miUlOSHddtx5pIlsHGSqjYiG4O1ai1R6Ut4nxteFkZANJpVuyUBGjzn4jk2t2glv+z1QwvP8Gv5pMrLW3rXcBXNoL9N4cCOw1yReq4s0fmFcdQsdcO3gTR6icOay5pkXpTHOelbld2ITsnD2unctuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897254; c=relaxed/simple;
	bh=9nJv/kUUVM4jJcMZtD8DQfUF4lseZjiXmC4hvCFKb4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkSxFL5HLGCQx8QKMsZX9/GY0HJBlp0QujaYlvBgS/+DxAv5tpwzQI6G34AS03AUb+/tw+mKXs1/uyCdOtuL0hA1mOgGKVwOM35YhDKyP+hX4sabozUmMDLAgObfbf5epRMKxvXJ7VDOofrR7ldCFP+7ixP5U2L9CiwQ6zxcnrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ld2UcbF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1361FC4CECD;
	Wed,  6 Nov 2024 12:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897253;
	bh=9nJv/kUUVM4jJcMZtD8DQfUF4lseZjiXmC4hvCFKb4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ld2UcbF56F2DFjGPkEQuYHCZS/abQnCBNlyk9nyghhGN3viXj+oxJN/AeIXIV9L3E
	 BqglRudFxXPRsKgEFakuFMVjg9zlHxon2DWVCe0vcfvSbXO4W2QZvul4Fb9FFnaHe5
	 QYaU/xL0I+3kESkO9hAF0tYMHYxfFmVPJT4gjxoc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Ashish Sangwan <a.sangwan@samsung.com>,
	Namjae Jeon <namjae.jeon@samsung.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 6.1 071/126] Revert "driver core: Fix uevent_show() vs driver detach race"
Date: Wed,  6 Nov 2024 13:04:32 +0100
Message-ID: <20241106120308.008333876@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120306.038154857@linuxfoundation.org>
References: <20241106120306.038154857@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 9a71892cbcdb9d1459c84f5a4c722b14354158a5 upstream.

This reverts commit 15fffc6a5624b13b428bb1c6e9088e32a55eb82c.

This commit causes a regression, so revert it for now until it can come
back in a way that works for everyone.

Link: https://lore.kernel.org/all/172790598832.1168608.4519484276671503678.stgit@dwillia2-xfh.jf.intel.com/
Fixes: 15fffc6a5624 ("driver core: Fix uevent_show() vs driver detach race")
Cc: stable <stable@kernel.org>
Cc: Ashish Sangwan <a.sangwan@samsung.com>
Cc: Namjae Jeon <namjae.jeon@samsung.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c   |   13 +++++--------
 drivers/base/module.c |    4 ----
 2 files changed, 5 insertions(+), 12 deletions(-)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -25,7 +25,6 @@
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/netdevice.h>
-#include <linux/rcupdate.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/swiotlb.h>
@@ -2559,7 +2558,6 @@ static const char *dev_uevent_name(struc
 static int dev_uevent(struct kobject *kobj, struct kobj_uevent_env *env)
 {
 	struct device *dev = kobj_to_dev(kobj);
-	struct device_driver *driver;
 	int retval = 0;
 
 	/* add device node properties if present */
@@ -2588,12 +2586,8 @@ static int dev_uevent(struct kobject *ko
 	if (dev->type && dev->type->name)
 		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
 
-	/* Synchronize with module_remove_driver() */
-	rcu_read_lock();
-	driver = READ_ONCE(dev->driver);
-	if (driver)
-		add_uevent_var(env, "DRIVER=%s", driver->name);
-	rcu_read_unlock();
+	if (dev->driver)
+		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
 
 	/* Add common DT information about the device */
 	of_device_uevent(dev, env);
@@ -2663,8 +2657,11 @@ static ssize_t uevent_show(struct device
 	if (!env)
 		return -ENOMEM;
 
+	/* Synchronize with really_probe() */
+	device_lock(dev);
 	/* let the kset specific function add its keys */
 	retval = kset->uevent_ops->uevent(&dev->kobj, env);
+	device_unlock(dev);
 	if (retval)
 		goto out;
 
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -7,7 +7,6 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/rcupdate.h>
 #include "base.h"
 
 static char *make_driver_name(struct device_driver *drv)
@@ -78,9 +77,6 @@ void module_remove_driver(struct device_
 	if (!drv)
 		return;
 
-	/* Synchronize with dev_uevent() */
-	synchronize_rcu();
-
 	sysfs_remove_link(&drv->p->kobj, "module");
 
 	if (drv->owner)



