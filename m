Return-Path: <stable+bounces-227173-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJunA7wZu2k+fAIAu9opvQ
	(envelope-from <stable+bounces-227173-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:31:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FEB2C309A
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 232BA301733D
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 21:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206F938944D;
	Wed, 18 Mar 2026 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d38ccaAW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EC538B7B0
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773869492; cv=none; b=R6Yh4B4shYGPxK5w/uol3MZOZOPSqBPMlv0GMJ/on1B5RU1QNfPMAi/8+Wi0N5eR7//LsTSCEmVLA6lRohg3+wxB0RBjMxGzKlzlcMx7cyA4mQCzvUrGgu1/hSeiJ3dseHN9jAjLqX/HOh9nb8iZk15rP7LjQm1Sfd8swOjdXk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773869492; c=relaxed/simple;
	bh=et5D8V73rZjkAyk++8EhKvs8Yg5N0W6cd1px6I5KlhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAv+pwhuSjQlshX8S/gecn750Vl56yxehfCBDNTW8QLQd/6HolIgApkZizMOMXKw62CpYtnlRjXNlhdg0G02EFsXBrzlIkcsxjd2bjn2hP2QYa7JCu28fVzfGIbkgASm1D77z3C/XlyV204KMvsVQauAmG3QvYQg8E2THtzIOPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d38ccaAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071DFC19421;
	Wed, 18 Mar 2026 21:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773869492;
	bh=et5D8V73rZjkAyk++8EhKvs8Yg5N0W6cd1px6I5KlhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d38ccaAWcVF17FNJY+t9hWugJ2aauyn/iCE5DvhhHN850Q67Jluf8Ws03zjMCWRFv
	 8BYRs0AiIu1ZHJI6oaXvMuy93P4jd+YmUpUI6pGhsZXk7m+62C853uRMuEvGJh9x0e
	 ckIhjIjctlKKrQW8q+K7EmAekdBVc784gQiBWJLRyz4R2hC/O8an7OKV0W/lJa+dkS
	 G7XMI8u107mK4f4GI7ZDifq+9h7s9hU/X2FKJ5dvmL5HhjtmB29K0W+sRgK6piEoDj
	 oz2FvZQvT/j4W3UGVGxzsM631A795Xcm0NCDzC7r9+5AnhMaokWGdhCXkJ8h0N1fWG
	 Ve3Rt5cAiGcUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] cifs: open files should not hold ref on superblock
Date: Wed, 18 Mar 2026 17:31:29 -0400
Message-ID: <20260318213129.1363807-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031712-unadorned-freezing-f067@gregkh>
References: <2026031712-unadorned-freezing-f067@gregkh>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227173-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06FEB2C309A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit 340cea84f691c5206561bb2e0147158fe02070be ]

Today whenever we deal with a file, in addition to holding
a reference on the dentry, we also get a reference on the
superblock. This happens in two cases:
1. when a new cinode is allocated
2. when an oplock break is being processed

The reasoning for holding the superblock ref was to make sure
that when umount happens, if there are users of inodes and
dentries, it does not try to clean them up and wait for the
last ref to superblock to be dropped by last of such users.

But the side effect of doing that is that umount silently drops
a ref on the superblock and we could have deferred closes and
lease breaks still holding these refs.

Ideally, we should ensure that all of these users of inodes and
dentries are cleaned up at the time of umount, which is what this
code is doing.

This code change allows these code paths to use a ref on the
dentry (and hence the inode). That way, umount is
ensured to clean up SMB client resources when it's the last
ref on the superblock (For ex: when same objects are shared).

The code change also moves the call to close all the files in
deferred close list to the umount code path. It also waits for
oplock_break workers to be flushed before calling
kill_anon_super (which eventually frees up those objects).

Fixes: 24261fc23db9 ("cifs: delay super block destruction until all cifsFileInfo objects are gone")
Fixes: 705c79101ccf ("smb: client: fix use-after-free in cifs_oplock_break")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ replaced kmalloc_obj() with kmalloc(sizeof(...)) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsfs.c    |  7 +++++--
 fs/smb/client/cifsproto.h |  1 +
 fs/smb/client/file.c      | 11 ----------
 fs/smb/client/misc.c      | 42 +++++++++++++++++++++++++++++++++++++++
 fs/smb/client/trace.h     |  2 ++
 5 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 1187b0240a444..ce3af62ddaf4c 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -291,10 +291,14 @@ static void cifs_kill_sb(struct super_block *sb)
 
 	/*
 	 * We need to release all dentries for the cached directories
-	 * before we kill the sb.
+	 * and close all deferred file handles before we kill the sb.
 	 */
 	if (cifs_sb->root) {
 		close_all_cached_dirs(cifs_sb);
+		cifs_close_all_deferred_files_sb(cifs_sb);
+
+		/* Wait for all pending oplock breaks to complete */
+		flush_workqueue(cifsoplockd_wq);
 
 		/* finally release root dentry */
 		dput(cifs_sb->root);
@@ -799,7 +803,6 @@ static void cifs_umount_begin(struct super_block *sb)
 	spin_unlock(&tcon->tc_lock);
 	spin_unlock(&cifs_tcp_ses_lock);
 
-	cifs_close_all_deferred_files(tcon);
 	/* cancel_brl_requests(tcon); */ /* BB mark all brl mids as exiting */
 	/* cancel_notify_requests(tcon); */
 	if (tcon->ses && tcon->ses->server) {
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index b59647291363b..d2d004764a708 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -298,6 +298,7 @@ extern void cifs_close_deferred_file(struct cifsInodeInfo *cifs_inode);
 
 extern void cifs_close_all_deferred_files(struct cifs_tcon *cifs_tcon);
 
+void cifs_close_all_deferred_files_sb(struct cifs_sb_info *cifs_sb);
 void cifs_close_deferred_file_under_dentry(struct cifs_tcon *cifs_tcon,
 					   struct dentry *dentry);
 
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 166dc8fd06c02..486f6e9aaff17 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -697,8 +697,6 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
 	mutex_init(&cfile->fh_mutex);
 	spin_lock_init(&cfile->file_info_lock);
 
-	cifs_sb_active(inode->i_sb);
-
 	/*
 	 * If the server returned a read oplock and we have mandatory brlocks,
 	 * set oplock level to None.
@@ -753,7 +751,6 @@ static void cifsFileInfo_put_final(struct cifsFileInfo *cifs_file)
 	struct inode *inode = d_inode(cifs_file->dentry);
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	struct cifsLockInfo *li, *tmp;
-	struct super_block *sb = inode->i_sb;
 
 	/*
 	 * Delete any outstanding lock records. We'll lose them when the file
@@ -771,7 +768,6 @@ static void cifsFileInfo_put_final(struct cifsFileInfo *cifs_file)
 
 	cifs_put_tlink(cifs_file->tlink);
 	dput(cifs_file->dentry);
-	cifs_sb_deactive(sb);
 	kfree(cifs_file->symlink_target);
 	kfree(cifs_file);
 }
@@ -3087,12 +3083,6 @@ void cifs_oplock_break(struct work_struct *work)
 	__u64 persistent_fid, volatile_fid;
 	__u16 net_fid;
 
-	/*
-	 * Hold a reference to the superblock to prevent it and its inodes from
-	 * being freed while we are accessing cinode. Otherwise, _cifsFileInfo_put()
-	 * may release the last reference to the sb and trigger inode eviction.
-	 */
-	cifs_sb_active(sb);
 	wait_on_bit(&cinode->flags, CIFS_INODE_PENDING_WRITERS,
 			TASK_UNINTERRUPTIBLE);
 
@@ -3165,7 +3155,6 @@ void cifs_oplock_break(struct work_struct *work)
 	cifs_put_tlink(tlink);
 out:
 	cifs_done_oplock_break(cinode);
-	cifs_sb_deactive(sb);
 }
 
 static int cifs_swap_activate(struct swap_info_struct *sis,
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 3f3f184f7fb97..6abfa22f4c176 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -27,6 +27,11 @@
 #include "fs_context.h"
 #include "cached_dir.h"
 
+struct tcon_list {
+	struct list_head entry;
+	struct cifs_tcon *tcon;
+};
+
 /* The xid serves as a useful identifier for each incoming vfs request,
    in a similar way to the mid which is useful to track each sent smb,
    and CurrentXid can also provide a running counter (although it
@@ -830,6 +835,43 @@ cifs_close_all_deferred_files(struct cifs_tcon *tcon)
 	}
 }
 
+void cifs_close_all_deferred_files_sb(struct cifs_sb_info *cifs_sb)
+{
+	struct rb_root *root = &cifs_sb->tlink_tree;
+	struct rb_node *node;
+	struct cifs_tcon *tcon;
+	struct tcon_link *tlink;
+	struct tcon_list *tmp_list, *q;
+	LIST_HEAD(tcon_head);
+
+	spin_lock(&cifs_sb->tlink_tree_lock);
+	for (node = rb_first(root); node; node = rb_next(node)) {
+		tlink = rb_entry(node, struct tcon_link, tl_rbnode);
+		tcon = tlink_tcon(tlink);
+		if (IS_ERR(tcon))
+			continue;
+		tmp_list = kmalloc(sizeof(struct tcon_list), GFP_ATOMIC);
+		if (tmp_list == NULL)
+			break;
+		tmp_list->tcon = tcon;
+		/* Take a reference on tcon to prevent it from being freed */
+		spin_lock(&tcon->tc_lock);
+		++tcon->tc_count;
+		trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
+				    netfs_trace_tcon_ref_get_close_defer_files);
+		spin_unlock(&tcon->tc_lock);
+		list_add_tail(&tmp_list->entry, &tcon_head);
+	}
+	spin_unlock(&cifs_sb->tlink_tree_lock);
+
+	list_for_each_entry_safe(tmp_list, q, &tcon_head, entry) {
+		cifs_close_all_deferred_files(tmp_list->tcon);
+		list_del(&tmp_list->entry);
+		cifs_put_tcon(tmp_list->tcon, netfs_trace_tcon_ref_put_close_defer_files);
+		kfree(tmp_list);
+	}
+}
+
 void cifs_close_deferred_file_under_dentry(struct cifs_tcon *tcon,
 					   struct dentry *dentry)
 {
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index fb9c631e0ec1e..547d1e5d000ac 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -47,6 +47,7 @@
 	EM(netfs_trace_tcon_ref_get_cached_laundromat,	"GET Ch-Lau") \
 	EM(netfs_trace_tcon_ref_get_cached_lease_break,	"GET Ch-Lea") \
 	EM(netfs_trace_tcon_ref_get_cancelled_close,	"GET Cn-Cls") \
+	EM(netfs_trace_tcon_ref_get_close_defer_files,	"GET Cl-Def") \
 	EM(netfs_trace_tcon_ref_get_dfs_refer,		"GET DfsRef") \
 	EM(netfs_trace_tcon_ref_get_find,		"GET Find  ") \
 	EM(netfs_trace_tcon_ref_get_find_sess_tcon,	"GET FndSes") \
@@ -58,6 +59,7 @@
 	EM(netfs_trace_tcon_ref_put_cancelled_close,	"PUT Cn-Cls") \
 	EM(netfs_trace_tcon_ref_put_cancelled_close_fid, "PUT Cn-Fid") \
 	EM(netfs_trace_tcon_ref_put_cancelled_mid,	"PUT Cn-Mid") \
+	EM(netfs_trace_tcon_ref_put_close_defer_files,	"PUT Cl-Def") \
 	EM(netfs_trace_tcon_ref_put_mnt_ctx,		"PUT MntCtx") \
 	EM(netfs_trace_tcon_ref_put_dfs_refer,		"PUT DfsRfr") \
 	EM(netfs_trace_tcon_ref_put_reconnect_server,	"PUT Reconn") \
-- 
2.51.0


