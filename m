Return-Path: <stable+bounces-159303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60169AF7281
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 13:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2421C847EA
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 11:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF102E49AC;
	Thu,  3 Jul 2025 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvzzNWAj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687B42E4998;
	Thu,  3 Jul 2025 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542523; cv=none; b=fRZFmaBUVcG9ESMmLIW7BxYzT4ZOfc0h40PrIsjrgvKdPI9IhDnAWus9PCZoMampPVxGi6srWnTGe09z4IoP13vpaihKJCEFLqv7oehUDI5WUqlr+PWzCHe07bvo8kGE/p00PvBXkSyOy6AofK7V2aTlc8gx5tng08Ax5YR1O/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542523; c=relaxed/simple;
	bh=A4riHgWjqMWmrsxRmZWfbxDqGgfiBe8zxNDdKPjS3ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhixNSaSo/WpvV86NggpehaetjnrKs3JxepySp3+jBUVihiAX3IE6BIBHCwOHgZYM8mCuIJM/J57QCjBnIMQskBZo5wiN7eypTlt5BVN+fWpbo2w4b/IX5CcBFdGyBGSQjflcZfmw9vKxoJm/bv9C3DAi3oiF0G9vnbSDgf9imU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvzzNWAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F508C4CEF2;
	Thu,  3 Jul 2025 11:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751542523;
	bh=A4riHgWjqMWmrsxRmZWfbxDqGgfiBe8zxNDdKPjS3ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QvzzNWAjIQsNmBPZMrqC+Cew/UzBEgbcwlcI15Bud0rQ/vm1oFU3P2H2RJXDs3avx
	 9IrhpocLkoewSwZITh9RNCdRsF2+5SP7DEmhE8CP3284QPdYgp6PNZ0evDd05MsEwM
	 bSpxvUM2NcbSqOhLJWE9XykLH4JxEbiDBoLpwdvQmxNJNLbErmYh9zDqBSKKWrPHXr
	 ugfOkZOGM0vsIleT8ovpi59HCprBHJLtCWYAgQIS5SmDRAT+8Zvdfc8NRyFAyv0jwJ
	 qLTEWLHtRzi7DSlGicXqfIEKnwdCs/wibWaDr/DtqcSx+xZ+XeFRDRZZfc68neMBam
	 Ipk6/q3EjhvUA==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: bleung@chromium.org
Cc: chrome-platform@lists.linux.dev,
	tzungbi@kernel.org,
	dawidn@google.com,
	stable@vger.kernel.org
Subject: [PATCH 2/2] platform/chrome: cros_ec_chardev: Fix UAF of ec_dev
Date: Thu,  3 Jul 2025 11:35:09 +0000
Message-ID: <20250703113509.2511758-3-tzungbi@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250703113509.2511758-1-tzungbi@kernel.org>
References: <20250703113509.2511758-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lifecycle of misc device and `ec_dev` are independent. It is
possible that the `ec_dev` is used after free.

The following script shows the concept:
: import fcntl
: import os
: import struct
: import time
:
: EC_CMD_HELLO = 0x1
:
: fd = os.open('/dev/cros_fp', os.O_RDONLY)
: s = struct.pack('IIIIII', 0, EC_CMD_HELLO, 4, 4, 0, 0)
: fcntl.ioctl(fd, 0xc014ec00, s)
:
: time.sleep(1)
: open('/sys/bus/spi/drivers/cros-ec-spi/unbind', 'w').write('spi10.0')
: time.sleep(1)
: open('/sys/bus/spi/drivers/cros-ec-spi/bind', 'w').write('spi10.0')
:
: time.sleep(3)
: fcntl.ioctl(fd, 0xc014ec00, s)     <--- The UAF happens here.
:
: os.close(fd)

Set `ec_dev` to NULL to let the misc device know the underlying
protocol device is gone.

Fixes: eda2e30c6684 ("mfd / platform: cros_ec: Miscellaneous character device to talk with the EC")
Cc: stable@vger.kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_chardev.c | 65 +++++++++++++++++++----
 1 file changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
index 5c858d30dd52..87c800c30f31 100644
--- a/drivers/platform/chrome/cros_ec_chardev.c
+++ b/drivers/platform/chrome/cros_ec_chardev.c
@@ -11,11 +11,14 @@
  */
 
 #include <linux/init.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/fs.h>
+#include <linux/list.h>
 #include <linux/miscdevice.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/notifier.h>
 #include <linux/platform_data/cros_ec_chardev.h>
 #include <linux/platform_data/cros_ec_commands.h>
@@ -31,7 +34,14 @@
 /* Arbitrary bounded size for the event queue */
 #define CROS_MAX_EVENT_LEN	PAGE_SIZE
 
+/* This protects 'chardev_list' */
+static DEFINE_MUTEX(chardev_lock);
+static LIST_HEAD(chardev_list);
+
 struct chardev_priv {
+	struct list_head list;
+	/* This protects 'ec_dev' */
+	struct mutex lock;
 	struct cros_ec_dev *ec_dev;
 	struct notifier_block notifier;
 	wait_queue_head_t wait_event;
@@ -176,9 +186,14 @@ static int cros_ec_chardev_open(struct inode *inode, struct file *filp)
 	if (ret) {
 		dev_err(ec_dev->dev, "failed to register event notifier\n");
 		kfree(priv);
+		return ret;
 	}
 
-	return ret;
+	mutex_init(&priv->lock);
+	INIT_LIST_HEAD(&priv->list);
+	scoped_guard(mutex, &chardev_lock)
+		list_add_tail(&priv->list, &chardev_list);
+	return 0;
 }
 
 static __poll_t cros_ec_chardev_poll(struct file *filp, poll_table *wait)
@@ -199,7 +214,6 @@ static ssize_t cros_ec_chardev_read(struct file *filp, char __user *buffer,
 	char msg[sizeof(struct ec_response_get_version) +
 		 sizeof(CROS_EC_DEV_VERSION)];
 	struct chardev_priv *priv = filp->private_data;
-	struct cros_ec_dev *ec_dev = priv->ec_dev;
 	size_t count;
 	int ret;
 
@@ -233,7 +247,12 @@ static ssize_t cros_ec_chardev_read(struct file *filp, char __user *buffer,
 	if (*offset != 0)
 		return 0;
 
-	ret = ec_get_version(ec_dev, msg, sizeof(msg));
+	scoped_guard(mutex, &priv->lock) {
+		if (!priv->ec_dev)
+			return -ENODEV;
+	}
+
+	ret = ec_get_version(priv->ec_dev, msg, sizeof(msg));
 	if (ret)
 		return ret;
 
@@ -249,11 +268,15 @@ static ssize_t cros_ec_chardev_read(struct file *filp, char __user *buffer,
 static int cros_ec_chardev_release(struct inode *inode, struct file *filp)
 {
 	struct chardev_priv *priv = filp->private_data;
-	struct cros_ec_dev *ec_dev = priv->ec_dev;
 	struct ec_event *event, *e;
 
-	blocking_notifier_chain_unregister(&ec_dev->ec_dev->event_notifier,
-					   &priv->notifier);
+	scoped_guard(mutex, &priv->lock) {
+		if (priv->ec_dev)
+			blocking_notifier_chain_unregister(&priv->ec_dev->ec_dev->event_notifier,
+							   &priv->notifier);
+	}
+	scoped_guard(mutex, &chardev_lock)
+		list_del(&priv->list);
 
 	list_for_each_entry_safe(event, e, &priv->events, node) {
 		list_del(&event->node);
@@ -341,16 +364,20 @@ static long cros_ec_chardev_ioctl(struct file *filp, unsigned int cmd,
 				   unsigned long arg)
 {
 	struct chardev_priv *priv = filp->private_data;
-	struct cros_ec_dev *ec = priv->ec_dev;
 
 	if (_IOC_TYPE(cmd) != CROS_EC_DEV_IOC)
 		return -ENOTTY;
 
+	scoped_guard(mutex, &priv->lock) {
+		if (!priv->ec_dev)
+			return -ENODEV;
+	}
+
 	switch (cmd) {
 	case CROS_EC_DEV_IOCXCMD:
-		return cros_ec_chardev_ioctl_xcmd(ec, (void __user *)arg);
+		return cros_ec_chardev_ioctl_xcmd(priv->ec_dev, (void __user *)arg);
 	case CROS_EC_DEV_IOCRDMEM:
-		return cros_ec_chardev_ioctl_readmem(ec, (void __user *)arg);
+		return cros_ec_chardev_ioctl_readmem(priv->ec_dev, (void __user *)arg);
 	case CROS_EC_DEV_IOCEVENTMASK:
 		priv->event_mask = arg;
 		return 0;
@@ -394,8 +421,28 @@ static int cros_ec_chardev_probe(struct platform_device *pdev)
 static void cros_ec_chardev_remove(struct platform_device *pdev)
 {
 	struct miscdevice *misc = dev_get_drvdata(&pdev->dev);
+	struct chardev_priv *priv;
 
+	/*
+	 * Must deregister the misc device first so that the following
+	 * open fops get handled correctly.
+	 *
+	 * misc device is serialized by `misc_mtx`.
+	 * 1) If misc_deregister() gets the lock earlier than misc_open(),
+	 *    the open fops won't be called as the corresponding misc
+	 *    device is already destroyed.
+	 * 2) If misc_open() gets the lock earlier than misc_deregister(),
+	 *    the following code block resets the `ec_dev` to prevent
+	 *    the rest of fops from accessing the obsolete `ec_dev`.
+	 */
 	misc_deregister(misc);
+
+	scoped_guard(mutex, &chardev_lock) {
+		list_for_each_entry(priv, &chardev_list, list) {
+			scoped_guard(mutex, &priv->lock)
+				priv->ec_dev = NULL;
+		}
+	}
 }
 
 static const struct platform_device_id cros_ec_chardev_id[] = {
-- 
2.50.0.727.gbf7dc18ff4-goog


