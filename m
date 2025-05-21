Return-Path: <stable+bounces-145862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D0AABF86E
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BD5C1BC76AF
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E81218ADE;
	Wed, 21 May 2025 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DA8eXBMz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312A31E1E1C;
	Wed, 21 May 2025 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839080; cv=none; b=uBaBoRnI8c1ssZzAPx9i6OIkstIPYCEbsEt8meS/T5u4IlpqTw0+CGw1pa2/oG3oCai1MWgpSuxOH2Ruo0UiCpnb71ja+CJDA4r5R51lu1EenuR5EdSJmoqrn8oG1fzjW0ssEySilcaY6qj/PM20OvocECp9sIof7UU4sPKmaVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839080; c=relaxed/simple;
	bh=wRQQFqc9Q+OLVI5oXIa/+8+D65v+vcb0Zh7HW85KKHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjrof9FgPxRFIu3q7DF+0BxNa4m6si7uUl+ATfXto5nmedjqlNSh58av4YTgdRmss2gVkkm6tvZg9KSwGjHHpCyTNN4Ar/GNWj6N2ZmIOujRVdy22RJFqApPUOpUHmGBUY2pok7pCZIpzOojValNbJLEMb8a1ehkBwR1tlvCyHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DA8eXBMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD885C4CEE4;
	Wed, 21 May 2025 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747839080;
	bh=wRQQFqc9Q+OLVI5oXIa/+8+D65v+vcb0Zh7HW85KKHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DA8eXBMzI1PSW+QcxTgxDwb8qWW5aTeW/mXfohn6JRevEPD8V7Wz1g6o72F2UFbjV
	 Rd1iXuvp8d7+eiKJqL3ipAeBXnjzCMvNJo6bQBGbWqEfTCKfXx51WgBtJYQzeqeywf
	 JlBD6KHGI9bTiAsUmaCgPphUZkszuBDcUqfuKIyc0uUFzqVl7NSOycv1IiuEe1Z8op
	 H8DkVB3Vt1vVbtwkxg/DDX478zKE14Ldolm/TGeztcOvomAqglFaj62FnEJWgodEIX
	 oO3+J5qJxcH/RWdLNl1p+YmxyVT46GwCa+rcVFYE5+1Y5YYCEFxqCOttshYq29VhCk
	 3H0qnWABVwXvQ==
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
Subject: [PATCH v6.6 15/26] af_unix: Save O(n) setup of Tarjan's algo.
Date: Wed, 21 May 2025 14:45:23 +0000
Message-ID: <20250521144803.2050504-16-lee@kernel.org>
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

[ Upstream commit ba31b4a4e1018f5844c6eb31734976e2184f2f9a ]

Before starting Tarjan's algorithm, we need to mark all vertices
as unvisited.  We can save this O(n) setup by reserving two special
indices (0, 1) and using two variables.

The first time we link a vertex to unix_unvisited_vertices, we set
unix_vertex_unvisited_index to index.

During DFS, we can see that the index of unvisited vertices is the
same as unix_vertex_unvisited_index.

When we finalise SCC later, we set unix_vertex_grouped_index to each
vertex's index.

Then, we can know (i) that the vertex is on the stack if the index
of a visited vertex is >= 2 and (ii) that it is not on the stack and
belongs to a different SCC if the index is unix_vertex_grouped_index.

After the whole algorithm, all indices of vertices are set as
unix_vertex_grouped_index.

Next time we start DFS, we know that all unvisited vertices have
unix_vertex_grouped_index, and we can use unix_vertex_unvisited_index
as the not-on-stack marker.

To use the same variable in __unix_walk_scc(), we can swap
unix_vertex_(grouped|unvisited)_index at the end of Tarjan's
algorithm.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20240325202425.60930-10-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit ba31b4a4e1018f5844c6eb31734976e2184f2f9a)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/net/af_unix.h |  1 -
 net/unix/garbage.c    | 26 +++++++++++++++-----------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 9d92dd608fc42..053f67adb9f1b 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -37,7 +37,6 @@ struct unix_vertex {
 	unsigned long out_degree;
 	unsigned long index;
 	unsigned long lowlink;
-	bool on_stack;
 };
 
 struct unix_edge {
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 6ff7e0b5c5444..feae6c17b2911 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -115,16 +115,20 @@ static struct unix_vertex *unix_edge_successor(struct unix_edge *edge)
 static LIST_HEAD(unix_unvisited_vertices);
 
 enum unix_vertex_index {
-	UNIX_VERTEX_INDEX_UNVISITED,
+	UNIX_VERTEX_INDEX_MARK1,
+	UNIX_VERTEX_INDEX_MARK2,
 	UNIX_VERTEX_INDEX_START,
 };
 
+static unsigned long unix_vertex_unvisited_index = UNIX_VERTEX_INDEX_MARK1;
+
 static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 {
 	struct unix_vertex *vertex = edge->predecessor->vertex;
 
 	if (!vertex) {
 		vertex = list_first_entry(&fpl->vertices, typeof(*vertex), entry);
+		vertex->index = unix_vertex_unvisited_index;
 		vertex->out_degree = 0;
 		INIT_LIST_HEAD(&vertex->edges);
 
@@ -265,6 +269,7 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
 }
 
 static LIST_HEAD(unix_visited_vertices);
+static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
 
 static void __unix_walk_scc(struct unix_vertex *vertex)
 {
@@ -274,10 +279,10 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 	LIST_HEAD(edge_stack);
 
 next_vertex:
-	/* Push vertex to vertex_stack.
+	/* Push vertex to vertex_stack and mark it as on-stack
+	 * (index >= UNIX_VERTEX_INDEX_START).
 	 * The vertex will be popped when finalising SCC later.
 	 */
-	vertex->on_stack = true;
 	list_add(&vertex->scc_entry, &vertex_stack);
 
 	vertex->index = index;
@@ -291,7 +296,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 		if (!next_vertex)
 			continue;
 
-		if (next_vertex->index == UNIX_VERTEX_INDEX_UNVISITED) {
+		if (next_vertex->index == unix_vertex_unvisited_index) {
 			/* Iterative deepening depth first search
 			 *
 			 *   1. Push a forward edge to edge_stack and set
@@ -317,7 +322,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 			 * to skip SCC finalisation.
 			 */
 			vertex->lowlink = min(vertex->lowlink, next_vertex->lowlink);
-		} else if (next_vertex->on_stack) {
+		} else if (next_vertex->index != unix_vertex_grouped_index) {
 			/* Loop detected by a back/cross edge.
 			 *
 			 * The successor is on vertex_stack, so two vertices are
@@ -344,7 +349,8 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 			/* Don't restart DFS from this vertex in unix_walk_scc(). */
 			list_move_tail(&vertex->entry, &unix_visited_vertices);
 
-			vertex->on_stack = false;
+			/* Mark vertex as off-stack. */
+			vertex->index = unix_vertex_grouped_index;
 		}
 
 		list_del(&scc);
@@ -357,20 +363,18 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 
 static void unix_walk_scc(void)
 {
-	struct unix_vertex *vertex;
-
-	list_for_each_entry(vertex, &unix_unvisited_vertices, entry)
-		vertex->index = UNIX_VERTEX_INDEX_UNVISITED;
-
 	/* Visit every vertex exactly once.
 	 * __unix_walk_scc() moves visited vertices to unix_visited_vertices.
 	 */
 	while (!list_empty(&unix_unvisited_vertices)) {
+		struct unix_vertex *vertex;
+
 		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
 		__unix_walk_scc(vertex);
 	}
 
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
+	swap(unix_vertex_unvisited_index, unix_vertex_grouped_index);
 }
 
 static LIST_HEAD(gc_candidates);
-- 
2.49.0.1112.g889b7c5bd8-goog


