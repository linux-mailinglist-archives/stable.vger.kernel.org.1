Return-Path: <stable+bounces-147963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394C1AC6A66
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 15:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4ED3AD30B
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 13:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10951286D62;
	Wed, 28 May 2025 13:29:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A94280A39;
	Wed, 28 May 2025 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438940; cv=none; b=dqR38MerC2EQlbDiQfkqBB1AWivcbtcz3mHyCsK/HteNT3Kh1maM9aF1rUEY7cEzYG2Ps4ZOVFIRelWVqJF4BXDREAfl0AsQnJDlOonLZ2tuZ0vSxJTL30drXaKad5ouDjMxITNqMgPNet3LF9RhnqZZPyW6wjLjXTgqislJk40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438940; c=relaxed/simple;
	bh=JdfXJ/vInh7/MMrsz8IDuINMM9tubZrHEwzHj6RsruM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EP56GyP0JJ2wyLu1ZZyHDfD50TiKZ4L0ucViS/7otWreqPexBKns7PGB414EW4snE9b0B/8kjV+ZEwWWcyM9ixX/SDebPmduO6kaP+3G/oxiOLZG4O5mMfyXcDKf2Ndz44l3611ixuwteNCIxGqJisuet19VbM5cIHHVqv+FmiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 7F57110392E;
	Wed, 28 May 2025 13:28:47 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Max Staudt <max@enpas.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] tty: Register device *after* creating the cdev for a tty
Date: Wed, 28 May 2025 22:28:15 +0900
Message-Id: <20250528132816.11433-1-max@enpas.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change makes the tty device file available only after the tty's
backing character device is ready.

Since 6a7e6f78c235975cc14d4e141fa088afffe7062c, the class device is
registered before the cdev is created, and userspace may pick it up,
yet open() will fail because the backing cdev doesn't exist yet.
Userspace is racing the bottom half of tty_register_device_attr() here,
specifically the call to tty_cdev_add().

dev_set_uevent_suppress() was used to work around this, but this fails
on embedded systems that rely on bare devtmpfs rather than udev.
On such systems, the device file is created as part of device_add(),
and userspace can pick it up via inotify, irrespective of uevent
suppression.

So let's undo the existing patch, and create the cdev first, and only
afterwards register the class device in the kernel's device tree.

However, this restores the original race of the cdev existing before the
class device is registered, and an attempt to tty_[k]open() the chardev
between these two steps will lead to tty->dev being assigned NULL by
alloc_tty_struct().

This will be addressed in a second patch.

Fixes: 6a7e6f78c235 ("tty: close race between device register and open")
Signed-off-by: Max Staudt <max@enpas.org>
Cc: <stable@vger.kernel.org>
---
 drivers/tty/tty_io.c | 54 +++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index ca9b7d7bad2b..e922b84524d2 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3245,6 +3245,7 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 	struct ktermios *tp;
 	struct device *dev;
 	int retval;
+	bool cdev_added = false;
 
 	if (index >= driver->num) {
 		pr_err("%s: Attempt to register invalid tty line number (%d)\n",
@@ -3257,24 +3258,6 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 	else
 		tty_line_name(driver, index, name);
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return ERR_PTR(-ENOMEM);
-
-	dev->devt = devt;
-	dev->class = &tty_class;
-	dev->parent = device;
-	dev->release = tty_device_create_release;
-	dev_set_name(dev, "%s", name);
-	dev->groups = attr_grp;
-	dev_set_drvdata(dev, drvdata);
-
-	dev_set_uevent_suppress(dev, 1);
-
-	retval = device_register(dev);
-	if (retval)
-		goto err_put;
-
 	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC)) {
 		/*
 		 * Free any saved termios data so that the termios state is
@@ -3288,19 +3271,44 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 
 		retval = tty_cdev_add(driver, devt, index, 1);
 		if (retval)
-			goto err_del;
+			return ERR_PTR(retval);
+
+		cdev_added = true;
+	}
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev) {
+		retval = -ENOMEM;
+		goto err_del_cdev;
 	}
 
-	dev_set_uevent_suppress(dev, 0);
-	kobject_uevent(&dev->kobj, KOBJ_ADD);
+	dev->devt = devt;
+	dev->class = &tty_class;
+	dev->parent = device;
+	dev->release = tty_device_create_release;
+	dev_set_name(dev, "%s", name);
+	dev->groups = attr_grp;
+	dev_set_drvdata(dev, drvdata);
+
+	retval = device_register(dev);
+	if (retval)
+		goto err_put;
 
 	return dev;
 
-err_del:
-	device_del(dev);
 err_put:
+	/*
+	 * device_register() calls device_add(), after which
+	 * we must use put_device() instead of kfree().
+	 */
 	put_device(dev);
 
+err_del_cdev:
+	if (cdev_added) {
+		cdev_del(driver->cdevs[index]);
+		driver->cdevs[index] = NULL;
+	}
+
 	return ERR_PTR(retval);
 }
 EXPORT_SYMBOL_GPL(tty_register_device_attr);
-- 
2.39.5


