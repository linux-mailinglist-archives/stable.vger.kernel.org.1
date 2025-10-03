Return-Path: <stable+bounces-183291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B26BB77B7
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 18:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3761B20C0A
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 16:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A1829E0E5;
	Fri,  3 Oct 2025 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HPLf6SQH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028D335962;
	Fri,  3 Oct 2025 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507742; cv=none; b=QoYzXWR1ITGfiMWDuhQl7GhPChPOUvabzaAg9btUVcAORT8a6knzJpm/vvkLM70Bq154f7Qw1VqDstrMSBUSIPiKfjFdUzOcsQzkRTZCfBvTNYSLookSw4Nfq4ip4bx2WUm8lyRqGqkj0Atqht0+ZpjgH3FdiyB6hn9zXpn53s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507742; c=relaxed/simple;
	bh=b6DtyNeSJ7rifq9y7mNo3NDlj5N6uVglN/WhX3yvdww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2FaXNzV70vMLMq+5+PfrZizMgD+iYNy6uvdhbC55OQmXHptXm6+9Ck6hkGjz+5cAbHCw3h7pw5QrfBS4pjEsjNZqWRRM/YayfxPi8KYuLm46wGhOOavHm6npGIz9/kagA6QydhipKtZaYVneVLDv75iwz7sD4YHBGYq8sZBVNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HPLf6SQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3F7C4CEF5;
	Fri,  3 Oct 2025 16:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759507741;
	bh=b6DtyNeSJ7rifq9y7mNo3NDlj5N6uVglN/WhX3yvdww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HPLf6SQH7bQrzYeEdkgE0FCOxT65kJy5jIxDWDGrCMbbkx8lOi5IRJ8h9tbfgwj7N
	 pjt1PVC6aSHxwwLX8N6SimMxdwPQpNVx63tYDu/GBHs1SthZSk9nHMaaretGUSEcaY
	 CMZCB+3oEmw19fmtVCuXjC0QL864AH8xu5L+KJZc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+f1a69784f6efe748c3bf@syzkaller.appspotmail.com,
	Larshin Sergey <Sergey.Larshin@kaspersky.com>,
	Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 6.6 5/7] media: rc: fix races with imon_disconnect()
Date: Fri,  3 Oct 2025 18:06:13 +0200
Message-ID: <20251003160331.647625074@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003160331.487313415@linuxfoundation.org>
References: <20251003160331.487313415@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Larshin Sergey <Sergey.Larshin@kaspersky.com>

commit fa0f61cc1d828178aa921475a9b786e7fbb65ccb upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/rc/imon.c |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -536,7 +536,9 @@ static int display_open(struct inode *in
 
 	mutex_lock(&ictx->lock);
 
-	if (!ictx->display_supported) {
+	if (ictx->disconnected) {
+		retval = -ENODEV;
+	} else if (!ictx->display_supported) {
 		pr_err("display not supported by device\n");
 		retval = -ENODEV;
 	} else if (ictx->display_isopen) {
@@ -598,6 +600,9 @@ static int send_packet(struct imon_conte
 	int retval = 0;
 	struct usb_ctrlrequest *control_req = NULL;
 
+	if (ictx->disconnected)
+		return -ENODEV;
+
 	/* Check if we need to use control or interrupt urb */
 	if (!ictx->tx_control) {
 		pipe = usb_sndintpipe(ictx->usbdev_intf0,
@@ -949,12 +954,14 @@ static ssize_t vfd_write(struct file *fi
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
@@ -1029,11 +1036,13 @@ static ssize_t lcd_write(struct file *fi
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
@@ -2499,7 +2508,11 @@ static void imon_disconnect(struct usb_i
 	int ifnum;
 
 	ictx = usb_get_intfdata(interface);
+
+	mutex_lock(&ictx->lock);
 	ictx->disconnected = true;
+	mutex_unlock(&ictx->lock);
+
 	dev = ictx->dev;
 	ifnum = interface->cur_altsetting->desc.bInterfaceNumber;
 



