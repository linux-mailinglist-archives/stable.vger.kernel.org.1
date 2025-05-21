Return-Path: <stable+bounces-145856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2959ABF84D
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354811BA3016
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099CE16DC28;
	Wed, 21 May 2025 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIrmhVhh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77BF1DFD84;
	Wed, 21 May 2025 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839035; cv=none; b=PcSQT07sRfS+tVVoudFNnIJx+4dkru9A91M2xLlVrbRvhSfeJ1zcYb9okp4RW4iXsIZxfaFw71IKBeeWKV7mjcBPyS2VjVwv5DbAedFXkeuhim+6dWnBOjQ61jJfEJv1TBJin/U3DehNnMBMwc4o0Fv7Kw1zfL7keIoQHnaTDWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839035; c=relaxed/simple;
	bh=WMTznbR6ePA4gSowAlz0pUqMZN0xJeUBgveOaz/kO8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luWgOKtBolfd30wCfaq2RFG5K1522NOjkNZ9qaf0Cqxud3QznnRav3KNWXJcpPFez//c63Lb3hq2fQebIy7vkVsBg2bxg6Z5/JBIMFGyT4s9lizenr34GObhrPowdrMPzYdkwWxqcu7sbX2LhQRVFbyyTZjUpllgSfn95rgErcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIrmhVhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B4DC4CEE4;
	Wed, 21 May 2025 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747839034;
	bh=WMTznbR6ePA4gSowAlz0pUqMZN0xJeUBgveOaz/kO8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CIrmhVhhy3wfmXNVQ0dVSgaIya7iuS5/TfnW6UDJmTR7K365ulvaV98Jj3Zg7Gt9k
	 miTxcyGx4sDm6278KzYRU1pVfXc07LIilyamTVk1rDxUBofUxqK0was3Bv1hCq9CI8
	 /VRg/QmpGz7EyyyaQAEfeuSQ85krc+FvJA/b30CCPTdj6m1g5js0+CAnTGFJ2vk8lp
	 u3ONM6P+isQ/6cFl0ZqIUNSfdprNfl/wnSr4b1vpkj2gk/Te9lOVK75VmoNksaeZoI
	 D7nIkyDvszjVYSpK3AjZMSK0h51vWESFQYVlfXeEEgVMC/DmbN3xZQwvaR1CwDdO8Z
	 oMUtL5nd3JgzA==
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
Subject: [PATCH v6.6 09/26] af_unix: Link struct unix_edge when queuing skb.
Date: Wed, 21 May 2025 14:45:17 +0000
Message-ID: <20250521144803.2050504-10-lee@kernel.org>
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

[ Upstream commit 42f298c06b30bfe0a8cbee5d38644e618699e26e ]

Just before queuing skb with inflight fds, we call scm_stat_add(),
which is a good place to set up the preallocated struct unix_vertex
and struct unix_edge in UNIXCB(skb).fp.

Then, we call unix_add_edges() and construct the directed graph
as follows:

  1. Set the inflight socket's unix_sock to unix_edge.predecessor.
  2. Set the receiver's unix_sock to unix_edge.successor.
  3. Set the preallocated vertex to inflight socket's unix_sock.vertex.
  4. Link inflight socket's unix_vertex.entry to unix_unvisited_vertices.
  5. Link unix_edge.vertex_entry to the inflight socket's unix_vertex.edges.

Let's say we pass the fd of AF_UNIX socket A to B and the fd of B
to C.  The graph looks like this:

  +-------------------------+
  | unix_unvisited_vertices | <-------------------------.
  +-------------------------+                           |
  +                                                     |
  |     +--------------+             +--------------+   |         +--------------+
  |     |  unix_sock A | <---. .---> |  unix_sock B | <-|-. .---> |  unix_sock C |
  |     +--------------+     | |     +--------------+   | | |     +--------------+
  | .-+ |    vertex    |     | | .-+ |    vertex    |   | | |     |    vertex    |
  | |   +--------------+     | | |   +--------------+   | | |     +--------------+
  | |                        | | |                      | | |
  | |   +--------------+     | | |   +--------------+   | | |
  | '-> |  unix_vertex |     | | '-> |  unix_vertex |   | | |
  |     +--------------+     | |     +--------------+   | | |
  `---> |    entry     | +---------> |    entry     | +-' | |
        |--------------|     | |     |--------------|     | |
        |    edges     | <-. | |     |    edges     | <-. | |
        +--------------+   | | |     +--------------+   | | |
                           | | |                        | | |
    .----------------------' | | .----------------------' | |
    |                        | | |                        | |
    |   +--------------+     | | |   +--------------+     | |
    |   |   unix_edge  |     | | |   |   unix_edge  |     | |
    |   +--------------+     | | |   +--------------+     | |
    `-> | vertex_entry |     | | `-> | vertex_entry |     | |
        |--------------|     | |     |--------------|     | |
        |  predecessor | +---' |     |  predecessor | +---' |
        |--------------|       |     |--------------|       |
        |   successor  | +-----'     |   successor  | +-----'
        +--------------+             +--------------+

Henceforth, we denote such a graph as A -> B (-> C).

Now, we can express all inflight fd graphs that do not contain
embryo sockets.  We will support the particular case later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20240325202425.60930-4-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 42f298c06b30bfe0a8cbee5d38644e618699e26e)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/net/af_unix.h |  2 +
 include/net/scm.h     |  1 +
 net/core/scm.c        |  2 +
 net/unix/af_unix.c    |  8 +++-
 net/unix/garbage.c    | 90 ++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index dd5750daf0b92..affcb990f95e2 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -22,6 +22,8 @@ extern unsigned int unix_tot_inflight;
 
 void unix_inflight(struct user_struct *user, struct file *fp);
 void unix_notinflight(struct user_struct *user, struct file *fp);
+void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver);
+void unix_del_edges(struct scm_fp_list *fpl);
 int unix_prepare_fpl(struct scm_fp_list *fpl);
 void unix_destroy_fpl(struct scm_fp_list *fpl);
 void unix_gc(void);
diff --git a/include/net/scm.h b/include/net/scm.h
index 915c4c94306ec..07d66c41cc33c 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -31,6 +31,7 @@ struct scm_fp_list {
 	short			count_unix;
 	short			max;
 #ifdef CONFIG_UNIX
+	bool			inflight;
 	struct list_head	vertices;
 	struct unix_edge	*edges;
 #endif
diff --git a/net/core/scm.c b/net/core/scm.c
index 96e3d2785e509..1e47788379c2c 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -90,6 +90,7 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 		fpl->max = SCM_MAX_FD;
 		fpl->user = NULL;
 #if IS_ENABLED(CONFIG_UNIX)
+		fpl->inflight = false;
 		fpl->edges = NULL;
 		INIT_LIST_HEAD(&fpl->vertices);
 #endif
@@ -384,6 +385,7 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl)
 		new_fpl->max = new_fpl->count;
 		new_fpl->user = get_uid(fpl->user);
 #if IS_ENABLED(CONFIG_UNIX)
+		new_fpl->inflight = false;
 		new_fpl->edges = NULL;
 		INIT_LIST_HEAD(&new_fpl->vertices);
 #endif
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 6d62fa5b0e68d..e54f54f9d9948 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1920,8 +1920,10 @@ static void scm_stat_add(struct sock *sk, struct sk_buff *skb)
 	struct scm_fp_list *fp = UNIXCB(skb).fp;
 	struct unix_sock *u = unix_sk(sk);
 
-	if (unlikely(fp && fp->count))
+	if (unlikely(fp && fp->count)) {
 		atomic_add(fp->count, &u->scm_stat.nr_fds);
+		unix_add_edges(fp, u);
+	}
 }
 
 static void scm_stat_del(struct sock *sk, struct sk_buff *skb)
@@ -1929,8 +1931,10 @@ static void scm_stat_del(struct sock *sk, struct sk_buff *skb)
 	struct scm_fp_list *fp = UNIXCB(skb).fp;
 	struct unix_sock *u = unix_sk(sk);
 
-	if (unlikely(fp && fp->count))
+	if (unlikely(fp && fp->count)) {
 		atomic_sub(fp->count, &u->scm_stat.nr_fds);
+		unix_del_edges(fp);
+	}
 }
 
 /*
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 912b7945692c9..b5b4a200dbf3b 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -101,6 +101,38 @@ struct unix_sock *unix_get_socket(struct file *filp)
 	return NULL;
 }
 
+static LIST_HEAD(unix_unvisited_vertices);
+
+static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
+{
+	struct unix_vertex *vertex = edge->predecessor->vertex;
+
+	if (!vertex) {
+		vertex = list_first_entry(&fpl->vertices, typeof(*vertex), entry);
+		vertex->out_degree = 0;
+		INIT_LIST_HEAD(&vertex->edges);
+
+		list_move_tail(&vertex->entry, &unix_unvisited_vertices);
+		edge->predecessor->vertex = vertex;
+	}
+
+	vertex->out_degree++;
+	list_add_tail(&edge->vertex_entry, &vertex->edges);
+}
+
+static void unix_del_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
+{
+	struct unix_vertex *vertex = edge->predecessor->vertex;
+
+	list_del(&edge->vertex_entry);
+	vertex->out_degree--;
+
+	if (!vertex->out_degree) {
+		edge->predecessor->vertex = NULL;
+		list_move_tail(&vertex->entry, &fpl->vertices);
+	}
+}
+
 static void unix_free_vertices(struct scm_fp_list *fpl)
 {
 	struct unix_vertex *vertex, *next_vertex;
@@ -111,6 +143,60 @@ static void unix_free_vertices(struct scm_fp_list *fpl)
 	}
 }
 
+DEFINE_SPINLOCK(unix_gc_lock);
+
+void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
+{
+	int i = 0, j = 0;
+
+	spin_lock(&unix_gc_lock);
+
+	if (!fpl->count_unix)
+		goto out;
+
+	do {
+		struct unix_sock *inflight = unix_get_socket(fpl->fp[j++]);
+		struct unix_edge *edge;
+
+		if (!inflight)
+			continue;
+
+		edge = fpl->edges + i++;
+		edge->predecessor = inflight;
+		edge->successor = receiver;
+
+		unix_add_edge(fpl, edge);
+	} while (i < fpl->count_unix);
+
+out:
+	spin_unlock(&unix_gc_lock);
+
+	fpl->inflight = true;
+
+	unix_free_vertices(fpl);
+}
+
+void unix_del_edges(struct scm_fp_list *fpl)
+{
+	int i = 0;
+
+	spin_lock(&unix_gc_lock);
+
+	if (!fpl->count_unix)
+		goto out;
+
+	do {
+		struct unix_edge *edge = fpl->edges + i++;
+
+		unix_del_edge(fpl, edge);
+	} while (i < fpl->count_unix);
+
+out:
+	spin_unlock(&unix_gc_lock);
+
+	fpl->inflight = false;
+}
+
 int unix_prepare_fpl(struct scm_fp_list *fpl)
 {
 	struct unix_vertex *vertex;
@@ -141,11 +227,13 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
 
 void unix_destroy_fpl(struct scm_fp_list *fpl)
 {
+	if (fpl->inflight)
+		unix_del_edges(fpl);
+
 	kvfree(fpl->edges);
 	unix_free_vertices(fpl);
 }
 
-DEFINE_SPINLOCK(unix_gc_lock);
 unsigned int unix_tot_inflight;
 static LIST_HEAD(gc_candidates);
 static LIST_HEAD(gc_inflight_list);
-- 
2.49.0.1112.g889b7c5bd8-goog


