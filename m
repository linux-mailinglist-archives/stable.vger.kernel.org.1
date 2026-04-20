Return-Path: <stable+bounces-239257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qwmAEixK5mnQuQEAu9opvQ
	(envelope-from <stable+bounces-239257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:45:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAF742E891
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F7B4346E114
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0B133F5A9;
	Mon, 20 Apr 2026 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYMxFZB6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6E233F5BC
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697116; cv=none; b=tJ49JotLdjYtcI4n7q4vfoXN+ma5RfK2Lu/8PahQWtdxWGRINebZ+XJBnF3T8uF4ybhVRfQVqUNLHo4ccwByg/n7U1I/pXnKLqIFts7jIyfhCYA1b0ywnOMnz8VD6BiqTvnv/T7dmeedk2A7odpQtZh1dA/a8md6dqEwRuFL7Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697116; c=relaxed/simple;
	bh=Cc3Wek4RFdHkn7iVUBWXRzqOxEafPgLzkWO1nPVUX8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GN1QaIailxRolPWyspRC3laBYoZWtuCX2m58wcRh6beQTfZkotn3KRVsMTTMRv1UdKArZWPZmF7Q3S0aiedLRNlp1nE/4r0PR4rE5hzgzpXOH46mJCU6C7nLASuMlBkYrQ5rtlusv/iVNN5Iw3/XXwh3PWrxdVOIeRWxKsuRi9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYMxFZB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BBBC19425;
	Mon, 20 Apr 2026 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776697115;
	bh=Cc3Wek4RFdHkn7iVUBWXRzqOxEafPgLzkWO1nPVUX8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYMxFZB6kWxF+1KMg5oupipuNi2ex+SajA8tFyQ9hTJd2/GVkm7zUK5Qmg1kZzQ5s
	 2/5Fh9iYB1Weo95KCvN1dyHv6hIb2KrYczlBgbKvxVYX42JZX8diQRji72gL3L4FkW
	 JXOsu94h/6SE7rIX8IPLVZXrsaDpDb+HtKNh2E6tvL0OwBJMeOo+lJ9N35VIp2BXD0
	 UL+J8F2IV9xjMbNnGxnNV2dCSyAWe+Ezo9YSCI5BWaHPOnbs4LPRWBHn3CPtCb4p9v
	 I67X6ffz6dbFb8Q7bIiSyAXe8kIcMQQjtSuJjcleieYnRll9EKQr1UkA3OaZkLb1h9
	 qvHF4FA+wk9Bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: hongnanli <hongnan.li@linux.alibaba.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Gang He <ghe@suse.com>,
	Jun Piao <piaojun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] fs/ocfs2: fix comments mentioning i_mutex
Date: Mon, 20 Apr 2026 10:58:32 -0400
Message-ID: <20260420145833.1151197-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042003-rocking-engine-1cb6@gregkh>
References: <2026042003-rocking-engine-1cb6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,fasheh.com,evilplan.org,oracle.com,live.cn,suse.com,huawei.com,linux-foundation.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239257-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,fasheh.com:email,live.cn:email,oracle.com:email,alibaba.com:email,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: CCAF742E891
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: hongnanli <hongnan.li@linux.alibaba.com>

[ Upstream commit 137cebf9432eae024d0334953ed92a2a78619b52 ]

inode->i_mutex has been replaced with inode->i_rwsem long ago.  Fix
comments still mentioning i_mutex.

Link: https://lkml.kernel.org/r/20220214031314.100094-1-hongnan.li@linux.alibaba.com
Signed-off-by: hongnanli <hongnan.li@linux.alibaba.com>
Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Jun Piao <piaojun@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Stable-dep-of: b02da26a992d ("ocfs2: fix possible deadlock between unlink and dio_end_io_write")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/alloc.c               | 2 +-
 fs/ocfs2/aops.c                | 2 +-
 fs/ocfs2/cluster/nodemanager.c | 2 +-
 fs/ocfs2/dir.c                 | 4 ++--
 fs/ocfs2/file.c                | 4 ++--
 fs/ocfs2/inode.c               | 2 +-
 fs/ocfs2/localalloc.c          | 6 +++---
 fs/ocfs2/namei.c               | 2 +-
 fs/ocfs2/ocfs2.h               | 4 ++--
 fs/ocfs2/quota_global.c        | 2 +-
 fs/ocfs2/xattr.c               | 2 +-
 11 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 9f61a6d64cbce..82593871c4e1f 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -5988,7 +5988,7 @@ static int ocfs2_replay_truncate_records(struct ocfs2_super *osb,
 	return status;
 }
 
-/* Expects you to already be holding tl_inode->i_mutex */
+/* Expects you to already be holding tl_inode->i_rwsem */
 int __ocfs2_flush_truncate_log(struct ocfs2_super *osb)
 {
 	int status;
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 667d63d23f8f0..c4a47ea14b5fe 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2327,7 +2327,7 @@ static int ocfs2_dio_end_io_write(struct inode *inode,
 
 	down_write(&oi->ip_alloc_sem);
 
-	/* Delete orphan before acquire i_mutex. */
+	/* Delete orphan before acquire i_rwsem. */
 	if (dwc->dw_orphaned) {
 		BUG_ON(dwc->dw_writer_pid != task_pid_nr(current));
 
diff --git a/fs/ocfs2/cluster/nodemanager.c b/fs/ocfs2/cluster/nodemanager.c
index 7a7640c59f3ca..5d0f6bc0fc072 100644
--- a/fs/ocfs2/cluster/nodemanager.c
+++ b/fs/ocfs2/cluster/nodemanager.c
@@ -691,7 +691,7 @@ static struct config_group *o2nm_cluster_group_make_group(struct config_group *g
 	struct o2nm_node_group *ns = NULL;
 	struct config_group *o2hb_group = NULL, *ret = NULL;
 
-	/* this runs under the parent dir's i_mutex; there can be only
+	/* this runs under the parent dir's i_rwsem; there can be only
 	 * one caller in here at a time */
 	if (o2nm_single_cluster)
 		return ERR_PTR(-ENOSPC);
diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index 195515eefd331..ae96e58ba5399 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -1981,7 +1981,7 @@ int ocfs2_readdir(struct file *file, struct dir_context *ctx)
 }
 
 /*
- * NOTE: this should always be called with parent dir i_mutex taken.
+ * NOTE: this should always be called with parent dir i_rwsem taken.
  */
 int ocfs2_find_files_on_disk(const char *name,
 			     int namelen,
@@ -2028,7 +2028,7 @@ int ocfs2_lookup_ino_from_name(struct inode *dir, const char *name,
  * Return -EEXIST if the directory contains the name
  * Return -EFSCORRUPTED if found corruption
  *
- * Callers should have i_mutex + a cluster lock on dir
+ * Callers should have i_rwsem + a cluster lock on dir
  */
 int ocfs2_check_dir_for_entry(struct inode *dir,
 			      const char *name,
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 3ce7606f5dbe8..53b5fbaee7f73 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -272,7 +272,7 @@ int ocfs2_update_inode_atime(struct inode *inode,
 
 	/*
 	 * Don't use ocfs2_mark_inode_dirty() here as we don't always
-	 * have i_mutex to guard against concurrent changes to other
+	 * have i_rwsem to guard against concurrent changes to other
 	 * inode fields.
 	 */
 	inode->i_atime = current_time(inode);
@@ -1070,7 +1070,7 @@ static int ocfs2_extend_file(struct inode *inode,
 	/*
 	 * The alloc sem blocks people in read/write from reading our
 	 * allocation until we're done changing it. We depend on
-	 * i_mutex to block other extend/truncate calls while we're
+	 * i_rwsem to block other extend/truncate calls while we're
 	 * here.  We even have to hold it for sparse files because there
 	 * might be some tail zeroing.
 	 */
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 7c9dfd50c1c17..932658134243b 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -715,7 +715,7 @@ static int ocfs2_remove_inode(struct inode *inode,
 /*
  * Serialize with orphan dir recovery. If the process doing
  * recovery on this orphan dir does an iget() with the dir
- * i_mutex held, we'll deadlock here. Instead we detect this
+ * i_rwsem held, we'll deadlock here. Instead we detect this
  * and exit early - recovery will wipe this inode for us.
  */
 static int ocfs2_check_orphan_recovery_state(struct ocfs2_super *osb,
diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index fc8252a28cb1a..5fbd77a9bc3c5 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -608,7 +608,7 @@ int ocfs2_complete_local_alloc_recovery(struct ocfs2_super *osb,
 
 /*
  * make sure we've got at least bits_wanted contiguous bits in the
- * local alloc. You lose them when you drop i_mutex.
+ * local alloc. You lose them when you drop i_rwsem.
  *
  * We will add ourselves to the transaction passed in, but may start
  * our own in order to shift windows.
@@ -638,7 +638,7 @@ int ocfs2_reserve_local_alloc_bits(struct ocfs2_super *osb,
 
 	/*
 	 * We must double check state and allocator bits because
-	 * another process may have changed them while holding i_mutex.
+	 * another process may have changed them while holding i_rwsem.
 	 */
 	spin_lock(&osb->osb_lock);
 	if (!ocfs2_la_state_enabled(osb) ||
@@ -1031,7 +1031,7 @@ enum ocfs2_la_event {
 /*
  * Given an event, calculate the size of our next local alloc window.
  *
- * This should always be called under i_mutex of the local alloc inode
+ * This should always be called under i_rwsem of the local alloc inode
  * so that local alloc disabling doesn't race with processes trying to
  * use the allocator.
  *
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 0e0f844dcf7f4..aa91c70a2963f 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -485,7 +485,7 @@ static int ocfs2_mknod(struct inode *dir,
 		ocfs2_free_alloc_context(meta_ac);
 
 	/*
-	 * We should call iput after the i_mutex of the bitmap been
+	 * We should call iput after the i_rwsem of the bitmap been
 	 * unlocked in ocfs2_free_alloc_context, or the
 	 * ocfs2_delete_inode will mutex_lock again.
 	 */
diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index 5cea6942c1bdf..ea616c3ab09a3 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -371,7 +371,7 @@ struct ocfs2_super
 	struct delayed_work		la_enable_wq;
 
 	/*
-	 * Must hold local alloc i_mutex and osb->osb_lock to change
+	 * Must hold local alloc i_rwsem and osb->osb_lock to change
 	 * local_alloc_bits. Reads can be done under either lock.
 	 */
 	unsigned int local_alloc_bits;
@@ -446,7 +446,7 @@ struct ocfs2_super
 	atomic_t			osb_tl_disable;
 	/*
 	 * How many clusters in our truncate log.
-	 * It must be protected by osb_tl_inode->i_mutex.
+	 * It must be protected by osb_tl_inode->i_rwsem.
 	 */
 	unsigned int truncated_clusters;
 
diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
index 742bf103d2eb2..6ea0820b0d347 100644
--- a/fs/ocfs2/quota_global.c
+++ b/fs/ocfs2/quota_global.c
@@ -36,7 +36,7 @@
  * should be obeyed by all the functions:
  * - any write of quota structure (either to local or global file) is protected
  *   by dqio_sem or dquot->dq_lock.
- * - any modification of global quota file holds inode cluster lock, i_mutex,
+ * - any modification of global quota file holds inode cluster lock, i_rwsem,
  *   and ip_alloc_sem of the global quota file (achieved by
  *   ocfs2_lock_global_qf). It also has to hold qinfo_lock.
  * - an allocation of new blocks for local quota file is protected by
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 7b1688e282674..d1409187b3fd1 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -7210,7 +7210,7 @@ int ocfs2_reflink_xattrs(struct inode *old_inode,
  * Used for reflink a non-preserve-security file.
  *
  * It uses common api like ocfs2_xattr_set, so the caller
- * must not hold any lock expect i_mutex.
+ * must not hold any lock expect i_rwsem.
  */
 int ocfs2_init_security_and_acl(struct inode *dir,
 				struct inode *inode,
-- 
2.53.0


