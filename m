Return-Path: <stable+bounces-119018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A53F3A42435
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62244452C1
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F0A18E34A;
	Mon, 24 Feb 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SQWEa5TK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E25155308;
	Mon, 24 Feb 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408040; cv=none; b=gDfF8LCWWSh73kqrRozk0j4/2u0JxJeWU+71E05h+GdMoUWv35ep3A6QS/Xk+sWwAzMUmHdyDB3NsiPHBUvzYnhC4WFOoQ3T2f5iPKaPJ+0KAHbapqGCEt+BPEb4JohH4JJPhUMkFuIT0tXYQFBbzQY6jVoYfGMeQExYOY+bCQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408040; c=relaxed/simple;
	bh=QlK5vwpudER+qHsjA8emmzCkE1oxO+WBXsLBypaSQEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGXwYY3vNpxlZmSKszElCpdgJQCRzyxGwRbBR7Wr4/o76fok4DAm91QcE7/Zh0MRoLwMB9I8YHdU2bYBrQmbGA7kGcFg2F0OirHyl99vAlvnxmF4CmCD2BUNwtVlvy4M4ijmuYJJgn51q8W5Ht44IWGQHqcIMrTd5wLqI9YT+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SQWEa5TK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD733C4CED6;
	Mon, 24 Feb 2025 14:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408040;
	bh=QlK5vwpudER+qHsjA8emmzCkE1oxO+WBXsLBypaSQEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SQWEa5TK2qBJf+1TJPi+6aq4Pv9gllvOPtxfWyDiI2ypdSTMDPByCoBnmewdA3qWP
	 +dTOIoqbRcxupP6dWN3PaT95QDrI8VyO8NRLL4nDJbez9z5q6d4b9DX1MJ1gr5jJb5
	 8p9cwvHU/9IBMDn49HqQXpPot/1cGj+b858KDYJU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brad Spengler <spender@grsecurity.net>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 082/140] gtp: Suppress list corruption splat in gtp_net_exit_batch_rtnl().
Date: Mon, 24 Feb 2025 15:34:41 +0100
Message-ID: <20250224142606.233759135@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142602.998423469@linuxfoundation.org>
References: <20250224142602.998423469@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 4ccacf86491d33d2486b62d4d44864d7101b299d ]

Brad Spengler reported the list_del() corruption splat in
gtp_net_exit_batch_rtnl(). [0]

Commit eb28fd76c0a0 ("gtp: Destroy device along with udp socket's netns
dismantle.") added the for_each_netdev() loop in gtp_net_exit_batch_rtnl()
to destroy devices in each netns as done in geneve and ip tunnels.

However, this could trigger ->dellink() twice for the same device during
->exit_batch_rtnl().

Say we have two netns A & B and gtp device B that resides in netns B but
whose UDP socket is in netns A.

  1. cleanup_net() processes netns A and then B.

  2. gtp_net_exit_batch_rtnl() finds the device B while iterating
     netns A's gn->gtp_dev_list and calls ->dellink().

  [ device B is not yet unlinked from netns B
    as unregister_netdevice_many() has not been called. ]

  3. gtp_net_exit_batch_rtnl() finds the device B while iterating
     netns B's for_each_netdev() and calls ->dellink().

gtp_dellink() cleans up the device's hash table, unlinks the dev from
gn->gtp_dev_list, and calls unregister_netdevice_queue().

Basically, calling gtp_dellink() multiple times is fine unless
CONFIG_DEBUG_LIST is enabled.

Let's remove for_each_netdev() in gtp_net_exit_batch_rtnl() and
delegate the destruction to default_device_exit_batch() as done
in bareudp.

[0]:
list_del corruption, ffff8880aaa62c00->next (autoslab_size_M_dev_P_net_core_dev_11127_8_1328_8_S_4096_A_64_n_139+0xc00/0x1000 [slab object]) is LIST_POISON1 (ffffffffffffff02) (prev is 0xffffffffffffff04)
kernel BUG at lib/list_debug.c:58!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 UID: 0 PID: 1804 Comm: kworker/u8:7 Tainted: G                T   6.12.13-grsec-full-20250211091339 #1
Tainted: [T]=RANDSTRUCT
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:[<ffffffff84947381>] __list_del_entry_valid_or_report+0x141/0x200 lib/list_debug.c:58
Code: c2 76 91 31 c0 e8 9f b1 f7 fc 0f 0b 4d 89 f0 48 c7 c1 02 ff ff ff 48 89 ea 48 89 ee 48 c7 c7 e0 c2 76 91 31 c0 e8 7f b1 f7 fc <0f> 0b 4d 89 e8 48 c7 c1 04 ff ff ff 48 89 ea 48 89 ee 48 c7 c7 60
RSP: 0018:fffffe8040b4fbd0 EFLAGS: 00010283
RAX: 00000000000000cc RBX: dffffc0000000000 RCX: ffffffff818c4054
RDX: ffffffff84947381 RSI: ffffffff818d1512 RDI: 0000000000000000
RBP: ffff8880aaa62c00 R08: 0000000000000001 R09: fffffbd008169f32
R10: fffffe8040b4f997 R11: 0000000000000001 R12: a1988d84f24943e4
R13: ffffffffffffff02 R14: ffffffffffffff04 R15: ffff8880aaa62c08
RBX: kasan shadow of 0x0
RCX: __wake_up_klogd.part.0+0x74/0xe0 kernel/printk/printk.c:4554
RDX: __list_del_entry_valid_or_report+0x141/0x200 lib/list_debug.c:58
RSI: vprintk+0x72/0x100 kernel/printk/printk_safe.c:71
RBP: autoslab_size_M_dev_P_net_core_dev_11127_8_1328_8_S_4096_A_64_n_139+0xc00/0x1000 [slab object]
RSP: process kstack fffffe8040b4fbd0+0x7bd0/0x8000 [kworker/u8:7+netns 1804 ]
R09: kasan shadow of process kstack fffffe8040b4f990+0x7990/0x8000 [kworker/u8:7+netns 1804 ]
R10: process kstack fffffe8040b4f997+0x7997/0x8000 [kworker/u8:7+netns 1804 ]
R15: autoslab_size_M_dev_P_net_core_dev_11127_8_1328_8_S_4096_A_64_n_139+0xc08/0x1000 [slab object]
FS:  0000000000000000(0000) GS:ffff888116000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000748f5372c000 CR3: 0000000015408000 CR4: 00000000003406f0 shadow CR4: 00000000003406f0
Stack:
 0000000000000000 ffffffff8a0c35e7 ffffffff8a0c3603 ffff8880aaa62c00
 ffff8880aaa62c00 0000000000000004 ffff88811145311c 0000000000000005
 0000000000000001 ffff8880aaa62000 fffffe8040b4fd40 ffffffff8a0c360d
Call Trace:
 <TASK>
 [<ffffffff8a0c360d>] __list_del_entry_valid include/linux/list.h:131 [inline] fffffe8040b4fc28
 [<ffffffff8a0c360d>] __list_del_entry include/linux/list.h:248 [inline] fffffe8040b4fc28
 [<ffffffff8a0c360d>] list_del include/linux/list.h:262 [inline] fffffe8040b4fc28
 [<ffffffff8a0c360d>] gtp_dellink+0x16d/0x360 drivers/net/gtp.c:1557 fffffe8040b4fc28
 [<ffffffff8a0d0404>] gtp_net_exit_batch_rtnl+0x124/0x2c0 drivers/net/gtp.c:2495 fffffe8040b4fc88
 [<ffffffff8e705b24>] cleanup_net+0x5a4/0xbe0 net/core/net_namespace.c:635 fffffe8040b4fcd0
 [<ffffffff81754c97>] process_one_work+0xbd7/0x2160 kernel/workqueue.c:3326 fffffe8040b4fd88
 [<ffffffff81757195>] process_scheduled_works kernel/workqueue.c:3407 [inline] fffffe8040b4fec0
 [<ffffffff81757195>] worker_thread+0x6b5/0xfa0 kernel/workqueue.c:3488 fffffe8040b4fec0
 [<ffffffff817782a0>] kthread+0x360/0x4c0 kernel/kthread.c:397 fffffe8040b4ff78
 [<ffffffff814d8594>] ret_from_fork+0x74/0xe0 arch/x86/kernel/process.c:172 fffffe8040b4ffb8
 [<ffffffff8110f509>] ret_from_fork_asm+0x29/0xc0 arch/x86/entry/entry_64.S:399 fffffe8040b4ffe8
 </TASK>
Modules linked in:

Fixes: eb28fd76c0a0 ("gtp: Destroy device along with udp socket's netns dismantle.")
Reported-by: Brad Spengler <spender@grsecurity.net>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20250217203705.40342-2-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/gtp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 47238c3ec82e7..55160a5fc90fc 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1895,11 +1895,6 @@ static void __net_exit gtp_net_exit_batch_rtnl(struct list_head *net_list,
 	list_for_each_entry(net, net_list, exit_list) {
 		struct gtp_net *gn = net_generic(net, gtp_net_id);
 		struct gtp_dev *gtp, *gtp_next;
-		struct net_device *dev;
-
-		for_each_netdev(net, dev)
-			if (dev->rtnl_link_ops == &gtp_link_ops)
-				gtp_dellink(dev, dev_to_kill);
 
 		list_for_each_entry_safe(gtp, gtp_next, &gn->gtp_dev_list, list)
 			gtp_dellink(gtp->dev, dev_to_kill);
-- 
2.39.5




