Return-Path: <stable+bounces-239239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GElVCKtH5mnSuAEAu9opvQ
	(envelope-from <stable+bounces-239239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:35:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9154E42E5A5
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C46431B016E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84A538BF62;
	Mon, 20 Apr 2026 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeKPiY0K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745923A0B26
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776696121; cv=none; b=Tw2Za4u1yLP+uW6ubr4qCdQI369Tc+fEDDipNTio3gR2PaqUKeNaEKExzqmm00sWYKAmXjUrAWlx51UcGBCCefea++jbzR5+T0RY9YTRz3CMVW3BYAFzMFWY6zYJZX8WMIFiZdqxB2kzkjSYuxt79nx/6Bz6lvI7dtNPpRPWAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776696121; c=relaxed/simple;
	bh=O3MzEOgZCFwpdzACIIp+xDCTTmcLxFnw9p/fBJkFotg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPIgDapaZyIbIihYFubhCLyqBC0HsyeHSXKbzVr+b5yRwIVN6tV+4OvZz6dy2aAJkGM/EbnZN+7oPZvRvukfNxD/bNPKMGhd5SbzixZjpdu1UV4oOKXz3LEqOQo8X/JWm8MAOCUq9jwVEew+VvNiiysRXHV+Yf3SVKEYU+Fvrvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeKPiY0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE57CC19425;
	Mon, 20 Apr 2026 14:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776696121;
	bh=O3MzEOgZCFwpdzACIIp+xDCTTmcLxFnw9p/fBJkFotg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qeKPiY0KIWznGSp2fl7Z/GbTfM8xJpO7/p/O1waq4gdMMhexHbTf+qjgmv5CWRijE
	 EVi9W/qYIA8dAixVVRk0K6Nj5GS3IzJgtvLR27kmKDEc7uQFZAgpahl1qa1nBcRLaA
	 m5ZjOyNO1mxcqqlE9CQaJk6e94/MsXz5FmRyIw8jdzuX1CNWKk2zQzdubpOdSGNjQg
	 oxgl7yjq5NIHX1qH43C2iUu3yMjaF6hdTfobiHDj/AU1AkcplI8edDsiAyPuBkgu79
	 1dhlwROQUhe1jrjh/Xd9ot5nZ1I3L/jm/RX7h+9H393h3OXBqheZr2SxuNmBr9isFS
	 3i/gUVR8WxlbQ==
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
Subject: [PATCH 5.15.y 1/2] fs/ocfs2: fix comments mentioning i_mutex
Date: Mon, 20 Apr 2026 10:41:57 -0400
Message-ID: <20260420144158.1143438-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042002-rumbling-plunder-40f1@gregkh>
References: <2026042002-rumbling-plunder-40f1@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,fasheh.com,evilplan.org,oracle.com,live.cn,suse.com,huawei.com,linux-foundation.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239239-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,live.cn:email,suse.com:email,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,fasheh.com:email]
X-Rspamd-Queue-Id: 9154E42E5A5
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
index 9589b462b5913..79e308fb9ea09 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -5986,7 +5986,7 @@ static int ocfs2_replay_truncate_records(struct ocfs2_super *osb,
 	return status;
 }
 
-/* Expects you to already be holding tl_inode->i_mutex */
+/* Expects you to already be holding tl_inode->i_rwsem */
 int __ocfs2_flush_truncate_log(struct ocfs2_super *osb)
 {
 	int status;
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 2a04e65e8a92c..22bc41d2bdcc6 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2324,7 +2324,7 @@ static int ocfs2_dio_end_io_write(struct inode *inode,
 
 	down_write(&oi->ip_alloc_sem);
 
-	/* Delete orphan before acquire i_mutex. */
+	/* Delete orphan before acquire i_rwsem. */
 	if (dwc->dw_orphaned) {
 		BUG_ON(dwc->dw_writer_pid != task_pid_nr(current));
 
diff --git a/fs/ocfs2/cluster/nodemanager.c b/fs/ocfs2/cluster/nodemanager.c
index 625c925214169..27fee68f860a6 100644
--- a/fs/ocfs2/cluster/nodemanager.c
+++ b/fs/ocfs2/cluster/nodemanager.c
@@ -689,7 +689,7 @@ static struct config_group *o2nm_cluster_group_make_group(struct config_group *g
 	struct o2nm_node_group *ns = NULL;
 	struct config_group *o2hb_group = NULL, *ret = NULL;
 
-	/* this runs under the parent dir's i_mutex; there can be only
+	/* this runs under the parent dir's i_rwsem; there can be only
 	 * one caller in here at a time */
 	if (o2nm_single_cluster)
 		return ERR_PTR(-ENOSPC);
diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index 441818535bfc5..4d4d5ef6ef29e 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -1979,7 +1979,7 @@ int ocfs2_readdir(struct file *file, struct dir_context *ctx)
 }
 
 /*
- * NOTE: this should always be called with parent dir i_mutex taken.
+ * NOTE: this should always be called with parent dir i_rwsem taken.
  */
 int ocfs2_find_files_on_disk(const char *name,
 			     int namelen,
@@ -2026,7 +2026,7 @@ int ocfs2_lookup_ino_from_name(struct inode *dir, const char *name,
  * Return -EEXIST if the directory contains the name
  * Return -EFSCORRUPTED if found corruption
  *
- * Callers should have i_mutex + a cluster lock on dir
+ * Callers should have i_rwsem + a cluster lock on dir
  */
 int ocfs2_check_dir_for_entry(struct inode *dir,
 			      const char *name,
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index cf877efdca575..e35d735e551d0 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -270,7 +270,7 @@ int ocfs2_update_inode_atime(struct inode *inode,
 
 	/*
 	 * Don't use ocfs2_mark_inode_dirty() here as we don't always
-	 * have i_mutex to guard against concurrent changes to other
+	 * have i_rwsem to guard against concurrent changes to other
 	 * inode fields.
 	 */
 	inode->i_atime = current_time(inode);
@@ -1068,7 +1068,7 @@ static int ocfs2_extend_file(struct inode *inode,
 	/*
 	 * The alloc sem blocks people in read/write from reading our
 	 * allocation until we're done changing it. We depend on
-	 * i_mutex to block other extend/truncate calls while we're
+	 * i_rwsem to block other extend/truncate calls while we're
 	 * here.  We even have to hold it for sparse files because there
 	 * might be some tail zeroing.
 	 */
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index bc8f32fab964c..738cd90d66682 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -713,7 +713,7 @@ static int ocfs2_remove_inode(struct inode *inode,
 /*
  * Serialize with orphan dir recovery. If the process doing
  * recovery on this orphan dir does an iget() with the dir
- * i_mutex held, we'll deadlock here. Instead we detect this
+ * i_rwsem held, we'll deadlock here. Instead we detect this
  * and exit early - recovery will wipe this inode for us.
  */
 static int ocfs2_check_orphan_recovery_state(struct ocfs2_super *osb,
diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index 5f6bacbeef6b8..c4426d12a2adb 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -606,7 +606,7 @@ int ocfs2_complete_local_alloc_recovery(struct ocfs2_super *osb,
 
 /*
  * make sure we've got at least bits_wanted contiguous bits in the
- * local alloc. You lose them when you drop i_mutex.
+ * local alloc. You lose them when you drop i_rwsem.
  *
  * We will add ourselves to the transaction passed in, but may start
  * our own in order to shift windows.
@@ -636,7 +636,7 @@ int ocfs2_reserve_local_alloc_bits(struct ocfs2_super *osb,
 
 	/*
 	 * We must double check state and allocator bits because
-	 * another process may have changed them while holding i_mutex.
+	 * another process may have changed them while holding i_rwsem.
 	 */
 	spin_lock(&osb->osb_lock);
 	if (!ocfs2_la_state_enabled(osb) ||
@@ -1029,7 +1029,7 @@ enum ocfs2_la_event {
 /*
  * Given an event, calculate the size of our next local alloc window.
  *
- * This should always be called under i_mutex of the local alloc inode
+ * This should always be called under i_rwsem of the local alloc inode
  * so that local alloc disabling doesn't race with processes trying to
  * use the allocator.
  *
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 272dbc13d3bc2..63b06377f6305 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -485,7 +485,7 @@ static int ocfs2_mknod(struct user_namespace *mnt_userns,
 		ocfs2_free_alloc_context(meta_ac);
 
 	/*
-	 * We should call iput after the i_mutex of the bitmap been
+	 * We should call iput after the i_rwsem of the bitmap been
 	 * unlocked in ocfs2_free_alloc_context, or the
 	 * ocfs2_delete_inode will mutex_lock again.
 	 */
diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index adec276bf4c52..22882c636bfb8 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -369,7 +369,7 @@ struct ocfs2_super
 	struct delayed_work		la_enable_wq;
 
 	/*
-	 * Must hold local alloc i_mutex and osb->osb_lock to change
+	 * Must hold local alloc i_rwsem and osb->osb_lock to change
 	 * local_alloc_bits. Reads can be done under either lock.
 	 */
 	unsigned int local_alloc_bits;
@@ -444,7 +444,7 @@ struct ocfs2_super
 	atomic_t			osb_tl_disable;
 	/*
 	 * How many clusters in our truncate log.
-	 * It must be protected by osb_tl_inode->i_mutex.
+	 * It must be protected by osb_tl_inode->i_rwsem.
 	 */
 	unsigned int truncated_clusters;
 
diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
index 79e70aaa9a90d..5ff08c481f345 100644
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
index 248b5e45393a7..7ac7cb6117d4f 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -7208,7 +7208,7 @@ int ocfs2_reflink_xattrs(struct inode *old_inode,
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


