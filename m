Return-Path: <stable+bounces-98685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E86E9E49F1
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD6516A8A7
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3888213225;
	Wed,  4 Dec 2024 23:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9VddgDm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCEA212B3B;
	Wed,  4 Dec 2024 23:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355329; cv=none; b=OrpDvvxsqh1x9cmk+X1INSSvk0G6EJD1Q1dnvq8iDKBOxn4vJ/7KSuT6I1jcI4Mt8YJOgon1jfRQc2kiaOJnUvh6BK1l2eOy661UHrLrDo7KRmB6K4OzxViu3vTDZ4WJK6mf/dJYc4iPzuQR/KuHjhBDGU2EoPklDEioDOYZ7uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355329; c=relaxed/simple;
	bh=6g/3gOZpjLqFEtM76L2A0xUggHcj0QKf3jkNqW6mKdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icH+QJoKenU70rnR8yFZNZoDmOungKexqdj1EGlEcESgqkNjTlt7e3z4gCf1WLaMR6HgN4xP3P0q4DjhXtYofTAYmq9deOQH6jSR92r8tstiU2Bp2yc1ItsXbzHHRPAibcMGKElqTshL5n3ZwIgYtylgL6jrDaHPyfhpvbFh4wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9VddgDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36976C4CED2;
	Wed,  4 Dec 2024 23:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355329;
	bh=6g/3gOZpjLqFEtM76L2A0xUggHcj0QKf3jkNqW6mKdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s9VddgDmnhooTFCg+1QSbhYbf41oKuY3EJbY4FgyEo47VVXC1ylBQ1nJ/Vz8FpM9X
	 Vb2eufM6aUixXZqJjpi0OLMPWHJG1uGEN3D3rlR0g0CSWpr+JBdJFyx/V86GMTXuH8
	 Vdm2EGuxv1Zob7hv/7jcrv/Zy71vsrYlKo9GjF7CBt6e8S11MArB6wFZQQojx0TW+J
	 niT99oclN+uw8keYeH56iG6npqx4+spzNPfzWhHjtofRN7dCE5egvATfqY9R7j6cGS
	 4U/Z0HbQwlUj/IpE9llIj0+4vmV/JpDVEfTTfGJ1s5y7/Jxwy1uS7B5FDOBmsK+coM
	 m0WByteKXJnHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.11 5/7] smb: client: don't try following DFS links in cifs_tree_connect()
Date: Wed,  4 Dec 2024 17:23:47 -0500
Message-ID: <20241204222402.2249702-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204222402.2249702-1-sashal@kernel.org>
References: <20241204222402.2249702-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 36008fe6e3dc588e5e9ceae6e82c7f69399eb5d8 ]

We can't properly support chasing DFS links in cifs_tree_connect()
because

  (1) We don't support creating new sessions while we're reconnecting,
      which would be required for DFS interlinks.

  (2) ->is_path_accessible() can't be called from cifs_tree_connect()
     as it would deadlock with smb2_reconnect().  This is required for
     checking if new DFS target is a nested DFS link.

By unconditionally trying to get an DFS referral from new DFS target
isn't correct because if the new DFS target (interlink) is an DFS
standalone namespace, then we would end up getting -ELOOP and then
potentially leaving tcon disconnected.

Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/dfs.c | 188 ++++----------------------------------------
 1 file changed, 17 insertions(+), 171 deletions(-)

diff --git a/fs/smb/client/dfs.c b/fs/smb/client/dfs.c
index 3ec965547e3d4..bd259b04cdede 100644
--- a/fs/smb/client/dfs.c
+++ b/fs/smb/client/dfs.c
@@ -324,49 +324,6 @@ int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx, bool *isdfs)
 	return rc;
 }
 
-/* Update dfs referral path of superblock */
-static int update_server_fullpath(struct TCP_Server_Info *server, struct cifs_sb_info *cifs_sb,
-				  const char *target)
-{
-	int rc = 0;
-	size_t len = strlen(target);
-	char *refpath, *npath;
-
-	if (unlikely(len < 2 || *target != '\\'))
-		return -EINVAL;
-
-	if (target[1] == '\\') {
-		len += 1;
-		refpath = kmalloc(len, GFP_KERNEL);
-		if (!refpath)
-			return -ENOMEM;
-
-		scnprintf(refpath, len, "%s", target);
-	} else {
-		len += sizeof("\\");
-		refpath = kmalloc(len, GFP_KERNEL);
-		if (!refpath)
-			return -ENOMEM;
-
-		scnprintf(refpath, len, "\\%s", target);
-	}
-
-	npath = dfs_cache_canonical_path(refpath, cifs_sb->local_nls, cifs_remap(cifs_sb));
-	kfree(refpath);
-
-	if (IS_ERR(npath)) {
-		rc = PTR_ERR(npath);
-	} else {
-		mutex_lock(&server->refpath_lock);
-		spin_lock(&server->srv_lock);
-		kfree(server->leaf_fullpath);
-		server->leaf_fullpath = npath;
-		spin_unlock(&server->srv_lock);
-		mutex_unlock(&server->refpath_lock);
-	}
-	return rc;
-}
-
 static int target_share_matches_server(struct TCP_Server_Info *server, char *share,
 				       bool *target_match)
 {
@@ -391,77 +348,22 @@ static int target_share_matches_server(struct TCP_Server_Info *server, char *sha
 	return rc;
 }
 
-static void __tree_connect_ipc(const unsigned int xid, char *tree,
-			       struct cifs_sb_info *cifs_sb,
-			       struct cifs_ses *ses)
-{
-	struct TCP_Server_Info *server = ses->server;
-	struct cifs_tcon *tcon = ses->tcon_ipc;
-	int rc;
-
-	spin_lock(&ses->ses_lock);
-	spin_lock(&ses->chan_lock);
-	if (cifs_chan_needs_reconnect(ses, server) ||
-	    ses->ses_status != SES_GOOD) {
-		spin_unlock(&ses->chan_lock);
-		spin_unlock(&ses->ses_lock);
-		cifs_server_dbg(FYI, "%s: skipping ipc reconnect due to disconnected ses\n",
-				__func__);
-		return;
-	}
-	spin_unlock(&ses->chan_lock);
-	spin_unlock(&ses->ses_lock);
-
-	cifs_server_lock(server);
-	scnprintf(tree, MAX_TREE_SIZE, "\\\\%s\\IPC$", server->hostname);
-	cifs_server_unlock(server);
-
-	rc = server->ops->tree_connect(xid, ses, tree, tcon,
-				       cifs_sb->local_nls);
-	cifs_server_dbg(FYI, "%s: tree_reconnect %s: %d\n", __func__, tree, rc);
-	spin_lock(&tcon->tc_lock);
-	if (rc) {
-		tcon->status = TID_NEED_TCON;
-	} else {
-		tcon->status = TID_GOOD;
-		tcon->need_reconnect = false;
-	}
-	spin_unlock(&tcon->tc_lock);
-}
-
-static void tree_connect_ipc(const unsigned int xid, char *tree,
-			     struct cifs_sb_info *cifs_sb,
-			     struct cifs_tcon *tcon)
-{
-	struct cifs_ses *ses = tcon->ses;
-
-	__tree_connect_ipc(xid, tree, cifs_sb, ses);
-	__tree_connect_ipc(xid, tree, cifs_sb, CIFS_DFS_ROOT_SES(ses));
-}
-
-static int __tree_connect_dfs_target(const unsigned int xid, struct cifs_tcon *tcon,
-				     struct cifs_sb_info *cifs_sb, char *tree, bool islink,
-				     struct dfs_cache_tgt_list *tl)
+static int tree_connect_dfs_target(const unsigned int xid,
+				   struct cifs_tcon *tcon,
+				   struct cifs_sb_info *cifs_sb,
+				   char *tree, bool islink,
+				   struct dfs_cache_tgt_list *tl)
 {
-	int rc;
+	const struct smb_version_operations *ops = tcon->ses->server->ops;
 	struct TCP_Server_Info *server = tcon->ses->server;
-	const struct smb_version_operations *ops = server->ops;
-	struct cifs_ses *root_ses = CIFS_DFS_ROOT_SES(tcon->ses);
-	char *share = NULL, *prefix = NULL;
 	struct dfs_cache_tgt_iterator *tit;
+	char *share = NULL, *prefix = NULL;
 	bool target_match;
-
-	tit = dfs_cache_get_tgt_iterator(tl);
-	if (!tit) {
-		rc = -ENOENT;
-		goto out;
-	}
+	int rc = -ENOENT;
 
 	/* Try to tree connect to all dfs targets */
-	for (; tit; tit = dfs_cache_get_next_tgt(tl, tit)) {
-		const char *target = dfs_cache_get_tgt_name(tit);
-		DFS_CACHE_TGT_LIST(ntl);
-
+	for (tit = dfs_cache_get_tgt_iterator(tl);
+	     tit; tit = dfs_cache_get_next_tgt(tl, tit)) {
 		kfree(share);
 		kfree(prefix);
 		share = prefix = NULL;
@@ -482,69 +384,16 @@ static int __tree_connect_dfs_target(const unsigned int xid, struct cifs_tcon *t
 		}
 
 		dfs_cache_noreq_update_tgthint(server->leaf_fullpath + 1, tit);
-		tree_connect_ipc(xid, tree, cifs_sb, tcon);
-
 		scnprintf(tree, MAX_TREE_SIZE, "\\%s", share);
-		if (!islink) {
-			rc = ops->tree_connect(xid, tcon->ses, tree, tcon, cifs_sb->local_nls);
-			break;
-		}
-
-		/*
-		 * If no dfs referrals were returned from link target, then just do a TREE_CONNECT
-		 * to it.  Otherwise, cache the dfs referral and then mark current tcp ses for
-		 * reconnect so either the demultiplex thread or the echo worker will reconnect to
-		 * newly resolved target.
-		 */
-		if (dfs_cache_find(xid, root_ses, cifs_sb->local_nls, cifs_remap(cifs_sb), target,
-				   NULL, &ntl)) {
-			rc = ops->tree_connect(xid, tcon->ses, tree, tcon, cifs_sb->local_nls);
-			if (rc)
-				continue;
-
+		rc = ops->tree_connect(xid, tcon->ses, tree,
+				       tcon, tcon->ses->local_nls);
+		if (islink && !rc && cifs_sb)
 			rc = cifs_update_super_prepath(cifs_sb, prefix);
-		} else {
-			/* Target is another dfs share */
-			rc = update_server_fullpath(server, cifs_sb, target);
-			dfs_cache_free_tgts(tl);
-
-			if (!rc) {
-				rc = -EREMOTE;
-				list_replace_init(&ntl.tl_list, &tl->tl_list);
-			} else
-				dfs_cache_free_tgts(&ntl);
-		}
 		break;
 	}
 
-out:
 	kfree(share);
 	kfree(prefix);
-
-	return rc;
-}
-
-static int tree_connect_dfs_target(const unsigned int xid, struct cifs_tcon *tcon,
-				   struct cifs_sb_info *cifs_sb, char *tree, bool islink,
-				   struct dfs_cache_tgt_list *tl)
-{
-	int rc;
-	int num_links = 0;
-	struct TCP_Server_Info *server = tcon->ses->server;
-	char *old_fullpath = server->leaf_fullpath;
-
-	do {
-		rc = __tree_connect_dfs_target(xid, tcon, cifs_sb, tree, islink, tl);
-		if (!rc || rc != -EREMOTE)
-			break;
-	} while (rc = -ELOOP, ++num_links < MAX_NESTED_LINKS);
-	/*
-	 * If we couldn't tree connect to any targets from last referral path, then
-	 * retry it from newly resolved dfs referral.
-	 */
-	if (rc && server->leaf_fullpath != old_fullpath)
-		cifs_signal_cifsd_for_reconnect(server, true);
-
 	dfs_cache_free_tgts(tl);
 	return rc;
 }
@@ -599,14 +448,11 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
 	if (!IS_ERR(sb))
 		cifs_sb = CIFS_SB(sb);
 
-	/*
-	 * Tree connect to last share in @tcon->tree_name whether dfs super or
-	 * cached dfs referral was not found.
-	 */
-	if (!cifs_sb || !server->leaf_fullpath ||
+	/* Tree connect to last share in @tcon->tree_name if no DFS referral */
+	if (!server->leaf_fullpath ||
 	    dfs_cache_noreq_find(server->leaf_fullpath + 1, &ref, &tl)) {
-		rc = ops->tree_connect(xid, tcon->ses, tcon->tree_name, tcon,
-				       cifs_sb ? cifs_sb->local_nls : nlsc);
+		rc = ops->tree_connect(xid, tcon->ses, tcon->tree_name,
+				       tcon, tcon->ses->local_nls);
 		goto out;
 	}
 
-- 
2.43.0


