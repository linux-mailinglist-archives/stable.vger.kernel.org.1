Return-Path: <stable+bounces-145897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EE6ABF9AE
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9051BC5D74
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F52227E9B;
	Wed, 21 May 2025 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLkJs1ml"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4025D22127A;
	Wed, 21 May 2025 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841679; cv=none; b=qh2yhxsRWaDY5UMu022GpAdxD57iPC7dqEH2CBl4cfeNXV7Uz5QbJvp8YV+yvaHjEd714aAXQQ2qQWEIKQoN77PUBM+CmV9N3+K8E8Ee8pSfiqL3vrIbV/Cpn6Wd3LcU+QKbf5Qs/lBoZwfSiqJhX9/y+wmKUnTlREpSZ6EcAsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841679; c=relaxed/simple;
	bh=HEKPamw4N0SlwDUEynkY5dfMAkCnnRNBCS9aAC+V1kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTpQZNfA0tuuqETiGgYljfc3ES5aoZvS/biKyeukpxJGrcaYojJXWQ1S9/qQdLPXHYs/imcDNqRXRh5Irl09d3SmAhYZp8LVDvebGQs50y9zl1stfgR2Vu6XaBbO8Xrp0o15fm+qPrBtoBzfP6ykQLFuc+JKy69E6Bmvk23Oc2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLkJs1ml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4A9C4CEE7;
	Wed, 21 May 2025 15:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841679;
	bh=HEKPamw4N0SlwDUEynkY5dfMAkCnnRNBCS9aAC+V1kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NLkJs1mlGZOcEy/Rd5EZWCQArgVcPmHGtil0q3tehtMMwKrpmFCmEjcE3YlErsjgY
	 H4utljsy5djUbPijWEWwQBZk2p/IT+ZGsEWz90sABAkGcT19qhvkBtE7gijEIWK6JA
	 Vek5jhv47XzspmDZgfQBv/DqK3A5gCXcfHVNXLQlzKaFlrVjc7pTLOkDAoueLtUoMU
	 9OaMhRUKdrNZJt/qp2OyEm+ODSFleJJi/LLeR+KD6i78Ycka/eMGrm9D5Vu52PddSX
	 wCg/YV85iEoCm7XDa026Xrw0VLevXKsrEJirSVy1Vk5pnnjmr2N7aD8AE8kZ8ktJtT
	 +4zbb3h8i20BA==
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
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v6.1 20/27] af_unix: Detect dead SCC.
Date: Wed, 21 May 2025 16:27:19 +0100
Message-ID: <20250521152920.1116756-21-lee@kernel.org>
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

[ Upstream commit a15702d8b3aad8ce5268c565bd29f0e02fd2db83 ]

When iterating SCC, we call unix_vertex_dead() for each vertex
to check if the vertex is close()d and has no bridge to another
SCC.

If both conditions are true for every vertex in SCC, we can
execute garbage collection for all skb in the SCC.

The actual garbage collection is done in the following patch,
replacing the old implementation.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20240325202425.60930-14-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit a15702d8b3aad8ce5268c565bd29f0e02fd2db83)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/unix/garbage.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 2e66b57f3f0f..1f53c25fc71b 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -289,6 +289,39 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
 	unix_free_vertices(fpl);
 }
 
+static bool unix_vertex_dead(struct unix_vertex *vertex)
+{
+	struct unix_edge *edge;
+	struct unix_sock *u;
+	long total_ref;
+
+	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
+		struct unix_vertex *next_vertex = unix_edge_successor(edge);
+
+		/* The vertex's fd can be received by a non-inflight socket. */
+		if (!next_vertex)
+			return false;
+
+		/* The vertex's fd can be received by an inflight socket in
+		 * another SCC.
+		 */
+		if (next_vertex->scc_index != vertex->scc_index)
+			return false;
+	}
+
+	/* No receiver exists out of the same SCC. */
+
+	edge = list_first_entry(&vertex->edges, typeof(*edge), vertex_entry);
+	u = edge->predecessor;
+	total_ref = file_count(u->sk.sk_socket->file);
+
+	/* If not close()d, total_ref > out_degree. */
+	if (total_ref != vertex->out_degree)
+		return false;
+
+	return true;
+}
+
 static bool unix_scc_cyclic(struct list_head *scc)
 {
 	struct unix_vertex *vertex;
@@ -377,6 +410,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
 
 	if (vertex->index == vertex->scc_index) {
 		struct list_head scc;
+		bool scc_dead = true;
 
 		/* SCC finalised.
 		 *
@@ -391,6 +425,9 @@ static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
 
 			/* Mark vertex as off-stack. */
 			vertex->index = unix_vertex_grouped_index;
+
+			if (scc_dead)
+				scc_dead = unix_vertex_dead(vertex);
 		}
 
 		if (!unix_graph_maybe_cyclic)
@@ -431,13 +468,18 @@ static void unix_walk_scc_fast(void)
 	while (!list_empty(&unix_unvisited_vertices)) {
 		struct unix_vertex *vertex;
 		struct list_head scc;
+		bool scc_dead = true;
 
 		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
 		list_add(&scc, &vertex->scc_entry);
 
-		list_for_each_entry_reverse(vertex, &scc, scc_entry)
+		list_for_each_entry_reverse(vertex, &scc, scc_entry) {
 			list_move_tail(&vertex->entry, &unix_visited_vertices);
 
+			if (scc_dead)
+				scc_dead = unix_vertex_dead(vertex);
+		}
+
 		list_del(&scc);
 	}
 
-- 
2.49.0.1143.g0be31eac6b-goog


