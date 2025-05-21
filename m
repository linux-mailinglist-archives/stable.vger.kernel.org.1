Return-Path: <stable+bounces-145901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 867F1ABF9BC
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18CC1897E57
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559BA221730;
	Wed, 21 May 2025 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZV+/0pE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2011EB9E1;
	Wed, 21 May 2025 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841709; cv=none; b=LS4/Q8FZtZQM8KTA1nXKCSdEldVFRTTnDSFyeQsITPb3vOsr3ZZyZtzkUofFhxBL+oVlRp8Jm+MB4rbP+vrR/YzNr05K6eVZ+ascLdAb5KoIdUdWXBxq0IEESZfXSYkI393qhiYgeuJrkoSkHKAceHjnf9YDEcLzDaquHlvmuc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841709; c=relaxed/simple;
	bh=PT5Ok3WA0PklFQdEs6v5dKeUByJAMYK5CcQzWgFX76s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OI43OAxrc2FzDiPeHgTAmxMqcPgRd/7lwaLnnDdqQWrG81LlrSgZlJs4Y6954+jb6DwooLkF3uRS56Xan9FblMHZdt8ToAhdLBf1bvUuKw75dl9TFmUt75SN4JvR0q9wqbwCYsFI2Roa/hGQL6lT7bgOjnroy2jkj0touZsPcUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZV+/0pE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584DFC4CEEB;
	Wed, 21 May 2025 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841708;
	bh=PT5Ok3WA0PklFQdEs6v5dKeUByJAMYK5CcQzWgFX76s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZV+/0pEU7Ph/QKkON90pB+6Kxfc4TKYUYzKBuBNk+FMYPVKbxidM/Jq1GRkzNvJ9
	 zVBf9QModPwznwI6+oorV5ewq4eu++IBMIoJv4b4u1X/xchuQgoh5ya7GlKai5Ooao
	 MQRrYRcR4dSSwNqXUCGMH6cr0FjQUwfdS0xI3CW0d0KqYFIZkYBK9nUXLI7rKyJFrC
	 5FyfwMNS/Ak8P1mBiWi3U2zWivoI4XMqjOJvcxjGTJCWC357KSWAs0UDVcbQufOLPS
	 kPXRVZj5nDKlvosKcG7aLK2L7paLgjbTO4CyqIVynooESen6QZsOiEu/N7LKSSzcPM
	 DCjs7g2cPmcgQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Sasha Levin <sashal@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Rao Shoaib <Rao.Shoaib@oracle.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	syzbot+f3f3eef1d2100200e593@syzkaller.appspotmail.com
Subject: [PATCH v6.1 24/27] af_unix: Don't access successor in unix_del_edges() during GC.
Date: Wed, 21 May 2025 16:27:23 +0100
Message-ID: <20250521152920.1116756-25-lee@kernel.org>
X-Mailer: git-send-email 2.49.0.1143.g0be31eac6b-goog
In-Reply-To: <20250521152920.1116756-1-lee@kernel.org>
References: <20250521152920.1116756-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 1af2dface5d286dd1f2f3405a0d6fa9f2c8fb998 ]

syzbot reported use-after-free in unix_del_edges().  [0]

What the repro does is basically repeat the following quickly.

  1. pass a fd of an AF_UNIX socket to itself

    socketpair(AF_UNIX, SOCK_DGRAM, 0, [3, 4]) = 0
    sendmsg(3, {..., msg_control=[{cmsg_len=20, cmsg_level=SOL_SOCKET,
                                   cmsg_type=SCM_RIGHTS, cmsg_data=[4]}], ...}, 0) = 0

  2. pass other fds of AF_UNIX sockets to the socket above

    socketpair(AF_UNIX, SOCK_SEQPACKET, 0, [5, 6]) = 0
    sendmsg(3, {..., msg_control=[{cmsg_len=48, cmsg_level=SOL_SOCKET,
                                   cmsg_type=SCM_RIGHTS, cmsg_data=[5, 6]}], ...}, 0) = 0

  3. close all sockets

Here, two skb are created, and every unix_edge->successor is the first
socket.  Then, __unix_gc() will garbage-collect the two skb:

  (a) free skb with self-referencing fd
  (b) free skb holding other sockets

After (a), the self-referencing socket will be scheduled to be freed
later by the delayed_fput() task.

syzbot repeated the sequences above (1. ~ 3.) quickly and triggered
the task concurrently while GC was running.

So, at (b), the socket was already freed, and accessing it was illegal.

unix_del_edges() accesses the receiver socket as edge->successor to
optimise GC.  However, we should not do it during GC.

Garbage-collecting sockets does not change the shape of the rest
of the graph, so we need not call unix_update_graph() to update
unix_graph_grouped when we purge skb.

However, if we clean up all loops in the unix_walk_scc_fast() path,
unix_graph_maybe_cyclic remains unchanged (true), and __unix_gc()
will call unix_walk_scc_fast() continuously even though there is no
socket to garbage-collect.

To keep that optimisation while fixing UAF, let's add the same
updating logic of unix_graph_maybe_cyclic in unix_walk_scc_fast()
as done in unix_walk_scc() and __unix_walk_scc().

Note that when unix_del_edges() is called from other places, the
receiver socket is always alive:

  - sendmsg: the successor's sk_refcnt is bumped by sock_hold()
             unix_find_other() for SOCK_DGRAM, connect() for SOCK_STREAM

  - recvmsg: the successor is the receiver, and its fd is alive

[0]:
BUG: KASAN: slab-use-after-free in unix_edge_successor net/unix/garbage.c:109 [inline]
BUG: KASAN: slab-use-after-free in unix_del_edge net/unix/garbage.c:165 [inline]
BUG: KASAN: slab-use-after-free in unix_del_edges+0x148/0x630 net/unix/garbage.c:237
Read of size 8 at addr ffff888079c6e640 by task kworker/u8:6/1099

CPU: 0 PID: 1099 Comm: kworker/u8:6 Not tainted 6.9.0-rc4-next-20240418-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events_unbound __unix_gc
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 unix_edge_successor net/unix/garbage.c:109 [inline]
 unix_del_edge net/unix/garbage.c:165 [inline]
 unix_del_edges+0x148/0x630 net/unix/garbage.c:237
 unix_destroy_fpl+0x59/0x210 net/unix/garbage.c:298
 unix_detach_fds net/unix/af_unix.c:1811 [inline]
 unix_destruct_scm+0x13e/0x210 net/unix/af_unix.c:1826
 skb_release_head_state+0x100/0x250 net/core/skbuff.c:1127
 skb_release_all net/core/skbuff.c:1138 [inline]
 __kfree_skb net/core/skbuff.c:1154 [inline]
 kfree_skb_reason+0x16d/0x3b0 net/core/skbuff.c:1190
 __skb_queue_purge_reason include/linux/skbuff.h:3251 [inline]
 __skb_queue_purge include/linux/skbuff.h:3256 [inline]
 __unix_gc+0x1732/0x1830 net/unix/garbage.c:575
 process_one_work kernel/workqueue.c:3218 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 14427:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3897 [inline]
 slab_alloc_node mm/slub.c:3957 [inline]
 kmem_cache_alloc_noprof+0x135/0x290 mm/slub.c:3964
 sk_prot_alloc+0x58/0x210 net/core/sock.c:2074
 sk_alloc+0x38/0x370 net/core/sock.c:2133
 unix_create1+0xb4/0x770
 unix_create+0x14e/0x200 net/unix/af_unix.c:1034
 __sock_create+0x490/0x920 net/socket.c:1571
 sock_create net/socket.c:1622 [inline]
 __sys_socketpair+0x33e/0x720 net/socket.c:1773
 __do_sys_socketpair net/socket.c:1822 [inline]
 __se_sys_socketpair net/socket.c:1819 [inline]
 __x64_sys_socketpair+0x9b/0xb0 net/socket.c:1819
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 1805:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2190 [inline]
 slab_free mm/slub.c:4393 [inline]
 kmem_cache_free+0x145/0x340 mm/slub.c:4468
 sk_prot_free net/core/sock.c:2114 [inline]
 __sk_destruct+0x467/0x5f0 net/core/sock.c:2208
 sock_put include/net/sock.h:1948 [inline]
 unix_release_sock+0xa8b/0xd20 net/unix/af_unix.c:665
 unix_release+0x91/0xc0 net/unix/af_unix.c:1049
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x406/0x8b0 fs/file_table.c:422
 delayed_fput+0x59/0x80 fs/file_table.c:445
 process_one_work kernel/workqueue.c:3218 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888079c6e000
 which belongs to the cache UNIX of size 1920
The buggy address is located 1600 bytes inside of
 freed 1920-byte region [ffff888079c6e000, ffff888079c6e780)

Reported-by: syzbot+f3f3eef1d2100200e593@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f3f3eef1d2100200e593
Fixes: 77e5593aebba ("af_unix: Skip GC if no cycle exists.")
Fixes: fd86344823b5 ("af_unix: Try not to hold unix_gc_lock during accept().")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20240419235102.31707-1-kuniyu@amazon.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
(cherry picked from commit 1af2dface5d286dd1f2f3405a0d6fa9f2c8fb998)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/unix/garbage.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 95240a59808f..d76450133e4f 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -158,11 +158,14 @@ static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 	unix_update_graph(unix_edge_successor(edge));
 }
 
+static bool gc_in_progress;
+
 static void unix_del_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 {
 	struct unix_vertex *vertex = edge->predecessor->vertex;
 
-	unix_update_graph(unix_edge_successor(edge));
+	if (!gc_in_progress)
+		unix_update_graph(unix_edge_successor(edge));
 
 	list_del(&edge->vertex_entry);
 	vertex->out_degree--;
@@ -237,8 +240,10 @@ void unix_del_edges(struct scm_fp_list *fpl)
 		unix_del_edge(fpl, edge);
 	} while (i < fpl->count_unix);
 
-	receiver = fpl->edges[0].successor;
-	receiver->scm_stat.nr_unix_fds -= fpl->count_unix;
+	if (!gc_in_progress) {
+		receiver = fpl->edges[0].successor;
+		receiver->scm_stat.nr_unix_fds -= fpl->count_unix;
+	}
 	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - fpl->count_unix);
 out:
 	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight - fpl->count);
@@ -526,6 +531,8 @@ static void unix_walk_scc(struct sk_buff_head *hitlist)
 
 static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 {
+	unix_graph_maybe_cyclic = false;
+
 	while (!list_empty(&unix_unvisited_vertices)) {
 		struct unix_vertex *vertex;
 		struct list_head scc;
@@ -543,6 +550,8 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 
 		if (scc_dead)
 			unix_collect_skb(&scc, hitlist);
+		else if (!unix_graph_maybe_cyclic)
+			unix_graph_maybe_cyclic = unix_scc_cyclic(&scc);
 
 		list_del(&scc);
 	}
@@ -550,8 +559,6 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 }
 
-static bool gc_in_progress;
-
 static void __unix_gc(struct work_struct *work)
 {
 	struct sk_buff_head hitlist;
-- 
2.49.0.1143.g0be31eac6b-goog


