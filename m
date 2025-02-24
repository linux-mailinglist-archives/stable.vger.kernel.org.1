Return-Path: <stable+bounces-119195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2049EA424D8
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18879426BD2
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A222505B8;
	Mon, 24 Feb 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GNi2fCNg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E2E1514CC;
	Mon, 24 Feb 2025 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408642; cv=none; b=Ej67WBk5LJnAOj13pSN9x5JRdHRYFbEtFCad/9RHJIpIv4GcFF2dqJ4bamDGxk02TkeA8A5MUO186XbcrtVaQk5ANpk1aNAsuNz2qu757SBxbjw5HsE0RPHVN7MTkyrhOxkuGVIbSPncSTju4ToB0iTQC9/bN4LmqnJn7hV+Yzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408642; c=relaxed/simple;
	bh=Px0prWcbc3bwjAlR+wd/+mGHc6R8qa+cRA+GqdfEf2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUb9P5KziarIqsi58/Es7euj6INr+Uz5E2vHdjSxV2XDCm8TCtbIKtfpIYT6WJh9wV9e657mDscZdKTW1NH3whM50GVxjqwyQOFEXfQm4Hf+XrAzPQt+jQzNIxuuMeUdq+wh+E7SjQg2zSbUUVAkzosgdnkT3PtCLsGU2tJoxu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GNi2fCNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D08AC4CEE6;
	Mon, 24 Feb 2025 14:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408641;
	bh=Px0prWcbc3bwjAlR+wd/+mGHc6R8qa+cRA+GqdfEf2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GNi2fCNgl9iqYUCHyT9O0U7MRIMK6L8o/IP8A2MHZDUdZiFnsLi0kIQ4K4Ta+EP1t
	 xKaOVoHxzLjpnOQpSBd9eG3jQoAO/Ulwo6v59SYNXuk6A9kpAq/dAPiCLn0D/HHtT8
	 vCIu+nOgvy7olpLyJB9HgE8kI3hEDZiTV7qrvelc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 117/154] drop_monitor: fix incorrect initialization order
Date: Mon, 24 Feb 2025 15:35:16 +0100
Message-ID: <20250224142611.638396141@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142607.058226288@linuxfoundation.org>
References: <20250224142607.058226288@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>

commit 07b598c0e6f06a0f254c88dafb4ad50f8a8c6eea upstream.

Syzkaller reports the following bug:

BUG: spinlock bad magic on CPU#1, syz-executor.0/7995
 lock: 0xffff88805303f3e0, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
CPU: 1 PID: 7995 Comm: syz-executor.0 Tainted: G            E     5.10.209+ #1
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x119/0x179 lib/dump_stack.c:118
 debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
 do_raw_spin_lock+0x1f6/0x270 kernel/locking/spinlock_debug.c:112
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:117 [inline]
 _raw_spin_lock_irqsave+0x50/0x70 kernel/locking/spinlock.c:159
 reset_per_cpu_data+0xe6/0x240 [drop_monitor]
 net_dm_cmd_trace+0x43d/0x17a0 [drop_monitor]
 genl_family_rcv_msg_doit+0x22f/0x330 net/netlink/genetlink.c:739
 genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
 genl_rcv_msg+0x341/0x5a0 net/netlink/genetlink.c:800
 netlink_rcv_skb+0x14d/0x440 net/netlink/af_netlink.c:2497
 genl_rcv+0x29/0x40 net/netlink/genetlink.c:811
 netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
 netlink_unicast+0x54b/0x800 net/netlink/af_netlink.c:1348
 netlink_sendmsg+0x914/0xe00 net/netlink/af_netlink.c:1916
 sock_sendmsg_nosec net/socket.c:651 [inline]
 __sock_sendmsg+0x157/0x190 net/socket.c:663
 ____sys_sendmsg+0x712/0x870 net/socket.c:2378
 ___sys_sendmsg+0xf8/0x170 net/socket.c:2432
 __sys_sendmsg+0xea/0x1b0 net/socket.c:2461
 do_syscall_64+0x30/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x62/0xc7
RIP: 0033:0x7f3f9815aee9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3f972bf0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f3f9826d050 RCX: 00007f3f9815aee9
RDX: 0000000020000000 RSI: 0000000020001300 RDI: 0000000000000007
RBP: 00007f3f981b63bd R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f3f9826d050 R15: 00007ffe01ee6768

If drop_monitor is built as a kernel module, syzkaller may have time
to send a netlink NET_DM_CMD_START message during the module loading.
This will call the net_dm_monitor_start() function that uses
a spinlock that has not yet been initialized.

To fix this, let's place resource initialization above the registration
of a generic netlink family.

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with Syzkaller.

Fixes: 9a8afc8d3962 ("Network Drop Monitor: Adding drop monitor implementation & Netlink protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20250213152054.2785669-1-Ilia.Gavrilov@infotecs.ru
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/drop_monitor.c |   29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -1734,30 +1734,30 @@ static int __init init_net_drop_monitor(
 		return -ENOSPC;
 	}
 
-	rc = genl_register_family(&net_drop_monitor_family);
-	if (rc) {
-		pr_err("Could not create drop monitor netlink family\n");
-		return rc;
+	for_each_possible_cpu(cpu) {
+		net_dm_cpu_data_init(cpu);
+		net_dm_hw_cpu_data_init(cpu);
 	}
-	WARN_ON(net_drop_monitor_family.mcgrp_offset != NET_DM_GRP_ALERT);
 
 	rc = register_netdevice_notifier(&dropmon_net_notifier);
 	if (rc < 0) {
 		pr_crit("Failed to register netdevice notifier\n");
+		return rc;
+	}
+
+	rc = genl_register_family(&net_drop_monitor_family);
+	if (rc) {
+		pr_err("Could not create drop monitor netlink family\n");
 		goto out_unreg;
 	}
+	WARN_ON(net_drop_monitor_family.mcgrp_offset != NET_DM_GRP_ALERT);
 
 	rc = 0;
 
-	for_each_possible_cpu(cpu) {
-		net_dm_cpu_data_init(cpu);
-		net_dm_hw_cpu_data_init(cpu);
-	}
-
 	goto out;
 
 out_unreg:
-	genl_unregister_family(&net_drop_monitor_family);
+	WARN_ON(unregister_netdevice_notifier(&dropmon_net_notifier));
 out:
 	return rc;
 }
@@ -1766,19 +1766,18 @@ static void exit_net_drop_monitor(void)
 {
 	int cpu;
 
-	BUG_ON(unregister_netdevice_notifier(&dropmon_net_notifier));
-
 	/*
 	 * Because of the module_get/put we do in the trace state change path
 	 * we are guaranteed not to have any current users when we get here
 	 */
+	BUG_ON(genl_unregister_family(&net_drop_monitor_family));
+
+	BUG_ON(unregister_netdevice_notifier(&dropmon_net_notifier));
 
 	for_each_possible_cpu(cpu) {
 		net_dm_hw_cpu_data_fini(cpu);
 		net_dm_cpu_data_fini(cpu);
 	}
-
-	BUG_ON(genl_unregister_family(&net_drop_monitor_family));
 }
 
 module_init(init_net_drop_monitor);



