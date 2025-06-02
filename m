Return-Path: <stable+bounces-150553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E90ACB847
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6C64C196F
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1875722A7FD;
	Mon,  2 Jun 2025 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HNmY0k2J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99CC228CB7;
	Mon,  2 Jun 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877485; cv=none; b=WMkC/Io0IFKIhoFh2WMw5O8KMWShY17+f1gLmiWc4NkyW+F3Hnop+mv8GOEiIaW6tLJUxMJDMhHdTpBw67KyH/xRCX/79qMNtsgXPjhIV4eWHo0/HDEscP2eqEvQSJisj0mQ3JywaQBddEfbhM0WUZGh+PlgJl/qtoGLR4YRsPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877485; c=relaxed/simple;
	bh=mq0+s7penHUwEqd3N0bmZGeo6lfKEIutRLiBQ5VABBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbXUIR4jGjk8Fx4/UvM23Wd7ULmDNdWg/Qy42ex7Q3tU9qc9e4NkcuQrStgefoEFsp+7E9re9BYAf5XmkzaUTpNZ9f4ReX/6h9VzPmP/WkQxOoTRxpSYf6XwAD/evY+qdyVs14ChjU69dxq0SENoP3oUbpADuma3UR18a0lsWhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HNmY0k2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328E5C4CEEB;
	Mon,  2 Jun 2025 15:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748877485;
	bh=mq0+s7penHUwEqd3N0bmZGeo6lfKEIutRLiBQ5VABBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HNmY0k2JsJc6yRhk+sunkKk17Si8KkRGhqFiuYH4exvf334+DQ0mx/LMMwu0lxY3K
	 b/pNXtrRN/Exx3ZK3kMOg5SpV/YfrNLznXjtGNL2I4/DQEZhgoAAl/FO2xovs4Y6Fg
	 5oh8qc1lVH/RzqVMPzcK7BIkmHHZ0ubIod2kfSEk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 6.1 292/325] af_unix: Iterate all vertices by DFS.
Date: Mon,  2 Jun 2025 15:49:28 +0200
Message-ID: <20250602134331.767094622@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

commit 6ba76fd2848e107594ea4f03b737230f74bc23ea upstream.

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
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/af_unix.h |    2 +
 net/unix/garbage.c    |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

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
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -103,6 +103,11 @@ struct unix_sock *unix_get_socket(struct
 
 static LIST_HEAD(unix_unvisited_vertices);
 
+enum unix_vertex_index {
+	UNIX_VERTEX_INDEX_UNVISITED,
+	UNIX_VERTEX_INDEX_START,
+};
+
 static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 {
 	struct unix_vertex *vertex = edge->predecessor->vertex;
@@ -241,6 +246,73 @@ void unix_destroy_fpl(struct scm_fp_list
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
 
@@ -388,6 +460,8 @@ static void __unix_gc(struct work_struct
 
 	spin_lock(&unix_gc_lock);
 
+	unix_walk_scc();
+
 	/* First, select candidates for garbage collection.  Only
 	 * in-flight sockets are considered, and from those only ones
 	 * which don't have any external reference.



