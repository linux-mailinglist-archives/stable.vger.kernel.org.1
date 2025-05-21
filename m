Return-Path: <stable+bounces-145859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2DCABF85A
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05062188E5A1
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A25221D8B;
	Wed, 21 May 2025 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnYQUXLB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E87C22173F;
	Wed, 21 May 2025 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839057; cv=none; b=Kt/amGIDYScZve5trAqCkaIZf0BGU5APhgwkS+qOD3rcnRmN3AIpUID/YB+AKRzvfVgwp6vJj7ycLWmV/PFwuhSZvHTTwXNoUnM4a1rZSvAV/HpQ99YLEzm3iomLdOuBDRA/eM0NxpK7EHvO91tn8ABkn9ckzRB/85wn6U3Bniw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839057; c=relaxed/simple;
	bh=qQc3vuQx4R+xhH0ECzFCqUUCufG4WSasMZ8FEbnAfWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=po59V+fJrtHlI775NqZ/ORlOO7dYomq2sgHSr/4bnMAQ7O8O72wWiUss8+4hV06jD0EFRikkG7v2zwtajqZxNQc44tWARGsRu5MhC81YDUcVZl7ZzSyLZVjqWy7MurukEE6tX++xbJunzju4UIJaOta3V066u5GQPmXUT70S7g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnYQUXLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD88C4CEE4;
	Wed, 21 May 2025 14:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747839056;
	bh=qQc3vuQx4R+xhH0ECzFCqUUCufG4WSasMZ8FEbnAfWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FnYQUXLBbZ3Mh0EoLmtj1Q95gz4MBL05bdDnb23Cj7hoSezHQAGSNJJ2hKD6DZ2/a
	 8kOUuV8V7DatKSBhgOpc/ZkI0n5vWzocxIGGAcRltAiyKnoTVKnk3chRXH/TIuqE7+
	 xSGj6WvSeoa042NetWaEyWR9yUVAQSLuuzPM8Fs4zFNLGkKM5MBMH07Roi5Z60sKeH
	 Gic2F0poJYDWSde2xxd19FmPRDJoq9+H7lNCxo2m8Miahk79xHsJkL9+FOuPycWIQd
	 cODnIz/RxEDZwzlT6e3g7nvlgW8m5c02hG/HmOh8nM3bpounGh1I3VcmJ5u4hPW4jW
	 qaOmYZO+0vBWw==
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
Subject: [PATCH v6.6 12/26] af_unix: Detect Strongly Connected Components.
Date: Wed, 21 May 2025 14:45:20 +0000
Message-ID: <20250521144803.2050504-13-lee@kernel.org>
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

[ Upstream commit 3484f063172dd88776b062046d721d7c2ae1af7c ]

In the new GC, we use a simple graph algorithm, Tarjan's Strongly
Connected Components (SCC) algorithm, to find cyclic references.

The algorithm visits every vertex exactly once using depth-first
search (DFS).

DFS starts by pushing an input vertex to a stack and assigning it
a unique number.  Two fields, index and lowlink, are initialised
with the number, but lowlink could be updated later during DFS.

If a vertex has an edge to an unvisited inflight vertex, we visit
it and do the same processing.  So, we will have vertices in the
stack in the order they appear and number them consecutively in
the same order.

If a vertex has a back-edge to a visited vertex in the stack,
we update the predecessor's lowlink with the successor's index.

After iterating edges from the vertex, we check if its index
equals its lowlink.

If the lowlink is different from the index, it shows there was a
back-edge.  Then, we go backtracking and propagate the lowlink to
its predecessor and resume the previous edge iteration from the
next edge.

If the lowlink is the same as the index, we pop vertices before
and including the vertex from the stack.  Then, the set of vertices
is SCC, possibly forming a cycle.  At the same time, we move the
vertices to unix_visited_vertices.

When we finish the algorithm, all vertices in each SCC will be
linked via unix_vertex.scc_entry.

Let's take an example.  We have a graph including five inflight
vertices (F is not inflight):

  A -> B -> C -> D -> E (-> F)
       ^         |
       `---------'

Suppose that we start DFS from C.  We will visit C, D, and B first
and initialise their index and lowlink.  Then, the stack looks like
this:

  > B = (3, 3)  (index, lowlink)
    D = (2, 2)
    C = (1, 1)

When checking B's edge to C, we update B's lowlink with C's index
and propagate it to D.

    B = (3, 1)  (index, lowlink)
  > D = (2, 1)
    C = (1, 1)

Next, we visit E, which has no edge to an inflight vertex.

  > E = (4, 4)  (index, lowlink)
    B = (3, 1)
    D = (2, 1)
    C = (1, 1)

When we leave from E, its index and lowlink are the same, so we
pop E from the stack as single-vertex SCC.  Next, we leave from
B and D but do nothing because their lowlink are different from
their index.

    B = (3, 1)  (index, lowlink)
    D = (2, 1)
  > C = (1, 1)

Then, we leave from C, whose index and lowlink are the same, so
we pop B, D and C as SCC.

Last, we do DFS for the rest of vertices, A, which is also a
single-vertex SCC.

Finally, each unix_vertex.scc_entry is linked as follows:

  A -.  B -> C -> D  E -.
  ^  |  ^         |  ^  |
  `--'  `---------'  `--'

We use SCC later to decide whether we can garbage-collect the
sockets.

Note that we still cannot detect SCC properly if an edge points
to an embryo socket.  The following two patches will sort it out.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20240325202425.60930-7-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 3484f063172dd88776b062046d721d7c2ae1af7c)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/net/af_unix.h |  3 +++
 net/unix/garbage.c    | 46 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 9198735a6acb0..37171943fb542 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -32,8 +32,11 @@ void wait_for_unix_gc(struct scm_fp_list *fpl);
 struct unix_vertex {
 	struct list_head edges;
 	struct list_head entry;
+	struct list_head scc_entry;
 	unsigned long out_degree;
 	unsigned long index;
+	unsigned long lowlink;
+	bool on_stack;
 };
 
 struct unix_edge {
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 295dd1a7b8e0f..cdeff548e1307 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -251,11 +251,19 @@ static LIST_HEAD(unix_visited_vertices);
 static void __unix_walk_scc(struct unix_vertex *vertex)
 {
 	unsigned long index = UNIX_VERTEX_INDEX_START;
+	LIST_HEAD(vertex_stack);
 	struct unix_edge *edge;
 	LIST_HEAD(edge_stack);
 
 next_vertex:
+	/* Push vertex to vertex_stack.
+	 * The vertex will be popped when finalising SCC later.
+	 */
+	vertex->on_stack = true;
+	list_add(&vertex->scc_entry, &vertex_stack);
+
 	vertex->index = index;
+	vertex->lowlink = index;
 	index++;
 
 	/* Explore neighbour vertices (receivers of the current vertex's fd). */
@@ -283,12 +291,46 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 			edge = list_first_entry(&edge_stack, typeof(*edge), stack_entry);
 			list_del_init(&edge->stack_entry);
 
+			next_vertex = vertex;
 			vertex = edge->predecessor->vertex;
+
+			/* If the successor has a smaller lowlink, two vertices
+			 * are in the same SCC, so propagate the smaller lowlink
+			 * to skip SCC finalisation.
+			 */
+			vertex->lowlink = min(vertex->lowlink, next_vertex->lowlink);
+		} else if (next_vertex->on_stack) {
+			/* Loop detected by a back/cross edge.
+			 *
+			 * The successor is on vertex_stack, so two vertices are
+			 * in the same SCC.  If the successor has a smaller index,
+			 * propagate it to skip SCC finalisation.
+			 */
+			vertex->lowlink = min(vertex->lowlink, next_vertex->index);
+		} else {
+			/* The successor was already grouped as another SCC */
 		}
 	}
 
-	/* Don't restart DFS from this vertex in unix_walk_scc(). */
-	list_move_tail(&vertex->entry, &unix_visited_vertices);
+	if (vertex->index == vertex->lowlink) {
+		struct list_head scc;
+
+		/* SCC finalised.
+		 *
+		 * If the lowlink was not updated, all the vertices above on
+		 * vertex_stack are in the same SCC.  Group them using scc_entry.
+		 */
+		__list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
+
+		list_for_each_entry_reverse(vertex, &scc, scc_entry) {
+			/* Don't restart DFS from this vertex in unix_walk_scc(). */
+			list_move_tail(&vertex->entry, &unix_visited_vertices);
+
+			vertex->on_stack = false;
+		}
+
+		list_del(&scc);
+	}
 
 	/* Need backtracking ? */
 	if (!list_empty(&edge_stack))
-- 
2.49.0.1112.g889b7c5bd8-goog


