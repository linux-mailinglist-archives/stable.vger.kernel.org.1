Return-Path: <stable+bounces-145884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D90BEABF97F
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866211BA8BB3
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3628621885D;
	Wed, 21 May 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u634/p1X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29E91EA7C2;
	Wed, 21 May 2025 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841587; cv=none; b=tW8NHDocAN6mry3hxOulXg+OLdkpUK/tIfvIoVy+OQi6N98Jx9jwsnHx4JomLwgaVO2EIODhqEmjG/xzkaK+WWEG+nv/JRdLUwQF5t+b79vL1ug0UZDEX1gwkD53AcV6KFKvTAulS/G/RDdO8yhNZkjeQZQ0UlP1mkWmlu5NSek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841587; c=relaxed/simple;
	bh=uy5+OGLquQ/hI58aGewGRzZaToGymlH4O2HPyG63V1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgqUQn6K0wx/yUcT2wBSbay+joVdbfQ/c7GXZMlDbwxVS9xJQn6DtZP+uhFpwGtBgGigvD561K0qNkajK/76IZnhdqkTdupaogHELH/ZHue9ewnUA5SQ5mC8/Aa71O/3mORnFhc8n99PCUVSIlTi7R1To3Fqn/NQKO3F05CDP1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u634/p1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6490FC4CEE7;
	Wed, 21 May 2025 15:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841586;
	bh=uy5+OGLquQ/hI58aGewGRzZaToGymlH4O2HPyG63V1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u634/p1Xku1Cpj5EXo9jf5o8fUeQW3kQGnhsLg5J5uyM9pZQHwY5jlcVlc7pFRUUK
	 80m1OPxP1UtkCaaRew4EvRwTT7IhjBFWmGMPlEjsVJjHOyvkBN5lu5k+Eu6lPqav7T
	 vgEDoO+91lZheh6w4Uz4vgIu1tNDUOzoVGFgMdo4GqNbiXwUOZYhFZ0G1QUKkVk+mc
	 AT/b1CEhUsQujhLk5A42Xxrk99mw4vhSPs0rbqZHk1OjHKqM9djVn1traUK38LxY+u
	 KwodJBYdTyGPn6K7p/hNCWFqbA3mg3Z/qFqmPu1j/Q7jK93tHnc0iND1i56zJi2I1A
	 qd3agsMoy/ePQ==
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
Subject: [PATCH v6.1 07/27] af_unix: Remove CONFIG_UNIX_SCM.
Date: Wed, 21 May 2025 16:27:06 +0100
Message-ID: <20250521152920.1116756-8-lee@kernel.org>
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

[ Upstream commit 99a7a5b9943ea2d05fb0dee38e4ae2290477ed83 ]

Originally, the code related to garbage collection was all in garbage.c.

Commit f4e65870e5ce ("net: split out functions related to registering
inflight socket files") moved some functions to scm.c for io_uring and
added CONFIG_UNIX_SCM just in case AF_UNIX was built as module.

However, since commit 97154bcf4d1b ("af_unix: Kconfig: make CONFIG_UNIX
bool"), AF_UNIX is no longer built separately.  Also, io_uring does not
support SCM_RIGHTS now.

Let's move the functions back to garbage.c

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Jens Axboe <axboe@kernel.dk>
Link: https://lore.kernel.org/r/20240129190435.57228-4-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 99a7a5b9943ea2d05fb0dee38e4ae2290477ed83)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/net/af_unix.h |   7 +-
 net/Makefile          |   2 +-
 net/unix/Kconfig      |   5 --
 net/unix/Makefile     |   2 -
 net/unix/af_unix.c    |  63 +++++++++++++++++-
 net/unix/garbage.c    |  73 ++++++++++++++++++++-
 net/unix/scm.c        | 149 ------------------------------------------
 net/unix/scm.h        |  10 ---
 8 files changed, 137 insertions(+), 174 deletions(-)
 delete mode 100644 net/unix/scm.c
 delete mode 100644 net/unix/scm.h

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index be488d627531..91d2036fc182 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -17,19 +17,20 @@ static inline struct unix_sock *unix_get_socket(struct file *filp)
 }
 #endif
 
+extern spinlock_t unix_gc_lock;
+extern unsigned int unix_tot_inflight;
+
 void unix_inflight(struct user_struct *user, struct file *fp);
 void unix_notinflight(struct user_struct *user, struct file *fp);
-void unix_destruct_scm(struct sk_buff *skb);
 void unix_gc(void);
 void wait_for_unix_gc(struct scm_fp_list *fpl);
+
 struct sock *unix_peer_get(struct sock *sk);
 
 #define UNIX_HASH_MOD	(256 - 1)
 #define UNIX_HASH_SIZE	(256 * 2)
 #define UNIX_HASH_BITS	8
 
-extern unsigned int unix_tot_inflight;
-
 struct unix_address {
 	refcount_t	refcnt;
 	int		len;
diff --git a/net/Makefile b/net/Makefile
index 0914bea9c335..103cd8d61f68 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_NETFILTER)		+= netfilter/
 obj-$(CONFIG_INET)		+= ipv4/
 obj-$(CONFIG_TLS)		+= tls/
 obj-$(CONFIG_XFRM)		+= xfrm/
-obj-$(CONFIG_UNIX_SCM)		+= unix/
+obj-$(CONFIG_UNIX)		+= unix/
 obj-y				+= ipv6/
 obj-$(CONFIG_BPFILTER)		+= bpfilter/
 obj-$(CONFIG_PACKET)		+= packet/
diff --git a/net/unix/Kconfig b/net/unix/Kconfig
index 28b232f281ab..8b5d04210d7c 100644
--- a/net/unix/Kconfig
+++ b/net/unix/Kconfig
@@ -16,11 +16,6 @@ config UNIX
 
 	  Say Y unless you know what you are doing.
 
-config UNIX_SCM
-	bool
-	depends on UNIX
-	default y
-
 config	AF_UNIX_OOB
 	bool
 	depends on UNIX
diff --git a/net/unix/Makefile b/net/unix/Makefile
index 20491825b4d0..4ddd125c4642 100644
--- a/net/unix/Makefile
+++ b/net/unix/Makefile
@@ -11,5 +11,3 @@ unix-$(CONFIG_BPF_SYSCALL) += unix_bpf.o
 
 obj-$(CONFIG_UNIX_DIAG)	+= unix_diag.o
 unix_diag-y		:= diag.o
-
-obj-$(CONFIG_UNIX_SCM)	+= scm.o
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f74f7878b3fe..7bcc4c526274 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -116,8 +116,6 @@
 #include <linux/file.h>
 #include <linux/btf_ids.h>
 
-#include "scm.h"
-
 static atomic_long_t unix_nr_socks;
 static struct hlist_head bsd_socket_buckets[UNIX_HASH_SIZE / 2];
 static spinlock_t bsd_socket_locks[UNIX_HASH_SIZE / 2];
@@ -1726,6 +1724,52 @@ static int unix_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
 	return err;
 }
 
+/* The "user->unix_inflight" variable is protected by the garbage
+ * collection lock, and we just read it locklessly here. If you go
+ * over the limit, there might be a tiny race in actually noticing
+ * it across threads. Tough.
+ */
+static inline bool too_many_unix_fds(struct task_struct *p)
+{
+	struct user_struct *user = current_user();
+
+	if (unlikely(READ_ONCE(user->unix_inflight) > task_rlimit(p, RLIMIT_NOFILE)))
+		return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
+	return false;
+}
+
+static int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
+{
+	int i;
+
+	if (too_many_unix_fds(current))
+		return -ETOOMANYREFS;
+
+	/* Need to duplicate file references for the sake of garbage
+	 * collection.  Otherwise a socket in the fps might become a
+	 * candidate for GC while the skb is not yet queued.
+	 */
+	UNIXCB(skb).fp = scm_fp_dup(scm->fp);
+	if (!UNIXCB(skb).fp)
+		return -ENOMEM;
+
+	for (i = scm->fp->count - 1; i >= 0; i--)
+		unix_inflight(scm->fp->user, scm->fp->fp[i]);
+
+	return 0;
+}
+
+static void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
+{
+	int i;
+
+	scm->fp = UNIXCB(skb).fp;
+	UNIXCB(skb).fp = NULL;
+
+	for (i = scm->fp->count - 1; i >= 0; i--)
+		unix_notinflight(scm->fp->user, scm->fp->fp[i]);
+}
+
 static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
 {
 	scm->fp = scm_fp_dup(UNIXCB(skb).fp);
@@ -1773,6 +1817,21 @@ static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
 	spin_unlock(&unix_gc_lock);
 }
 
+static void unix_destruct_scm(struct sk_buff *skb)
+{
+	struct scm_cookie scm;
+
+	memset(&scm, 0, sizeof(scm));
+	scm.pid  = UNIXCB(skb).pid;
+	if (UNIXCB(skb).fp)
+		unix_detach_fds(&scm, skb);
+
+	/* Alas, it calls VFS */
+	/* So fscking what? fput() had been SMP-safe since the last Summer */
+	scm_destroy(&scm);
+	sock_wfree(skb);
+}
+
 static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool send_fds)
 {
 	int err = 0;
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index c04f82489abb..0104be9d4704 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -81,11 +81,80 @@
 #include <net/scm.h>
 #include <net/tcp_states.h>
 
-#include "scm.h"
+struct unix_sock *unix_get_socket(struct file *filp)
+{
+	struct inode *inode = file_inode(filp);
+
+	/* Socket ? */
+	if (S_ISSOCK(inode->i_mode) && !(filp->f_mode & FMODE_PATH)) {
+		struct socket *sock = SOCKET_I(inode);
+		const struct proto_ops *ops;
+		struct sock *sk = sock->sk;
 
-/* Internal data structures and random procedures: */
+		ops = READ_ONCE(sock->ops);
 
+		/* PF_UNIX ? */
+		if (sk && ops && ops->family == PF_UNIX)
+			return unix_sk(sk);
+	}
+
+	return NULL;
+}
+
+DEFINE_SPINLOCK(unix_gc_lock);
+unsigned int unix_tot_inflight;
 static LIST_HEAD(gc_candidates);
+static LIST_HEAD(gc_inflight_list);
+
+/* Keep the number of times in flight count for the file
+ * descriptor if it is for an AF_UNIX socket.
+ */
+void unix_inflight(struct user_struct *user, struct file *filp)
+{
+	struct unix_sock *u = unix_get_socket(filp);
+
+	spin_lock(&unix_gc_lock);
+
+	if (u) {
+		if (!u->inflight) {
+			WARN_ON_ONCE(!list_empty(&u->link));
+			list_add_tail(&u->link, &gc_inflight_list);
+		} else {
+			WARN_ON_ONCE(list_empty(&u->link));
+		}
+		u->inflight++;
+
+		/* Paired with READ_ONCE() in wait_for_unix_gc() */
+		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + 1);
+	}
+
+	WRITE_ONCE(user->unix_inflight, user->unix_inflight + 1);
+
+	spin_unlock(&unix_gc_lock);
+}
+
+void unix_notinflight(struct user_struct *user, struct file *filp)
+{
+	struct unix_sock *u = unix_get_socket(filp);
+
+	spin_lock(&unix_gc_lock);
+
+	if (u) {
+		WARN_ON_ONCE(!u->inflight);
+		WARN_ON_ONCE(list_empty(&u->link));
+
+		u->inflight--;
+		if (!u->inflight)
+			list_del_init(&u->link);
+
+		/* Paired with READ_ONCE() in wait_for_unix_gc() */
+		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - 1);
+	}
+
+	WRITE_ONCE(user->unix_inflight, user->unix_inflight - 1);
+
+	spin_unlock(&unix_gc_lock);
+}
 
 static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
 			  struct sk_buff_head *hitlist)
diff --git a/net/unix/scm.c b/net/unix/scm.c
deleted file mode 100644
index 6f446dd2deed..000000000000
--- a/net/unix/scm.c
+++ /dev/null
@@ -1,149 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/socket.h>
-#include <linux/net.h>
-#include <linux/fs.h>
-#include <net/af_unix.h>
-#include <net/scm.h>
-#include <linux/init.h>
-#include <linux/io_uring.h>
-
-#include "scm.h"
-
-unsigned int unix_tot_inflight;
-EXPORT_SYMBOL(unix_tot_inflight);
-
-LIST_HEAD(gc_inflight_list);
-EXPORT_SYMBOL(gc_inflight_list);
-
-DEFINE_SPINLOCK(unix_gc_lock);
-EXPORT_SYMBOL(unix_gc_lock);
-
-struct unix_sock *unix_get_socket(struct file *filp)
-{
-	struct inode *inode = file_inode(filp);
-
-	/* Socket ? */
-	if (S_ISSOCK(inode->i_mode) && !(filp->f_mode & FMODE_PATH)) {
-		struct socket *sock = SOCKET_I(inode);
-		struct sock *s = sock->sk;
-
-		/* PF_UNIX ? */
-		if (s && sock->ops && sock->ops->family == PF_UNIX)
-			return unix_sk(s);
-	}
-
-	return NULL;
-}
-EXPORT_SYMBOL(unix_get_socket);
-
-/* Keep the number of times in flight count for the file
- * descriptor if it is for an AF_UNIX socket.
- */
-void unix_inflight(struct user_struct *user, struct file *fp)
-{
-	struct unix_sock *u = unix_get_socket(fp);
-
-	spin_lock(&unix_gc_lock);
-
-	if (u) {
-		if (!u->inflight) {
-			WARN_ON_ONCE(!list_empty(&u->link));
-			list_add_tail(&u->link, &gc_inflight_list);
-		} else {
-			WARN_ON_ONCE(list_empty(&u->link));
-		}
-		u->inflight++;
-		/* Paired with READ_ONCE() in wait_for_unix_gc() */
-		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + 1);
-	}
-	WRITE_ONCE(user->unix_inflight, user->unix_inflight + 1);
-	spin_unlock(&unix_gc_lock);
-}
-
-void unix_notinflight(struct user_struct *user, struct file *fp)
-{
-	struct unix_sock *u = unix_get_socket(fp);
-
-	spin_lock(&unix_gc_lock);
-
-	if (u) {
-		WARN_ON_ONCE(!u->inflight);
-		WARN_ON_ONCE(list_empty(&u->link));
-
-		u->inflight--;
-		if (!u->inflight)
-			list_del_init(&u->link);
-		/* Paired with READ_ONCE() in wait_for_unix_gc() */
-		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - 1);
-	}
-	WRITE_ONCE(user->unix_inflight, user->unix_inflight - 1);
-	spin_unlock(&unix_gc_lock);
-}
-
-/*
- * The "user->unix_inflight" variable is protected by the garbage
- * collection lock, and we just read it locklessly here. If you go
- * over the limit, there might be a tiny race in actually noticing
- * it across threads. Tough.
- */
-static inline bool too_many_unix_fds(struct task_struct *p)
-{
-	struct user_struct *user = current_user();
-
-	if (unlikely(READ_ONCE(user->unix_inflight) > task_rlimit(p, RLIMIT_NOFILE)))
-		return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
-	return false;
-}
-
-int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
-{
-	int i;
-
-	if (too_many_unix_fds(current))
-		return -ETOOMANYREFS;
-
-	/*
-	 * Need to duplicate file references for the sake of garbage
-	 * collection.  Otherwise a socket in the fps might become a
-	 * candidate for GC while the skb is not yet queued.
-	 */
-	UNIXCB(skb).fp = scm_fp_dup(scm->fp);
-	if (!UNIXCB(skb).fp)
-		return -ENOMEM;
-
-	for (i = scm->fp->count - 1; i >= 0; i--)
-		unix_inflight(scm->fp->user, scm->fp->fp[i]);
-	return 0;
-}
-EXPORT_SYMBOL(unix_attach_fds);
-
-void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
-{
-	int i;
-
-	scm->fp = UNIXCB(skb).fp;
-	UNIXCB(skb).fp = NULL;
-
-	for (i = scm->fp->count-1; i >= 0; i--)
-		unix_notinflight(scm->fp->user, scm->fp->fp[i]);
-}
-EXPORT_SYMBOL(unix_detach_fds);
-
-void unix_destruct_scm(struct sk_buff *skb)
-{
-	struct scm_cookie scm;
-
-	memset(&scm, 0, sizeof(scm));
-	scm.pid  = UNIXCB(skb).pid;
-	if (UNIXCB(skb).fp)
-		unix_detach_fds(&scm, skb);
-
-	/* Alas, it calls VFS */
-	/* So fscking what? fput() had been SMP-safe since the last Summer */
-	scm_destroy(&scm);
-	sock_wfree(skb);
-}
-EXPORT_SYMBOL(unix_destruct_scm);
diff --git a/net/unix/scm.h b/net/unix/scm.h
deleted file mode 100644
index 5a255a477f16..000000000000
--- a/net/unix/scm.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef NET_UNIX_SCM_H
-#define NET_UNIX_SCM_H
-
-extern struct list_head gc_inflight_list;
-extern spinlock_t unix_gc_lock;
-
-int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb);
-void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb);
-
-#endif
-- 
2.49.0.1143.g0be31eac6b-goog


