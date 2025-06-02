Return-Path: <stable+bounces-150551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E02CACB7B4
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4854A437A
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096F0228CA9;
	Mon,  2 Jun 2025 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PpyKRaqK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF4E20E026;
	Mon,  2 Jun 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877479; cv=none; b=Hy9mzngjpNpbT2XzKtaAe6oNFmFXzqEGh8PD7gcC3n5yxnFKw5iE07EMrtbOBlDEbrxIIVn10uAiCrkwBkM+28zJb6OIDsTATfSpRC/PYMs4VJ7P9HHSPWzFy1cTOjtZuQ6qvfuSfH2+H0RXjivAslGFXKGuuRkmEpWoTVQIV3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877479; c=relaxed/simple;
	bh=LTAtfZ3m1j5wC4l+jsFMwAYb6kttri75qk0pHfKuiQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dX1VCk+nfA0eABCxyZWkLBR0i8wcoNZDVRK863ipOBYl2SYGb6a97pT0y+d4hSFEGen+aNcfjjTHhvqvGudmbn/VhyYpr7vuoiULBc/gAWBEzPjrgxXzxUgmkx9pOfL5F53tBytmBAupWTodopCgQ/rlUs6Tky/FdpowqqG1GbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PpyKRaqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC862C4CEEB;
	Mon,  2 Jun 2025 15:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748877479;
	bh=LTAtfZ3m1j5wC4l+jsFMwAYb6kttri75qk0pHfKuiQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PpyKRaqKJOu53oMsT8P9lTcCYJ2arzFJp+0R7xCs3dELuZpOC2LodkaGgo2eQYVer
	 sfkzYQMbQcr9hBgeSxf+DbpspZeEeRYiNjeNdodxpgtt/XNyguqkV+byEYp0phOONL
	 H3UeZYCciqPLiqg54lEhu26wQkQ2VDH5hq51uyKo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 6.1 290/325] af_unix: Link struct unix_edge when queuing skb.
Date: Mon,  2 Jun 2025 15:49:26 +0200
Message-ID: <20250602134331.687490975@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

commit 42f298c06b30bfe0a8cbee5d38644e618699e26e upstream.

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
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/af_unix.h |    2 +
 include/net/scm.h     |    1 
 net/core/scm.c        |    2 +
 net/unix/af_unix.c    |    8 +++-
 net/unix/garbage.c    |   90 +++++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 100 insertions(+), 3 deletions(-)

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
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -30,6 +30,7 @@ struct scm_fp_list {
 	short			count_unix;
 	short			max;
 #ifdef CONFIG_UNIX
+	bool			inflight;
 	struct list_head	vertices;
 	struct unix_edge	*edges;
 #endif
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -90,6 +90,7 @@ static int scm_fp_copy(struct cmsghdr *c
 		fpl->max = SCM_MAX_FD;
 		fpl->user = NULL;
 #if IS_ENABLED(CONFIG_UNIX)
+		fpl->inflight = false;
 		fpl->edges = NULL;
 		INIT_LIST_HEAD(&fpl->vertices);
 #endif
@@ -380,6 +381,7 @@ struct scm_fp_list *scm_fp_dup(struct sc
 		new_fpl->max = new_fpl->count;
 		new_fpl->user = get_uid(fpl->user);
 #if IS_ENABLED(CONFIG_UNIX)
+		new_fpl->inflight = false;
 		new_fpl->edges = NULL;
 		INIT_LIST_HEAD(&new_fpl->vertices);
 #endif
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1910,8 +1910,10 @@ static void scm_stat_add(struct sock *sk
 	struct scm_fp_list *fp = UNIXCB(skb).fp;
 	struct unix_sock *u = unix_sk(sk);
 
-	if (unlikely(fp && fp->count))
+	if (unlikely(fp && fp->count)) {
 		atomic_add(fp->count, &u->scm_stat.nr_fds);
+		unix_add_edges(fp, u);
+	}
 }
 
 static void scm_stat_del(struct sock *sk, struct sk_buff *skb)
@@ -1919,8 +1921,10 @@ static void scm_stat_del(struct sock *sk
 	struct scm_fp_list *fp = UNIXCB(skb).fp;
 	struct unix_sock *u = unix_sk(sk);
 
-	if (unlikely(fp && fp->count))
+	if (unlikely(fp && fp->count)) {
 		atomic_sub(fp->count, &u->scm_stat.nr_fds);
+		unix_del_edges(fp);
+	}
 }
 
 /*
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -101,6 +101,38 @@ struct unix_sock *unix_get_socket(struct
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
@@ -111,6 +143,60 @@ static void unix_free_vertices(struct sc
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
@@ -141,11 +227,13 @@ err:
 
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



