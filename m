Return-Path: <stable+bounces-145863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1440EABF85C
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3B55018A5
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F8B1EB18D;
	Wed, 21 May 2025 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+FYoWCV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3833C219A6B;
	Wed, 21 May 2025 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839088; cv=none; b=r4RyvCuXW4wFv3DPNefB8gfX2mpM71XeqPF2Bv13AbhmG+6E8xEWEG8kHBHgnJQGPK2U1c0plaH4cRTQeonkF9v3sWV5ngf7xXWa9+KnjxYmEBC9PTpUtSaTflrerZPS9X6cEH+3HKzs7XdPU2kOpGI2TX9j0RiUMGnCr0N5vUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839088; c=relaxed/simple;
	bh=4OcnMD5UfSaRziij14tKB31fCsUtEP1azZGsr3SMlRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZ2SVzPIpHvSJO0e9ROM0QY1faGnG4g+304z3q7hQ1Ri75B5jH17l9CKHUsywb2bAfvLWLAiRV1f6bFlfcgstN/RWNbUmvQPLz6pZGsfCyzAAzEBmK6pE9VFWZitNKPsdUZMd5ThXvGifAh7R/aTpUAEWtzUUH37x+KcTFShy+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+FYoWCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A865C4CEE4;
	Wed, 21 May 2025 14:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747839087;
	bh=4OcnMD5UfSaRziij14tKB31fCsUtEP1azZGsr3SMlRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P+FYoWCVKJiW6NBDu43O3B9Lg035kqQTAtpc6A7pnda0EPiMiiSpKquf5NWCWx34j
	 ue9xwInn4GBNCrQfzuNLPAse27m+jWl8r0ds+WZsNhVLjnEHfwwc5oNx/mugwWX8ah
	 adm96WNVnkkaaNporNyYyStU7mKFH38cXEtSMqiRJWWr+Dokk5ai/PSop6h8taN2Xm
	 YBXHMdWh1Zd8XJib/8L3ro7+yx4egjf+RaE/p5XRBCgT7qEWpyXU6xthgaW026tw+y
	 E90bkkHFBbIuWND7P57RpAUQc9tY9na47vl0mtiXMyugwMK5+Zgm8iAahy/0FLkUmi
	 sz8Tz//aRUqZw==
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
Subject: [PATCH v6.6 16/26] af_unix: Skip GC if no cycle exists.
Date: Wed, 21 May 2025 14:45:24 +0000
Message-ID: <20250521144803.2050504-17-lee@kernel.org>
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

[ Upstream commit 77e5593aebba823bcbcf2c4b58b07efcd63933b8 ]

We do not need to run GC if there is no possible cyclic reference.
We use unix_graph_maybe_cyclic to decide if we should run GC.

If a fd of an AF_UNIX socket is passed to an already inflight AF_UNIX
socket, they could form a cyclic reference.  Then, we set true to
unix_graph_maybe_cyclic and later run Tarjan's algorithm to group
them into SCC.

Once we run Tarjan's algorithm, we are 100% sure whether cyclic
references exist or not.  If there is no cycle, we set false to
unix_graph_maybe_cyclic and can skip the entire garbage collection
next time.

When finalising SCC, we set true to unix_graph_maybe_cyclic if SCC
consists of multiple vertices.

Even if SCC is a single vertex, a cycle might exist as self-fd passing.
Given the corner case is rare, we detect it by checking all edges of
the vertex and set true to unix_graph_maybe_cyclic.

With this change, __unix_gc() is just a spin_lock() dance in the normal
usage.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20240325202425.60930-11-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 77e5593aebba823bcbcf2c4b58b07efcd63933b8)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/unix/garbage.c | 48 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index feae6c17b2911..8f0dc39bb72fc 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -112,6 +112,19 @@ static struct unix_vertex *unix_edge_successor(struct unix_edge *edge)
 	return edge->successor->vertex;
 }
 
+static bool unix_graph_maybe_cyclic;
+
+static void unix_update_graph(struct unix_vertex *vertex)
+{
+	/* If the receiver socket is not inflight, no cyclic
+	 * reference could be formed.
+	 */
+	if (!vertex)
+		return;
+
+	unix_graph_maybe_cyclic = true;
+}
+
 static LIST_HEAD(unix_unvisited_vertices);
 
 enum unix_vertex_index {
@@ -138,12 +151,16 @@ static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 
 	vertex->out_degree++;
 	list_add_tail(&edge->vertex_entry, &vertex->edges);
+
+	unix_update_graph(unix_edge_successor(edge));
 }
 
 static void unix_del_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 {
 	struct unix_vertex *vertex = edge->predecessor->vertex;
 
+	unix_update_graph(unix_edge_successor(edge));
+
 	list_del(&edge->vertex_entry);
 	vertex->out_degree--;
 
@@ -227,6 +244,7 @@ void unix_del_edges(struct scm_fp_list *fpl)
 void unix_update_edges(struct unix_sock *receiver)
 {
 	spin_lock(&unix_gc_lock);
+	unix_update_graph(unix_sk(receiver->listener)->vertex);
 	receiver->listener = NULL;
 	spin_unlock(&unix_gc_lock);
 }
@@ -268,6 +286,26 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
 	unix_free_vertices(fpl);
 }
 
+static bool unix_scc_cyclic(struct list_head *scc)
+{
+	struct unix_vertex *vertex;
+	struct unix_edge *edge;
+
+	/* SCC containing multiple vertices ? */
+	if (!list_is_singular(scc))
+		return true;
+
+	vertex = list_first_entry(scc, typeof(*vertex), scc_entry);
+
+	/* Self-reference or a embryo-listener circle ? */
+	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
+		if (unix_edge_successor(edge) == vertex)
+			return true;
+	}
+
+	return false;
+}
+
 static LIST_HEAD(unix_visited_vertices);
 static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
 
@@ -353,6 +391,9 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 			vertex->index = unix_vertex_grouped_index;
 		}
 
+		if (!unix_graph_maybe_cyclic)
+			unix_graph_maybe_cyclic = unix_scc_cyclic(&scc);
+
 		list_del(&scc);
 	}
 
@@ -363,6 +404,8 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 
 static void unix_walk_scc(void)
 {
+	unix_graph_maybe_cyclic = false;
+
 	/* Visit every vertex exactly once.
 	 * __unix_walk_scc() moves visited vertices to unix_visited_vertices.
 	 */
@@ -524,6 +567,9 @@ static void __unix_gc(struct work_struct *work)
 
 	spin_lock(&unix_gc_lock);
 
+	if (!unix_graph_maybe_cyclic)
+		goto skip_gc;
+
 	unix_walk_scc();
 
 	/* First, select candidates for garbage collection.  Only
@@ -633,7 +679,7 @@ static void __unix_gc(struct work_struct *work)
 
 	/* All candidates should have been detached by now. */
 	WARN_ON_ONCE(!list_empty(&gc_candidates));
-
+skip_gc:
 	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
 	WRITE_ONCE(gc_in_progress, false);
 
-- 
2.49.0.1112.g889b7c5bd8-goog


