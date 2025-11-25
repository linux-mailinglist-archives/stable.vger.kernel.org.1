Return-Path: <stable+bounces-196831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAE3C82F30
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 01:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C1184E2D42
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 00:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5381E2834;
	Tue, 25 Nov 2025 00:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Axtz4DBy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F36F1B4F1F
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 00:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764031596; cv=none; b=KyP04JrUughrf6ak6I++zj2j3UW+xCGjMB6/BF8DkDSHDCamv2Ij6qgvaKNwyKvDNr7tAbBO5MEFUjgKzsxN9h2byKvaQg0k5eYzU7S09KK31t/yhdxhKwtviANcI9dePRWlEZEnh0ZE/dqOH16K5D5YqU62X/9BjcaFDO58ufg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764031596; c=relaxed/simple;
	bh=bQjhq9lyJ3WYa54A/4lbhJeJuNtnYR71pFiNlSCk9V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHvOvEEXgZB5znVg9BwWQvx4GQG8yBs8SHSL0l1vny9Z0vOKzc+PjsUx4N+ySP5k2F0ZjiodWBpRC3rLRXc1pTdQndJlWD46iPatY6+pSxG4T2WttrqdKVK6vxSDPcfBFj/TOgVSZrywLWsln//tVy19n5rqx/SAqlNhbZvO/Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Axtz4DBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13089C4CEF1;
	Tue, 25 Nov 2025 00:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764031595;
	bh=bQjhq9lyJ3WYa54A/4lbhJeJuNtnYR71pFiNlSCk9V4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Axtz4DBy4sZig+1gt66iwhLKP3NrNkyVq/6kC1IqjMIQ0CmnsQUqfuudtXH618lGV
	 EdZ0Qx91tYG48DiU1iZEQjhoe/NH35iDB1X8RVR+R5wpeCognn/4CNFci5u4gavhlo
	 cW2mIUY1YRz+bP4IQyQ91io6mRr7C1TzL7uUCp6grCkiQEdFSnNal3pma/Zu+vCjRp
	 NockC9xZ/0kCGXac/0LMjrHCWidCYlGFvMm5eGULqjGssjXF47hNJGhWkuJZXav+EO
	 5ds1e4RjdmR61c9MCYsIcGomNj3lgK7vKHgaNKp70lnB+aPHWJ99MNL/kcWYS4X6DF
	 WdIhYUoGfREow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot+2a6fbf0f0530375968df@syzkaller.appspotmail.com,
	Geliang Tang <geliang@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mptcp: fix a race in mptcp_pm_del_add_timer()
Date: Mon, 24 Nov 2025 19:46:33 -0500
Message-ID: <20251125004633.189471-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112433-mortuary-favorable-330a@gregkh>
References: <2025112433-mortuary-favorable-330a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 426358d9be7ce3518966422f87b96f1bad27295f ]

mptcp_pm_del_add_timer() can call sk_stop_timer_sync(sk, &entry->add_timer)
while another might have free entry already, as reported by syzbot.

Add RCU protection to fix this issue.

Also change confusing add_timer variable with stop_timer boolean.

syzbot report:

BUG: KASAN: slab-use-after-free in __timer_delete_sync+0x372/0x3f0 kernel/time/timer.c:1616
Read of size 4 at addr ffff8880311e4150 by task kworker/1:1/44

CPU: 1 UID: 0 PID: 44 Comm: kworker/1:1 Not tainted syzkaller #0 PREEMPT_{RT,(full)}
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: events mptcp_worker
Call Trace:
 <TASK>
  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
  print_address_description mm/kasan/report.c:378 [inline]
  print_report+0xca/0x240 mm/kasan/report.c:482
  kasan_report+0x118/0x150 mm/kasan/report.c:595
  __timer_delete_sync+0x372/0x3f0 kernel/time/timer.c:1616
  sk_stop_timer_sync+0x1b/0x90 net/core/sock.c:3631
  mptcp_pm_del_add_timer+0x283/0x310 net/mptcp/pm.c:362
  mptcp_incoming_options+0x1357/0x1f60 net/mptcp/options.c:1174
  tcp_data_queue+0xca/0x6450 net/ipv4/tcp_input.c:5361
  tcp_rcv_established+0x1335/0x2670 net/ipv4/tcp_input.c:6441
  tcp_v4_do_rcv+0x98b/0xbf0 net/ipv4/tcp_ipv4.c:1931
  tcp_v4_rcv+0x252a/0x2dc0 net/ipv4/tcp_ipv4.c:2374
  ip_protocol_deliver_rcu+0x221/0x440 net/ipv4/ip_input.c:205
  ip_local_deliver_finish+0x3bb/0x6f0 net/ipv4/ip_input.c:239
  NF_HOOK+0x30c/0x3a0 include/linux/netfilter.h:318
  NF_HOOK+0x30c/0x3a0 include/linux/netfilter.h:318
  __netif_receive_skb_one_core net/core/dev.c:6079 [inline]
  __netif_receive_skb+0x143/0x380 net/core/dev.c:6192
  process_backlog+0x31e/0x900 net/core/dev.c:6544
  __napi_poll+0xb6/0x540 net/core/dev.c:7594
  napi_poll net/core/dev.c:7657 [inline]
  net_rx_action+0x5f7/0xda0 net/core/dev.c:7784
  handle_softirqs+0x22f/0x710 kernel/softirq.c:622
  __do_softirq kernel/softirq.c:656 [inline]
  __local_bh_enable_ip+0x1a0/0x2e0 kernel/softirq.c:302
  mptcp_pm_send_ack net/mptcp/pm.c:210 [inline]
 mptcp_pm_addr_send_ack+0x41f/0x500 net/mptcp/pm.c:-1
  mptcp_pm_worker+0x174/0x320 net/mptcp/pm.c:1002
  mptcp_worker+0xd5/0x1170 net/mptcp/protocol.c:2762
  process_one_work kernel/workqueue.c:3263 [inline]
  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
  kthread+0x711/0x8a0 kernel/kthread.c:463
  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 44:
  kasan_save_stack mm/kasan/common.c:56 [inline]
  kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
  poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
  __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:417
  kasan_kmalloc include/linux/kasan.h:262 [inline]
  __kmalloc_cache_noprof+0x1ef/0x6c0 mm/slub.c:5748
  kmalloc_noprof include/linux/slab.h:957 [inline]
  mptcp_pm_alloc_anno_list+0x104/0x460 net/mptcp/pm.c:385
  mptcp_pm_create_subflow_or_signal_addr+0xf9d/0x1360 net/mptcp/pm_kernel.c:355
  mptcp_pm_nl_fully_established net/mptcp/pm_kernel.c:409 [inline]
  __mptcp_pm_kernel_worker+0x417/0x1ef0 net/mptcp/pm_kernel.c:1529
  mptcp_pm_worker+0x1ee/0x320 net/mptcp/pm.c:1008
  mptcp_worker+0xd5/0x1170 net/mptcp/protocol.c:2762
  process_one_work kernel/workqueue.c:3263 [inline]
  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
  kthread+0x711/0x8a0 kernel/kthread.c:463
  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 6630:
  kasan_save_stack mm/kasan/common.c:56 [inline]
  kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
  __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
  kasan_save_free_info mm/kasan/kasan.h:406 [inline]
  poison_slab_object mm/kasan/common.c:252 [inline]
  __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
  kasan_slab_free include/linux/kasan.h:234 [inline]
  slab_free_hook mm/slub.c:2523 [inline]
  slab_free mm/slub.c:6611 [inline]
  kfree+0x197/0x950 mm/slub.c:6818
  mptcp_remove_anno_list_by_saddr+0x2d/0x40 net/mptcp/pm.c:158
  mptcp_pm_flush_addrs_and_subflows net/mptcp/pm_kernel.c:1209 [inline]
  mptcp_nl_flush_addrs_list net/mptcp/pm_kernel.c:1240 [inline]
  mptcp_pm_nl_flush_addrs_doit+0x593/0xbb0 net/mptcp/pm_kernel.c:1281
  genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
  genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
  netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
  netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
  netlink_unicast+0x846/0xa10 net/netlink/af_netlink.c:1346
  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
  sock_sendmsg_nosec net/socket.c:727 [inline]
  __sock_sendmsg+0x21c/0x270 net/socket.c:742
  ____sys_sendmsg+0x508/0x820 net/socket.c:2630
  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
  __sys_sendmsg net/socket.c:2716 [inline]
  __do_sys_sendmsg net/socket.c:2721 [inline]
  __se_sys_sendmsg net/socket.c:2719 [inline]
  __x64_sys_sendmsg+0x1a1/0x260 net/socket.c:2719
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Cc: stable@vger.kernel.org
Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Reported-by: syzbot+2a6fbf0f0530375968df@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/691ad3c3.a70a0220.f6df1.0004.GAE@google.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251117100745.1913963-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7fd6714f41fe7..8dbe826555d29 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -29,6 +29,7 @@ struct mptcp_pm_add_entry {
 	u8			retrans_times;
 	struct timer_list	add_timer;
 	struct mptcp_sock	*sock;
+	struct rcu_head		rcu;
 };
 
 struct pm_nl_pernet {
@@ -344,22 +345,27 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
-	struct timer_list *add_timer = NULL;
+	bool stop_timer = false;
+
+	rcu_read_lock();
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
-		add_timer = &entry->add_timer;
+		stop_timer = true;
 	}
 	if (!check_id && entry)
 		list_del(&entry->list);
 	spin_unlock_bh(&msk->pm.lock);
 
-	/* no lock, because sk_stop_timer_sync() is calling del_timer_sync() */
-	if (add_timer)
-		sk_stop_timer_sync(sk, add_timer);
+	/* Note: entry might have been removed by another thread.
+	 * We hold rcu_read_lock() to ensure it is not freed under us.
+	 */
+	if (stop_timer)
+		sk_stop_timer_sync(sk, &entry->add_timer);
 
+	rcu_read_unlock();
 	return entry;
 }
 
@@ -415,7 +421,7 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
 		sk_stop_timer_sync(sk, &entry->add_timer);
-		kfree(entry);
+		kfree_rcu(entry, rcu);
 	}
 }
 
@@ -1573,7 +1579,7 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
-		kfree(entry);
+		kfree_rcu(entry, rcu);
 		return true;
 	}
 
-- 
2.51.0


