Return-Path: <stable+bounces-145902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 960BAABF9C0
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA1B189AB53
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838E222CBF3;
	Wed, 21 May 2025 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XF0753SD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E1A21CA12;
	Wed, 21 May 2025 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841716; cv=none; b=i8luGjM7iJv86bjAllUoE8BGYM4Ds/HiyejGTnTF8t2OhHpi2FQGtY7rv2jXkCq3mu0VOPKT1+Ee1x8z7m74HhhPHAAgFZff0jSAdIUxgpVs4yNmDTP8Gl5YuKVnhx81B4XJMHgw6lMEeeIaOyrbqxtPkmIL0+5giMnSP/a3IMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841716; c=relaxed/simple;
	bh=nFpv8UhQogZFwEw7DnfQ4TT/MPeOnir38BUAG2sE8mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGfgVz0NtbaJveDQBTQEmJxNKnZVbd8mZyBTzJ1vDlPz048+Emzu7PIKmhI5W8DzGqokhTcs1fFrT6ysrX4v6l8uhtXPc01lSuCNS9CAT994WyPNNna2wV6xa1vHrn46SUVfINLuvkaCa3aah7S3oP+DSFKAM9hgrMsv51EGoQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XF0753SD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C58C4CEE4;
	Wed, 21 May 2025 15:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841715;
	bh=nFpv8UhQogZFwEw7DnfQ4TT/MPeOnir38BUAG2sE8mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XF0753SDmWZuRg6Sb/HL76J5YJxubvUwe/clloAepLadwa5XZ1Tf5RpSPkmBADHYA
	 mP3WAtHrXstacimuADd1f9TgRRNjMA+WfHqNikTjvCdeq/0CelQ+1+vjlU+Pukvs71
	 td2GCIByqefukOrO/HA6f9dMphKqLeh4aY0H19ddcg96WVacl8x9qO2azmmntOKPmS
	 bHYN4TqxNHHH34odTxUwPF0rBtS7xGNrkvjW+zt76zxpuR9ktAlcxdsVQpprNBVqug
	 TnxcYsKx7jS/TqPTCiXNEd0/kNURINpH9huNLPX0mkYAlTVQBNXSUWimxfrrR2DZCI
	 ORCgADxlOCxJg==
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
Subject: [PATCH v6.1 25/27] af_unix: Add dead flag to struct scm_fp_list.
Date: Wed, 21 May 2025 16:27:24 +0100
Message-ID: <20250521152920.1116756-26-lee@kernel.org>
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

[ Upstream commit 7172dc93d621d5dc302d007e95ddd1311ec64283 ]

Commit 1af2dface5d2 ("af_unix: Don't access successor in unix_del_edges()
during GC.") fixed use-after-free by avoid accessing edge->successor while
GC is in progress.

However, there could be a small race window where another process could
call unix_del_edges() while gc_in_progress is true and __skb_queue_purge()
is on the way.

So, we need another marker for struct scm_fp_list which indicates if the
skb is garbage-collected.

This patch adds dead flag in struct scm_fp_list and set it true before
calling __skb_queue_purge().

Fixes: 1af2dface5d2 ("af_unix: Don't access successor in unix_del_edges() during GC.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20240508171150.50601-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 7172dc93d621d5dc302d007e95ddd1311ec64283)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/net/scm.h  |  1 +
 net/core/scm.c     |  1 +
 net/unix/garbage.c | 14 ++++++++++----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index 19789096424d..0be0dc3eb1dc 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -31,6 +31,7 @@ struct scm_fp_list {
 	short			max;
 #ifdef CONFIG_UNIX
 	bool			inflight;
+	bool			dead;
 	struct list_head	vertices;
 	struct unix_edge	*edges;
 #endif
diff --git a/net/core/scm.c b/net/core/scm.c
index 1ff78bd4ee83..cdd4e5befb14 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -91,6 +91,7 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 		fpl->user = NULL;
 #if IS_ENABLED(CONFIG_UNIX)
 		fpl->inflight = false;
+		fpl->dead = false;
 		fpl->edges = NULL;
 		INIT_LIST_HEAD(&fpl->vertices);
 #endif
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index d76450133e4f..1f8b8cdfcdc8 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -158,13 +158,11 @@ static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 	unix_update_graph(unix_edge_successor(edge));
 }
 
-static bool gc_in_progress;
-
 static void unix_del_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 {
 	struct unix_vertex *vertex = edge->predecessor->vertex;
 
-	if (!gc_in_progress)
+	if (!fpl->dead)
 		unix_update_graph(unix_edge_successor(edge));
 
 	list_del(&edge->vertex_entry);
@@ -240,7 +238,7 @@ void unix_del_edges(struct scm_fp_list *fpl)
 		unix_del_edge(fpl, edge);
 	} while (i < fpl->count_unix);
 
-	if (!gc_in_progress) {
+	if (!fpl->dead) {
 		receiver = fpl->edges[0].successor;
 		receiver->scm_stat.nr_unix_fds -= fpl->count_unix;
 	}
@@ -559,9 +557,12 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 }
 
+static bool gc_in_progress;
+
 static void __unix_gc(struct work_struct *work)
 {
 	struct sk_buff_head hitlist;
+	struct sk_buff *skb;
 
 	spin_lock(&unix_gc_lock);
 
@@ -579,6 +580,11 @@ static void __unix_gc(struct work_struct *work)
 
 	spin_unlock(&unix_gc_lock);
 
+	skb_queue_walk(&hitlist, skb) {
+		if (UNIXCB(skb).fp)
+			UNIXCB(skb).fp->dead = true;
+	}
+
 	__skb_queue_purge(&hitlist);
 skip_gc:
 	WRITE_ONCE(gc_in_progress, false);
-- 
2.49.0.1143.g0be31eac6b-goog


