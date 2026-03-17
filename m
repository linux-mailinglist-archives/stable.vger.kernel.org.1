Return-Path: <stable+bounces-225929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDkDETZPuWnj/wEAu9opvQ
	(envelope-from <stable+bounces-225929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:55:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D50E32AA363
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A02B309F6B7
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231D93C5DB8;
	Tue, 17 Mar 2026 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B2wqEWbu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7FC3AE19B
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773751960; cv=none; b=O8vVozn1bvmDU62lkhtXSlaki+mbQwhI5gvOzN0Fahk2skx66u8tE6kTt/kAkOz6NNoKH2VTjoUPN1h5K+p5peqoq7k61aZx/9Eu9IckBjpZnIxs9Y0NRCU8Da752zkdTNwqPiEmSIfn27m3O4bbDxbAFIvzQoBNEcRjcLReazU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773751960; c=relaxed/simple;
	bh=EMrvHPfkEGLRxJHJTUpB1pZnPIpAIdUKSB7FzLqeyrk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eZPWrWldjFPdtL/NnIZE9kY8VAGLFJkI+tu7+bU3vYiSlr4AfARXnJZsuz/MZgGABHN6DcEPbwiSofRyLM1kLWMo1NUQXQAcAy67SdIsVTowTZQzg4OnRbRldOtGgTSEeAKQHi/3a9CQGbQjmHHfbgQZoGUAp3O/FkxDGwohcpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B2wqEWbu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D716EC4CEF7;
	Tue, 17 Mar 2026 12:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773751960;
	bh=EMrvHPfkEGLRxJHJTUpB1pZnPIpAIdUKSB7FzLqeyrk=;
	h=Subject:To:Cc:From:Date:From;
	b=B2wqEWbu/PKZN0l4DmYEqB9ZF/SibzFdDF/CbZRT7MzX8aHTiSbkBcHr2IgIa1yOB
	 Gwt70sUS5hfmmyi0R4UJ1jSJdKEy1BlV257yGEX5Qt8z16PzFg1JAtKvjVkto565li
	 oDvH4/sJZCrT4uF5q/yEEPLfi9rC5HPlqeAFog94=
Subject: FAILED: patch "[PATCH] cifs: open files should not hold ref on superblock" failed to apply to 6.1-stable tree
To: sprasad@microsoft.com,stable@vger.kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:52:14 +0100
Message-ID: <2026031714-dragster-unaired-0a09@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225929-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: D50E32AA363
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 340cea84f691c5206561bb2e0147158fe02070be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031714-dragster-unaired-0a09@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 340cea84f691c5206561bb2e0147158fe02070be Mon Sep 17 00:00:00 2001
From: Shyam Prasad N <sprasad@microsoft.com>
Date: Wed, 4 Mar 2026 18:15:53 +0530
Subject: [PATCH] cifs: open files should not hold ref on superblock

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

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 427558404aa5..b6e3db993cc6 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -332,10 +332,14 @@ static void cifs_kill_sb(struct super_block *sb)
 
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
@@ -868,7 +872,6 @@ static void cifs_umount_begin(struct super_block *sb)
 	spin_unlock(&tcon->tc_lock);
 	spin_unlock(&cifs_tcp_ses_lock);
 
-	cifs_close_all_deferred_files(tcon);
 	/* cancel_brl_requests(tcon); */ /* BB mark all brl mids as exiting */
 	/* cancel_notify_requests(tcon); */
 	if (tcon->ses && tcon->ses->server) {
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 96d6b5325aa3..800a7e418c32 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -261,6 +261,7 @@ void cifs_close_deferred_file(struct cifsInodeInfo *cifs_inode);
 
 void cifs_close_all_deferred_files(struct cifs_tcon *tcon);
 
+void cifs_close_all_deferred_files_sb(struct cifs_sb_info *cifs_sb);
 void cifs_close_deferred_file_under_dentry(struct cifs_tcon *tcon,
 					   struct dentry *dentry);
 
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index f3ddcdf406c8..cffcf82c1b69 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -711,8 +711,6 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
 	mutex_init(&cfile->fh_mutex);
 	spin_lock_init(&cfile->file_info_lock);
 
-	cifs_sb_active(inode->i_sb);
-
 	/*
 	 * If the server returned a read oplock and we have mandatory brlocks,
 	 * set oplock level to None.
@@ -767,7 +765,6 @@ static void cifsFileInfo_put_final(struct cifsFileInfo *cifs_file)
 	struct inode *inode = d_inode(cifs_file->dentry);
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	struct cifsLockInfo *li, *tmp;
-	struct super_block *sb = inode->i_sb;
 
 	/*
 	 * Delete any outstanding lock records. We'll lose them when the file
@@ -785,7 +782,6 @@ static void cifsFileInfo_put_final(struct cifsFileInfo *cifs_file)
 
 	cifs_put_tlink(cifs_file->tlink);
 	dput(cifs_file->dentry);
-	cifs_sb_deactive(sb);
 	kfree(cifs_file->symlink_target);
 	kfree(cifs_file);
 }
@@ -3163,12 +3159,6 @@ void cifs_oplock_break(struct work_struct *work)
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
 
@@ -3253,7 +3243,6 @@ void cifs_oplock_break(struct work_struct *work)
 	cifs_put_tlink(tlink);
 out:
 	cifs_done_oplock_break(cinode);
-	cifs_sb_deactive(sb);
 }
 
 static int cifs_swap_activate(struct swap_info_struct *sis,
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index bc24c92b8b95..2aff1cab6c31 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -28,6 +28,11 @@
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
@@ -554,6 +559,43 @@ cifs_close_all_deferred_files(struct cifs_tcon *tcon)
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
+		tmp_list = kmalloc_obj(struct tcon_list, GFP_ATOMIC);
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
index 9228f95cae2b..acfbb63086ea 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -176,6 +176,7 @@
 	EM(netfs_trace_tcon_ref_get_cached_laundromat,	"GET Ch-Lau") \
 	EM(netfs_trace_tcon_ref_get_cached_lease_break,	"GET Ch-Lea") \
 	EM(netfs_trace_tcon_ref_get_cancelled_close,	"GET Cn-Cls") \
+	EM(netfs_trace_tcon_ref_get_close_defer_files,	"GET Cl-Def") \
 	EM(netfs_trace_tcon_ref_get_dfs_refer,		"GET DfsRef") \
 	EM(netfs_trace_tcon_ref_get_find,		"GET Find  ") \
 	EM(netfs_trace_tcon_ref_get_find_sess_tcon,	"GET FndSes") \
@@ -187,6 +188,7 @@
 	EM(netfs_trace_tcon_ref_put_cancelled_close,	"PUT Cn-Cls") \
 	EM(netfs_trace_tcon_ref_put_cancelled_close_fid, "PUT Cn-Fid") \
 	EM(netfs_trace_tcon_ref_put_cancelled_mid,	"PUT Cn-Mid") \
+	EM(netfs_trace_tcon_ref_put_close_defer_files,	"PUT Cl-Def") \
 	EM(netfs_trace_tcon_ref_put_mnt_ctx,		"PUT MntCtx") \
 	EM(netfs_trace_tcon_ref_put_dfs_refer,		"PUT DfsRfr") \
 	EM(netfs_trace_tcon_ref_put_reconnect_server,	"PUT Reconn") \


