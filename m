Return-Path: <stable+bounces-145864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43748ABF865
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8354E774E
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D261EF09C;
	Wed, 21 May 2025 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOwTX0P7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBBB1D63DF;
	Wed, 21 May 2025 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839095; cv=none; b=aEMfvcsqmOQZCHNmzHvQse15n65yf60r5zfvyBvyxm6Abftuc3NPWveKkA/QkrctBwP6uDdGvYdHnpwY4nlGkVjgT3e3C6K35wPtlXqToJrSVcyalsearSdaGu92gQDWgfnmY0UY/MATpxjHIM12bsVV5WQO6Dt+esBQbjzUXgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839095; c=relaxed/simple;
	bh=H4UhcNGje5V+6UrQJrQ/fqXbkUaEHJufJVQE+hU3Mc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sj6x6qgYAZ56iVKVVtE31wG0nuRsG+22D7R6nhnAZU47Ciyy5KSBMEkCSuBO3JThHVcbiuQy+iyAlNFLFdS9uwaDfMvCS6oOEWk1PHaR+vbWtYCHJFoURq8rphyoSYDMvTvios11E7pXq30kg+C8CS99yUnsfDWZqOT+zUA74oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOwTX0P7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6075EC4CEE4;
	Wed, 21 May 2025 14:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747839095;
	bh=H4UhcNGje5V+6UrQJrQ/fqXbkUaEHJufJVQE+hU3Mc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nOwTX0P7cYynehac63VSlU0zvdZGZO6yOGQBnLgVOFadk8bJAe5K8I05yY/yERIM9
	 4o0VAZFrJprgFQoJ1+pUOFMUeIJDVHJLj6VasNu3j3FHRVxVxsr3IaMFV7ogr5AERW
	 C1yavlPT9scgAVDFXmH41BA+rJrrtkJ9nx1ltoKIj4V4nvJSPCtAr6qTBJJjFAlMIK
	 dYg0jFDIfuv/oiXcEVlGRgs44kBx0/2xJiu5vNKO43IGTzUYThLM1bJ1kXB4VbkvWS
	 YnIGYkNiCC+xfisHkODODcNRIt/n2HCUR2V5wVHUrfmirSYzyWP0EPSJIgxko85Ser
	 w+1Ou2Xz9tuGg==
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
Subject: [PATCH v6.6 17/26] af_unix: Avoid Tarjan's algorithm if unnecessary.
Date: Wed, 21 May 2025 14:45:25 +0000
Message-ID: <20250521144803.2050504-18-lee@kernel.org>
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
index 8f0dc39bb72fc..d25841ab2de40 100644
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
2.49.0.1112.g889b7c5bd8-goog


