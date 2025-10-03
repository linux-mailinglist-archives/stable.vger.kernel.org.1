Return-Path: <stable+bounces-183333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C12BB826E
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 22:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 105154E4A24
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 20:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B6F2561B6;
	Fri,  3 Oct 2025 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+IN7kyH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CFE253951
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524941; cv=none; b=nDCY5jwQWZeh2uCZl1Y0ow3vBNJf1Ge90pZp3rIg4AI4NOeEjYgXzttkRVwO44bqv57J+zuIe4EmvRD8dhoeFQ7sTGqrj3RMRxEUPIQ/QKt+YlUVxV/0oT4UL048yVXobQJzv8z91GKOGEWNSt+WEX9TDGgfsmtRPWuezZdDoZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524941; c=relaxed/simple;
	bh=KNNVlitj8V7yWCK6FiJszKPSycUYP9BiDYhhdrS1/Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uE5blBShacHJs5wafIhP32x/Y2yH1v5KWsuNTynybLXYPOtpQxQhlbZLqv+ytUsi2mCCZ9nXO7lh/oB1Lzw//KRyHac/6yq/6C8CnF0V8g3o9CSRqMgpaI7Xyae/reFkW/tetdk91h5GOAdHo3rO4glbYYJxhQ425aBC1Ka0o24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+IN7kyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776C7C4CEFA;
	Fri,  3 Oct 2025 20:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759524941;
	bh=KNNVlitj8V7yWCK6FiJszKPSycUYP9BiDYhhdrS1/Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+IN7kyHRrNm09xMAQH+G0s7Ww0O64a5B+Lwt4RRfWf6tnR7pYd3rZ50ge5IpFk2F
	 34QTIK2zKn2Tn25I1uOy6/xu2YVJl2aX55A2Z1QWeTPMYYbEN3178CsgMIET0Scwph
	 9E+1xICmGRc12eta3EWEold+qTUtq/nYnLHFWnaMR0kFir4li1QcxR8q8tuAYEC9+O
	 o/Aw8VZjEMo/VO6Z1FgBGuPh9+LZ6XJhclpG3ubSLyRdr50iJwr5zvnZk7Fd+tncHr
	 E1LvDvJtP1JaPbfAyHeqKkBlfKH+9Rcnl7ZVDmesLZ9aq4m5t2PngT1uvyaFIB+QbI
	 6CIvX8MWV8dxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzbot+c558267ad910fc494497@syzkaller.appspotmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 2/4] media: imon: reorganize serialization
Date: Fri,  3 Oct 2025 16:55:35 -0400
Message-ID: <20251003205537.3386848-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003205537.3386848-1-sashal@kernel.org>
References: <2025100320-pout-unwired-1096@gregkh>
 <20251003205537.3386848-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit db264d4c66c0fe007b5d19fd007707cd0697603d ]

Since usb_register_dev() from imon_init_display() from imon_probe() holds
minor_rwsem while display_open() which holds driver_lock and ictx->lock is
called with minor_rwsem held from usb_open(), holding driver_lock or
ictx->lock when calling usb_register_dev() causes circular locking
dependency problem.

Since usb_deregister_dev() from imon_disconnect() holds minor_rwsem while
display_open() which holds driver_lock is called with minor_rwsem held,
holding driver_lock when calling usb_deregister_dev() also causes circular
locking dependency problem.

Sean Young explained that the problem is there are imon devices which have
two usb interfaces, even though it is one device. The probe and disconnect
function of both usb interfaces can run concurrently.

Alan Stern responded that the driver and USB cores guarantee that when an
interface is probed, both the interface and its USB device are locked.
Ditto for when the disconnect callback gets run. So concurrent probing/
disconnection of multiple interfaces on the same device is not possible.

Therefore, we don't need locks for handling race between imon_probe() and
imon_disconnect(). But we still need to handle race between display_open()
/vfd_write()/lcd_write()/display_close() and imon_disconnect(), for
disconnect event can happen while file descriptors are in use.

Since "struct file"->private_data is set by display_open(), vfd_write()/
lcd_write()/display_close() can assume that "struct file"->private_data
is not NULL even after usb_set_intfdata(interface, NULL) was called.

Replace insufficiently held driver_lock with refcount_t based management.
Add a boolean flag for recording whether imon_disconnect() was already
called. Use RCU for accessing this boolean flag and refcount_t.

Since the boolean flag for imon_disconnect() is shared, disconnect event
on either intf0 or intf1 affects both interfaces. But I assume that this
change does not matter, for usually disconnect event would not happen
while interfaces are in use.

Link: https://syzkaller.appspot.com/bug?extid=c558267ad910fc494497

Reported-by: syzbot <syzbot+c558267ad910fc494497@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot <syzbot+c558267ad910fc494497@syzkaller.appspotmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Stable-dep-of: fa0f61cc1d82 ("media: rc: fix races with imon_disconnect()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/imon.c | 99 +++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 52 deletions(-)

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index be4f92d4e6b6b..b1a759e174841 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -153,6 +153,24 @@ struct imon_context {
 	const struct imon_usb_dev_descr *dev_descr;
 					/* device description with key */
 					/* table for front panels */
+	/*
+	 * Fields for deferring free_imon_context().
+	 *
+	 * Since reference to "struct imon_context" is stored into
+	 * "struct file"->private_data, we need to remember
+	 * how many file descriptors might access this "struct imon_context".
+	 */
+	refcount_t users;
+	/*
+	 * Use a flag for telling display_open()/vfd_write()/lcd_write() that
+	 * imon_disconnect() was already called.
+	 */
+	bool disconnected;
+	/*
+	 * We need to wait for RCU grace period in order to allow
+	 * display_open() to safely check ->disconnected and increment ->users.
+	 */
+	struct rcu_head rcu;
 };
 
 #define TOUCH_TIMEOUT	(HZ/30)
@@ -160,18 +178,18 @@ struct imon_context {
 /* vfd character device file operations */
 static const struct file_operations vfd_fops = {
 	.owner		= THIS_MODULE,
-	.open		= &display_open,
-	.write		= &vfd_write,
-	.release	= &display_close,
+	.open		= display_open,
+	.write		= vfd_write,
+	.release	= display_close,
 	.llseek		= noop_llseek,
 };
 
 /* lcd character device file operations */
 static const struct file_operations lcd_fops = {
 	.owner		= THIS_MODULE,
-	.open		= &display_open,
-	.write		= &lcd_write,
-	.release	= &display_close,
+	.open		= display_open,
+	.write		= lcd_write,
+	.release	= display_close,
 	.llseek		= noop_llseek,
 };
 
@@ -439,9 +457,6 @@ static struct usb_driver imon_driver = {
 	.id_table	= imon_usb_id_table,
 };
 
-/* to prevent races between open() and disconnect(), probing, etc */
-static DEFINE_MUTEX(driver_lock);
-
 /* Module bookkeeping bits */
 MODULE_AUTHOR(MOD_AUTHOR);
 MODULE_DESCRIPTION(MOD_DESC);
@@ -481,9 +496,11 @@ static void free_imon_context(struct imon_context *ictx)
 	struct device *dev = ictx->dev;
 
 	usb_free_urb(ictx->tx_urb);
+	WARN_ON(ictx->dev_present_intf0);
 	usb_free_urb(ictx->rx_urb_intf0);
+	WARN_ON(ictx->dev_present_intf1);
 	usb_free_urb(ictx->rx_urb_intf1);
-	kfree(ictx);
+	kfree_rcu(ictx, rcu);
 
 	dev_dbg(dev, "%s: iMON context freed\n", __func__);
 }
@@ -499,9 +516,6 @@ static int display_open(struct inode *inode, struct file *file)
 	int subminor;
 	int retval = 0;
 
-	/* prevent races with disconnect */
-	mutex_lock(&driver_lock);
-
 	subminor = iminor(inode);
 	interface = usb_find_interface(&imon_driver, subminor);
 	if (!interface) {
@@ -509,13 +523,16 @@ static int display_open(struct inode *inode, struct file *file)
 		retval = -ENODEV;
 		goto exit;
 	}
-	ictx = usb_get_intfdata(interface);
 
-	if (!ictx) {
+	rcu_read_lock();
+	ictx = usb_get_intfdata(interface);
+	if (!ictx || ictx->disconnected || !refcount_inc_not_zero(&ictx->users)) {
+		rcu_read_unlock();
 		pr_err("no context found for minor %d\n", subminor);
 		retval = -ENODEV;
 		goto exit;
 	}
+	rcu_read_unlock();
 
 	mutex_lock(&ictx->lock);
 
@@ -533,8 +550,10 @@ static int display_open(struct inode *inode, struct file *file)
 
 	mutex_unlock(&ictx->lock);
 
+	if (retval && refcount_dec_and_test(&ictx->users))
+		free_imon_context(ictx);
+
 exit:
-	mutex_unlock(&driver_lock);
 	return retval;
 }
 
@@ -544,16 +563,9 @@ static int display_open(struct inode *inode, struct file *file)
  */
 static int display_close(struct inode *inode, struct file *file)
 {
-	struct imon_context *ictx = NULL;
+	struct imon_context *ictx = file->private_data;
 	int retval = 0;
 
-	ictx = file->private_data;
-
-	if (!ictx) {
-		pr_err("no context for device\n");
-		return -ENODEV;
-	}
-
 	mutex_lock(&ictx->lock);
 
 	if (!ictx->display_supported) {
@@ -568,6 +580,8 @@ static int display_close(struct inode *inode, struct file *file)
 	}
 
 	mutex_unlock(&ictx->lock);
+	if (refcount_dec_and_test(&ictx->users))
+		free_imon_context(ictx);
 	return retval;
 }
 
@@ -936,15 +950,12 @@ static ssize_t vfd_write(struct file *file, const char __user *buf,
 	int offset;
 	int seq;
 	int retval = 0;
-	struct imon_context *ictx;
+	struct imon_context *ictx = file->private_data;
 	static const unsigned char vfd_packet6[] = {
 		0x01, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF };
 
-	ictx = file->private_data;
-	if (!ictx) {
-		pr_err_ratelimited("no context for device\n");
+	if (ictx->disconnected)
 		return -ENODEV;
-	}
 
 	if (mutex_lock_interruptible(&ictx->lock))
 		return -ERESTARTSYS;
@@ -1021,13 +1032,10 @@ static ssize_t lcd_write(struct file *file, const char __user *buf,
 			 size_t n_bytes, loff_t *pos)
 {
 	int retval = 0;
-	struct imon_context *ictx;
+	struct imon_context *ictx = file->private_data;
 
-	ictx = file->private_data;
-	if (!ictx) {
-		pr_err_ratelimited("no context for device\n");
+	if (ictx->disconnected)
 		return -ENODEV;
-	}
 
 	mutex_lock(&ictx->lock);
 
@@ -2402,7 +2410,6 @@ static int imon_probe(struct usb_interface *interface,
 	int ifnum, sysfs_err;
 	int ret = 0;
 	struct imon_context *ictx = NULL;
-	struct imon_context *first_if_ctx = NULL;
 	u16 vendor, product;
 
 	usbdev     = usb_get_dev(interface_to_usbdev(interface));
@@ -2414,17 +2421,12 @@ static int imon_probe(struct usb_interface *interface,
 	dev_dbg(dev, "%s: found iMON device (%04x:%04x, intf%d)\n",
 		__func__, vendor, product, ifnum);
 
-	/* prevent races probing devices w/multiple interfaces */
-	mutex_lock(&driver_lock);
-
 	first_if = usb_ifnum_to_if(usbdev, 0);
 	if (!first_if) {
 		ret = -ENODEV;
 		goto fail;
 	}
 
-	first_if_ctx = usb_get_intfdata(first_if);
-
 	if (ifnum == 0) {
 		ictx = imon_init_intf0(interface, id);
 		if (!ictx) {
@@ -2432,9 +2434,11 @@ static int imon_probe(struct usb_interface *interface,
 			ret = -ENODEV;
 			goto fail;
 		}
+		refcount_set(&ictx->users, 1);
 
 	} else {
 		/* this is the secondary interface on the device */
+		struct imon_context *first_if_ctx = usb_get_intfdata(first_if);
 
 		/* fail early if first intf failed to register */
 		if (!first_if_ctx) {
@@ -2448,14 +2452,13 @@ static int imon_probe(struct usb_interface *interface,
 			ret = -ENODEV;
 			goto fail;
 		}
+		refcount_inc(&ictx->users);
 
 	}
 
 	usb_set_intfdata(interface, ictx);
 
 	if (ifnum == 0) {
-		mutex_lock(&ictx->lock);
-
 		if (product == 0xffdc && ictx->rf_device) {
 			sysfs_err = sysfs_create_group(&interface->dev.kobj,
 						       &imon_rf_attr_group);
@@ -2466,21 +2469,17 @@ static int imon_probe(struct usb_interface *interface,
 
 		if (ictx->display_supported)
 			imon_init_display(ictx, interface);
-
-		mutex_unlock(&ictx->lock);
 	}
 
 	dev_info(dev, "iMON device (%04x:%04x, intf%d) on usb<%d:%d> initialized\n",
 		 vendor, product, ifnum,
 		 usbdev->bus->busnum, usbdev->devnum);
 
-	mutex_unlock(&driver_lock);
 	usb_put_dev(usbdev);
 
 	return 0;
 
 fail:
-	mutex_unlock(&driver_lock);
 	usb_put_dev(usbdev);
 	dev_err(dev, "unable to register, err %d\n", ret);
 
@@ -2496,10 +2495,8 @@ static void imon_disconnect(struct usb_interface *interface)
 	struct device *dev;
 	int ifnum;
 
-	/* prevent races with multi-interface device probing and display_open */
-	mutex_lock(&driver_lock);
-
 	ictx = usb_get_intfdata(interface);
+	ictx->disconnected = true;
 	dev = ictx->dev;
 	ifnum = interface->cur_altsetting->desc.bInterfaceNumber;
 
@@ -2540,11 +2537,9 @@ static void imon_disconnect(struct usb_interface *interface)
 		}
 	}
 
-	if (!ictx->dev_present_intf0 && !ictx->dev_present_intf1)
+	if (refcount_dec_and_test(&ictx->users))
 		free_imon_context(ictx);
 
-	mutex_unlock(&driver_lock);
-
 	dev_dbg(dev, "%s: iMON device (intf%d) disconnected\n",
 		__func__, ifnum);
 }
-- 
2.51.0


