Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73A26FACE5
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbjEHL3H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbjEHL2l (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:28:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD023C3FD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:28:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FE5262E8C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D989C433EF;
        Mon,  8 May 2023 11:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545300;
        bh=h0GZM46ackmWdvrtsBLnG6oCF1R4vMFH+lknJBSS7m8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t1vUqk94Pdp80tS9Be4tvBPYElM+U99vgRI5RohQfWinPuVPa+qu7NUFHRODSJkeR
         hK3eWtuzH988/XrjgdxFfvnzHFALwk2SDD60431QWGQCk/mgGK21uIngJ/yDgEk+bF
         y6Z5ElK3opD5v1w9s1JJB+KXYUCQzbc4am4Y5rks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.3 690/694] cifs: fix sharing of DFS connections
Date:   Mon,  8 May 2023 11:48:45 +0200
Message-Id: <20230508094458.806128693@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paulo Alcantara <pc@manguebit.com>

commit 8e3554150d6c80a84b3cb046615d1a0e943811dc upstream.

When matching DFS connections, we can't rely on the values set in
cifs_sb_info::prepath and cifs_tcon::tree_name as they might change
during DFS failover.  The DFS referrals related to a specific DFS tcon
are already matched earlier in match_server(), therefore we can safely
skip those checks altogether as the connection is guaranteed to be
unique for the DFS tcon.

Besides, when creating or finding an SMB session, make sure to also
refcount any DFS root session related to it (cifs_ses::dfs_root_ses),
so if a new DFS mount ends up reusing the connection from the old
mount while there was an umount(2) still in progress (e.g. umount(2)
-> cifs_umount() -> reconnect -> cifs_put_tcon()), the connection
could potentially be put right after the umount(2) finished.

Patch has minor update to include fix for unused variable issue
noted by the kernel test robot

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202305041040.j7W2xQSy-lkp@intel.com/
Cc: stable@vger.kernel.org # v6.2+
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/cifsglob.h  |    1 
 fs/cifs/cifsproto.h |   44 +++++++++++++++++++
 fs/cifs/connect.c   |  116 ++++++++++++++++++++++++++--------------------------
 fs/cifs/dfs.c       |   62 +++++++++++++++++++--------
 fs/cifs/ioctl.c     |    2 
 fs/cifs/smb2pdu.c   |    4 -
 6 files changed, 148 insertions(+), 81 deletions(-)

--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1750,7 +1750,6 @@ struct cifs_mount_ctx {
 	struct TCP_Server_Info *server;
 	struct cifs_ses *ses;
 	struct cifs_tcon *tcon;
-	char *origin_fullpath, *leaf_fullpath;
 	struct list_head dfs_ses_list;
 };
 
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -8,6 +8,7 @@
 #ifndef _CIFSPROTO_H
 #define _CIFSPROTO_H
 #include <linux/nls.h>
+#include <linux/ctype.h>
 #include "trace.h"
 #ifdef CONFIG_CIFS_DFS_UPCALL
 #include "dfs_cache.h"
@@ -572,7 +573,7 @@ extern int E_md4hash(const unsigned char
 extern struct TCP_Server_Info *
 cifs_find_tcp_session(struct smb3_fs_context *ctx);
 
-extern void cifs_put_smb_ses(struct cifs_ses *ses);
+void __cifs_put_smb_ses(struct cifs_ses *ses);
 
 extern struct cifs_ses *
 cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx);
@@ -696,4 +697,45 @@ struct super_block *cifs_get_tcon_super(
 void cifs_put_tcon_super(struct super_block *sb);
 int cifs_wait_for_server_reconnect(struct TCP_Server_Info *server, bool retry);
 
+/* Put references of @ses and @ses->dfs_root_ses */
+static inline void cifs_put_smb_ses(struct cifs_ses *ses)
+{
+	struct cifs_ses *rses = ses->dfs_root_ses;
+
+	__cifs_put_smb_ses(ses);
+	if (rses)
+		__cifs_put_smb_ses(rses);
+}
+
+/* Get an active reference of @ses and @ses->dfs_root_ses.
+ *
+ * NOTE: make sure to call this function when incrementing reference count of
+ * @ses to ensure that any DFS root session attached to it (@ses->dfs_root_ses)
+ * will also get its reference count incremented.
+ *
+ * cifs_put_smb_ses() will put both references, so call it when you're done.
+ */
+static inline void cifs_smb_ses_inc_refcount(struct cifs_ses *ses)
+{
+	lockdep_assert_held(&cifs_tcp_ses_lock);
+
+	ses->ses_count++;
+	if (ses->dfs_root_ses)
+		ses->dfs_root_ses->ses_count++;
+}
+
+static inline bool dfs_src_pathname_equal(const char *s1, const char *s2)
+{
+	if (strlen(s1) != strlen(s2))
+		return false;
+	for (; *s1; s1++, s2++) {
+		if (*s1 == '/' || *s1 == '\\') {
+			if (*s2 != '/' && *s2 != '\\')
+				return false;
+		} else if (tolower(*s1) != tolower(*s2))
+			return false;
+	}
+	return true;
+}
+
 #endif			/* _CIFSPROTO_H */
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -993,10 +993,8 @@ static void clean_demultiplex_info(struc
 		 */
 	}
 
-#ifdef CONFIG_CIFS_DFS_UPCALL
 	kfree(server->origin_fullpath);
 	kfree(server->leaf_fullpath);
-#endif
 	kfree(server);
 
 	length = atomic_dec_return(&tcpSesAllocCount);
@@ -1384,23 +1382,8 @@ match_security(struct TCP_Server_Info *s
 	return true;
 }
 
-static bool dfs_src_pathname_equal(const char *s1, const char *s2)
-{
-	if (strlen(s1) != strlen(s2))
-		return false;
-	for (; *s1; s1++, s2++) {
-		if (*s1 == '/' || *s1 == '\\') {
-			if (*s2 != '/' && *s2 != '\\')
-				return false;
-		} else if (tolower(*s1) != tolower(*s2))
-			return false;
-	}
-	return true;
-}
-
 /* this function must be called with srv_lock held */
-static int match_server(struct TCP_Server_Info *server, struct smb3_fs_context *ctx,
-			bool dfs_super_cmp)
+static int match_server(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 {
 	struct sockaddr *addr = (struct sockaddr *)&ctx->dstaddr;
 
@@ -1431,27 +1414,41 @@ static int match_server(struct TCP_Serve
 			       (struct sockaddr *)&server->srcaddr))
 		return 0;
 	/*
-	 * When matching DFS superblocks, we only check for original source pathname as the
-	 * currently connected target might be different than the one parsed earlier in i.e.
-	 * mount.cifs(8).
-	 */
-	if (dfs_super_cmp) {
-		if (!ctx->source || !server->origin_fullpath ||
-		    !dfs_src_pathname_equal(server->origin_fullpath, ctx->source))
-			return 0;
-	} else {
-		/* Skip addr, hostname and port matching for DFS connections */
-		if (server->leaf_fullpath) {
+	 * - Match for an DFS tcon (@server->origin_fullpath).
+	 * - Match for an DFS root server connection (@server->leaf_fullpath).
+	 * - If none of the above and @ctx->leaf_fullpath is set, then
+	 *   it is a new DFS connection.
+	 * - If 'nodfs' mount option was passed, then match only connections
+	 *   that have no DFS referrals set
+	 *   (e.g. can't failover to other targets).
+	 */
+	if (!ctx->nodfs) {
+		if (ctx->source && server->origin_fullpath) {
+			if (!dfs_src_pathname_equal(ctx->source,
+						    server->origin_fullpath))
+				return 0;
+		} else if (server->leaf_fullpath) {
 			if (!ctx->leaf_fullpath ||
-			    strcasecmp(server->leaf_fullpath, ctx->leaf_fullpath))
+			    strcasecmp(server->leaf_fullpath,
+				       ctx->leaf_fullpath))
 				return 0;
-		} else if (strcasecmp(server->hostname, ctx->server_hostname) ||
-			   !match_server_address(server, addr) ||
-			   !match_port(server, addr)) {
+		} else if (ctx->leaf_fullpath) {
 			return 0;
 		}
+	} else if (server->origin_fullpath || server->leaf_fullpath) {
+		return 0;
 	}
 
+	/*
+	 * Match for a regular connection (address/hostname/port) which has no
+	 * DFS referrals set.
+	 */
+	if (!server->origin_fullpath && !server->leaf_fullpath &&
+	    (strcasecmp(server->hostname, ctx->server_hostname) ||
+	     !match_server_address(server, addr) ||
+	     !match_port(server, addr)))
+		return 0;
+
 	if (!match_security(server, ctx))
 		return 0;
 
@@ -1482,7 +1479,7 @@ cifs_find_tcp_session(struct smb3_fs_con
 		 * Skip ses channels since they're only handled in lower layers
 		 * (e.g. cifs_send_recv).
 		 */
-		if (CIFS_SERVER_IS_CHAN(server) || !match_server(server, ctx, false)) {
+		if (CIFS_SERVER_IS_CHAN(server) || !match_server(server, ctx)) {
 			spin_unlock(&server->srv_lock);
 			continue;
 		}
@@ -1867,7 +1864,7 @@ cifs_free_ipc(struct cifs_ses *ses)
 static struct cifs_ses *
 cifs_find_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 {
-	struct cifs_ses *ses;
+	struct cifs_ses *ses, *ret = NULL;
 
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
@@ -1877,23 +1874,22 @@ cifs_find_smb_ses(struct TCP_Server_Info
 			continue;
 		}
 		spin_lock(&ses->chan_lock);
-		if (!match_session(ses, ctx)) {
+		if (match_session(ses, ctx)) {
 			spin_unlock(&ses->chan_lock);
 			spin_unlock(&ses->ses_lock);
-			continue;
+			ret = ses;
+			break;
 		}
 		spin_unlock(&ses->chan_lock);
 		spin_unlock(&ses->ses_lock);
-
-		++ses->ses_count;
-		spin_unlock(&cifs_tcp_ses_lock);
-		return ses;
 	}
+	if (ret)
+		cifs_smb_ses_inc_refcount(ret);
 	spin_unlock(&cifs_tcp_ses_lock);
-	return NULL;
+	return ret;
 }
 
-void cifs_put_smb_ses(struct cifs_ses *ses)
+void __cifs_put_smb_ses(struct cifs_ses *ses)
 {
 	unsigned int rc, xid;
 	unsigned int chan_count;
@@ -2244,6 +2240,8 @@ cifs_get_smb_ses(struct TCP_Server_Info
 	 */
 	spin_lock(&cifs_tcp_ses_lock);
 	ses->dfs_root_ses = ctx->dfs_root_ses;
+	if (ses->dfs_root_ses)
+		ses->dfs_root_ses->ses_count++;
 	list_add(&ses->smb_ses_list, &server->smb_ses_list);
 	spin_unlock(&cifs_tcp_ses_lock);
 
@@ -2260,12 +2258,15 @@ get_ses_fail:
 }
 
 /* this function must be called with tc_lock held */
-static int match_tcon(struct cifs_tcon *tcon, struct smb3_fs_context *ctx, bool dfs_super_cmp)
+static int match_tcon(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 {
+	struct TCP_Server_Info *server = tcon->ses->server;
+
 	if (tcon->status == TID_EXITING)
 		return 0;
-	/* Skip UNC validation when matching DFS superblocks */
-	if (!dfs_super_cmp && strncmp(tcon->tree_name, ctx->UNC, MAX_TREE_SIZE))
+	/* Skip UNC validation when matching DFS connections or superblocks */
+	if (!server->origin_fullpath && !server->leaf_fullpath &&
+	    strncmp(tcon->tree_name, ctx->UNC, MAX_TREE_SIZE))
 		return 0;
 	if (tcon->seal != ctx->seal)
 		return 0;
@@ -2288,7 +2289,7 @@ cifs_find_tcon(struct cifs_ses *ses, str
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 		spin_lock(&tcon->tc_lock);
-		if (!match_tcon(tcon, ctx, false)) {
+		if (!match_tcon(tcon, ctx)) {
 			spin_unlock(&tcon->tc_lock);
 			continue;
 		}
@@ -2659,9 +2660,11 @@ compare_mount_options(struct super_block
 	return 1;
 }
 
-static int
-match_prepath(struct super_block *sb, struct cifs_mnt_data *mnt_data)
+static int match_prepath(struct super_block *sb,
+			 struct TCP_Server_Info *server,
+			 struct cifs_mnt_data *mnt_data)
 {
+	struct smb3_fs_context *ctx = mnt_data->ctx;
 	struct cifs_sb_info *old = CIFS_SB(sb);
 	struct cifs_sb_info *new = mnt_data->cifs_sb;
 	bool old_set = (old->mnt_cifs_flags & CIFS_MOUNT_USE_PREFIX_PATH) &&
@@ -2669,6 +2672,10 @@ match_prepath(struct super_block *sb, st
 	bool new_set = (new->mnt_cifs_flags & CIFS_MOUNT_USE_PREFIX_PATH) &&
 		new->prepath;
 
+	if (server->origin_fullpath &&
+	    dfs_src_pathname_equal(server->origin_fullpath, ctx->source))
+		return 1;
+
 	if (old_set && new_set && !strcmp(new->prepath, old->prepath))
 		return 1;
 	else if (!old_set && !new_set)
@@ -2687,7 +2694,6 @@ cifs_match_super(struct super_block *sb,
 	struct cifs_ses *ses;
 	struct cifs_tcon *tcon;
 	struct tcon_link *tlink;
-	bool dfs_super_cmp;
 	int rc = 0;
 
 	spin_lock(&cifs_tcp_ses_lock);
@@ -2702,18 +2708,16 @@ cifs_match_super(struct super_block *sb,
 	ses = tcon->ses;
 	tcp_srv = ses->server;
 
-	dfs_super_cmp = IS_ENABLED(CONFIG_CIFS_DFS_UPCALL) && tcp_srv->origin_fullpath;
-
 	ctx = mnt_data->ctx;
 
 	spin_lock(&tcp_srv->srv_lock);
 	spin_lock(&ses->ses_lock);
 	spin_lock(&ses->chan_lock);
 	spin_lock(&tcon->tc_lock);
-	if (!match_server(tcp_srv, ctx, dfs_super_cmp) ||
+	if (!match_server(tcp_srv, ctx) ||
 	    !match_session(ses, ctx) ||
-	    !match_tcon(tcon, ctx, dfs_super_cmp) ||
-	    !match_prepath(sb, mnt_data)) {
+	    !match_tcon(tcon, ctx) ||
+	    !match_prepath(sb, tcp_srv, mnt_data)) {
 		rc = 0;
 		goto out;
 	}
@@ -3458,8 +3462,6 @@ out:
 
 error:
 	dfs_put_root_smb_sessions(&mnt_ctx.dfs_ses_list);
-	kfree(mnt_ctx.origin_fullpath);
-	kfree(mnt_ctx.leaf_fullpath);
 	cifs_mount_put_conns(&mnt_ctx);
 	return rc;
 }
--- a/fs/cifs/dfs.c
+++ b/fs/cifs/dfs.c
@@ -99,7 +99,7 @@ static int get_session(struct cifs_mount
 	return rc;
 }
 
-static int get_root_smb_session(struct cifs_mount_ctx *mnt_ctx)
+static int add_root_smb_session(struct cifs_mount_ctx *mnt_ctx)
 {
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
 	struct dfs_root_ses *root_ses;
@@ -127,7 +127,7 @@ static int get_dfs_conn(struct cifs_moun
 {
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
 	struct dfs_info3_param ref = {};
-	bool is_refsrv = false;
+	bool is_refsrv;
 	int rc, rc2;
 
 	rc = dfs_cache_get_tgt_referral(ref_path + 1, tit, &ref);
@@ -158,7 +158,7 @@ static int get_dfs_conn(struct cifs_moun
 	}
 
 	if (rc == -EREMOTE && is_refsrv) {
-		rc2 = get_root_smb_session(mnt_ctx);
+		rc2 = add_root_smb_session(mnt_ctx);
 		if (rc2)
 			rc = rc2;
 	}
@@ -272,15 +272,21 @@ out:
 
 int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx, bool *isdfs)
 {
-	struct cifs_sb_info *cifs_sb = mnt_ctx->cifs_sb;
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
+	struct cifs_ses *ses;
+	char *source = ctx->source;
+	bool nodfs = ctx->nodfs;
 	int rc;
 
 	*isdfs = false;
-
+	/* Temporarily set @ctx->source to NULL as we're not matching DFS
+	 * superblocks yet.  See cifs_match_super() and match_server().
+	 */
+	ctx->source = NULL;
 	rc = get_session(mnt_ctx, NULL);
 	if (rc)
-		return rc;
+		goto out;
+
 	ctx->dfs_root_ses = mnt_ctx->ses;
 	/*
 	 * If called with 'nodfs' mount option, then skip DFS resolving.  Otherwise unconditionally
@@ -289,23 +295,41 @@ int dfs_mount_share(struct cifs_mount_ct
 	 * Skip prefix path to provide support for DFS referrals from w2k8 servers which don't seem
 	 * to respond with PATH_NOT_COVERED to requests that include the prefix.
 	 */
-	if ((cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_DFS) ||
-	    dfs_get_referral(mnt_ctx, ctx->UNC + 1, NULL, NULL)) {
+	if (!nodfs) {
+		rc = dfs_get_referral(mnt_ctx, ctx->UNC + 1, NULL, NULL);
+		if (rc) {
+			if (rc != -ENOENT && rc != -EOPNOTSUPP)
+				goto out;
+			nodfs = true;
+		}
+	}
+	if (nodfs) {
 		rc = cifs_mount_get_tcon(mnt_ctx);
-		if (rc)
-			return rc;
-
-		rc = cifs_is_path_remote(mnt_ctx);
-		if (!rc || rc != -EREMOTE)
-			return rc;
+		if (!rc)
+			rc = cifs_is_path_remote(mnt_ctx);
+		goto out;
 	}
 
 	*isdfs = true;
-	rc = get_root_smb_session(mnt_ctx);
-	if (rc)
-		return rc;
-
-	return __dfs_mount_share(mnt_ctx);
+	/*
+	 * Prevent DFS root session of being put in the first call to
+	 * cifs_mount_put_conns().  If another DFS root server was not found
+	 * while chasing the referrals (@ctx->dfs_root_ses == @ses), then we
+	 * can safely put extra refcount of @ses.
+	 */
+	ses = mnt_ctx->ses;
+	mnt_ctx->ses = NULL;
+	mnt_ctx->server = NULL;
+	rc = __dfs_mount_share(mnt_ctx);
+	if (ses == ctx->dfs_root_ses)
+		cifs_put_smb_ses(ses);
+out:
+	/*
+	 * Restore previous value of @ctx->source so DFS superblock can be
+	 * matched in cifs_match_super().
+	 */
+	ctx->source = source;
+	return rc;
 }
 
 /* Update dfs referral path of superblock */
--- a/fs/cifs/ioctl.c
+++ b/fs/cifs/ioctl.c
@@ -239,7 +239,7 @@ static int cifs_dump_full_key(struct cif
 					 * section, we need to make sure it won't be released
 					 * so increment its refcount
 					 */
-					ses->ses_count++;
+					cifs_smb_ses_inc_refcount(ses);
 					found = true;
 					goto search_end;
 				}
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3856,7 +3856,7 @@ void smb2_reconnect_server(struct work_s
 		if (ses->tcon_ipc && ses->tcon_ipc->need_reconnect) {
 			list_add_tail(&ses->tcon_ipc->rlist, &tmp_list);
 			tcon_selected = tcon_exist = true;
-			ses->ses_count++;
+			cifs_smb_ses_inc_refcount(ses);
 		}
 		/*
 		 * handle the case where channel needs to reconnect
@@ -3867,7 +3867,7 @@ void smb2_reconnect_server(struct work_s
 		if (!tcon_selected && cifs_chan_needs_reconnect(ses, server)) {
 			list_add_tail(&ses->rlist, &tmp_ses_list);
 			ses_exist = true;
-			ses->ses_count++;
+			cifs_smb_ses_inc_refcount(ses);
 		}
 		spin_unlock(&ses->chan_lock);
 	}


