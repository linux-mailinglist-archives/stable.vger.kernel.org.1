Return-Path: <stable+bounces-145854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ACAABF849
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C040F3B2500
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6521C21E091;
	Wed, 21 May 2025 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGMETCHK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD091DF72C;
	Wed, 21 May 2025 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839019; cv=none; b=QqWx+iv92uIWpCar0CtRB8tNycd0AjyA7Rw9GZUqhVY1kDanNeUo4H+gAsvo7hQ7o3pX1N/h5nRpIbfwCC1E4BRR+YWbh4FRss2tNFJ8pZrnsqoTxj7Cf5DLldPdU4sQBqUQqq+xgjkW+8pYIr8exxkUAjmvBh0i64bF50Rb6H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839019; c=relaxed/simple;
	bh=TOLrDA2eeMqe0vtTBtCmPHLnSNOa4XzbiEXn1PfbsmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8YPc8Vw9YlpWNzL/ElGF7AuryZgqt+GAO7N7Jy1BGBvyQKbrrzf/GcWAtRt6v4R+6EVvwBX7LmRO4sJQTVXfq2kAIEnJKx9wnfqEWO3xCFqeKmX1dLigie4HyoM52348Ar45Miky3zy3X8ImgpQiNft9yFasIj9mpvnCwx1ujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGMETCHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E9CC4CEE4;
	Wed, 21 May 2025 14:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747839018;
	bh=TOLrDA2eeMqe0vtTBtCmPHLnSNOa4XzbiEXn1PfbsmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DGMETCHKjyHaPOa5wxkCkC/AOqg/az0lIPJnyOVODKa1xqg1SWzWbNLO6zT3WNKsI
	 27ko9aiFCBK3/zLYNGw68+SiWM+OzTq6q7h6FXbBlq1IoWto4OQCKuUuRllPlxRMEK
	 103GF/LeohFTIWioFzhBYpCg+sr5K9cRGou2jDIn+0vxu9BZQU3ANyoUjhAmGi1yQP
	 B5Af6pJNmS/qSavfREQZFCFZhyOb+9oLU/5zwtAoPNj1Jm/7U1AoDVzWAvHCQUWysP
	 ZUdfuVEtVeQF1AtY4LkPCxHDR71j/6mMvuHu0MdKmgUV0Dm7HS19VujUvp1bVHi3Gu
	 27Pu8rqQS07dA==
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
Subject: [PATCH v6.6 07/26] af_unix: Allocate struct unix_vertex for each inflight AF_UNIX fd.
Date: Wed, 21 May 2025 14:45:15 +0000
Message-ID: <20250521144803.2050504-8-lee@kernel.org>
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

[ Upstream commit 1fbfdfaa590248c1d86407f578e40e5c65136330 ]

We will replace the garbage collection algorithm for AF_UNIX, where
we will consider each inflight AF_UNIX socket as a vertex and its file
descriptor as an edge in a directed graph.

This patch introduces a new struct unix_vertex representing a vertex
in the graph and adds its pointer to struct unix_sock.

When we send a fd using the SCM_RIGHTS message, we allocate struct
scm_fp_list to struct scm_cookie in scm_fp_copy().  Then, we bump
each refcount of the inflight fds' struct file and save them in
scm_fp_list.fp.

After that, unix_attach_fds() inexplicably clones scm_fp_list of
scm_cookie and sets it to skb.  (We will remove this part after
replacing GC.)

Here, we add a new function call in unix_attach_fds() to preallocate
struct unix_vertex per inflight AF_UNIX fd and link each vertex to
skb's scm_fp_list.vertices.

When sendmsg() succeeds later, if the socket of the inflight fd is
still not inflight yet, we will set the preallocated vertex to struct
unix_sock.vertex and link it to a global list unix_unvisited_vertices
under spin_lock(&unix_gc_lock).

If the socket is already inflight, we free the preallocated vertex.
This is to avoid taking the lock unnecessarily when sendmsg() could
fail later.

In the following patch, we will similarly allocate another struct
per edge, which will finally be linked to the inflight socket's
unix_vertex.edges.

And then, we will count the number of edges as unix_vertex.out_degree.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20240325202425.60930-2-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 1fbfdfaa590248c1d86407f578e40e5c65136330)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/net/af_unix.h |  9 +++++++++
 include/net/scm.h     |  3 +++
 net/core/scm.c        |  7 +++++++
 net/unix/af_unix.c    |  6 ++++++
 net/unix/garbage.c    | 38 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 3dee0b2721aa4..07f0f698c9490 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -22,9 +22,17 @@ extern unsigned int unix_tot_inflight;
 
 void unix_inflight(struct user_struct *user, struct file *fp);
 void unix_notinflight(struct user_struct *user, struct file *fp);
+int unix_prepare_fpl(struct scm_fp_list *fpl);
+void unix_destroy_fpl(struct scm_fp_list *fpl);
 void unix_gc(void);
 void wait_for_unix_gc(struct scm_fp_list *fpl);
 
+struct unix_vertex {
+	struct list_head edges;
+	struct list_head entry;
+	unsigned long out_degree;
+};
+
 struct sock *unix_peer_get(struct sock *sk);
 
 #define UNIX_HASH_MOD	(256 - 1)
@@ -62,6 +70,7 @@ struct unix_sock {
 	struct path		path;
 	struct mutex		iolock, bindlock;
 	struct sock		*peer;
+	struct unix_vertex	*vertex;
 	struct list_head	link;
 	unsigned long		inflight;
 	spinlock_t		lock;
diff --git a/include/net/scm.h b/include/net/scm.h
index 1ff6a28550644..11e86e55f332d 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -26,6 +26,9 @@ struct scm_fp_list {
 	short			count;
 	short			count_unix;
 	short			max;
+#ifdef CONFIG_UNIX
+	struct list_head	vertices;
+#endif
 	struct user_struct	*user;
 	struct file		*fp[SCM_MAX_FD];
 };
diff --git a/net/core/scm.c b/net/core/scm.c
index 574607b1c2d96..27e5634c958e8 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -89,6 +89,9 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 		fpl->count_unix = 0;
 		fpl->max = SCM_MAX_FD;
 		fpl->user = NULL;
+#if IS_ENABLED(CONFIG_UNIX)
+		INIT_LIST_HEAD(&fpl->vertices);
+#endif
 	}
 	fpp = &fpl->fp[fpl->count];
 
@@ -376,8 +379,12 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl)
 	if (new_fpl) {
 		for (i = 0; i < fpl->count; i++)
 			get_file(fpl->fp[i]);
+
 		new_fpl->max = new_fpl->count;
 		new_fpl->user = get_uid(fpl->user);
+#if IS_ENABLED(CONFIG_UNIX)
+		INIT_LIST_HEAD(&new_fpl->vertices);
+#endif
 	}
 	return new_fpl;
 }
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 78758af2c6f38..6d62fa5b0e68d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -979,6 +979,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	sk->sk_destruct		= unix_sock_destructor;
 	u = unix_sk(sk);
 	u->inflight = 0;
+	u->vertex = NULL;
 	u->path.dentry = NULL;
 	u->path.mnt = NULL;
 	spin_lock_init(&u->lock);
@@ -1782,6 +1783,9 @@ static int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 	for (i = scm->fp->count - 1; i >= 0; i--)
 		unix_inflight(scm->fp->user, scm->fp->fp[i]);
 
+	if (unix_prepare_fpl(UNIXCB(skb).fp))
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -1792,6 +1796,8 @@ static void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 	scm->fp = UNIXCB(skb).fp;
 	UNIXCB(skb).fp = NULL;
 
+	unix_destroy_fpl(scm->fp);
+
 	for (i = scm->fp->count - 1; i >= 0; i--)
 		unix_notinflight(scm->fp->user, scm->fp->fp[i]);
 }
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 0104be9d47045..8ea7640e032e8 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -101,6 +101,44 @@ struct unix_sock *unix_get_socket(struct file *filp)
 	return NULL;
 }
 
+static void unix_free_vertices(struct scm_fp_list *fpl)
+{
+	struct unix_vertex *vertex, *next_vertex;
+
+	list_for_each_entry_safe(vertex, next_vertex, &fpl->vertices, entry) {
+		list_del(&vertex->entry);
+		kfree(vertex);
+	}
+}
+
+int unix_prepare_fpl(struct scm_fp_list *fpl)
+{
+	struct unix_vertex *vertex;
+	int i;
+
+	if (!fpl->count_unix)
+		return 0;
+
+	for (i = 0; i < fpl->count_unix; i++) {
+		vertex = kmalloc(sizeof(*vertex), GFP_KERNEL);
+		if (!vertex)
+			goto err;
+
+		list_add(&vertex->entry, &fpl->vertices);
+	}
+
+	return 0;
+
+err:
+	unix_free_vertices(fpl);
+	return -ENOMEM;
+}
+
+void unix_destroy_fpl(struct scm_fp_list *fpl)
+{
+	unix_free_vertices(fpl);
+}
+
 DEFINE_SPINLOCK(unix_gc_lock);
 unsigned int unix_tot_inflight;
 static LIST_HEAD(gc_candidates);
-- 
2.49.0.1112.g889b7c5bd8-goog


