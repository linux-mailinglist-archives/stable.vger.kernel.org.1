Return-Path: <stable+bounces-145889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D2DABF991
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3B01BC04FC
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C950821D3C9;
	Wed, 21 May 2025 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLQ7LHh6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FAD1DF75C;
	Wed, 21 May 2025 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841622; cv=none; b=UU+qQdLcL5A7kgoy9qQPSHTkCEyEcZCmG/pB6eb2Mt1p3bVR9We2g0nF19J+QoCTT/LDezSYC6Iy8euW03hYuBZer52p/wr9cqSz7086C1GWSsP0sfWG054NMf4r3TsHblDWL8gVviHFz+V7ADTYGpYdpjNqM3vYPFGXW2UhW5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841622; c=relaxed/simple;
	bh=pivfaqLbjvxiTmCHNmYRHM0reWtCukqUacXbd9qDv+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MREQuh+A5aNBbu3F16X5LdrDZDv8VHemaJv+IvfHCeAr1T8ujyzKtu6cqnea/+qSrD9fQ5d98CIxp4tly3vQ6uB3zDkhapGOh5SDos6jpehBjjo1Hvt3aZUs6FvYvFcLhGc+i2EtQtwgkWS+CabjoH+XzMSlT1phe2wnxcIhQx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLQ7LHh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5197DC4CEE7;
	Wed, 21 May 2025 15:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841622;
	bh=pivfaqLbjvxiTmCHNmYRHM0reWtCukqUacXbd9qDv+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FLQ7LHh6i6jOmYwzj14pa1emwXPUxmSvd8I35OwFuLcAfzbFvYQjPrNBe9G89WI0F
	 XO5AznfmHLxYmTdoVsXrNluH+LSt2fcrvMKbIPbTgasnViPi5L4ZC5lGA2mn5WX0Tq
	 8ksQj/7FExqUOiZY7K5TBSRiWn4i7DGPi8s7dir0KraApLJvZD167BLnQb2vvEzIEe
	 9cF+YHAOOUfdcQS3hRVkqdkPzOp/ghOi1YwjXkFex98vAaAVjto5MgUfC2wqzKJNIM
	 IhWh9xGX/tEpfDoNZYsKq3fgs5qzJJVC9r3f12EznE4uVnWcFXBPpbneszeEf6pp9P
	 u2nTTET6oht7A==
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
Cc: stable@vger.kernel.org
Subject: [PATCH v6.1 12/27] af_unix: Iterate all vertices by DFS.
Date: Wed, 21 May 2025 16:27:11 +0100
Message-ID: <20250521152920.1116756-13-lee@kernel.org>
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
index 08cc90348043..9d51d675cc9f 100644
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
index f7041fc23000..295dd1a7b8e0 100644
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
2.49.0.1143.g0be31eac6b-goog


