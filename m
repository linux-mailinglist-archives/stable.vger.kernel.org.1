Return-Path: <stable+bounces-154948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6C6AE1510
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B0A4A48C8
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDC6202978;
	Fri, 20 Jun 2025 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iAlGUw2X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D25817583
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750405045; cv=none; b=r495N0/7m5AvZgrqVpHqIm/mWmvSKUXk9zRAA54B5SwfcR75TyvYOVFxU+X6Ob/kZFGdSwg7O9/JmYsxBARKppqyc1vgFgr78fuGZlj/FGBhzn1ulUoG9BGQOs/GzBd9EqIDuGQGpQy+rTwahOu1KRx9HT+H6E09S1ov1QKaPEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750405045; c=relaxed/simple;
	bh=DLhaV5uIhcwy0UZy8PXtuyqMmO6B490st4kkQKDIghU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RNJhjSFdM1URziB60Hhm739iYvl3Tn0OgGtDrGFt/+UkeoIT2Nc/h/xxl5NcEN9nM8N/viYe92yvOzFtuJ/MvfQlrhtYX85c+pTzh9QDplzFdPUpjkQPhmTx+7oyTzr5eHjOYgvrNy6ZQes+5FmOLfihs5W3NUaOQlI0Tk+ssHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iAlGUw2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937CDC4CEE3;
	Fri, 20 Jun 2025 07:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750405044;
	bh=DLhaV5uIhcwy0UZy8PXtuyqMmO6B490st4kkQKDIghU=;
	h=Subject:To:Cc:From:Date:From;
	b=iAlGUw2XTfIcMxOc74AK6xDOX6yvHMMzqyO1LpjK54skyvBS7u8Ob/tblkFESfv1X
	 XyQ/6b/9BS3C4xdx7MbxlqlBW+vSi/s5NRJejICJLM3LMQ709xN3FTTv/1EBnyKVc9
	 x0VOUsZ4HynvYqkEQwR2CXDzqi7G0Du+zDsxszBw=
Subject: FAILED: patch "[PATCH] media: cxusb: no longer judge rbuf when the write fails" failed to apply to 5.4-stable tree
To: eadavis@qq.com,hverkuil@xs4all.nl
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 09:37:22 +0200
Message-ID: <2025062022-fleshed-wildcard-a434@gregkh>
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
git cherry-pick -x 73fb3b92da84637e3817580fa205d48065924e15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062022-fleshed-wildcard-a434@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 73fb3b92da84637e3817580fa205d48065924e15 Mon Sep 17 00:00:00 2001
From: Edward Adam Davis <eadavis@qq.com>
Date: Sat, 5 Apr 2025 19:56:41 +0800
Subject: [PATCH] media: cxusb: no longer judge rbuf when the write fails

syzbot reported a uninit-value in cxusb_i2c_xfer. [1]

Only when the write operation of usb_bulk_msg() in dvb_usb_generic_rw()
succeeds and rlen is greater than 0, the read operation of usb_bulk_msg()
will be executed to read rlen bytes of data from the dvb device into the
rbuf.

In this case, although rlen is 1, the write operation failed which resulted
in the dvb read operation not being executed, and ultimately variable i was
not initialized.

[1]
BUG: KMSAN: uninit-value in cxusb_gpio_tuner drivers/media/usb/dvb-usb/cxusb.c:124 [inline]
BUG: KMSAN: uninit-value in cxusb_i2c_xfer+0x153a/0x1a60 drivers/media/usb/dvb-usb/cxusb.c:196
 cxusb_gpio_tuner drivers/media/usb/dvb-usb/cxusb.c:124 [inline]
 cxusb_i2c_xfer+0x153a/0x1a60 drivers/media/usb/dvb-usb/cxusb.c:196
 __i2c_transfer+0xe25/0x3150 drivers/i2c/i2c-core-base.c:-1
 i2c_transfer+0x317/0x4a0 drivers/i2c/i2c-core-base.c:2315
 i2c_transfer_buffer_flags+0x125/0x1e0 drivers/i2c/i2c-core-base.c:2343
 i2c_master_send include/linux/i2c.h:109 [inline]
 i2cdev_write+0x210/0x280 drivers/i2c/i2c-dev.c:183
 do_loop_readv_writev fs/read_write.c:848 [inline]
 vfs_writev+0x963/0x14e0 fs/read_write.c:1057
 do_writev+0x247/0x5c0 fs/read_write.c:1101
 __do_sys_writev fs/read_write.c:1169 [inline]
 __se_sys_writev fs/read_write.c:1166 [inline]
 __x64_sys_writev+0x98/0xe0 fs/read_write.c:1166
 x64_sys_call+0x2229/0x3c80 arch/x86/include/generated/asm/syscalls_64.h:21
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported-by: syzbot+526bd95c0ec629993bf3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=526bd95c0ec629993bf3
Tested-by: syzbot+526bd95c0ec629993bf3@syzkaller.appspotmail.com
Fixes: 22c6d93a7310 ("[PATCH] dvb: usb: support Medion hybrid USB2.0 DVB-T/analogue box")
Cc: stable@vger.kernel.org
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/usb/dvb-usb/cxusb.c b/drivers/media/usb/dvb-usb/cxusb.c
index f44529b40989..d0501c1e81d6 100644
--- a/drivers/media/usb/dvb-usb/cxusb.c
+++ b/drivers/media/usb/dvb-usb/cxusb.c
@@ -119,9 +119,8 @@ static void cxusb_gpio_tuner(struct dvb_usb_device *d, int onoff)
 
 	o[0] = GPIO_TUNER;
 	o[1] = onoff;
-	cxusb_ctrl_msg(d, CMD_GPIO_WRITE, o, 2, &i, 1);
 
-	if (i != 0x01)
+	if (!cxusb_ctrl_msg(d, CMD_GPIO_WRITE, o, 2, &i, 1) && i != 0x01)
 		dev_info(&d->udev->dev, "gpio_write failed.\n");
 
 	st->gpio_write_state[GPIO_TUNER] = onoff;


