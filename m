Return-Path: <stable+bounces-254243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPvwILYzFWqPTgcAu9opvQ
	(envelope-from <stable+bounces-254243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 07:46:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EA45D0F03
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 07:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 246D33027307
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 05:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC733BFAEB;
	Tue, 26 May 2026 05:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="tlCsLrJH"
X-Original-To: stable@vger.kernel.org
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6E33955FD
	for <stable@vger.kernel.org>; Tue, 26 May 2026 05:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779774366; cv=none; b=fvCzeaibRQkUzn+6I0OmjTQ5I3U4n8dVtblYYdAx5iuScuSSV4uq8NnHrDEONP/FIUsr45dL06GtuyiEFWm+d51Cs7pGVaXLtSZNHD5Ex1sc9DPShGwaKWzV7drmST3ynj8M/3kEggrCpPitUHYPFKi3T0tlD6U07lzCmIlsbPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779774366; c=relaxed/simple;
	bh=LHT1H2JF1c4Umnk7Rhla19JSZMpgZuUVnmrrZubISbU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=T9FWjsbSLAmBz7G7FfkIXl4n7IVl+QM4RE76RUxzhoEuA8nJ+Y3hmzNG5nNdeM/+9DYBo5xAG+2L+ke+/AWOin3oNuvPCRw+P7d8pT4Bd6l8ER3UUznTIO3gIElWtzTRWBlVv1lr56iGb8UzenK1kY3wngDbQTlJ2+zI+0C+bLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=tlCsLrJH; arc=none smtp.client-ip=120.232.169.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=tlCsLrJHif6IaBfWGUbR5RLuJwxnZCQQh4FhSz0dltF8fbSFW08sK0rnTSQqHrfd00Ta90r61Owyh
	 FlVpPieuK/ViCgVnPfiAZIrw/d0Zsr6T5dHWByUTgSjBpoYB2yMIlxLzsMhx74UJIyqWBpRtriJgar
	 zb1b8g0h0phv+0mA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from China-Mobile-Kernel-Team (unknown[106.121.166.134])
	by rmsmtp-lg-appmail-22-12025 (RichMail) with SMTP id 2ef96a15338df88-9c93a;
	Tue, 26 May 2026 13:45:51 +0800 (CST)
X-RM-TRANSID:2ef96a15338df88-9c93a
From: Leon Chen <leonchen.oss@139.com>
To: kuniyu@google.com,
	kuba@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.12.y] af_unix: Give up GC if MSG_PEEK intervened.
Date: Tue, 26 May 2026 13:45:49 +0800
Message-Id: <20260526054549.3962-1-leonchen.oss@139.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254243-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[139.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonchen.oss@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.892];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,139.com:mid,139.com:email]
X-Rspamd-Queue-Id: 39EA45D0F03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit e5b31d988a41549037b8d8721a3c3cae893d8670 ]

Igor Ushakov reported that GC purged the receive queue of
an alive socket due to a race with MSG_PEEK with a nice repro.

This is the exact same issue previously fixed by commit
cbcf01128d0a ("af_unix: fix garbage collect vs MSG_PEEK").

After GC was replaced with the current algorithm, the cited
commit removed the locking dance in unix_peek_fds() and
reintroduced the same issue.

The problem is that MSG_PEEK bumps a file refcount without
interacting with GC.

Consider an SCC containing sk-A and sk-B, where sk-A is
close()d but can be recv()ed via sk-B.

The bad thing happens if sk-A is recv()ed with MSG_PEEK from
sk-B and sk-B is close()d while GC is checking unix_vertex_dead()
for sk-A and sk-B.

  GC thread                    User thread
  ---------                    -----------
  unix_vertex_dead(sk-A)
  -> true   <------.
                    \
                     `------   recv(sk-B, MSG_PEEK)
              invalidate !!    -> sk-A's file refcount : 1 -> 2

                               close(sk-B)
                               -> sk-B's file refcount : 2 -> 1
  unix_vertex_dead(sk-B)
  -> true

Initially, sk-A's file refcount is 1 by the inflight fd in sk-B
recvq.  GC thinks sk-A is dead because the file refcount is the
same as the number of its inflight fds.

However, sk-A's file refcount is bumped silently by MSG_PEEK,
which invalidates the previous evaluation.

At this moment, sk-B's file refcount is 2; one by the open fd,
and one by the inflight fd in sk-A.  The subsequent close()
releases one refcount by the former.

Finally, GC incorrectly concludes that both sk-A and sk-B are dead.

One option is to restore the locking dance in unix_peek_fds(),
but we can resolve this more elegantly thanks to the new algorithm.

The point is that the issue does not occur without the subsequent
close() and we actually do not need to synchronise MSG_PEEK with
the dead SCC detection.

When the issue occurs, close() and GC touch the same file refcount.
If GC sees the refcount being decremented by close(), it can just
give up garbage-collecting the SCC.

Therefore, we only need to signal the race during MSG_PEEK with
a proper memory barrier to make it visible to the GC.

Let's use seqcount_t to notify GC when MSG_PEEK occurs and let
it defer the SCC to the next run.

This way no locking is needed on the MSG_PEEK side, and we can
avoid imposing a penalty on every MSG_PEEK unnecessarily.

Note that we can retry within unix_scc_dead() if MSG_PEEK is
detected, but we do not do so to avoid hung task splat from
abusive MSG_PEEK calls.

Fixes: 118f457da9ed ("af_unix: Remove lock dance in unix_peek_fds().")
Reported-by: Igor Ushakov <sysroot314@gmail.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260311054043.1231316-1-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Using include/net/af_unix.h instead of net/unix/af_unix.h on 6.12.y ]
Signed-off-by: Leon Chen <leonchen.oss@139.com>
---
 include/net/af_unix.h |  1 +
 net/unix/af_unix.c    |  2 ++
 net/unix/garbage.c    | 79 ++++++++++++++++++++++++++++---------------
 3 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 63129c79b8cb..8cacc5290d8b 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -23,6 +23,7 @@ void unix_del_edges(struct scm_fp_list *fpl);
 void unix_update_edges(struct unix_sock *receiver);
 int unix_prepare_fpl(struct scm_fp_list *fpl);
 void unix_destroy_fpl(struct scm_fp_list *fpl);
+void unix_peek_fpl(struct scm_fp_list *fpl);
 void unix_gc(void);
 void wait_for_unix_gc(struct scm_fp_list *fpl);
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 77976f36c4aa..9c5a812bd681 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1878,6 +1878,8 @@ static void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
 {
 	scm->fp = scm_fp_dup(UNIXCB(skb).fp);
+
+	unix_peek_fpl(scm->fp);
 }
 
 static void unix_destruct_scm(struct sk_buff *skb)
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 66fd606c43f4..1cdb54c61619 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -306,6 +306,25 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
 	unix_free_vertices(fpl);
 }
 
+static bool gc_in_progress;
+static seqcount_t unix_peek_seq = SEQCNT_ZERO(unix_peek_seq);
+
+void unix_peek_fpl(struct scm_fp_list *fpl)
+{
+	static DEFINE_SPINLOCK(unix_peek_lock);
+
+	if (!fpl || !fpl->count_unix)
+		return;
+
+	if (!READ_ONCE(gc_in_progress))
+		return;
+
+	/* Invalidate the final refcnt check in unix_vertex_dead(). */
+	spin_lock(&unix_peek_lock);
+	raw_write_seqcount_barrier(&unix_peek_seq);
+	spin_unlock(&unix_peek_lock);
+}
+
 static bool unix_vertex_dead(struct unix_vertex *vertex)
 {
 	struct unix_edge *edge;
@@ -339,6 +358,36 @@ static bool unix_vertex_dead(struct unix_vertex *vertex)
 	return true;
 }
 
+static LIST_HEAD(unix_visited_vertices);
+static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
+
+static bool unix_scc_dead(struct list_head *scc, bool fast)
+{
+	struct unix_vertex *vertex;
+	bool scc_dead = true;
+	unsigned int seq;
+
+	seq = read_seqcount_begin(&unix_peek_seq);
+
+	list_for_each_entry_reverse(vertex, scc, scc_entry) {
+		/* Don't restart DFS from this vertex. */
+		list_move_tail(&vertex->entry, &unix_visited_vertices);
+
+		/* Mark vertex as off-stack for __unix_walk_scc(). */
+		if (!fast)
+			vertex->index = unix_vertex_grouped_index;
+
+		if (scc_dead)
+			scc_dead = unix_vertex_dead(vertex);
+	}
+
+	/* If MSG_PEEK intervened, defer this SCC to the next round. */
+	if (read_seqcount_retry(&unix_peek_seq, seq))
+		return false;
+
+	return scc_dead;
+}
+
 static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist)
 {
 	struct unix_vertex *vertex;
@@ -392,9 +441,6 @@ static bool unix_scc_cyclic(struct list_head *scc)
 	return false;
 }
 
-static LIST_HEAD(unix_visited_vertices);
-static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
-
 static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_index,
 			    struct sk_buff_head *hitlist)
 {
@@ -460,9 +506,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
 	}
 
 	if (vertex->index == vertex->scc_index) {
-		struct unix_vertex *v;
 		struct list_head scc;
-		bool scc_dead = true;
 
 		/* SCC finalised.
 		 *
@@ -471,18 +515,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
 		 */
 		__list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
 
-		list_for_each_entry_reverse(v, &scc, scc_entry) {
-			/* Don't restart DFS from this vertex in unix_walk_scc(). */
-			list_move_tail(&v->entry, &unix_visited_vertices);
-
-			/* Mark vertex as off-stack. */
-			v->index = unix_vertex_grouped_index;
-
-			if (scc_dead)
-				scc_dead = unix_vertex_dead(v);
-		}
-
-		if (scc_dead) {
+		if (unix_scc_dead(&scc, false)) {
 			unix_collect_skb(&scc, hitlist);
 		} else {
 			if (unix_vertex_max_scc_index < vertex->scc_index)
@@ -530,19 +563,11 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 	while (!list_empty(&unix_unvisited_vertices)) {
 		struct unix_vertex *vertex;
 		struct list_head scc;
-		bool scc_dead = true;
 
 		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
 		list_add(&scc, &vertex->scc_entry);
 
-		list_for_each_entry_reverse(vertex, &scc, scc_entry) {
-			list_move_tail(&vertex->entry, &unix_visited_vertices);
-
-			if (scc_dead)
-				scc_dead = unix_vertex_dead(vertex);
-		}
-
-		if (scc_dead)
+		if (unix_scc_dead(&scc, true))
 			unix_collect_skb(&scc, hitlist);
 		else if (!unix_graph_maybe_cyclic)
 			unix_graph_maybe_cyclic = unix_scc_cyclic(&scc);
@@ -553,8 +578,6 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 }
 
-static bool gc_in_progress;
-
 static void __unix_gc(struct work_struct *work)
 {
 	struct sk_buff_head hitlist;
-- 
2.35.3



