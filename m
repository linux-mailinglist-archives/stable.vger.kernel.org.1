Return-Path: <stable+bounces-145892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E52FABF99E
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B3A18986E9
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B02224B0D;
	Wed, 21 May 2025 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1chswUg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DFF2206AC;
	Wed, 21 May 2025 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841643; cv=none; b=DzRG0F49+Egji0E0NW08oqraEPJ4n1dQ11RLBvPc99HHpaZEgut6TrWKYlEa7QzqqO1PTSwZfCHJazKE1Wh+99jcnWnPRTu+D3LDhjx2VOH92QLslRZXznIuZ9lkk58EgIjRjpdchIr6vh2l/iYuU6C5qxfVMY+bcYq5c7bTWMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841643; c=relaxed/simple;
	bh=eSfVZgrHS8VynzF1LFlvxACfI79Y+FAdwgbNMxCAqr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6MIwot9rImO+bQ7HZKwRv1gHiSu+8MntI40UGGfZ/7GS/oMOB86oBu8GL26Ay2sfg9/nWhvNiVR21jYyPwEpZoZc7xwRDxiIBb7TRdDbZXy+5RW6AzubyFpsK0ABcT1Lf4ZRZAK12NdPSrarWhokPCuoYh6ezDtfmNgFXrisHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1chswUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1EAC4CEE4;
	Wed, 21 May 2025 15:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841643;
	bh=eSfVZgrHS8VynzF1LFlvxACfI79Y+FAdwgbNMxCAqr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A1chswUgNTH/Z4k/hLqCfpeiTQHBkTnA5bCOf20Eqv4/t1EETnCHW8VO8kL3VDhtW
	 mBC79jmkest8lVadn6Gdm5GrOvSvpc4zAnSyODw1WNhnnxYXZGy6R48F5RNAaZCvaA
	 GE8UVRtqR2IVH/IXBjenBv95RD+GoYNh5nBxXE4BxwfSeD4Hk9321RF37NYGfQtDck
	 IYhOnUtcrHkmigDy952f1FUs6Vt9kS5pjaES23ThaasuvzxvNj7FrVaEGEH1PD0L2I
	 2wLRn4S4KiyMUTd/B9QwH5crYbTejxOcCl+VzkDhDrULTsloKBYBNnaS2YrLNMedjY
	 qU0KiBFg3PDcg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Rao Shoaib <Rao.Shoaib@oracle.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v6.1 15/27] af_unix: Fix up unix_edge.successor for embryo socket.
Date: Wed, 21 May 2025 16:27:14 +0100
Message-ID: <20250521152920.1116756-16-lee@kernel.org>
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
index 624fea657518..d7f589e14467 100644
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
index 6075ecbe40b2..4d8b2b2b9a70 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1679,7 +1679,7 @@ static int unix_accept(struct socket *sock, struct socket *newsock, int flags,
 	}
 
 	tsk = skb->sk;
-	unix_sk(tsk)->listener = NULL;
+	unix_update_edges(unix_sk(tsk));
 	skb_free_datagram(sk, skb);
 	wake_up_interruptible(&unix_sk(sk)->peer_wait);
 
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index cdeff548e130..6ff7e0b5c544 100644
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
2.49.0.1143.g0be31eac6b-goog


