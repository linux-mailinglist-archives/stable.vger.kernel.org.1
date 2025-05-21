Return-Path: <stable+bounces-145871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DA6ABF87F
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE262501AAB
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F308220F33;
	Wed, 21 May 2025 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpYs3fLK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F061E1E00;
	Wed, 21 May 2025 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839150; cv=none; b=EBUZGO/Fnz6E3D0kSW+zrUujMuc+ap7m8UYcv7L08p3O+6TKOu2jHx+yji6rIPQO2lOI9uGxgJc7N7xmGXRh2Dt0dLxkzlfa8UxCam7KbjxGZzS8R6usDgzVFDi0Hp5/kbvGZ9b3D8W4aPXsUMWJu5I2aIqM6c3jSXgN0IC5p7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839150; c=relaxed/simple;
	bh=Xj05gGRo0xoYevcLOG2pEIBlkR32I/nMes0A76C29J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrXkaUzscI+6f6OAiqtuI9aYjX/MXjxCharhBmaK0yDQxYqDCHmvDRwnhAzNmLA1rG6Bl0IELMoVC34hTVZxU8PYaEbUqPBwu9kuQpN6DN7I6t6VYrEKCOFgm+3b6ov1d2s6i3qB7m1t2xKJucPtZGeMPDe/bwgVUpOdAciDgyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpYs3fLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA564C4CEE4;
	Wed, 21 May 2025 14:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747839150;
	bh=Xj05gGRo0xoYevcLOG2pEIBlkR32I/nMes0A76C29J8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GpYs3fLKW2G7uGseO7b0EDm5jiVW58q4yfk+dha9DLP6yaWlIF9qHtlnTjzuWzPh8
	 G8bzSqCrjxDjCcwAJR8O/Jirkp2442qazofQFzc6/frI3454o7NqWOcnJrnAFSzOnP
	 YWUR3E2uwnIukcS04BvqLJ9WnP0W6RZbtDNqSegGKVOMu4l7ZbejZIXes52H/2w56W
	 uXntNavvO4WqGZ73ToSQ2lel/ZGObAaKQZqx4Aj1J1Bk/OEKpc9Xty9ot8vz2ihIFC
	 2AjoA1HIlDK5CG1zq+fJ25gvQWkJ2vizMcFYTxG+MWYhZcfoK1ui75Jk/39QKlA2WL
	 BmQfR7CkuH52g==
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
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v6.6 24/26] af_unix: Add dead flag to struct scm_fp_list.
Date: Wed, 21 May 2025 14:45:32 +0000
Message-ID: <20250521144803.2050504-25-lee@kernel.org>
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
index 07d66c41cc33c..059e287745dc3 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -32,6 +32,7 @@ struct scm_fp_list {
 	short			max;
 #ifdef CONFIG_UNIX
 	bool			inflight;
+	bool			dead;
 	struct list_head	vertices;
 	struct unix_edge	*edges;
 #endif
diff --git a/net/core/scm.c b/net/core/scm.c
index 1e47788379c2c..431bfb3ea3929 100644
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
index d76450133e4f0..1f8b8cdfcdc8d 100644
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
2.49.0.1112.g889b7c5bd8-goog


