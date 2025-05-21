Return-Path: <stable+bounces-145858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C516CABF853
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E1F1BC6B97
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD92B20FA98;
	Wed, 21 May 2025 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j11N1BJ2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751DD1E32D3;
	Wed, 21 May 2025 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839049; cv=none; b=Gfd4685iiz+IDwAcJaBAbA8i/4VqPHDfQa9PTmn0tOi6sKFeYBSqQb2VEfUsDebBxYvlWuO4UkZ4GuN2k8e3B2t4TITjFl6Wj4tIibX8CarW3YLBAcYM03n+S0v5AwsD4cKlpe9Zm3vc1SGOVoHeANopFuTg1lbmLKBJrnpVOws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839049; c=relaxed/simple;
	bh=u2ZzaYvbGgy2F20uevAjxXFAtKBM0vNIjQjeYH5pvL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iy4hB7m7PpE2r25gzhCebZHyzeMIwwKEdo8n3SdOLJU5TISodaUcQS9XbtmVhFuFrtqptgUnv4vUQPZhJfOrueoHD4M9oWFECVh2soZm7WTTDA9gvu6GcXbVXInagekvrxY4LxpGJoEUGpKaekNphldQpbmjbD9vAxfQKEsN/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j11N1BJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC69C4CEE4;
	Wed, 21 May 2025 14:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747839049;
	bh=u2ZzaYvbGgy2F20uevAjxXFAtKBM0vNIjQjeYH5pvL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j11N1BJ2hXLNq+8QqZ4ddOPxS22i0lpYjtX7HVLZm0qD7H1FBYDYING4v5N+EDY/C
	 50artXd5IGCohx3DqnjnzmdqNcScYS10rlsHdDS2M569NSbomGxi1HtjPZPL2SdYsd
	 utBulrmsDO10q6PNKctb5JCi7+UgAVQCGRCW0KNVDnTWfS80TzVChWQjCWJbfHF//j
	 ngfGA7jGGauQ0A7h8iz43iDf/Jm3+8qaCricg0wCZqZFfMCOo72zr/P3IUrxlIARlU
	 w15IDnUgKNlKenLXtYEZUSuFUsMnDDWds8JJeaLSg4ru05iGBWscsJj/Cldbg+L2dn
	 33+ay0T3oJLvA==
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
Cc: stable@vger.kernel.org
Subject: [PATCH v6.6 11/26] af_unix: Iterate all vertices by DFS.
Date: Wed, 21 May 2025 14:45:19 +0000
Message-ID: <20250521144803.2050504-12-lee@kernel.org>
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

[ Upstream commit 6ba76fd2848e107594ea4f03b737230f74bc23ea ]

The new GC will use a depth first search graph algorithm to find
cyclic references.  The algorithm visits every vertex exactly once.

Here, we implement the DFS part without recursion so that no one
can abuse it.

unix_walk_scc() marks every vertex unvisited by initialising index
as UNIX_VERTEX_INDEX_UNVISITED and iterates inflight vertices in
unix_unvisited_vertices and call __unix_walk_scc() to start DFS from
an arbitrary vertex.

__unix_walk_scc() iterates all edges starting from the vertex and
explores the neighbour vertices with DFS using edge_stack.

After visiting all neighbours, __unix_walk_scc() moves the visited
vertex to unix_visited_vertices so that unix_walk_scc() will not
restart DFS from the visited vertex.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20240325202425.60930-6-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 6ba76fd2848e107594ea4f03b737230f74bc23ea)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/net/af_unix.h |  2 ++
 net/unix/garbage.c    | 74 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index affcb990f95e2..9198735a6acb0 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -33,12 +33,14 @@ struct unix_vertex {
 	struct list_head edges;
 	struct list_head entry;
 	unsigned long out_degree;
+	unsigned long index;
 };
 
 struct unix_edge {
 	struct unix_sock *predecessor;
 	struct unix_sock *successor;
 	struct list_head vertex_entry;
+	struct list_head stack_entry;
 };
 
 struct sock *unix_peer_get(struct sock *sk);
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index f7041fc230008..295dd1a7b8e0f 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -103,6 +103,11 @@ struct unix_sock *unix_get_socket(struct file *filp)
 
 static LIST_HEAD(unix_unvisited_vertices);
 
+enum unix_vertex_index {
+	UNIX_VERTEX_INDEX_UNVISITED,
+	UNIX_VERTEX_INDEX_START,
+};
+
 static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 {
 	struct unix_vertex *vertex = edge->predecessor->vertex;
@@ -241,6 +246,73 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
 	unix_free_vertices(fpl);
 }
 
+static LIST_HEAD(unix_visited_vertices);
+
+static void __unix_walk_scc(struct unix_vertex *vertex)
+{
+	unsigned long index = UNIX_VERTEX_INDEX_START;
+	struct unix_edge *edge;
+	LIST_HEAD(edge_stack);
+
+next_vertex:
+	vertex->index = index;
+	index++;
+
+	/* Explore neighbour vertices (receivers of the current vertex's fd). */
+	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
+		struct unix_vertex *next_vertex = edge->successor->vertex;
+
+		if (!next_vertex)
+			continue;
+
+		if (next_vertex->index == UNIX_VERTEX_INDEX_UNVISITED) {
+			/* Iterative deepening depth first search
+			 *
+			 *   1. Push a forward edge to edge_stack and set
+			 *      the successor to vertex for the next iteration.
+			 */
+			list_add(&edge->stack_entry, &edge_stack);
+
+			vertex = next_vertex;
+			goto next_vertex;
+
+			/*   2. Pop the edge directed to the current vertex
+			 *      and restore the ancestor for backtracking.
+			 */
+prev_vertex:
+			edge = list_first_entry(&edge_stack, typeof(*edge), stack_entry);
+			list_del_init(&edge->stack_entry);
+
+			vertex = edge->predecessor->vertex;
+		}
+	}
+
+	/* Don't restart DFS from this vertex in unix_walk_scc(). */
+	list_move_tail(&vertex->entry, &unix_visited_vertices);
+
+	/* Need backtracking ? */
+	if (!list_empty(&edge_stack))
+		goto prev_vertex;
+}
+
+static void unix_walk_scc(void)
+{
+	struct unix_vertex *vertex;
+
+	list_for_each_entry(vertex, &unix_unvisited_vertices, entry)
+		vertex->index = UNIX_VERTEX_INDEX_UNVISITED;
+
+	/* Visit every vertex exactly once.
+	 * __unix_walk_scc() moves visited vertices to unix_visited_vertices.
+	 */
+	while (!list_empty(&unix_unvisited_vertices)) {
+		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
+		__unix_walk_scc(vertex);
+	}
+
+	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
+}
+
 static LIST_HEAD(gc_candidates);
 static LIST_HEAD(gc_inflight_list);
 
@@ -388,6 +460,8 @@ static void __unix_gc(struct work_struct *work)
 
 	spin_lock(&unix_gc_lock);
 
+	unix_walk_scc();
+
 	/* First, select candidates for garbage collection.  Only
 	 * in-flight sockets are considered, and from those only ones
 	 * which don't have any external reference.
-- 
2.49.0.1112.g889b7c5bd8-goog


