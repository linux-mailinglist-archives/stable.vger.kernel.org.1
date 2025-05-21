Return-Path: <stable+bounces-145893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1679ABF9A2
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083E3189F0B8
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631FF220F32;
	Wed, 21 May 2025 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pcz0BEPp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2D01607A4;
	Wed, 21 May 2025 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841652; cv=none; b=E69zIMC254M7jLclKZagHhpgvRsPVguKcubvLNxAdsQLBgi3ohuY4R2zPqs/lgMocCkAV9REN6UvD+koGywNJT+E2kB4MLFi0TB+fzUXmQppLH8f86nwiQ3lN0rXE80uBUuo1n7wx1dhnXvfZ2pLyMcecuSGbwMI6eap4FTqZTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841652; c=relaxed/simple;
	bh=O03T3ChknsheJGHN0Jw6E9IVyQ1C+VFIXNJlYAu3PMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtr23Ev0H2lsK8ZSGe+UNBZiNEzMju0AhM+tphi8jHqH5dyyNVoM5DMLo2O6bxClw/pVHx4lZqxmGVmG0XLZt7CP+kNY10L+MTpe9h7agNvJruwgGJ6TOViCeTvBxtZJRKtXP6FI8f7vMmSVmmugi5pfpiPOI3Qc6L1oZ7bcui0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pcz0BEPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00BAC4CEEB;
	Wed, 21 May 2025 15:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841650;
	bh=O03T3ChknsheJGHN0Jw6E9IVyQ1C+VFIXNJlYAu3PMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pcz0BEPpYj+99/HP0j/YUS8E7rAkEphaHTPZvCs/GyevM0WIdDzRLU5n0hQpfVIfC
	 nCnM//FJLCsFNpP7LvyIq3x8rBYy+99crWZ9qK6hnH3nJI/fyC0NUxBF0NjTDWFzhV
	 ATpOnsju4k+r0wqkLftO3yTuRzVYUAOuy45VLawAVwKhnN+AkJQp7BCxdQw813XfqM
	 q4ILxrcLYOAKsit7dABugg/koZdEq0dE8w2Eq/7VVHM8JHZbyQVqb6F9R9Wf7GCHTg
	 9w4Cx/B6y/0+CuIcs9z1cbBlqnPG//0vQ7bsIkvRY3ingBE9gBU9cNM51lTOrpWyiT
	 zxBjgxBMBoyAw==
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
Subject: [PATCH v6.1 16/27] af_unix: Save O(n) setup of Tarjan's algo.
Date: Wed, 21 May 2025 16:27:15 +0100
Message-ID: <20250521152920.1116756-17-lee@kernel.org>
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
index d7f589e14467..ffbc7322e41b 100644
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
index 6ff7e0b5c544..feae6c17b291 100644
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
2.49.0.1143.g0be31eac6b-goog


