Return-Path: <stable+bounces-129623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D25C2A800BA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2E4460A13
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F4326AABE;
	Tue,  8 Apr 2025 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I0upFfTA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B5226AABD;
	Tue,  8 Apr 2025 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111538; cv=none; b=s2ehaz2mwB7F/2DP9kzkTHN/au+DXR6FF1d1h6FpPlBW99MK/10xI/ApdBX0AqMIx+hNixooZaOTSjOXRFP60JPS2nIkabbplsCPv0mURKe98HXzmdVIAGZVEoHIkTF7ActVbqlluNPjeoyVFbKafJE6HcqrZWNJ/4WTv09JzOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111538; c=relaxed/simple;
	bh=XZPah3JwD2qQ7gxqiiyUiI11OcakZUWrDQZy3CO2GHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfmafEoYz38ajj9BjKpzU9godp7aj5TBfLci8v/T88DBRA+iyPfAWRIPu+khHiJiXbLdQ/HXqm2ZxmIaXBFeXOEC9lZYtBVfqB6I2PQw7cAH7ne5J2+H8PGDI34NKcOYSZL2+msa3pSxk2n/ZTFr42w3+DLtUYRekDtwHHQ/bUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I0upFfTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EE9C4CEE7;
	Tue,  8 Apr 2025 11:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111538;
	bh=XZPah3JwD2qQ7gxqiiyUiI11OcakZUWrDQZy3CO2GHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0upFfTARqlwbrghuNglIHa74ekhemEW2LwioNH7d7ZFjkBCngNbFOQgjvulcj8yU
	 nzlJdTAVDSc7XaNkZqwR7BpXeOCJElA0GVrGKCFobH/m0w6vIrrX/+bOfIKFfZUcD6
	 2jSB+6iSyJ2Qh/sNJRBTIEsXC3l5UEdr1RR1eP/k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+f60349ba1f9f08df349f@syzkaller.appspotmail.com,
	Wang Liang <wangliang74@huawei.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 428/731] RDMA/core: Fix use-after-free when rename device name
Date: Tue,  8 Apr 2025 12:45:25 +0200
Message-ID: <20250408104924.230014847@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Liang <wangliang74@huawei.com>

[ Upstream commit 1d6a9e7449e2a0c1e2934eee7880ba8bd1e464cd ]

Syzbot reported a slab-use-after-free with the following call trace:

==================================================================
BUG: KASAN: slab-use-after-free in nla_put+0xd3/0x150 lib/nlattr.c:1099
Read of size 5 at addr ffff888140ea1c60 by task syz.0.988/10025

CPU: 0 UID: 0 PID: 10025 Comm: syz.0.988
Not tainted 6.14.0-rc4-syzkaller-00859-gf77f12010f67 #0
Hardware name: Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0x16e/0x5b0 mm/kasan/report.c:521
 kasan_report+0x143/0x180 mm/kasan/report.c:634
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 nla_put+0xd3/0x150 lib/nlattr.c:1099
 nla_put_string include/net/netlink.h:1621 [inline]
 fill_nldev_handle+0x16e/0x200 drivers/infiniband/core/nldev.c:265
 rdma_nl_notify_event+0x561/0xef0 drivers/infiniband/core/nldev.c:2857
 ib_device_notify_register+0x22/0x230 drivers/infiniband/core/device.c:1344
 ib_register_device+0x1292/0x1460 drivers/infiniband/core/device.c:1460
 rxe_register_device+0x233/0x350 drivers/infiniband/sw/rxe/rxe_verbs.c:1540
 rxe_net_add+0x74/0xf0 drivers/infiniband/sw/rxe/rxe_net.c:550
 rxe_newlink+0xde/0x1a0 drivers/infiniband/sw/rxe/rxe.c:212
 nldev_newlink+0x5ea/0x680 drivers/infiniband/core/nldev.c:1795
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:709 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:724
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
 ___sys_sendmsg net/socket.c:2618 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2650
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f42d1b8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 ...
RSP: 002b:00007f42d2960038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f42d1da6320 RCX: 00007f42d1b8d169
RDX: 0000000000000000 RSI: 00004000000002c0 RDI: 000000000000000c
RBP: 00007f42d1c0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f42d1da6320 R15: 00007ffe399344a8
 </TASK>

Allocated by task 10025:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4294 [inline]
 __kmalloc_node_track_caller_noprof+0x28b/0x4c0 mm/slub.c:4313
 __kmemdup_nul mm/util.c:61 [inline]
 kstrdup+0x42/0x100 mm/util.c:81
 kobject_set_name_vargs+0x61/0x120 lib/kobject.c:274
 dev_set_name+0xd5/0x120 drivers/base/core.c:3468
 assign_name drivers/infiniband/core/device.c:1202 [inline]
 ib_register_device+0x178/0x1460 drivers/infiniband/core/device.c:1384
 rxe_register_device+0x233/0x350 drivers/infiniband/sw/rxe/rxe_verbs.c:1540
 rxe_net_add+0x74/0xf0 drivers/infiniband/sw/rxe/rxe_net.c:550
 rxe_newlink+0xde/0x1a0 drivers/infiniband/sw/rxe/rxe.c:212
 nldev_newlink+0x5ea/0x680 drivers/infiniband/core/nldev.c:1795
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:709 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:724
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
 ___sys_sendmsg net/socket.c:2618 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2650
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 10035:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kfree+0x196/0x430 mm/slub.c:4757
 kobject_rename+0x38f/0x410 lib/kobject.c:524
 device_rename+0x16a/0x200 drivers/base/core.c:4525
 ib_device_rename+0x270/0x710 drivers/infiniband/core/device.c:402
 nldev_set_doit+0x30e/0x4c0 drivers/infiniband/core/nldev.c:1146
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:709 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:724
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
 ___sys_sendmsg net/socket.c:2618 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2650
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

This is because if rename device happens, the old name is freed in
ib_device_rename() with lock, but ib_device_notify_register() may visit
the dev name locklessly by event RDMA_REGISTER_EVENT or
RDMA_NETDEV_ATTACH_EVENT.

Fix this by hold devices_rwsem in ib_device_notify_register().

Reported-by: syzbot+f60349ba1f9f08df349f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=25bc6f0ed2b88b9eb9b8
Fixes: 9cbed5aab5ae ("RDMA/nldev: Add support for RDMA monitoring")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
Link: https://patch.msgid.link/20250313092421.944658-1-wangliang74@huawei.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/device.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 8feb22089cbbd..ee75b99f84bcc 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1350,9 +1350,11 @@ static void ib_device_notify_register(struct ib_device *device)
 	u32 port;
 	int ret;
 
+	down_read(&devices_rwsem);
+
 	ret = rdma_nl_notify_event(device, 0, RDMA_REGISTER_EVENT);
 	if (ret)
-		return;
+		goto out;
 
 	rdma_for_each_port(device, port) {
 		netdev = ib_device_get_netdev(device, port);
@@ -1363,8 +1365,11 @@ static void ib_device_notify_register(struct ib_device *device)
 					   RDMA_NETDEV_ATTACH_EVENT);
 		dev_put(netdev);
 		if (ret)
-			return;
+			goto out;
 	}
+
+out:
+	up_read(&devices_rwsem);
 }
 
 /**
-- 
2.39.5




