Return-Path: <stable+bounces-150548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B472ACB6E3
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE1197A8D8A
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5436F1C6FE9;
	Mon,  2 Jun 2025 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o0RvhqZw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3842288C6;
	Mon,  2 Jun 2025 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877470; cv=none; b=q4nbteUhbmq8nCrtTMjtkOkgt9kqGm2w2FMRn216sV2gT/b9xgDGzA906MOxlZmZ8u818C9B1FTIyBLBymLa/mQFzMK1ZoxLYOsHISMI4v89YkEKyXCE5QqT5FLPyXJgyrsVrqzOtN1VYUxrGKYDBB1njI2HHl6spS0/Os8Y/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877470; c=relaxed/simple;
	bh=Yhdhc5pVNb2Mmsa0dc5xUh5OSirQE8aXYEJumBu7Dtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=artX82dBSKJa6pSGbDfzxqlZxfoKonGT7fNE0Xyw+nOqA/qBwhVuo1bfEZG+55dXzOsupNvEHjj52R97oCa+GrbEzJoH2fcqBxbqSKxbiKFWO9klXDblbdzBFnYy0OG2NT9rDzF3fvr8o7jrsUhwReI00O94ww54K+++3ik4Jbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o0RvhqZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5E6C4CEEB;
	Mon,  2 Jun 2025 15:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748877469;
	bh=Yhdhc5pVNb2Mmsa0dc5xUh5OSirQE8aXYEJumBu7Dtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0RvhqZwYXpHW/u7G525ev8tf1DElHusGVeV5NId6XfMa63jx+DWyQgoLGPoNmTvr
	 NImkFdM7k2Q20D6mbxTgk8rPYR5amjzz+4tlhfGo+1iGIo8UDPc59iGxIyVAmt24km
	 F3J5tvcW6YUjWcKdRRne/Uz4LGFMtP4+opxaeiI0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 6.1 288/325] af_unix: Allocate struct unix_vertex for each inflight AF_UNIX fd.
Date: Mon,  2 Jun 2025 15:49:24 +0200
Message-ID: <20250602134331.605277689@linuxfoundation.org>
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

commit 1fbfdfaa590248c1d86407f578e40e5c65136330 upstream.

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
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/af_unix.h |    9 +++++++++
 include/net/scm.h     |    3 +++
 net/core/scm.c        |    7 +++++++
 net/unix/af_unix.c    |    6 ++++++
 net/unix/garbage.c    |   38 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+)

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
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -25,6 +25,9 @@ struct scm_fp_list {
 	short			count;
 	short			count_unix;
 	short			max;
+#ifdef CONFIG_UNIX
+	struct list_head	vertices;
+#endif
 	struct user_struct	*user;
 	struct file		*fp[SCM_MAX_FD];
 };
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -89,6 +89,9 @@ static int scm_fp_copy(struct cmsghdr *c
 		fpl->count_unix = 0;
 		fpl->max = SCM_MAX_FD;
 		fpl->user = NULL;
+#if IS_ENABLED(CONFIG_UNIX)
+		INIT_LIST_HEAD(&fpl->vertices);
+#endif
 	}
 	fpp = &fpl->fp[fpl->count];
 
@@ -372,8 +375,12 @@ struct scm_fp_list *scm_fp_dup(struct sc
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
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -955,6 +955,7 @@ static struct sock *unix_create1(struct
 	sk->sk_destruct		= unix_sock_destructor;
 	u = unix_sk(sk);
 	u->inflight = 0;
+	u->vertex = NULL;
 	u->path.dentry = NULL;
 	u->path.mnt = NULL;
 	spin_lock_init(&u->lock);
@@ -1756,6 +1757,9 @@ static int unix_attach_fds(struct scm_co
 	for (i = scm->fp->count - 1; i >= 0; i--)
 		unix_inflight(scm->fp->user, scm->fp->fp[i]);
 
+	if (unix_prepare_fpl(UNIXCB(skb).fp))
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -1766,6 +1770,8 @@ static void unix_detach_fds(struct scm_c
 	scm->fp = UNIXCB(skb).fp;
 	UNIXCB(skb).fp = NULL;
 
+	unix_destroy_fpl(scm->fp);
+
 	for (i = scm->fp->count - 1; i >= 0; i--)
 		unix_notinflight(scm->fp->user, scm->fp->fp[i]);
 }
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -101,6 +101,44 @@ struct unix_sock *unix_get_socket(struct
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



