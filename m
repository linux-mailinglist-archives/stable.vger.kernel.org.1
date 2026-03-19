Return-Path: <stable+bounces-227194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJx3OJtKu2kliQIAu9opvQ
	(envelope-from <stable+bounces-227194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 02:00:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2D02C4411
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 02:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B8863091FAD
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 01:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990BD23D2B1;
	Thu, 19 Mar 2026 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/V7Z5NM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B87F26B95B
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773882009; cv=none; b=jRJy9pSdoo0DmKCBsKozeaLpm/38Dj4pMhA6cfYLMoSIM8fS1rMDqcep1sdvqeuhSxc4qi2AWJTGFL4Ic9/GMBo8bjbDbNRjjJJ9bRBtRAoGOKJtSRAtEMjAMJkTX3W3UV1qB5lrPb5/RaL+nUre7Yok9DTKZlu/bu1xXsu3lSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773882009; c=relaxed/simple;
	bh=Sed7WMeDGc2ZPd+/ZxFfWN6Hg6PbY14v9zAZIRegw1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CY5ZpyPvQ+EfHrf1P99Cfu9mHcigvH/oe5XP/evgvHOuTV4fc/yIZyFJQ5bOuDXtS52A0HolusEySLn7glSOymctJ+wfwldjGBhXVeuqFH5fo3ositjg++GvcB6419YIGJE2z6YhXfcsHY2hep10irCKz+ZUO0V9BkJ8rcVvYzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/V7Z5NM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CA1C19421;
	Thu, 19 Mar 2026 01:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773882009;
	bh=Sed7WMeDGc2ZPd+/ZxFfWN6Hg6PbY14v9zAZIRegw1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X/V7Z5NM2RWxdfjlV6mFqCLwFgY3XXVpV4jcMYIQtK8nIlLlh9bBHlAX2qFfQk3GW
	 CZP7mbUWF27MMGvE0ajRCNx0PSfMi1YIZUPB3ec5KzREPBGZ9FY9BEqM8BOmqV3Qos
	 hMhsf2coMLHKD7ivZjhLYunOdw5+nSPoo6Ja7lWY5LWF6ygFoPOf9lhsK1nBCsnoVt
	 7MhHmhnGdunGIhiiYrzlxmznTdvoMgedQ6NfsUmaAmnRbhbeIaQhBsbsQkQE5NIJ6T
	 jp1CkN0ESJk9wOKL8kBRbUxzSllSMBVSwpIWeA0zydp1j2c2I/Yc3QlYyy3eKXwQOn
	 lGSP93wpRIFzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] cifs: open files should not hold ref on superblock
Date: Wed, 18 Mar 2026 21:00:06 -0400
Message-ID: <20260319010006.1861233-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031714-dragster-unaired-0a09@gregkh>
References: <2026031714-dragster-unaired-0a09@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227194-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A2D02C4411
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
[ kmalloc_obj() => kmalloc(), remove trace_smb3_tcon_ref() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsfs.c    |  9 ++++++---
 fs/smb/client/cifsproto.h |  1 +
 fs/smb/client/file.c      | 11 -----------
 fs/smb/client/misc.c      | 41 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 74e4beb351946..82db91df19b2c 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -287,11 +287,15 @@ static void cifs_kill_sb(struct super_block *sb)
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 
 	/*
-	 * We ned to release all dentries for the cached directories
-	 * before we kill the sb.
+	 * We need to release all dentries for the cached directories
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
@@ -756,7 +760,6 @@ static void cifs_umount_begin(struct super_block *sb)
 	spin_unlock(&tcon->tc_lock);
 	spin_unlock(&cifs_tcp_ses_lock);
 
-	cifs_close_all_deferred_files(tcon);
 	/* cancel_brl_requests(tcon); */ /* BB mark all brl mids as exiting */
 	/* cancel_notify_requests(tcon); */
 	if (tcon->ses && tcon->ses->server) {
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 9a30425b75a96..79ac8364d3875 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -297,6 +297,7 @@ extern void cifs_close_deferred_file(struct cifsInodeInfo *cifs_inode);
 
 extern void cifs_close_all_deferred_files(struct cifs_tcon *cifs_tcon);
 
+void cifs_close_all_deferred_files_sb(struct cifs_sb_info *cifs_sb);
 extern void cifs_close_deferred_file_under_dentry(struct cifs_tcon *cifs_tcon,
 				const char *path);
 extern struct TCP_Server_Info *
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 3551054ef0973..e257076f5b211 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -382,8 +382,6 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
 	mutex_init(&cfile->fh_mutex);
 	spin_lock_init(&cfile->file_info_lock);
 
-	cifs_sb_active(inode->i_sb);
-
 	/*
 	 * If the server returned a read oplock and we have mandatory brlocks,
 	 * set oplock level to None.
@@ -438,7 +436,6 @@ static void cifsFileInfo_put_final(struct cifsFileInfo *cifs_file)
 	struct inode *inode = d_inode(cifs_file->dentry);
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	struct cifsLockInfo *li, *tmp;
-	struct super_block *sb = inode->i_sb;
 
 	/*
 	 * Delete any outstanding lock records. We'll lose them when the file
@@ -456,7 +453,6 @@ static void cifsFileInfo_put_final(struct cifsFileInfo *cifs_file)
 
 	cifs_put_tlink(cifs_file->tlink);
 	dput(cifs_file->dentry);
-	cifs_sb_deactive(sb);
 	kfree(cifs_file->symlink_target);
 	kfree(cifs_file);
 }
@@ -5200,12 +5196,6 @@ void cifs_oplock_break(struct work_struct *work)
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
 
@@ -5278,7 +5268,6 @@ void cifs_oplock_break(struct work_struct *work)
 	cifs_put_tlink(tlink);
 out:
 	cifs_done_oplock_break(cinode);
-	cifs_sb_deactive(sb);
 }
 
 /*
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 13bfab36c04af..049a14677c910 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -29,6 +29,11 @@
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
@@ -809,6 +814,42 @@ cifs_close_all_deferred_files(struct cifs_tcon *tcon)
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
+		spin_lock(&tcon->tc_lock);
+		++tcon->tc_count;
+		spin_unlock(&tcon->tc_lock);
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


