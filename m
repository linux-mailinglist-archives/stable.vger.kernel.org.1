Return-Path: <stable+bounces-145895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B83DDABF9A6
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF141B68855
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DCB220F56;
	Wed, 21 May 2025 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKaa8S6T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51872220F4C;
	Wed, 21 May 2025 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841665; cv=none; b=ZDA6wT+GbPoym85xwhSHURfd1dEp2Tf5PG+fHBqUEZ1CYk9la0ANvYJCAz5oyVAk813yRk3pes2qhBWoa4y2NymnKoXCSUoeapLXSaczNlCJCSDPg2H/P/+L6Sv8Ut2lTIjVr9Nwe+yP1Q1ustkNs2uUuL7TinpqNQsvKSfI5eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841665; c=relaxed/simple;
	bh=PEQNaL5xlKqj4lxc3qzk2ZmeiDwQy4A5YNUXp+GxMWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9XTZfYVfCX9m4AqXHWs06eePfqhwQ6OUdmD0TvX5r1WPGXNWsFy/MMMmPmYZs31d4JM3ATOg+C8a26NJNHJoaglBIZ3v+10hO8rNiOZNeXE6j5bxoAQvDNWJLRcYsALugF5i03389uT26jxuaSznXSA1/7AmdozqT2XCwJmyC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKaa8S6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD72DC4CEE4;
	Wed, 21 May 2025 15:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841664;
	bh=PEQNaL5xlKqj4lxc3qzk2ZmeiDwQy4A5YNUXp+GxMWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NKaa8S6TCKtrW5AuS6+uVSvhHjGcuuCWlRayFbVQR/5nMMz165imPmRErOEsEpVk9
	 PEBDtfkDCCQSxfjBcCRRPQHitmhXSXQvxa02ri2/Iq5PppUxOoiI4jv86ypfQN5yIf
	 nhPIEjIVo+H39WGTikOYGA9T7icpE81dBGXfZb4nK94jGnPAItEeJOlUZC/pKwBQZJ
	 9piSKK3b9AA6FGEMY7M/lXV0T4Rqx41liEuSmZYUZODPRCEzCoGGw2ZXa9/LtzNpYd
	 UIseLoOBeYIK5SFu/IEPlrZKVkxN3Z80YN7LtkACOq3kv+fyxI7EKcfUV2aTKLO+xy
	 Lbqyw9tgLswJA==
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
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v6.1 18/27] af_unix: Avoid Tarjan's algorithm if unnecessary.
Date: Wed, 21 May 2025 16:27:17 +0100
Message-ID: <20250521152920.1116756-19-lee@kernel.org>
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

[ Upstream commit ad081928a8b0f57f269df999a28087fce6f2b6ce ]

Once a cyclic reference is formed, we need to run GC to check if
there is dead SCC.

However, we do not need to run Tarjan's algorithm if we know that
the shape of the inflight graph has not been changed.

If an edge is added/updated/deleted and the edge's successor is
inflight, we set false to unix_graph_grouped, which means we need
to re-classify SCC.

Once we finalise SCC, we set true to unix_graph_grouped.

While unix_graph_grouped is true, we can iterate the grouped
SCC using vertex->scc_entry in unix_walk_scc_fast().

list_add() and list_for_each_entry_reverse() uses seem weird, but
they are to keep the vertex order consistent and make writing test
easier.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20240325202425.60930-12-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit ad081928a8b0f57f269df999a28087fce6f2b6ce)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/unix/garbage.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 8f0dc39bb72f..d25841ab2de4 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -113,6 +113,7 @@ static struct unix_vertex *unix_edge_successor(struct unix_edge *edge)
 }
 
 static bool unix_graph_maybe_cyclic;
+static bool unix_graph_grouped;
 
 static void unix_update_graph(struct unix_vertex *vertex)
 {
@@ -123,6 +124,7 @@ static void unix_update_graph(struct unix_vertex *vertex)
 		return;
 
 	unix_graph_maybe_cyclic = true;
+	unix_graph_grouped = false;
 }
 
 static LIST_HEAD(unix_unvisited_vertices);
@@ -144,6 +146,7 @@ static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 		vertex->index = unix_vertex_unvisited_index;
 		vertex->out_degree = 0;
 		INIT_LIST_HEAD(&vertex->edges);
+		INIT_LIST_HEAD(&vertex->scc_entry);
 
 		list_move_tail(&vertex->entry, &unix_unvisited_vertices);
 		edge->predecessor->vertex = vertex;
@@ -418,6 +421,26 @@ static void unix_walk_scc(void)
 
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 	swap(unix_vertex_unvisited_index, unix_vertex_grouped_index);
+
+	unix_graph_grouped = true;
+}
+
+static void unix_walk_scc_fast(void)
+{
+	while (!list_empty(&unix_unvisited_vertices)) {
+		struct unix_vertex *vertex;
+		struct list_head scc;
+
+		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
+		list_add(&scc, &vertex->scc_entry);
+
+		list_for_each_entry_reverse(vertex, &scc, scc_entry)
+			list_move_tail(&vertex->entry, &unix_visited_vertices);
+
+		list_del(&scc);
+	}
+
+	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 }
 
 static LIST_HEAD(gc_candidates);
@@ -570,7 +593,10 @@ static void __unix_gc(struct work_struct *work)
 	if (!unix_graph_maybe_cyclic)
 		goto skip_gc;
 
-	unix_walk_scc();
+	if (unix_graph_grouped)
+		unix_walk_scc_fast();
+	else
+		unix_walk_scc();
 
 	/* First, select candidates for garbage collection.  Only
 	 * in-flight sockets are considered, and from those only ones
-- 
2.49.0.1143.g0be31eac6b-goog


