Return-Path: <stable+bounces-183220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F39BB6F6B
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 15:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BADA188FC40
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 13:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3582EFDB3;
	Fri,  3 Oct 2025 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kIqmZRw1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F672EFDB0
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759497203; cv=none; b=C9J/4fG2STeMjYismbrSR9EUYa7KX8GrpJEO4uWJ98bmCq7Wu/v/KQCfLahGNBlY05d2TcrtAjMMAHg0Z/vSRAZr1FKmZ4hf+OnGQ8jtg5970QsZCvvEBKFE+EiPpPw92kmKunMy49F0lcku+EWZv39Ry/QY5dx+Z24Nvamxrrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759497203; c=relaxed/simple;
	bh=t3JEEcMC+OgFvUecq9e+2yU/zhvM8X4+gquK+S+aTK4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Jph+m6GPo28axTStVZsd5JF/7qyO2Q2LWcA2r8WPnF3ofW9td2Fnh+Y3F5IC6zxgDNrC1Ry2jIfgiYELOKTrgtYTA9dZW7G27I4NIL4ind7X7fFaYzerea5KmW9IGap4kie6Jz3kEg35n1FkXR6gRL5XbAUNgCj0Xac4aIJ9C1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kIqmZRw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86031C4CEF5;
	Fri,  3 Oct 2025 13:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759497203;
	bh=t3JEEcMC+OgFvUecq9e+2yU/zhvM8X4+gquK+S+aTK4=;
	h=Subject:To:Cc:From:Date:From;
	b=kIqmZRw1FwR1DkF6ujXOQ63DBDhvRpVFNtLiAqzmBSiLKs/b7BrE64zOubqIKVdPZ
	 XYXaxlj/u525JfPZpNB+kg9hhAT+mzWwsccmdFWLkZMlO72VCBR+ojzvI08UhMMX2U
	 +nml+cYSlWL++F2ivfJx0lBw1QTqJQhKxaii7VIk=
Subject: FAILED: patch "[PATCH] media: rc: fix races with imon_disconnect()" failed to apply to 5.4-stable tree
To: Sergey.Larshin@kaspersky.com,hverkuil+cisco@kernel.org,sean@mess.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 03 Oct 2025 15:13:20 +0200
Message-ID: <2025100320-pout-unwired-1096@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x fa0f61cc1d828178aa921475a9b786e7fbb65ccb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025100320-pout-unwired-1096@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa0f61cc1d828178aa921475a9b786e7fbb65ccb Mon Sep 17 00:00:00 2001
From: Larshin Sergey <Sergey.Larshin@kaspersky.com>
Date: Tue, 29 Jul 2025 13:13:32 +0300
Subject: [PATCH] media: rc: fix races with imon_disconnect()

Syzbot reports a KASAN issue as below:
BUG: KASAN: use-after-free in __create_pipe include/linux/usb.h:1945 [inline]
BUG: KASAN: use-after-free in send_packet+0xa2d/0xbc0 drivers/media/rc/imon.c:627
Read of size 4 at addr ffff8880256fb000 by task syz-executor314/4465

CPU: 2 PID: 4465 Comm: syz-executor314 Not tainted 6.0.0-rc1-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
print_address_description mm/kasan/report.c:317 [inline]
print_report.cold+0x2ba/0x6e9 mm/kasan/report.c:433
kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
__create_pipe include/linux/usb.h:1945 [inline]
send_packet+0xa2d/0xbc0 drivers/media/rc/imon.c:627
vfd_write+0x2d9/0x550 drivers/media/rc/imon.c:991
vfs_write+0x2d7/0xdd0 fs/read_write.c:576
ksys_write+0x127/0x250 fs/read_write.c:631
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

The iMON driver improperly releases the usb_device reference in
imon_disconnect without coordinating with active users of the
device.

Specifically, the fields usbdev_intf0 and usbdev_intf1 are not
protected by the users counter (ictx->users). During probe,
imon_init_intf0 or imon_init_intf1 increments the usb_device
reference count depending on the interface. However, during
disconnect, usb_put_dev is called unconditionally, regardless of
actual usage.

As a result, if vfd_write or other operations are still in
progress after disconnect, this can lead to a use-after-free of
the usb_device pointer.

Thread 1 vfd_write                      Thread 2 imon_disconnect
                                        ...
                                        if
                                          usb_put_dev(ictx->usbdev_intf0)
                                        else
                                          usb_put_dev(ictx->usbdev_intf1)
...
while
  send_packet
    if
      pipe = usb_sndintpipe(
        ictx->usbdev_intf0) UAF
    else
      pipe = usb_sndctrlpipe(
        ictx->usbdev_intf0, 0) UAF

Guard access to usbdev_intf0 and usbdev_intf1 after disconnect by
checking ictx->disconnected in all writer paths. Add early return
with -ENODEV in send_packet(), vfd_write(), lcd_write() and
display_open() if the device is no longer present.

Set and read ictx->disconnected under ictx->lock to ensure memory
synchronization. Acquire the lock in imon_disconnect() before setting
the flag to synchronize with any ongoing operations.

Ensure writers exit early and safely after disconnect before the USB
core proceeds with cleanup.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Reported-by: syzbot+f1a69784f6efe748c3bf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f1a69784f6efe748c3bf
Fixes: 21677cfc562a ("V4L/DVB: ir-core: add imon driver")
Cc: stable@vger.kernel.org

Signed-off-by: Larshin Sergey <Sergey.Larshin@kaspersky.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index 91d05aadced3..35b9e07003d8 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -531,7 +531,9 @@ static int display_open(struct inode *inode, struct file *file)
 
 	mutex_lock(&ictx->lock);
 
-	if (!ictx->display_supported) {
+	if (ictx->disconnected) {
+		retval = -ENODEV;
+	} else if (!ictx->display_supported) {
 		pr_err("display not supported by device\n");
 		retval = -ENODEV;
 	} else if (ictx->display_isopen) {
@@ -595,6 +597,9 @@ static int send_packet(struct imon_context *ictx)
 
 	lockdep_assert_held(&ictx->lock);
 
+	if (ictx->disconnected)
+		return -ENODEV;
+
 	/* Check if we need to use control or interrupt urb */
 	if (!ictx->tx_control) {
 		pipe = usb_sndintpipe(ictx->usbdev_intf0,
@@ -949,12 +954,14 @@ static ssize_t vfd_write(struct file *file, const char __user *buf,
 	static const unsigned char vfd_packet6[] = {
 		0x01, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF };
 
-	if (ictx->disconnected)
-		return -ENODEV;
-
 	if (mutex_lock_interruptible(&ictx->lock))
 		return -ERESTARTSYS;
 
+	if (ictx->disconnected) {
+		retval = -ENODEV;
+		goto exit;
+	}
+
 	if (!ictx->dev_present_intf0) {
 		pr_err_ratelimited("no iMON device present\n");
 		retval = -ENODEV;
@@ -1029,11 +1036,13 @@ static ssize_t lcd_write(struct file *file, const char __user *buf,
 	int retval = 0;
 	struct imon_context *ictx = file->private_data;
 
-	if (ictx->disconnected)
-		return -ENODEV;
-
 	mutex_lock(&ictx->lock);
 
+	if (ictx->disconnected) {
+		retval = -ENODEV;
+		goto exit;
+	}
+
 	if (!ictx->display_supported) {
 		pr_err_ratelimited("no iMON display present\n");
 		retval = -ENODEV;
@@ -2507,7 +2516,11 @@ static void imon_disconnect(struct usb_interface *interface)
 	int ifnum;
 
 	ictx = usb_get_intfdata(interface);
+
+	mutex_lock(&ictx->lock);
 	ictx->disconnected = true;
+	mutex_unlock(&ictx->lock);
+
 	dev = ictx->dev;
 	ifnum = interface->cur_altsetting->desc.bInterfaceNumber;
 


