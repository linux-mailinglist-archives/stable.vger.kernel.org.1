Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8C76FA992
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbjEHKw6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbjEHKwk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:52:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188D12CFF4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C59F262941
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E4DC4339B;
        Mon,  8 May 2023 10:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543128;
        bh=vWfUcu/zjsURsKCR8GJ6ach5pMEOT+i814vX2hmW724=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOoIzhwYBv1PpbfODo3nssGmAS6+e9ni2yKTvNHsGlrCR4uFSzSscXEHcu9jeSWi7
         MyMzIvJDpgLqlna8ftUL0Kf2AUnlTZxBajKBL9CYRuBMK/1ydzd3rqKhBz6D4NdYMV
         eVKCDOSIA1yffU29k22RCd/CAzHdQ0GyADd95lKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.2 656/663] cifs: protect access of TCP_Server_Info::{origin,leaf}_fullpath
Date:   Mon,  8 May 2023 11:48:02 +0200
Message-Id: <20230508094451.440993007@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

commit 3dc9c433c9dde15477d02b609ccb4328e2adb6dc upstream.

Protect access of TCP_Server_Info::{origin,leaf}_fullpath when
matching DFS connections, and get rid of
TCP_Server_Info::current_fullpath while we're at it.

Cc: stable@vger.kernel.org # v6.2+
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/cifsglob.h  |   20 +++++++++++++-------
 fs/cifs/connect.c   |   10 ++++++----
 fs/cifs/dfs.c       |   14 ++++++++------
 fs/cifs/dfs.h       |   13 +++++++++++--
 fs/cifs/dfs_cache.c |    6 +++++-
 5 files changed, 43 insertions(+), 20 deletions(-)

--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -742,17 +742,23 @@ struct TCP_Server_Info {
 #endif
 	struct mutex refpath_lock; /* protects leaf_fullpath */
 	/*
-	 * Canonical DFS full paths that were used to chase referrals in mount and reconnect.
+	 * origin_fullpath: Canonical copy of smb3_fs_context::source.
+	 *                  It is used for matching existing DFS tcons.
 	 *
-	 * origin_fullpath: first or original referral path
-	 * leaf_fullpath: last referral path (might be changed due to nested links in reconnect)
+	 * leaf_fullpath: Canonical DFS referral path related to this
+	 *                connection.
+	 *                It is used in DFS cache refresher, reconnect and may
+	 *                change due to nested DFS links.
 	 *
-	 * current_fullpath: pointer to either origin_fullpath or leaf_fullpath
-	 * NOTE: cannot be accessed outside cifs_reconnect() and smb2_reconnect()
+	 * Both protected by @refpath_lock and @srv_lock.  The @refpath_lock is
+	 * mosly used for not requiring a copy of @leaf_fullpath when getting
+	 * cached or new DFS referrals (which might also sleep during I/O).
+	 * While @srv_lock is held for making string and NULL comparions against
+	 * both fields as in mount(2) and cache refresh.
 	 *
-	 * format: \\HOST\SHARE\[OPTIONAL PATH]
+	 * format: \\HOST\SHARE[\OPTIONAL PATH]
 	 */
-	char *origin_fullpath, *leaf_fullpath, *current_fullpath;
+	char *origin_fullpath, *leaf_fullpath;
 };
 
 static inline bool is_smb1(struct TCP_Server_Info *server)
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -486,7 +486,6 @@ static int reconnect_target_unlocked(str
 static int reconnect_dfs_server(struct TCP_Server_Info *server)
 {
 	int rc = 0;
-	const char *refpath = server->current_fullpath + 1;
 	struct dfs_cache_tgt_list tl = DFS_CACHE_TGT_LIST_INIT(tl);
 	struct dfs_cache_tgt_iterator *target_hint = NULL;
 	int num_targets = 0;
@@ -499,8 +498,10 @@ static int reconnect_dfs_server(struct T
 	 * through /proc/fs/cifs/dfscache or the target list is empty due to server settings after
 	 * refreshing the referral, so, in this case, default it to 1.
 	 */
-	if (!dfs_cache_noreq_find(refpath, NULL, &tl))
+	mutex_lock(&server->refpath_lock);
+	if (!dfs_cache_noreq_find(server->leaf_fullpath + 1, NULL, &tl))
 		num_targets = dfs_cache_get_nr_tgts(&tl);
+	mutex_unlock(&server->refpath_lock);
 	if (!num_targets)
 		num_targets = 1;
 
@@ -544,7 +545,9 @@ static int reconnect_dfs_server(struct T
 		mod_delayed_work(cifsiod_wq, &server->reconnect, 0);
 	} while (server->tcpStatus == CifsNeedReconnect);
 
-	dfs_cache_noreq_update_tgthint(refpath, target_hint);
+	mutex_lock(&server->refpath_lock);
+	dfs_cache_noreq_update_tgthint(server->leaf_fullpath + 1, target_hint);
+	mutex_unlock(&server->refpath_lock);
 	dfs_cache_free_tgts(&tl);
 
 	/* Need to set up echo worker again once connection has been established */
@@ -1621,7 +1624,6 @@ cifs_get_tcp_session(struct smb3_fs_cont
 			rc = -ENOMEM;
 			goto out_err;
 		}
-		tcp_ses->current_fullpath = tcp_ses->leaf_fullpath;
 	}
 
 	if (ctx->nosharesock)
--- a/fs/cifs/dfs.c
+++ b/fs/cifs/dfs.c
@@ -248,11 +248,12 @@ static int __dfs_mount_share(struct cifs
 		tcon = mnt_ctx->tcon;
 
 		mutex_lock(&server->refpath_lock);
+		spin_lock(&server->srv_lock);
 		if (!server->origin_fullpath) {
 			server->origin_fullpath = origin_fullpath;
-			server->current_fullpath = server->leaf_fullpath;
 			origin_fullpath = NULL;
 		}
+		spin_unlock(&server->srv_lock);
 		mutex_unlock(&server->refpath_lock);
 
 		if (list_empty(&tcon->dfs_ses_list)) {
@@ -366,10 +367,11 @@ static int update_server_fullpath(struct
 		rc = PTR_ERR(npath);
 	} else {
 		mutex_lock(&server->refpath_lock);
+		spin_lock(&server->srv_lock);
 		kfree(server->leaf_fullpath);
 		server->leaf_fullpath = npath;
+		spin_unlock(&server->srv_lock);
 		mutex_unlock(&server->refpath_lock);
-		server->current_fullpath = server->leaf_fullpath;
 	}
 	return rc;
 }
@@ -474,7 +476,7 @@ static int __tree_connect_dfs_target(con
 		share = prefix = NULL;
 
 		/* Check if share matches with tcp ses */
-		rc = dfs_cache_get_tgt_share(server->current_fullpath + 1, tit, &share, &prefix);
+		rc = dfs_cache_get_tgt_share(server->leaf_fullpath + 1, tit, &share, &prefix);
 		if (rc) {
 			cifs_dbg(VFS, "%s: failed to parse target share: %d\n", __func__, rc);
 			break;
@@ -488,7 +490,7 @@ static int __tree_connect_dfs_target(con
 			continue;
 		}
 
-		dfs_cache_noreq_update_tgthint(server->current_fullpath + 1, tit);
+		dfs_cache_noreq_update_tgthint(server->leaf_fullpath + 1, tit);
 		tree_connect_ipc(xid, tree, cifs_sb, tcon);
 
 		scnprintf(tree, MAX_TREE_SIZE, "\\%s", share);
@@ -602,8 +604,8 @@ int cifs_tree_connect(const unsigned int
 	cifs_sb = CIFS_SB(sb);
 
 	/* If it is not dfs or there was no cached dfs referral, then reconnect to same share */
-	if (!server->current_fullpath ||
-	    dfs_cache_noreq_find(server->current_fullpath + 1, &ref, &tl)) {
+	if (!server->leaf_fullpath ||
+	    dfs_cache_noreq_find(server->leaf_fullpath + 1, &ref, &tl)) {
 		rc = ops->tree_connect(xid, tcon->ses, tcon->tree_name, tcon, cifs_sb->local_nls);
 		goto out;
 	}
--- a/fs/cifs/dfs.h
+++ b/fs/cifs/dfs.h
@@ -43,8 +43,12 @@ static inline char *dfs_get_automount_de
 	size_t len;
 	char *s;
 
-	if (unlikely(!server->origin_fullpath))
+	spin_lock(&server->srv_lock);
+	if (unlikely(!server->origin_fullpath)) {
+		spin_unlock(&server->srv_lock);
 		return ERR_PTR(-EREMOTE);
+	}
+	spin_unlock(&server->srv_lock);
 
 	s = dentry_path_raw(dentry, page, PATH_MAX);
 	if (IS_ERR(s))
@@ -53,13 +57,18 @@ static inline char *dfs_get_automount_de
 	if (!s[1])
 		s++;
 
+	spin_lock(&server->srv_lock);
 	len = strlen(server->origin_fullpath);
-	if (s < (char *)page + len)
+	if (s < (char *)page + len) {
+		spin_unlock(&server->srv_lock);
 		return ERR_PTR(-ENAMETOOLONG);
+	}
 
 	s -= len;
 	memcpy(s, server->origin_fullpath, len);
+	spin_unlock(&server->srv_lock);
 	convert_delimiter(s, '/');
+
 	return s;
 }
 
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -1278,8 +1278,12 @@ static void refresh_cache_worker(struct
 
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(server, &cifs_tcp_ses_list, tcp_ses_list) {
-		if (!server->leaf_fullpath)
+		spin_lock(&server->srv_lock);
+		if (!server->leaf_fullpath) {
+			spin_unlock(&server->srv_lock);
 			continue;
+		}
+		spin_unlock(&server->srv_lock);
 
 		list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
 			if (ses->tcon_ipc) {


