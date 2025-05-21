Return-Path: <stable+bounces-145894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46508ABF9AC
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5208C2553
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D53F1607A4;
	Wed, 21 May 2025 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/SiIbi8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7718217704;
	Wed, 21 May 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841657; cv=none; b=sSG7VVGc0DSEpDytSKyzh3QerEPMMY+fhRa8sfVVcrI4pcbK73cO7z8wpuXKRjr/hoc1pyoMOkawd4vFwdahNMp5Y8x3a69gynGE2qRva2RRTnteHDpSZJ8k8/ARVTO4qFfq3YIkA5vwt8UbuXDyDmmflPvSYe8W1UfRTG4wBhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841657; c=relaxed/simple;
	bh=uNlOJaA3Kj9exb8Mp76c1OZdZEWpdVv9D2KSAybA18Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwjAeoTUcDr9DXYcgQyU7ODr9EZCot28O5EEoudm6C/gyQPsDn6zd9oFv5Jet1MFCxpfraU0RbLpn/bG4bROq03D5wmMQpN5N+UggQB+fbw+mP0YUD5fPmy+tBOFUfWIXNPwVpsDmb6mRJcAngsb2uMj+DUQjnkwa3NXhRp9ufA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/SiIbi8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4F9C4CEE4;
	Wed, 21 May 2025 15:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841657;
	bh=uNlOJaA3Kj9exb8Mp76c1OZdZEWpdVv9D2KSAybA18Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r/SiIbi87JL+YWRLguYSshkkgWbRjRQx6ooMpbxhPM02zq9suGVedlxL8OpsIIZoH
	 5T66yaq2/LAGg54Mlcp+AyHG+6nTk+aTZMu/Z15f+C50vuyA3B0dnAhma2TIhmCeGm
	 wRewuomehLUdmTz4fsqA7arDDwep04K4rmqNNmNwdxbOVHUjJH8lf0quTSHQB9iVrf
	 oDkUYdkAojPMNsU3ZrWJEnSyw+LwVmN7GqvofcPLAHcHB1AxQrgrGRUy+jqZnKhkFC
	 FXLNiv3MJwpIDwkzi+jbVPlZtGNOgZPhBCG9y6B6WgOzYNgkEm4+aajDTPM9tvmopv
	 w2iq2u1XbN3Zg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Rao Shoaib <Rao.Shoaib@oracle.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v6.1 17/27] af_unix: Skip GC if no cycle exists.
Date: Wed, 21 May 2025 16:27:16 +0100
Message-ID: <20250521152920.1116756-18-lee@kernel.org>
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
index feae6c17b291..8f0dc39bb72f 100644
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
2.49.0.1143.g0be31eac6b-goog


