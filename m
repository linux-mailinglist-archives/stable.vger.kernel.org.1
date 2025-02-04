Return-Path: <stable+bounces-112168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1A0A27414
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 15:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774C51886ED0
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 14:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C667F211A3D;
	Tue,  4 Feb 2025 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vtqBAgr2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8418838DFC
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677764; cv=none; b=pTEmYCar1fs/QpI7byV5lMjaBgyil7oLjqsvsxXK/fOfRAxetyZwKEdCqUaAQ2nyb4jSRO0Sfwuf2A3yoKlLGmNVyVayB4SDzjKn5veTMCmXg4rkEkKhMK+l6GoKJSL289C0kHNJKbYn308fMarZYCtsWLvZ8xUycdODmqzGXw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677764; c=relaxed/simple;
	bh=KRcLaX3sNWX7glfuPH0E4XfdnekcG84BIr6LNByJhTc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XPwwRMjE30fXJ9/i8NwmPb8IpZrdH1O4bK50ebc3MHlh/tlqBfMWLEfgiAfgftFIMLPhhaiRvUL/0RcYmdHCT2BZCTJGOfGIxkUj+zlgQfOBY8YjNA9s2UwYY7R6fVhbSKuXaZtkv/omK2MnR2p1qnpF8jOZjAc5i33rlqlRw3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vtqBAgr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1F7C4CEDF;
	Tue,  4 Feb 2025 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738677764;
	bh=KRcLaX3sNWX7glfuPH0E4XfdnekcG84BIr6LNByJhTc=;
	h=Subject:To:Cc:From:Date:From;
	b=vtqBAgr2TvVOurHWxg7nJaW9nPaaAy9nP+Eu6e8qLgeSa1cslwla0qXchagvMARs+
	 iIQJn/5nTA65jKmi+2NG5HpMjauyGiCDtUqVsmv/+/EHqH/Z71tPhMq14WX4RlJMKp
	 7vLLenI9Zv84o8eefVUo44kTZL0XgtO6i916/km0=
Subject: FAILED: patch "[PATCH] net: usb: rtl8150: enable basic endpoint checking" failed to apply to 5.4-stable tree
To: n.zhandarovich@fintech.ru,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Feb 2025 15:02:32 +0100
Message-ID: <2025020432-salaried-spree-b4a5@gregkh>
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
git cherry-pick -x 90b7f2961798793275b4844348619b622f983907
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025020432-salaried-spree-b4a5@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 90b7f2961798793275b4844348619b622f983907 Mon Sep 17 00:00:00 2001
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Date: Fri, 24 Jan 2025 01:30:20 -0800
Subject: [PATCH] net: usb: rtl8150: enable basic endpoint checking

Syzkaller reports [1] encountering a common issue of utilizing a wrong
usb endpoint type during URB submitting stage. This, in turn, triggers
a warning shown below.

For now, enable simple endpoint checking (specifically, bulk and
interrupt eps, testing control one is not essential) to mitigate
the issue with a view to do other related cosmetic changes later,
if they are necessary.

[1] Syzkaller report:
usb 1-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 1 PID: 2586 at drivers/usb/core/urb.c:503 usb_submit_urb+0xe4b/0x1730 driv>
Modules linked in:
CPU: 1 UID: 0 PID: 2586 Comm: dhcpcd Not tainted 6.11.0-rc4-syzkaller-00069-gfc88bb11617>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:usb_submit_urb+0xe4b/0x1730 drivers/usb/core/urb.c:503
Code: 84 3c 02 00 00 e8 05 e4 fc fc 4c 89 ef e8 fd 25 d7 fe 45 89 e0 89 e9 4c 89 f2 48 8>
RSP: 0018:ffffc9000441f740 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888112487a00 RCX: ffffffff811a99a9
RDX: ffff88810df6ba80 RSI: ffffffff811a99b6 RDI: 0000000000000001
RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
R13: ffff8881023bf0a8 R14: ffff888112452a20 R15: ffff888112487a7c
FS:  00007fc04eea5740(0000) GS:ffff8881f6300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0a1de9f870 CR3: 000000010dbd0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rtl8150_open+0x300/0xe30 drivers/net/usb/rtl8150.c:733
 __dev_open+0x2d4/0x4e0 net/core/dev.c:1474
 __dev_change_flags+0x561/0x720 net/core/dev.c:8838
 dev_change_flags+0x8f/0x160 net/core/dev.c:8910
 devinet_ioctl+0x127a/0x1f10 net/ipv4/devinet.c:1177
 inet_ioctl+0x3aa/0x3f0 net/ipv4/af_inet.c:1003
 sock_do_ioctl+0x116/0x280 net/socket.c:1222
 sock_ioctl+0x22e/0x6c0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc04ef73d49
...

This change has not been tested on real hardware.

Reported-and-tested-by: syzbot+d7e968426f644b567e31@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d7e968426f644b567e31
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Link: https://patch.msgid.link/20250124093020.234642-1-n.zhandarovich@fintech.ru
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index 01a3b2417a54..ddff6f19ff98 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -71,6 +71,14 @@
 #define MSR_SPEED		(1<<3)
 #define MSR_LINK		(1<<2)
 
+/* USB endpoints */
+enum rtl8150_usb_ep {
+	RTL8150_USB_EP_CONTROL = 0,
+	RTL8150_USB_EP_BULK_IN = 1,
+	RTL8150_USB_EP_BULK_OUT = 2,
+	RTL8150_USB_EP_INT_IN = 3,
+};
+
 /* Interrupt pipe data */
 #define INT_TSR			0x00
 #define INT_RSR			0x01
@@ -867,6 +875,13 @@ static int rtl8150_probe(struct usb_interface *intf,
 	struct usb_device *udev = interface_to_usbdev(intf);
 	rtl8150_t *dev;
 	struct net_device *netdev;
+	static const u8 bulk_ep_addr[] = {
+		RTL8150_USB_EP_BULK_IN | USB_DIR_IN,
+		RTL8150_USB_EP_BULK_OUT | USB_DIR_OUT,
+		0};
+	static const u8 int_ep_addr[] = {
+		RTL8150_USB_EP_INT_IN | USB_DIR_IN,
+		0};
 
 	netdev = alloc_etherdev(sizeof(rtl8150_t));
 	if (!netdev)
@@ -880,6 +895,13 @@ static int rtl8150_probe(struct usb_interface *intf,
 		return -ENOMEM;
 	}
 
+	/* Verify that all required endpoints are present */
+	if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
+	    !usb_check_int_endpoints(intf, int_ep_addr)) {
+		dev_err(&intf->dev, "couldn't find required endpoints\n");
+		goto out;
+	}
+
 	tasklet_setup(&dev->tl, rx_fixup);
 	spin_lock_init(&dev->rx_pool_lock);
 


