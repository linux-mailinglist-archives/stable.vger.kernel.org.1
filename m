Return-Path: <stable+bounces-109985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BE8A1850A
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B78387A3413
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FB91F7545;
	Tue, 21 Jan 2025 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZjgGbhgr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D791F8921;
	Tue, 21 Jan 2025 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737483008; cv=none; b=tpyNSQZ3j+ZzXgBhiMHWf1zXilznJkP1CIPXKEh+k9P+dUogWaQHoMjYFcuv3nbj76R49pEUij3lIyRGJckr6oosOVvMaC65IthJMxOzs561kD1UFB0ScnydUc21JxOdBAGPxwdRJhOMBvo1MB/fcKYrEF8egZu/95M6SaysVT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737483008; c=relaxed/simple;
	bh=J2s9X6U90/pEBa13XvCnSxSmfBpv6+kccPdZzj6QqHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sauXsKiEInLKblEWJ21YdA4JG8f7lj5KYqKApU3fXaUKgv4yo62e60C9blSjzJe+3eVLX3DPA6T0dpIAUs4b0fcmtpC0N3QBkDqHPR1nlHTm20SnmAOZl2IlUsiVg+c++uMtkEI+qo3CEX0umMOTjflxMEPwS8AzY2nfqdLVxYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZjgGbhgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268D6C4CEE0;
	Tue, 21 Jan 2025 18:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737483008;
	bh=J2s9X6U90/pEBa13XvCnSxSmfBpv6+kccPdZzj6QqHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZjgGbhgrDMWttnb1dol9RqzEY+ef7Uwq3D3KnGUu7aDkol90vn0EfxOEKajLsOCcB
	 kgkyAjqqdXyN+7WRqKNhKSWFUjXgxJaP7BCz2D/8h99XW+Q1SHoGfOfEBxz3VZpJ2Z
	 Az3jXtQgVFewgcmcrUdZmPPscRRf6d+W1pCWHmVA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 085/127] gtp: Destroy device along with udp sockets netns dismantle.
Date: Tue, 21 Jan 2025 18:52:37 +0100
Message-ID: <20250121174532.932575355@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174529.674452028@linuxfoundation.org>
References: <20250121174529.674452028@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit eb28fd76c0a08a47b470677c6cef9dd1c60e92d1 ]

gtp_newlink() links the device to a list in dev_net(dev) instead of
src_net, where a udp tunnel socket is created.

Even when src_net is removed, the device stays alive on dev_net(dev).
Then, removing src_net triggers the splat below. [0]

In this example, gtp0 is created in ns2, and the udp socket is created
in ns1.

  ip netns add ns1
  ip netns add ns2
  ip -n ns1 link add netns ns2 name gtp0 type gtp role sgsn
  ip netns del ns1

Let's link the device to the socket's netns instead.

Now, gtp_net_exit_batch_rtnl() needs another netdev iteration to remove
all gtp devices in the netns.

[0]:
ref_tracker: net notrefcnt@000000003d6e7d05 has 1/2 users at
     sk_alloc (./include/net/net_namespace.h:345 net/core/sock.c:2236)
     inet_create (net/ipv4/af_inet.c:326 net/ipv4/af_inet.c:252)
     __sock_create (net/socket.c:1558)
     udp_sock_create4 (net/ipv4/udp_tunnel_core.c:18)
     gtp_create_sock (./include/net/udp_tunnel.h:59 drivers/net/gtp.c:1423)
     gtp_create_sockets (drivers/net/gtp.c:1447)
     gtp_newlink (drivers/net/gtp.c:1507)
     rtnl_newlink (net/core/rtnetlink.c:3786 net/core/rtnetlink.c:3897 net/core/rtnetlink.c:4012)
     rtnetlink_rcv_msg (net/core/rtnetlink.c:6922)
     netlink_rcv_skb (net/netlink/af_netlink.c:2542)
     netlink_unicast (net/netlink/af_netlink.c:1321 net/netlink/af_netlink.c:1347)
     netlink_sendmsg (net/netlink/af_netlink.c:1891)
     ____sys_sendmsg (net/socket.c:711 net/socket.c:726 net/socket.c:2583)
     ___sys_sendmsg (net/socket.c:2639)
     __sys_sendmsg (net/socket.c:2669)
     do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)

WARNING: CPU: 1 PID: 60 at lib/ref_tracker.c:179 ref_tracker_dir_exit (lib/ref_tracker.c:179)
Modules linked in:
CPU: 1 UID: 0 PID: 60 Comm: kworker/u16:2 Not tainted 6.13.0-rc5-00147-g4c1224501e9d #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:ref_tracker_dir_exit (lib/ref_tracker.c:179)
Code: 00 00 00 fc ff df 4d 8b 26 49 bd 00 01 00 00 00 00 ad de 4c 39 f5 0f 85 df 00 00 00 48 8b 74 24 08 48 89 df e8 a5 cc 12 02 90 <0f> 0b 90 48 8d 6b 44 be 04 00 00 00 48 89 ef e8 80 de 67 ff 48 89
RSP: 0018:ff11000009a07b60 EFLAGS: 00010286
RAX: 0000000000002bd3 RBX: ff1100000f4e1aa0 RCX: 1ffffffff0e40ac6
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8423ee3c
RBP: ff1100000f4e1af0 R08: 0000000000000001 R09: fffffbfff0e395ae
R10: 0000000000000001 R11: 0000000000036001 R12: ff1100000f4e1af0
R13: dead000000000100 R14: ff1100000f4e1af0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ff1100006ce80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9b2464bd98 CR3: 0000000005286005 CR4: 0000000000771ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn (kernel/panic.c:748)
 ? ref_tracker_dir_exit (lib/ref_tracker.c:179)
 ? report_bug (lib/bug.c:201 lib/bug.c:219)
 ? handle_bug (arch/x86/kernel/traps.c:285)
 ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator 1))
 ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
 ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/irqflags.h:42 ./arch/x86/include/asm/irqflags.h:97 ./arch/x86/include/asm/irqflags.h:155 ./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
 ? ref_tracker_dir_exit (lib/ref_tracker.c:179)
 ? __pfx_ref_tracker_dir_exit (lib/ref_tracker.c:158)
 ? kfree (mm/slub.c:4613 mm/slub.c:4761)
 net_free (net/core/net_namespace.c:476 net/core/net_namespace.c:467)
 cleanup_net (net/core/net_namespace.c:664 (discriminator 3))
 process_one_work (kernel/workqueue.c:3229)
 worker_thread (kernel/workqueue.c:3304 kernel/workqueue.c:3391)
 kthread (kernel/kthread.c:389)
 ret_from_fork (arch/x86/kernel/process.c:147)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
 </TASK>

Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/20250104125732.17335-1-shaw.leon@gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/gtp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index e4d29c22a0a79..2d306971d4fde 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -697,7 +697,7 @@ static int gtp_newlink(struct net *src_net, struct net_device *dev,
 		goto out_encap;
 	}
 
-	gn = net_generic(dev_net(dev), gtp_net_id);
+	gn = net_generic(src_net, gtp_net_id);
 	list_add(&gtp->list, &gn->gtp_dev_list);
 	dev->priv_destructor = gtp_destructor;
 
@@ -1414,6 +1414,11 @@ static void __net_exit gtp_net_exit_batch_rtnl(struct list_head *net_list,
 	list_for_each_entry(net, net_list, exit_list) {
 		struct gtp_net *gn = net_generic(net, gtp_net_id);
 		struct gtp_dev *gtp, *gtp_next;
+		struct net_device *dev;
+
+		for_each_netdev(net, dev)
+			if (dev->rtnl_link_ops == &gtp_link_ops)
+				gtp_dellink(dev, dev_to_kill);
 
 		list_for_each_entry_safe(gtp, gtp_next, &gn->gtp_dev_list, list)
 			gtp_dellink(gtp->dev, dev_to_kill);
-- 
2.39.5




