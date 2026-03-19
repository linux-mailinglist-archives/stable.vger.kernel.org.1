Return-Path: <stable+bounces-227199-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDLBGkpRu2lMigIAu9opvQ
	(envelope-from <stable+bounces-227199-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 02:28:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA99E2C46CC
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 02:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33700301D489
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 01:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3A0270552;
	Thu, 19 Mar 2026 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2kJKIjn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E68D126BF1
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773883699; cv=none; b=Xf7mfiQX7f9PGhRZl2rPuivQQ/hWb5faIt+olozLwL2bZKs3dyOEDdcaWNsKZE6URL1uSYlr/FwajfX51+gncAXNcbaG/MrW92eQR8LiJx/Qk1v/qRdFI0VMo1EnWE0akTxQXnvIXLu/l/IL1kr3nAWQSOTtgivSPqHyabOrBco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773883699; c=relaxed/simple;
	bh=VGDNLdj0Gf7CKZHtP/H4dzdg88BAEWeFH7uGVlTAURA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpoXNvjQw8wAXHf4wJQ9LxcQG0S0eSgAQtLQp40vkD83MSaPPVe8eGPvk6/45wovou2DTaybA36ZiP3XJR4/zzD3BBz5BrKzEQGDq6SXwE3jixo9No6Rdmuz7Nza+xf1N/xmoi1Iu98kZl6I+VEi0/UHlJvsROyvRrCNIfNwBes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2kJKIjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0385C19421;
	Thu, 19 Mar 2026 01:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773883699;
	bh=VGDNLdj0Gf7CKZHtP/H4dzdg88BAEWeFH7uGVlTAURA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2kJKIjnYzNkFKRs/NOd08U8MIumiRC/E5pabKxHOllTc76zvDBQuTWf+7G/mtOQy
	 Z8Ya9PnlJZp2r7GFq0oUvgCIQXhPTujS242b3hmF4qKQ8pfVtsThYP2HnaCognfVZ/
	 wLrcA5t+yAbqr1PH0pr7FfezeUBtXNWiw/58O/gRcDnSTs5C0v+K1UY5x8QLHkn4Nl
	 rgl/7Uwa+BIlspyZWIZ5RdPiOsk8wM79wAjFWvr+kcUzfE5MDlVXchcMwdEpzdLgv6
	 k9TVESI8lAVHqEKzIIjPNL0v6rnIDtEgBR/WX9goQbBwOtcDdXhXu/WMDHSr/D48IC
	 5qzJKI+x5cL8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] cifs: open files should not hold ref on superblock
Date: Wed, 18 Mar 2026 21:28:17 -0400
Message-ID: <20260319012817.1877930-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031715-transform-unroasted-b999@gregkh>
References: <2026031715-transform-unroasted-b999@gregkh>
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
	TAGGED_FROM(0.00)[bounces-227199-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA99E2C46CC
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
[ filenames + some APIs ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsfs.c    |  9 ++++++---
 fs/cifs/cifsproto.h |  1 +
 fs/cifs/file.c      | 11 -----------
 fs/cifs/misc.c      | 41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index c254e714f7ceb..cdb915fade44e 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -262,8 +262,8 @@ static void cifs_kill_sb(struct super_block *sb)
 	struct tcon_link *tlink;
 
 	/*
-	 * We ned to release all dentries for the cached directories
-	 * before we kill the sb.
+	 * We need to release all dentries for the cached directories
+	 * and close all deferred file handles before we kill the sb.
 	 */
 	if (cifs_sb->root) {
 		for (node = rb_first(root); node; node = rb_next(node)) {
@@ -279,6 +279,10 @@ static void cifs_kill_sb(struct super_block *sb)
 			}
 			mutex_unlock(&cfid->fid_mutex);
 		}
+		cifs_close_all_deferred_files_sb(cifs_sb);
+
+		/* Wait for all pending oplock breaks to complete */
+		flush_workqueue(cifsoplockd_wq);
 
 		/* finally release root dentry */
 		dput(cifs_sb->root);
@@ -716,7 +720,6 @@ static void cifs_umount_begin(struct super_block *sb)
 		tcon->tidStatus = CifsExiting;
 	spin_unlock(&cifs_tcp_ses_lock);
 
-	cifs_close_all_deferred_files(tcon);
 	/* cancel_brl_requests(tcon); */ /* BB mark all brl mids as exiting */
 	/* cancel_notify_requests(tcon); */
 	if (tcon->ses && tcon->ses->server) {
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 7d00802f97223..90a722ec772b6 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -267,6 +267,7 @@ extern void cifs_close_deferred_file(struct cifsInodeInfo *cifs_inode);
 
 extern void cifs_close_all_deferred_files(struct cifs_tcon *cifs_tcon);
 
+extern void cifs_close_all_deferred_files_sb(struct cifs_sb_info *cifs_sb);
 extern void cifs_close_deferred_file_under_dentry(struct cifs_tcon *cifs_tcon,
 				const char *path);
 
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 10bb1f9551887..0ee2898f4122b 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -318,8 +318,6 @@ cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
 	mutex_init(&cfile->fh_mutex);
 	spin_lock_init(&cfile->file_info_lock);
 
-	cifs_sb_active(inode->i_sb);
-
 	/*
 	 * If the server returned a read oplock and we have mandatory brlocks,
 	 * set oplock level to None.
@@ -374,7 +372,6 @@ static void cifsFileInfo_put_final(struct cifsFileInfo *cifs_file)
 	struct inode *inode = d_inode(cifs_file->dentry);
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	struct cifsLockInfo *li, *tmp;
-	struct super_block *sb = inode->i_sb;
 
 	cifs_fscache_release_inode_cookie(inode);
 
@@ -394,7 +391,6 @@ static void cifsFileInfo_put_final(struct cifsFileInfo *cifs_file)
 
 	cifs_put_tlink(cifs_file->tlink);
 	dput(cifs_file->dentry);
-	cifs_sb_deactive(sb);
 	kfree(cifs_file);
 }
 
@@ -4876,12 +4872,6 @@ void cifs_oplock_break(struct work_struct *work)
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
 
@@ -4954,7 +4944,6 @@ void cifs_oplock_break(struct work_struct *work)
 	cifs_put_tlink(tlink);
 out:
 	cifs_done_oplock_break(cinode);
-	cifs_sb_deactive(sb);
 }
 
 /*
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index a3d37e7769e61..44b86058410de 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -27,6 +27,11 @@
 extern mempool_t *cifs_sm_req_poolp;
 extern mempool_t *cifs_req_poolp;
 
+struct tcon_list {
+	struct list_head entry;
+	struct cifs_tcon *tcon;
+};
+
 /* The xid serves as a useful identifier for each incoming vfs request,
    in a similar way to the mid which is useful to track each sent smb,
    and CurrentXid can also provide a running counter (although it
@@ -800,6 +805,42 @@ cifs_close_all_deferred_files(struct cifs_tcon *tcon)
 		kfree(tmp_list);
 	}
 }
+
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
+		spin_lock(&cifs_tcp_ses_lock);
+		++tcon->tc_count;
+		spin_unlock(&cifs_tcp_ses_lock);
+		list_add_tail(&tmp_list->entry, &tcon_head);
+	}
+	spin_unlock(&cifs_sb->tlink_tree_lock);
+
+	list_for_each_entry_safe(tmp_list, q, &tcon_head, entry) {
+		cifs_close_all_deferred_files(tmp_list->tcon);
+		list_del(&tmp_list->entry);
+		cifs_put_tcon(tmp_list->tcon);
+		kfree(tmp_list);
+	}
+}
+
 void
 cifs_close_deferred_file_under_dentry(struct cifs_tcon *tcon, const char *path)
 {
-- 
2.51.0


