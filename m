Return-Path: <stable+bounces-145873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2560FABF8A6
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0144A8C66E1
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B67227EB9;
	Wed, 21 May 2025 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H56f4tLY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B592220F46;
	Wed, 21 May 2025 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839166; cv=none; b=T57xNlpmmSwUKUIcwPedOtec7bLPowr8RgXYVoYwEWzebjvFB2IM1g5g7w1F14shz3MJq3v8PprvLTxDf8BTXQrac5IZn2X6WhWdFKVPqol7WWKnf6cY4xx75+9PQhX2ayAZu5jC8ybxI6rWZ9W2ySWtpuo2GhV1iQOrYtaHglE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839166; c=relaxed/simple;
	bh=aXs55NlSVM3VIwWtlSAUIA7UYBiL2MuTfKtNoqtLmI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMb0s8FDE45Bjp6MM5bhx8oRvpd5R/b37EV88/8U0Blw7tyvHTK+kMnYFCtuqSdeiXwHcyHs6qTLGww9LMytwGh0LxJDXqI/G0JRGE+HB8uYNNDYlZKwhDISKWV8KS5RXxbo/8LpB+7z0N0BoYVv/G7u9Vp3NUUEOadwrnf/u9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H56f4tLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD83C4CEE4;
	Wed, 21 May 2025 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747839166;
	bh=aXs55NlSVM3VIwWtlSAUIA7UYBiL2MuTfKtNoqtLmI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H56f4tLYqma46ZytPEcHP/iUlcHm9kwD74+sSJtVo1B/BpTLNSiTJwP6RK2u6rBBm
	 6MzMVUQ00WPYh4fNrqh8dc/4bA3+cGRYw4ho8m6UlnWZBFd86VxVCusmYQLc6xv6Dj
	 Bv4blWZXwft9yy8+V1HKJNdQcLycN+o9LBUpUo9zuaJ73P9S3WOLoAVXVdvxbY/JOY
	 1S0Ba3XAKQzVNGrBW+sdZdAnMVMnoB+2hYznn3sVCP32EelvuYskW3Fvg9cYoaVc3P
	 jrE3JsoSVLo3aaOJUS5ICN1vqCq4wQ4YStxgXv9GEhlr266zkjh1okhX1xe3xhS1nh
	 4Ek1fuG0o7WcQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Rao Shoaib <Rao.Shoaib@oracle.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH v6.6 26/26] af_unix: Fix uninit-value in __unix_walk_scc()
Date: Wed, 21 May 2025 14:45:34 +0000
Message-ID: <20250521144803.2050504-27-lee@kernel.org>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
In-Reply-To: <20250521144803.2050504-1-lee@kernel.org>
References: <20250521144803.2050504-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shigeru Yoshida <syoshida@redhat.com>

[ Upstream commit 927fa5b3e4f52e0967bfc859afc98ad1c523d2d5 ]

KMSAN reported uninit-value access in __unix_walk_scc() [1].

In the list_for_each_entry_reverse() loop, when the vertex's index
equals it's scc_index, the loop uses the variable vertex as a
temporary variable that points to a vertex in scc. And when the loop
is finished, the variable vertex points to the list head, in this case
scc, which is a local variable on the stack (more precisely, it's not
even scc and might underflow the call stack of __unix_walk_scc():
container_of(&scc, struct unix_vertex, scc_entry)).

However, the variable vertex is used under the label prev_vertex. So
if the edge_stack is not empty and the function jumps to the
prev_vertex label, the function will access invalid data on the
stack. This causes the uninit-value access issue.

Fix this by introducing a new temporary variable for the loop.

[1]
BUG: KMSAN: uninit-value in __unix_walk_scc net/unix/garbage.c:478 [inline]
BUG: KMSAN: uninit-value in unix_walk_scc net/unix/garbage.c:526 [inline]
BUG: KMSAN: uninit-value in __unix_gc+0x2589/0x3c20 net/unix/garbage.c:584
 __unix_walk_scc net/unix/garbage.c:478 [inline]
 unix_walk_scc net/unix/garbage.c:526 [inline]
 __unix_gc+0x2589/0x3c20 net/unix/garbage.c:584
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xade/0x1bf0 kernel/workqueue.c:3312
 worker_thread+0xeb6/0x15b0 kernel/workqueue.c:3393
 kthread+0x3c4/0x530 kernel/kthread.c:389
 ret_from_fork+0x6e/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 unix_walk_scc net/unix/garbage.c:526 [inline]
 __unix_gc+0x2adf/0x3c20 net/unix/garbage.c:584
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xade/0x1bf0 kernel/workqueue.c:3312
 worker_thread+0xeb6/0x15b0 kernel/workqueue.c:3393
 kthread+0x3c4/0x530 kernel/kthread.c:389
 ret_from_fork+0x6e/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Local variable entries created at:
 ref_tracker_free+0x48/0xf30 lib/ref_tracker.c:222
 netdev_tracker_free include/linux/netdevice.h:4058 [inline]
 netdev_put include/linux/netdevice.h:4075 [inline]
 dev_put include/linux/netdevice.h:4101 [inline]
 update_gid_event_work_handler+0xaa/0x1b0 drivers/infiniband/core/roce_gid_mgmt.c:813

CPU: 1 PID: 12763 Comm: kworker/u8:31 Not tainted 6.10.0-rc4-00217-g35bb670d65fc #32
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
Workqueue: events_unbound __unix_gc

Fixes: 3484f063172d ("af_unix: Detect Strongly Connected Components.")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20240702160428.10153-1-syoshida@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 927fa5b3e4f52e0967bfc859afc98ad1c523d2d5)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/unix/garbage.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index dfe94a90ece40..23efb78fe9ef4 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -476,6 +476,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
 	}
 
 	if (vertex->index == vertex->scc_index) {
+		struct unix_vertex *v;
 		struct list_head scc;
 		bool scc_dead = true;
 
@@ -486,15 +487,15 @@ static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
 		 */
 		__list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
 
-		list_for_each_entry_reverse(vertex, &scc, scc_entry) {
+		list_for_each_entry_reverse(v, &scc, scc_entry) {
 			/* Don't restart DFS from this vertex in unix_walk_scc(). */
-			list_move_tail(&vertex->entry, &unix_visited_vertices);
+			list_move_tail(&v->entry, &unix_visited_vertices);
 
 			/* Mark vertex as off-stack. */
-			vertex->index = unix_vertex_grouped_index;
+			v->index = unix_vertex_grouped_index;
 
 			if (scc_dead)
-				scc_dead = unix_vertex_dead(vertex);
+				scc_dead = unix_vertex_dead(v);
 		}
 
 		if (scc_dead)
-- 
2.49.0.1112.g889b7c5bd8-goog


