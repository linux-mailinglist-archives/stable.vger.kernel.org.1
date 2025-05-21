Return-Path: <stable+bounces-145899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AF6ABF9C1
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F00DA20266
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C1A22A1ED;
	Wed, 21 May 2025 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npabVo0V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD63922157E;
	Wed, 21 May 2025 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841693; cv=none; b=qdOT9s8WuC8kINzQseoWvEwGFp5/346DeQ9v2yYZlqY791KUxjUFBqEvXQGR6D9flvIqzg/jT/Eru6lgtJje4YiAnIekcJcl7FoNsTjQYoUSghpmGO4YPBH65FnK5L0tEbpidEMkxJhl1p3xkYlAIffqcuForMXLmUPJg6FanYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841693; c=relaxed/simple;
	bh=ERiCiUGqcRQ1G1WKLLAB8HnGpZKvb8P/HcN8e3Z+wu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azXJ0YY7BVgmWUUkknBlYBZFwwyqBRIrl1utp306ON7d5jUBaBsr7h9dDaPGJp7N0Mot9sKYHkTBC2KCKzBPKA5SvBc2KbqiO+2ZsRkBtvMXqcbqK4SDrr2VdDUyD/gYQAwQmuVFa/as1MRB2xAvgIaSttR2BYBXXcW5auuXvU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npabVo0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969CCC4CEE4;
	Wed, 21 May 2025 15:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841693;
	bh=ERiCiUGqcRQ1G1WKLLAB8HnGpZKvb8P/HcN8e3Z+wu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=npabVo0VCqqr9MC01PtJU4I23drif1Zf7URdVhwAc+nC0Q07mCjuF3WqYNf1hVvkJ
	 HNMGcNjvUo4pTuIS7aOQ4c2xauA0mPRLf91ePdXyMtNOH6H68nSjfqlT8xNHMtMN6z
	 jU/DO5GI81fP7XAw2pnCpXeaxrp4KOPmJ99lc/cYJAMiifDXCZZmOwpiqXeAV/hXh4
	 zuW4xH0mIyMJTituBavBC48IMImsKOG5Qt1Alf5NTWOJCzmCinN9Ap5FT9MQzy/3Wp
	 jVuhXM3/weCR4irf3NIWj05jRFofArqc63GDpd67EqDq5mQ37uPmBKTfkTGwackJSy
	 xqmG2gVWd8IJA==
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
Subject: [PATCH v6.1 22/27] af_unix: Remove lock dance in unix_peek_fds().
Date: Wed, 21 May 2025 16:27:21 +0100
Message-ID: <20250521152920.1116756-23-lee@kernel.org>
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

[ Upstream commit 118f457da9ed58a79e24b73c2ef0aa1987241f0e ]

In the previous GC implementation, the shape of the inflight socket
graph was not expected to change while GC was in progress.

MSG_PEEK was tricky because it could install inflight fd silently
and transform the graph.

Let's say we peeked a fd, which was a listening socket, and accept()ed
some embryo sockets from it.  The garbage collection algorithm would
have been confused because the set of sockets visited in scan_inflight()
would change within the same GC invocation.

That's why we placed spin_lock(&unix_gc_lock) and spin_unlock() in
unix_peek_fds() with a fat comment.

In the new GC implementation, we no longer garbage-collect the socket
if it exists in another queue, that is, if it has a bridge to another
SCC.  Also, accept() will require the lock if it has edges.

Thus, we need not do the complicated lock dance.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20240401173125.92184-3-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 118f457da9ed58a79e24b73c2ef0aa1987241f0e)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/net/af_unix.h |  1 -
 net/unix/af_unix.c    | 42 ------------------------------------------
 net/unix/garbage.c    |  2 +-
 3 files changed, 1 insertion(+), 44 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 47808e366731..4c726df56c0b 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -17,7 +17,6 @@ static inline struct unix_sock *unix_get_socket(struct file *filp)
 }
 #endif
 
-extern spinlock_t unix_gc_lock;
 extern unsigned int unix_tot_inflight;
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver);
 void unix_del_edges(struct scm_fp_list *fpl);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 25f66adf47d1..ce5b74dfd8ae 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1770,48 +1770,6 @@ static void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
 {
 	scm->fp = scm_fp_dup(UNIXCB(skb).fp);
-
-	/*
-	 * Garbage collection of unix sockets starts by selecting a set of
-	 * candidate sockets which have reference only from being in flight
-	 * (total_refs == inflight_refs).  This condition is checked once during
-	 * the candidate collection phase, and candidates are marked as such, so
-	 * that non-candidates can later be ignored.  While inflight_refs is
-	 * protected by unix_gc_lock, total_refs (file count) is not, hence this
-	 * is an instantaneous decision.
-	 *
-	 * Once a candidate, however, the socket must not be reinstalled into a
-	 * file descriptor while the garbage collection is in progress.
-	 *
-	 * If the above conditions are met, then the directed graph of
-	 * candidates (*) does not change while unix_gc_lock is held.
-	 *
-	 * Any operations that changes the file count through file descriptors
-	 * (dup, close, sendmsg) does not change the graph since candidates are
-	 * not installed in fds.
-	 *
-	 * Dequeing a candidate via recvmsg would install it into an fd, but
-	 * that takes unix_gc_lock to decrement the inflight count, so it's
-	 * serialized with garbage collection.
-	 *
-	 * MSG_PEEK is special in that it does not change the inflight count,
-	 * yet does install the socket into an fd.  The following lock/unlock
-	 * pair is to ensure serialization with garbage collection.  It must be
-	 * done between incrementing the file count and installing the file into
-	 * an fd.
-	 *
-	 * If garbage collection starts after the barrier provided by the
-	 * lock/unlock, then it will see the elevated refcount and not mark this
-	 * as a candidate.  If a garbage collection is already in progress
-	 * before the file count was incremented, then the lock/unlock pair will
-	 * ensure that garbage collection is finished before progressing to
-	 * installing the fd.
-	 *
-	 * (*) A -> B where B is on the queue of A or B is on the queue of C
-	 * which is on the queue of listening socket A.
-	 */
-	spin_lock(&unix_gc_lock);
-	spin_unlock(&unix_gc_lock);
 }
 
 static void unix_destruct_scm(struct sk_buff *skb)
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 89ea71d9297b..12a4ec27e0d4 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -183,7 +183,7 @@ static void unix_free_vertices(struct scm_fp_list *fpl)
 	}
 }
 
-DEFINE_SPINLOCK(unix_gc_lock);
+static DEFINE_SPINLOCK(unix_gc_lock);
 unsigned int unix_tot_inflight;
 
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
-- 
2.49.0.1143.g0be31eac6b-goog


