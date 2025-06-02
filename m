Return-Path: <stable+bounces-149539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40255ACB3CA
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D070E4A1151
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D993226CFD;
	Mon,  2 Jun 2025 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q56m2ff1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6281FBC90;
	Mon,  2 Jun 2025 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874263; cv=none; b=lvXA14NijA8rseNIRd33v8DN37GwGGdpZXlrzyvgLB1SLBYSW/p+c4yBdQUAgqk+y49zEqKw9O2FLHqhDZCsJA4dS8Zc6ZAv2pCglTcR+ytStrPKr3zbIO0pxEFaHUyoX22OrQpMeC6skoWiIBj2247DXucKuCnmVcb2DaxZw6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874263; c=relaxed/simple;
	bh=yrellp6Lwt7J3YJtoloc6u9cyBQbHWOe+3AdsrK1HlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QD/1e2dCAqU3xXkpJIxt4Ez3in5AB67dXg9RWH/qolyTtfk9hN4NzSV0z1XMogrnG5b/h3DYcp24YDZveXtvVNIryaEM91TU20uGPrKGJ7zN3Cqjp236wKaUt+QV0zP80F8APzdcnTSjE1KIH/tqmVb/9S6twKh9EO3sFhLbNoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q56m2ff1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEBAC4CEEB;
	Mon,  2 Jun 2025 14:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748874262;
	bh=yrellp6Lwt7J3YJtoloc6u9cyBQbHWOe+3AdsrK1HlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q56m2ff10F9KCSlZ1PW+kAzILROZett7la73h/SZhZ1FbkDIp6DaONtjOs57kp3Ik
	 ZPaMxNDvedrq4GBHr1Fcsj3n4aBt3nMllmrb9wt7aX+8z5BFvhmabNAKQhT4pzkUpl
	 PiHymhH0rP6EYt6B1Lif4YywCnfup6D1Ckwxj/G0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 6.6 412/444] af_unix: Assign a unique index to SCC.
Date: Mon,  2 Jun 2025 15:47:56 +0200
Message-ID: <20250602134357.655615327@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

commit bfdb01283ee8f2f3089656c3ff8f62bb072dabb2 upstream.

The definition of the lowlink in Tarjan's algorithm is the
smallest index of a vertex that is reachable with at most one
back-edge in SCC.  This is not useful for a cross-edge.

If we start traversing from A in the following graph, the final
lowlink of D is 3.  The cross-edge here is one between D and C.

  A -> B -> D   D = (4, 3)  (index, lowlink)
  ^    |    |   C = (3, 1)
  |    V    |   B = (2, 1)
  `--- C <--'   A = (1, 1)

This is because the lowlink of D is updated with the index of C.

In the following patch, we detect a dead SCC by checking two
conditions for each vertex.

  1) vertex has no edge directed to another SCC (no bridge)
  2) vertex's out_degree is the same as the refcount of its file

If 1) is false, there is a receiver of all fds of the SCC and
its ancestor SCC.

To evaluate 1), we need to assign a unique index to each SCC and
assign it to all vertices in the SCC.

This patch changes the lowlink update logic for cross-edge so
that in the example above, the lowlink of D is updated with the
lowlink of C.

  A -> B -> D   D = (4, 1)  (index, lowlink)
  ^    |    |   C = (3, 1)
  |    V    |   B = (2, 1)
  `--- C <--'   A = (1, 1)

Then, all vertices in the same SCC have the same lowlink, and we
can quickly find the bridge connecting to different SCC if exists.

However, it is no longer called lowlink, so we rename it to
scc_index.  (It's sometimes called lowpoint.)

Also, we add a global variable to hold the last index used in DFS
so that we do not reset the initial index in each DFS.

This patch can be squashed to the SCC detection patch but is
split deliberately for anyone wondering why lowlink is not used
as used in the original Tarjan's algorithm and many reference
implementations.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20240325202425.60930-13-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/af_unix.h |    2 +-
 net/unix/garbage.c    |   29 +++++++++++++++--------------
 2 files changed, 16 insertions(+), 15 deletions(-)

--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -36,7 +36,7 @@ struct unix_vertex {
 	struct list_head scc_entry;
 	unsigned long out_degree;
 	unsigned long index;
-	unsigned long lowlink;
+	unsigned long scc_index;
 };
 
 struct unix_edge {
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -312,9 +312,8 @@ static bool unix_scc_cyclic(struct list_
 static LIST_HEAD(unix_visited_vertices);
 static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
 
-static void __unix_walk_scc(struct unix_vertex *vertex)
+static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_index)
 {
-	unsigned long index = UNIX_VERTEX_INDEX_START;
 	LIST_HEAD(vertex_stack);
 	struct unix_edge *edge;
 	LIST_HEAD(edge_stack);
@@ -326,9 +325,9 @@ next_vertex:
 	 */
 	list_add(&vertex->scc_entry, &vertex_stack);
 
-	vertex->index = index;
-	vertex->lowlink = index;
-	index++;
+	vertex->index = *last_index;
+	vertex->scc_index = *last_index;
+	(*last_index)++;
 
 	/* Explore neighbour vertices (receivers of the current vertex's fd). */
 	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
@@ -358,30 +357,30 @@ prev_vertex:
 			next_vertex = vertex;
 			vertex = edge->predecessor->vertex;
 
-			/* If the successor has a smaller lowlink, two vertices
-			 * are in the same SCC, so propagate the smaller lowlink
+			/* If the successor has a smaller scc_index, two vertices
+			 * are in the same SCC, so propagate the smaller scc_index
 			 * to skip SCC finalisation.
 			 */
-			vertex->lowlink = min(vertex->lowlink, next_vertex->lowlink);
+			vertex->scc_index = min(vertex->scc_index, next_vertex->scc_index);
 		} else if (next_vertex->index != unix_vertex_grouped_index) {
 			/* Loop detected by a back/cross edge.
 			 *
-			 * The successor is on vertex_stack, so two vertices are
-			 * in the same SCC.  If the successor has a smaller index,
+			 * The successor is on vertex_stack, so two vertices are in
+			 * the same SCC.  If the successor has a smaller *scc_index*,
 			 * propagate it to skip SCC finalisation.
 			 */
-			vertex->lowlink = min(vertex->lowlink, next_vertex->index);
+			vertex->scc_index = min(vertex->scc_index, next_vertex->scc_index);
 		} else {
 			/* The successor was already grouped as another SCC */
 		}
 	}
 
-	if (vertex->index == vertex->lowlink) {
+	if (vertex->index == vertex->scc_index) {
 		struct list_head scc;
 
 		/* SCC finalised.
 		 *
-		 * If the lowlink was not updated, all the vertices above on
+		 * If the scc_index was not updated, all the vertices above on
 		 * vertex_stack are in the same SCC.  Group them using scc_entry.
 		 */
 		__list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
@@ -407,6 +406,8 @@ prev_vertex:
 
 static void unix_walk_scc(void)
 {
+	unsigned long last_index = UNIX_VERTEX_INDEX_START;
+
 	unix_graph_maybe_cyclic = false;
 
 	/* Visit every vertex exactly once.
@@ -416,7 +417,7 @@ static void unix_walk_scc(void)
 		struct unix_vertex *vertex;
 
 		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
-		__unix_walk_scc(vertex);
+		__unix_walk_scc(vertex, &last_index);
 	}
 
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);



