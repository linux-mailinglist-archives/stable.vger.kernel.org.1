Return-Path: <stable+bounces-223046-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOSBCwgqqGkdpAAAu9opvQ
	(envelope-from <stable+bounces-223046-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 13:48:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EFA1FFCF2
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 13:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 595CB3029AE9
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 12:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061191DE8AF;
	Wed,  4 Mar 2026 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFYDrWoQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFA91E0E14
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772628402; cv=none; b=nffes8P89HJ5wXgGD8stjfHSF5EUfHMMxrRIXY5SiPvfT+WkaBA6dhJBUtqQHXk7lNjX8HIGeOIYLAciFPo205ZNOuvfjSVG7qR3BjqGUxDve3Wpb0sRIvJ4l8BouYB/NtELl4P+NNAKjxxYutYRyaKsbVsiu+XYN7M00l7NM0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772628402; c=relaxed/simple;
	bh=X+cEgUYdBhzqmXNgOKBSdS0OGCTtnGXepLLe79iZaaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xv+TaP5OSPp2Rf6DnHT3N/oUGeS3s/JSTygmLVWWfKU68EmUa4jgmNw5gFJqOW5zwvWvPLX6wt+oNh58W088MGVIQLYnsGtcfO/NquVYWOjD2DMMOZNV5b4rghprw43vewCio1FkF8Ji6B/aU4VxoYIc+oNlRSj3WLUNOg48u/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFYDrWoQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82748095892so3283289b3a.0
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 04:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772628401; x=1773233201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PRHZvjbEn20Mjv6PiYHb8lOHhFpRFIdSlhpdu6s0ORg=;
        b=SFYDrWoQx1xs6xU+za7BEh8unzwo9BFEWcqiUMMvX4J2mcu0h4hR2M3SLR6QPTt6Cw
         xqmXDPHLt3emOwkdhD81zTZFMuDZqOVZLYO3T6JoA6rbzSiZialtDq/jarkiJLvmC4fY
         yW03ppKeuV0QFB0CYgUWChuij7xYQ/xcdhJXkx1MejI2kaNXeF704hLJ7tKG6pk5MquB
         S4UtI90IBJ0nFKURaHCnbMWjrL9DtNChgzDcrbqKXhAzTHkYPTi41n3UvXdGzBA63st5
         4lfEVWhNsthfmzsx2BO5KRJs0hopq5RD9Q2rv0x71CjPLeno4DWNxT9L6rg9/2+FQCxj
         +ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772628401; x=1773233201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRHZvjbEn20Mjv6PiYHb8lOHhFpRFIdSlhpdu6s0ORg=;
        b=Erv05XKAzDn3+AaxkiHs8E1EoiZp23dLgGty4f68kRAuf+lnAMiOcbbjvtDQPW+35o
         RvLTN7p/1Ux76079ZVvaXe6gGWXbttmk2tKqpSIvCgahEABymYhc5GZDZjaJsgQyMryv
         1SEHHW4sYJ+nY6NmkuCSYcTVOehu2nhlSXBKT9e88MeRpJ0stUMuhw3VLAnx5w6hM+Eu
         3KMmrvId3q56suU/T361QdZEfUqjquXx5n8Dt8IMzXO0+qIE3Cc56dSnt9TvVUxQ+/GS
         v8drTYKDqIbrxinK70YIqICfLsTumbO491MFGNYiAZEpBhWXTRDxIfPF0whRew2DE8pz
         jEZA==
X-Forwarded-Encrypted: i=1; AJvYcCW/sMsxXUtdwW4a/GBhaqQh9m2epKCxrzYTb6APO5FOnoE9yMuCqJxwmCobbZ7HMAj7f1SeM5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5LWgNRSCaAqaaZ8Utgg9rifkYgdz5XWd78byT5rSjXzpJ0oNZ
	MkDSH5OyPyQg7omyY76DUPV3UHIKlBAOazUg6gQfl63rYdav3ENAfkac
X-Gm-Gg: ATEYQzwzQSFCQx0RswELgP42/LnuWnhIxpuudYMlaG1i2jeg8Z9VRTswnHGvipclfT5
	mLZrJQBGajpYZbepX+z+1xqCtLjadZPhiQ2bQDBnYp5wxnxXd7KmNljD++dDkIPkNlVUN92hsBb
	ka6GpwVMbKcOz+zZEvjiiUkcLiNjUAmojYIrr5ZPcvfn3x1hZNBMMI+fODSUh8XsReomOcyh4+W
	QTjHtpDG7OxyecnmTV1Fg/fRNmkvJBxEJojbcx7CtS2hhVGive7J6kvB7Uy6fH5qAHfnDrKEQkS
	jch1CP3PZgWyJexgY5S4nire0psokrcp7K66GiuQS3r6bydTMBgXlrVAwjC9EyR7eXS4MjeH7iy
	pVl7WSOhjfL35ztAIAZCFZetcCymJebPy28JQFaEp0hCWtyZI2pMxAI+YnNB9ydJFRoNV6ziWZF
	puUjRVDUxFofJt5FJbkXrvoFAJ62Ra+3qrIV+MhqTN85zj6lPkw1g=
X-Received: by 2002:a05:6a20:7f96:b0:38d:ec8c:7e55 with SMTP id adf61e73a8af0-3982df0e577mr1836844637.32.1772628400796;
        Wed, 04 Mar 2026 04:46:40 -0800 (PST)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7377062904sm1836317a12.30.2026.03.04.04.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 04:46:40 -0800 (PST)
From: nspmangalore@gmail.com
X-Google-Original-From: sprasad@microsoft.com
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	pc@manguebit.com,
	bharathsm@microsoft.com,
	dhowells@redhat.com
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH] cifs: open files should not hold ref on superblock
Date: Wed,  4 Mar 2026 18:15:53 +0530
Message-ID: <20260304124629.1616108-1-sprasad@microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A3EFA1FFCF2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223046-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,manguebit.com,microsoft.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Shyam Prasad N <sprasad@microsoft.com>

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
---
 fs/smb/client/cifsfs.c    |  7 +++++--
 fs/smb/client/cifsproto.h |  1 +
 fs/smb/client/file.c      | 11 ----------
 fs/smb/client/misc.c      | 42 +++++++++++++++++++++++++++++++++++++++
 fs/smb/client/trace.h     |  2 ++
 5 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 99b04234a08e6..fcc56481d6cf2 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -330,10 +330,14 @@ static void cifs_kill_sb(struct super_block *sb)
 
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
@@ -864,7 +868,6 @@ static void cifs_umount_begin(struct super_block *sb)
 	spin_unlock(&tcon->tc_lock);
 	spin_unlock(&cifs_tcp_ses_lock);
 
-	cifs_close_all_deferred_files(tcon);
 	/* cancel_brl_requests(tcon); */ /* BB mark all brl mids as exiting */
 	/* cancel_notify_requests(tcon); */
 	if (tcon->ses && tcon->ses->server) {
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 96d6b5325aa33..800a7e418c326 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -261,6 +261,7 @@ void cifs_close_deferred_file(struct cifsInodeInfo *cifs_inode);
 
 void cifs_close_all_deferred_files(struct cifs_tcon *tcon);
 
+void cifs_close_all_deferred_files_sb(struct cifs_sb_info *cifs_sb);
 void cifs_close_deferred_file_under_dentry(struct cifs_tcon *tcon,
 					   struct dentry *dentry);
 
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 18f31d4eb98de..fb4f9aafe1386 100644
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
@@ -3165,12 +3161,6 @@ void cifs_oplock_break(struct work_struct *work)
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
 
@@ -3255,7 +3245,6 @@ void cifs_oplock_break(struct work_struct *work)
 	cifs_put_tlink(tlink);
 out:
 	cifs_done_oplock_break(cinode);
-	cifs_sb_deactive(sb);
 }
 
 static int cifs_swap_activate(struct swap_info_struct *sis,
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 22cde46309fe0..318533210648d 100644
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
@@ -550,6 +555,43 @@ cifs_close_all_deferred_files(struct cifs_tcon *tcon)
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
index 9228f95cae2bd..acfbb63086ea2 100644
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
-- 
2.43.0


