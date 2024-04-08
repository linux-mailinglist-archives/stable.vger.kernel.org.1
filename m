Return-Path: <stable+bounces-36358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9F789BCE9
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 12:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8491C2115E
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 10:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3191B52F86;
	Mon,  8 Apr 2024 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FCYCzqGl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA252F82
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571603; cv=none; b=t0xvzJgC8y4gSHrR4yYlHdCM13T9dbFAyJpCgHUl2NRGA3svYY1ckJCCZ6HwMGUfoBYYxt0mLc7j6igh5MwTCOWthnCzoxp52bgXFPDnpx7EqDyOn2W6K9jWyrDehEiGuHA5VxxGsTh2m3ssP/ci8Os2LmFDyITLIrNBFVti3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571603; c=relaxed/simple;
	bh=7fnyaQ2HtghdvLRCdyUvbBv7ZrbWExF8y8/RMU6W27g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eWIOFzzIreCVib010WAfrh88je/EGGZAGd1GoDX3CnlRqTziGu64FoLfoBpIgjqJDPxKtBBjxPxy6F5CZOu9kpeJWiD9jJnUegr03jwezx0z8oo2NBDls6lQh8K+BMbw25cPZ2govqCJO5PIIqKsUaYhitWhGCcJ77Vy8ctfPH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FCYCzqGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D2FC433C7;
	Mon,  8 Apr 2024 10:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712571602;
	bh=7fnyaQ2HtghdvLRCdyUvbBv7ZrbWExF8y8/RMU6W27g=;
	h=Subject:To:Cc:From:Date:From;
	b=FCYCzqGl8Z0kqpGqlN8yTubvX5FLrSHdPi8PyiTDhfuf39zpoBpbyIN+oTkKr+6hX
	 pta/4p+I9TDAqkAMyN3cEwdrhd0MI9/2mA17rck5Lhz+BNTt18MvTcbp2CMwcyUpY3
	 h6dlyFGPqhXeSryNgWT5TzcnlQdD2cMzsL7V2Tqw=
Subject: FAILED: patch "[PATCH] smb: client: guarantee refcounted children from parent" failed to apply to 6.6-stable tree
To: pc@manguebit.com,lkp@intel.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Apr 2024 12:19:57 +0200
Message-ID: <2024040857-earthworm-untimely-552b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 062a7f0ff46eb57aff526897bd2bebfdb1d3046a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040857-earthworm-untimely-552b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

062a7f0ff46e ("smb: client: guarantee refcounted children from parent session")
d8392c203e84 ("smb3: show beginning time for per share stats")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 062a7f0ff46eb57aff526897bd2bebfdb1d3046a Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.com>
Date: Mon, 1 Apr 2024 22:37:42 -0500
Subject: [PATCH] smb: client: guarantee refcounted children from parent
 session

Avoid potential use-after-free bugs when walking DFS referrals,
mounting and performing DFS failover by ensuring that all children
from parent @tcon->ses are also refcounted.  They're all needed across
the entire DFS mount.  Get rid of @tcon->dfs_ses_list while we're at
it, too.

Cc: stable@vger.kernel.org # 6.4+
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404021527.ZlRkIxgv-lkp@intel.com/
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 7ed9d05f6890..286afbe346be 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1281,7 +1281,6 @@ struct cifs_tcon {
 	struct cached_fids *cfids;
 	/* BB add field for back pointer to sb struct(s)? */
 #ifdef CONFIG_CIFS_DFS_UPCALL
-	struct list_head dfs_ses_list;
 	struct delayed_work dfs_cache_work;
 #endif
 	struct delayed_work	query_interfaces; /* query interfaces workqueue job */
@@ -1804,7 +1803,6 @@ struct cifs_mount_ctx {
 	struct TCP_Server_Info *server;
 	struct cifs_ses *ses;
 	struct cifs_tcon *tcon;
-	struct list_head dfs_ses_list;
 };
 
 static inline void __free_dfs_info_param(struct dfs_info3_param *param)
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 0723e1b57256..8e0a348f1f66 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -725,31 +725,31 @@ struct super_block *cifs_get_tcon_super(struct cifs_tcon *tcon);
 void cifs_put_tcon_super(struct super_block *sb);
 int cifs_wait_for_server_reconnect(struct TCP_Server_Info *server, bool retry);
 
-/* Put references of @ses and @ses->dfs_root_ses */
+/* Put references of @ses and its children */
 static inline void cifs_put_smb_ses(struct cifs_ses *ses)
 {
-	struct cifs_ses *rses = ses->dfs_root_ses;
+	struct cifs_ses *next;
 
-	__cifs_put_smb_ses(ses);
-	if (rses)
-		__cifs_put_smb_ses(rses);
+	do {
+		next = ses->dfs_root_ses;
+		__cifs_put_smb_ses(ses);
+	} while ((ses = next));
 }
 
-/* Get an active reference of @ses and @ses->dfs_root_ses.
+/* Get an active reference of @ses and its children.
  *
  * NOTE: make sure to call this function when incrementing reference count of
  * @ses to ensure that any DFS root session attached to it (@ses->dfs_root_ses)
  * will also get its reference count incremented.
  *
- * cifs_put_smb_ses() will put both references, so call it when you're done.
+ * cifs_put_smb_ses() will put all references, so call it when you're done.
  */
 static inline void cifs_smb_ses_inc_refcount(struct cifs_ses *ses)
 {
 	lockdep_assert_held(&cifs_tcp_ses_lock);
 
-	ses->ses_count++;
-	if (ses->dfs_root_ses)
-		ses->dfs_root_ses->ses_count++;
+	for (; ses; ses = ses->dfs_root_ses)
+		ses->ses_count++;
 }
 
 static inline bool dfs_src_pathname_equal(const char *s1, const char *s2)
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index ee29bc57300c..38b75cfa06e3 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1866,6 +1866,9 @@ static int match_session(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 	    ctx->sectype != ses->sectype)
 		return 0;
 
+	if (ctx->dfs_root_ses != ses->dfs_root_ses)
+		return 0;
+
 	/*
 	 * If an existing session is limited to less channels than
 	 * requested, it should not be reused
@@ -2358,9 +2361,9 @@ cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 	 * need to lock before changing something in the session.
 	 */
 	spin_lock(&cifs_tcp_ses_lock);
+	if (ctx->dfs_root_ses)
+		cifs_smb_ses_inc_refcount(ctx->dfs_root_ses);
 	ses->dfs_root_ses = ctx->dfs_root_ses;
-	if (ses->dfs_root_ses)
-		ses->dfs_root_ses->ses_count++;
 	list_add(&ses->smb_ses_list, &server->smb_ses_list);
 	spin_unlock(&cifs_tcp_ses_lock);
 
@@ -3311,6 +3314,9 @@ void cifs_mount_put_conns(struct cifs_mount_ctx *mnt_ctx)
 		cifs_put_smb_ses(mnt_ctx->ses);
 	else if (mnt_ctx->server)
 		cifs_put_tcp_session(mnt_ctx->server, 0);
+	mnt_ctx->ses = NULL;
+	mnt_ctx->tcon = NULL;
+	mnt_ctx->server = NULL;
 	mnt_ctx->cifs_sb->mnt_cifs_flags &= ~CIFS_MOUNT_POSIX_PATHS;
 	free_xid(mnt_ctx->xid);
 }
@@ -3589,8 +3595,6 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
 	bool isdfs;
 	int rc;
 
-	INIT_LIST_HEAD(&mnt_ctx.dfs_ses_list);
-
 	rc = dfs_mount_share(&mnt_ctx, &isdfs);
 	if (rc)
 		goto error;
@@ -3621,7 +3625,6 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
 	return rc;
 
 error:
-	dfs_put_root_smb_sessions(&mnt_ctx.dfs_ses_list);
 	cifs_mount_put_conns(&mnt_ctx);
 	return rc;
 }
@@ -3636,6 +3639,18 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
 		goto error;
 
 	rc = cifs_mount_get_tcon(&mnt_ctx);
+	if (!rc) {
+		/*
+		 * Prevent superblock from being created with any missing
+		 * connections.
+		 */
+		if (WARN_ON(!mnt_ctx.server))
+			rc = -EHOSTDOWN;
+		else if (WARN_ON(!mnt_ctx.ses))
+			rc = -EACCES;
+		else if (WARN_ON(!mnt_ctx.tcon))
+			rc = -ENOENT;
+	}
 	if (rc)
 		goto error;
 
diff --git a/fs/smb/client/dfs.c b/fs/smb/client/dfs.c
index 449c59830039..3ec965547e3d 100644
--- a/fs/smb/client/dfs.c
+++ b/fs/smb/client/dfs.c
@@ -66,33 +66,20 @@ static int get_session(struct cifs_mount_ctx *mnt_ctx, const char *full_path)
 }
 
 /*
- * Track individual DFS referral servers used by new DFS mount.
- *
- * On success, their lifetime will be shared by final tcon (dfs_ses_list).
- * Otherwise, they will be put by dfs_put_root_smb_sessions() in cifs_mount().
+ * Get an active reference of @ses so that next call to cifs_put_tcon() won't
+ * release it as any new DFS referrals must go through its IPC tcon.
  */
-static int add_root_smb_session(struct cifs_mount_ctx *mnt_ctx)
+static void add_root_smb_session(struct cifs_mount_ctx *mnt_ctx)
 {
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
-	struct dfs_root_ses *root_ses;
 	struct cifs_ses *ses = mnt_ctx->ses;
 
 	if (ses) {
-		root_ses = kmalloc(sizeof(*root_ses), GFP_KERNEL);
-		if (!root_ses)
-			return -ENOMEM;
-
-		INIT_LIST_HEAD(&root_ses->list);
-
 		spin_lock(&cifs_tcp_ses_lock);
 		cifs_smb_ses_inc_refcount(ses);
 		spin_unlock(&cifs_tcp_ses_lock);
-		root_ses->ses = ses;
-		list_add_tail(&root_ses->list, &mnt_ctx->dfs_ses_list);
 	}
-	/* Select new DFS referral server so that new referrals go through it */
 	ctx->dfs_root_ses = ses;
-	return 0;
 }
 
 static inline int parse_dfs_target(struct smb3_fs_context *ctx,
@@ -185,11 +172,8 @@ static int __dfs_referral_walk(struct cifs_mount_ctx *mnt_ctx,
 					continue;
 			}
 
-			if (is_refsrv) {
-				rc = add_root_smb_session(mnt_ctx);
-				if (rc)
-					goto out;
-			}
+			if (is_refsrv)
+				add_root_smb_session(mnt_ctx);
 
 			rc = ref_walk_advance(rw);
 			if (!rc) {
@@ -232,6 +216,7 @@ static int __dfs_mount_share(struct cifs_mount_ctx *mnt_ctx)
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
 	struct cifs_tcon *tcon;
 	char *origin_fullpath;
+	bool new_tcon = true;
 	int rc;
 
 	origin_fullpath = dfs_get_path(cifs_sb, ctx->source);
@@ -239,6 +224,18 @@ static int __dfs_mount_share(struct cifs_mount_ctx *mnt_ctx)
 		return PTR_ERR(origin_fullpath);
 
 	rc = dfs_referral_walk(mnt_ctx);
+	if (!rc) {
+		/*
+		 * Prevent superblock from being created with any missing
+		 * connections.
+		 */
+		if (WARN_ON(!mnt_ctx->server))
+			rc = -EHOSTDOWN;
+		else if (WARN_ON(!mnt_ctx->ses))
+			rc = -EACCES;
+		else if (WARN_ON(!mnt_ctx->tcon))
+			rc = -ENOENT;
+	}
 	if (rc)
 		goto out;
 
@@ -247,15 +244,14 @@ static int __dfs_mount_share(struct cifs_mount_ctx *mnt_ctx)
 	if (!tcon->origin_fullpath) {
 		tcon->origin_fullpath = origin_fullpath;
 		origin_fullpath = NULL;
+	} else {
+		new_tcon = false;
 	}
 	spin_unlock(&tcon->tc_lock);
 
-	if (list_empty(&tcon->dfs_ses_list)) {
-		list_replace_init(&mnt_ctx->dfs_ses_list, &tcon->dfs_ses_list);
+	if (new_tcon) {
 		queue_delayed_work(dfscache_wq, &tcon->dfs_cache_work,
 				   dfs_cache_get_ttl() * HZ);
-	} else {
-		dfs_put_root_smb_sessions(&mnt_ctx->dfs_ses_list);
 	}
 
 out:
@@ -298,7 +294,6 @@ int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx, bool *isdfs)
 	if (rc)
 		return rc;
 
-	ctx->dfs_root_ses = mnt_ctx->ses;
 	/*
 	 * If called with 'nodfs' mount option, then skip DFS resolving.  Otherwise unconditionally
 	 * try to get an DFS referral (even cached) to determine whether it is an DFS mount.
@@ -324,7 +319,9 @@ int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx, bool *isdfs)
 
 	*isdfs = true;
 	add_root_smb_session(mnt_ctx);
-	return __dfs_mount_share(mnt_ctx);
+	rc = __dfs_mount_share(mnt_ctx);
+	dfs_put_root_smb_sessions(mnt_ctx);
+	return rc;
 }
 
 /* Update dfs referral path of superblock */
diff --git a/fs/smb/client/dfs.h b/fs/smb/client/dfs.h
index 875ab7ae57fc..e5c4dcf83750 100644
--- a/fs/smb/client/dfs.h
+++ b/fs/smb/client/dfs.h
@@ -7,7 +7,9 @@
 #define _CIFS_DFS_H
 
 #include "cifsglob.h"
+#include "cifsproto.h"
 #include "fs_context.h"
+#include "dfs_cache.h"
 #include "cifs_unicode.h"
 #include <linux/namei.h>
 
@@ -114,11 +116,6 @@ static inline void ref_walk_set_tgt_hint(struct dfs_ref_walk *rw)
 				       ref_walk_tit(rw));
 }
 
-struct dfs_root_ses {
-	struct list_head list;
-	struct cifs_ses *ses;
-};
-
 int dfs_parse_target_referral(const char *full_path, const struct dfs_info3_param *ref,
 			      struct smb3_fs_context *ctx);
 int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx, bool *isdfs);
@@ -133,20 +130,32 @@ static inline int dfs_get_referral(struct cifs_mount_ctx *mnt_ctx, const char *p
 {
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
 	struct cifs_sb_info *cifs_sb = mnt_ctx->cifs_sb;
+	struct cifs_ses *rses = ctx->dfs_root_ses ?: mnt_ctx->ses;
 
-	return dfs_cache_find(mnt_ctx->xid, ctx->dfs_root_ses, cifs_sb->local_nls,
+	return dfs_cache_find(mnt_ctx->xid, rses, cifs_sb->local_nls,
 			      cifs_remap(cifs_sb), path, ref, tl);
 }
 
-static inline void dfs_put_root_smb_sessions(struct list_head *head)
+/*
+ * cifs_get_smb_ses() already guarantees an active reference of
+ * @ses->dfs_root_ses when a new session is created, so we need to put extra
+ * references of all DFS root sessions that were used across the mount process
+ * in dfs_mount_share().
+ */
+static inline void dfs_put_root_smb_sessions(struct cifs_mount_ctx *mnt_ctx)
 {
-	struct dfs_root_ses *root, *tmp;
+	const struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
+	struct cifs_ses *ses = ctx->dfs_root_ses;
+	struct cifs_ses *cur;
 
-	list_for_each_entry_safe(root, tmp, head, list) {
-		list_del_init(&root->list);
-		cifs_put_smb_ses(root->ses);
-		kfree(root);
+	if (!ses)
+		return;
+
+	for (cur = ses; cur; cur = cur->dfs_root_ses) {
+		if (cur->dfs_root_ses)
+			cifs_put_smb_ses(cur->dfs_root_ses);
 	}
+	cifs_put_smb_ses(ses);
 }
 
 #endif /* _CIFS_DFS_H */
diff --git a/fs/smb/client/dfs_cache.c b/fs/smb/client/dfs_cache.c
index 508d831fabe3..0552a864ff08 100644
--- a/fs/smb/client/dfs_cache.c
+++ b/fs/smb/client/dfs_cache.c
@@ -1278,21 +1278,12 @@ int dfs_cache_remount_fs(struct cifs_sb_info *cifs_sb)
 void dfs_cache_refresh(struct work_struct *work)
 {
 	struct TCP_Server_Info *server;
-	struct dfs_root_ses *rses;
 	struct cifs_tcon *tcon;
 	struct cifs_ses *ses;
 
 	tcon = container_of(work, struct cifs_tcon, dfs_cache_work.work);
-	ses = tcon->ses;
-	server = ses->server;
 
-	mutex_lock(&server->refpath_lock);
-	if (server->leaf_fullpath)
-		__refresh_tcon(server->leaf_fullpath + 1, ses, false);
-	mutex_unlock(&server->refpath_lock);
-
-	list_for_each_entry(rses, &tcon->dfs_ses_list, list) {
-		ses = rses->ses;
+	for (ses = tcon->ses; ses; ses = ses->dfs_root_ses) {
 		server = ses->server;
 		mutex_lock(&server->refpath_lock);
 		if (server->leaf_fullpath)
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index c3771fc81328..1ea22b3955a2 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -138,9 +138,6 @@ tcon_info_alloc(bool dir_leases_enabled)
 	atomic_set(&ret_buf->num_local_opens, 0);
 	atomic_set(&ret_buf->num_remote_opens, 0);
 	ret_buf->stats_from_time = ktime_get_real_seconds();
-#ifdef CONFIG_CIFS_DFS_UPCALL
-	INIT_LIST_HEAD(&ret_buf->dfs_ses_list);
-#endif
 
 	return ret_buf;
 }
@@ -156,9 +153,6 @@ tconInfoFree(struct cifs_tcon *tcon)
 	atomic_dec(&tconInfoAllocCount);
 	kfree(tcon->nativeFileSystem);
 	kfree_sensitive(tcon->password);
-#ifdef CONFIG_CIFS_DFS_UPCALL
-	dfs_put_root_smb_sessions(&tcon->dfs_ses_list);
-#endif
 	kfree(tcon->origin_fullpath);
 	kfree(tcon);
 }


