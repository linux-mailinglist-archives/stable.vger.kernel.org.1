Return-Path: <stable+bounces-145861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C59ABF869
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E78418850FB
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3FF215162;
	Wed, 21 May 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvOOhQiS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5437B1E5B60;
	Wed, 21 May 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839072; cv=none; b=H86nhlwSBbWY7DgiqD/Kjfy/rYEugquAIluCdS4PEiI2i2e+q3jAEPziEqUsYDtxgUJW5lUZsP/Y2jZ32cHEdYgagRzBUrdpxA91cUtbEW88kVE9LZcOMbtD0sHWiT139kuf7cVuWbrOqTZ8ajqI+RPAIbzpqvr2RdqTinQ+jHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839072; c=relaxed/simple;
	bh=Z9SeKw4LkfELpZ/nUOPNNN0qUN4nI9p96rYaieXj5Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvYSyWFAtiOGkaxY//oO5GuzymQNpi2EpXqGKumdWRoyRBY6szw8I4O7DV9zNz4qlF8VVGjsFDfi6COSZElbisUQ1Uv9kmD8Cz90omgcDUtTHHVaaaP91nMHZpssr1ihOtf8my1aVDrfPoQFHAziPd2tVrtUxPAzWwmwRIFXeMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvOOhQiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDDDC4CEF1;
	Wed, 21 May 2025 14:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747839072;
	bh=Z9SeKw4LkfELpZ/nUOPNNN0qUN4nI9p96rYaieXj5Sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RvOOhQiSh4bZ4gRUU/f8R+xs1V7LQWEsvyt/J/DeS/rUnoXZqkZIfRVJAoMw/Ix+l
	 XIiNapFvBpWS6KrV+TtZ8Kh0CZvfitlzK9RuJTjXO8QIIHq+4vs/urF9mZNwnUT2CG
	 OYXDutEhRMdsjGLGT4dlaw3gKm0J7cAqDh9JOuQhLPKLaJfKFmOwFvr1+C1arscMjC
	 pqEO+DDnsnbD+9U6BYMITTKEn3IHUHPI9Hd50FLAAI9Zq5087hccZIhXEHlw9HS6PB
	 XqqIydYHHX8rlJ1rvtBrf1OVxpO6zQv47KZ63xCmlsizo9ZG3WG99yWxOet1+2rvCL
	 bMrjzPIeBJncg==
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
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v6.6 14/26] af_unix: Fix up unix_edge.successor for embryo socket.
Date: Wed, 21 May 2025 14:45:22 +0000
Message-ID: <20250521144803.2050504-15-lee@kernel.org>
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

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit dcf70df2048d27c5d186f013f101a4aefd63aa41 ]

To garbage collect inflight AF_UNIX sockets, we must define the
cyclic reference appropriately.  This is a bit tricky if the loop
consists of embryo sockets.

Suppose that the fd of AF_UNIX socket A is passed to D and the fd B
to C and that C and D are embryo sockets of A and B, respectively.
It may appear that there are two separate graphs, A (-> D) and
B (-> C), but this is not correct.

     A --. .-- B
          X
     C <-' `-> D

Now, D holds A's refcount, and C has B's refcount, so unix_release()
will never be called for A and B when we close() them.  However, no
one can call close() for D and C to free skbs holding refcounts of A
and B because C/D is in A/B's receive queue, which should have been
purged by unix_release() for A and B.

So, here's another type of cyclic reference.  When a fd of an AF_UNIX
socket is passed to an embryo socket, the reference is indirectly held
by its parent listening socket.

  .-> A                            .-> B
  |   `- sk_receive_queue          |   `- sk_receive_queue
  |      `- skb                    |      `- skb
  |         `- sk == C             |         `- sk == D
  |            `- sk_receive_queue |           `- sk_receive_queue
  |               `- skb +---------'               `- skb +-.
  |                                                         |
  `---------------------------------------------------------'

Technically, the graph must be denoted as A <-> B instead of A (-> D)
and B (-> C) to find such a cyclic reference without touching each
socket's receive queue.

  .-> A --. .-- B <-.
  |        X        |  ==  A <-> B
  `-- C <-' `-> D --'

We apply this fixup during GC by fetching the real successor by
unix_edge_successor().

When we call accept(), we clear unix_sock.listener under unix_gc_lock
not to confuse GC.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20240325202425.60930-9-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit dcf70df2048d27c5d186f013f101a4aefd63aa41)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/net/af_unix.h |  1 +
 net/unix/af_unix.c    |  2 +-
 net/unix/garbage.c    | 20 +++++++++++++++++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index d6b755b254a17..9d92dd608fc42 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -24,6 +24,7 @@ void unix_inflight(struct user_struct *user, struct file *fp);
 void unix_notinflight(struct user_struct *user, struct file *fp);
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver);
 void unix_del_edges(struct scm_fp_list *fpl);
+void unix_update_edges(struct unix_sock *receiver);
 int unix_prepare_fpl(struct scm_fp_list *fpl);
 void unix_destroy_fpl(struct scm_fp_list *fpl);
 void unix_gc(void);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 4d4c035ba626d..93316e9efc532 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1705,7 +1705,7 @@ static int unix_accept(struct socket *sock, struct socket *newsock, int flags,
 	}
 
 	tsk = skb->sk;
-	unix_sk(tsk)->listener = NULL;
+	unix_update_edges(unix_sk(tsk));
 	skb_free_datagram(sk, skb);
 	wake_up_interruptible(&unix_sk(sk)->peer_wait);
 
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index cdeff548e1307..6ff7e0b5c5444 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -101,6 +101,17 @@ struct unix_sock *unix_get_socket(struct file *filp)
 	return NULL;
 }
 
+static struct unix_vertex *unix_edge_successor(struct unix_edge *edge)
+{
+	/* If an embryo socket has a fd,
+	 * the listener indirectly holds the fd's refcnt.
+	 */
+	if (edge->successor->listener)
+		return unix_sk(edge->successor->listener)->vertex;
+
+	return edge->successor->vertex;
+}
+
 static LIST_HEAD(unix_unvisited_vertices);
 
 enum unix_vertex_index {
@@ -209,6 +220,13 @@ void unix_del_edges(struct scm_fp_list *fpl)
 	fpl->inflight = false;
 }
 
+void unix_update_edges(struct unix_sock *receiver)
+{
+	spin_lock(&unix_gc_lock);
+	receiver->listener = NULL;
+	spin_unlock(&unix_gc_lock);
+}
+
 int unix_prepare_fpl(struct scm_fp_list *fpl)
 {
 	struct unix_vertex *vertex;
@@ -268,7 +286,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 
 	/* Explore neighbour vertices (receivers of the current vertex's fd). */
 	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
-		struct unix_vertex *next_vertex = edge->successor->vertex;
+		struct unix_vertex *next_vertex = unix_edge_successor(edge);
 
 		if (!next_vertex)
 			continue;
-- 
2.49.0.1112.g889b7c5bd8-goog


