Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41A176ACEE
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjHAJYa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjHAJYM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:24:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB0C19B7
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:23:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96319614FC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F489C433C8;
        Tue,  1 Aug 2023 09:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881782;
        bh=blNJlT2cc4WgFVq2jJ5hYbrNH1gHuksOUvpm4utPe84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTcGf/6CamJoWc2TpiKdTaHGt+2HYrlrElJJQL0vpPbdNrpLR/QnZS2suy5pthp7y
         Ykq8lTO5RHZVbNlL7bcLRzPQWVDRSMmwXTsugWAGE1P5XXhj6x8i8nv3KB1xNlKRba
         dG4yloTJv4SorrMixgPHIwMvgtKMHWVVtBpqGzfk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Paulo Alcantara (SUSE)" <pc@cjr.nz>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 028/155] cifs: use fs_context for automounts
Date:   Tue,  1 Aug 2023 11:19:00 +0200
Message-ID: <20230801091911.208174701@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paulo Alcantara <pc@cjr.nz>

[ Upstream commit 9fd29a5bae6e8f94b410374099a6fddb253d2d5f ]

Use filesystem context support to handle dfs links.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: df9d70c18616 ("cifs: if deferred close is disabled then close files immediately")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifs_dfs_ref.c | 100 +++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 60 deletions(-)

diff --git a/fs/cifs/cifs_dfs_ref.c b/fs/cifs/cifs_dfs_ref.c
index b0864da9ef434..020e71fe1454e 100644
--- a/fs/cifs/cifs_dfs_ref.c
+++ b/fs/cifs/cifs_dfs_ref.c
@@ -258,61 +258,23 @@ char *cifs_compose_mount_options(const char *sb_mountdata,
 	goto compose_mount_options_out;
 }
 
-/**
- * cifs_dfs_do_mount - mounts specified path using DFS full path
- *
- * Always pass down @fullpath to smb3_do_mount() so we can use the root server
- * to perform failover in case we failed to connect to the first target in the
- * referral.
- *
- * @mntpt:		directory entry for the path we are trying to automount
- * @cifs_sb:		parent/root superblock
- * @fullpath:		full path in UNC format
- */
-static struct vfsmount *cifs_dfs_do_mount(struct dentry *mntpt,
-					  struct cifs_sb_info *cifs_sb,
-					  const char *fullpath)
-{
-	struct vfsmount *mnt;
-	char *mountdata;
-	char *devname;
-
-	devname = kstrdup(fullpath, GFP_KERNEL);
-	if (!devname)
-		return ERR_PTR(-ENOMEM);
-
-	convert_delimiter(devname, '/');
-
-	/* TODO: change to call fs_context_for_mount(), fill in context directly, call fc_mount */
-
-	/* See afs_mntpt_do_automount in fs/afs/mntpt.c for an example */
-
-	/* strip first '\' from fullpath */
-	mountdata = cifs_compose_mount_options(cifs_sb->ctx->mount_options,
-					       fullpath + 1, NULL, NULL);
-	if (IS_ERR(mountdata)) {
-		kfree(devname);
-		return (struct vfsmount *)mountdata;
-	}
-
-	mnt = vfs_submount(mntpt, &cifs_fs_type, devname, mountdata);
-	kfree(mountdata);
-	kfree(devname);
-	return mnt;
-}
-
 /*
  * Create a vfsmount that we can automount
  */
-static struct vfsmount *cifs_dfs_do_automount(struct dentry *mntpt)
+static struct vfsmount *cifs_dfs_do_automount(struct path *path)
 {
+	int rc;
+	struct dentry *mntpt = path->dentry;
+	struct fs_context *fc;
 	struct cifs_sb_info *cifs_sb;
-	void *page;
+	void *page = NULL;
+	struct smb3_fs_context *ctx, *cur_ctx;
+	struct smb3_fs_context tmp;
 	char *full_path;
 	struct vfsmount *mnt;
 
-	cifs_dbg(FYI, "in %s\n", __func__);
-	BUG_ON(IS_ROOT(mntpt));
+	if (IS_ROOT(mntpt))
+		return ERR_PTR(-ESTALE);
 
 	/*
 	 * The MSDFS spec states that paths in DFS referral requests and
@@ -321,29 +283,47 @@ static struct vfsmount *cifs_dfs_do_automount(struct dentry *mntpt)
 	 * gives us the latter, so we must adjust the result.
 	 */
 	cifs_sb = CIFS_SB(mntpt->d_sb);
-	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_DFS) {
-		mnt = ERR_PTR(-EREMOTE);
-		goto cdda_exit;
-	}
+	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_DFS)
+		return ERR_PTR(-EREMOTE);
+
+	cur_ctx = cifs_sb->ctx;
+
+	fc = fs_context_for_submount(path->mnt->mnt_sb->s_type, mntpt);
+	if (IS_ERR(fc))
+		return ERR_CAST(fc);
+
+	ctx = smb3_fc2context(fc);
 
 	page = alloc_dentry_path();
 	/* always use tree name prefix */
 	full_path = build_path_from_dentry_optional_prefix(mntpt, page, true);
 	if (IS_ERR(full_path)) {
 		mnt = ERR_CAST(full_path);
-		goto free_full_path;
+		goto out;
 	}
 
-	convert_delimiter(full_path, '\\');
+	convert_delimiter(full_path, '/');
 	cifs_dbg(FYI, "%s: full_path: %s\n", __func__, full_path);
 
-	mnt = cifs_dfs_do_mount(mntpt, cifs_sb, full_path);
-	cifs_dbg(FYI, "%s: cifs_dfs_do_mount:%s , mnt:%p\n", __func__, full_path + 1, mnt);
+	tmp = *cur_ctx;
+	tmp.source = full_path;
+	tmp.UNC = tmp.prepath = NULL;
+
+	rc = smb3_fs_context_dup(ctx, &tmp);
+	if (rc) {
+		mnt = ERR_PTR(rc);
+		goto out;
+	}
+
+	rc = smb3_parse_devname(full_path, ctx);
+	if (!rc)
+		mnt = fc_mount(fc);
+	else
+		mnt = ERR_PTR(rc);
 
-free_full_path:
+out:
+	put_fs_context(fc);
 	free_dentry_path(page);
-cdda_exit:
-	cifs_dbg(FYI, "leaving %s\n" , __func__);
 	return mnt;
 }
 
@@ -354,9 +334,9 @@ struct vfsmount *cifs_dfs_d_automount(struct path *path)
 {
 	struct vfsmount *newmnt;
 
-	cifs_dbg(FYI, "in %s\n", __func__);
+	cifs_dbg(FYI, "%s: %pd\n", __func__, path->dentry);
 
-	newmnt = cifs_dfs_do_automount(path->dentry);
+	newmnt = cifs_dfs_do_automount(path);
 	if (IS_ERR(newmnt)) {
 		cifs_dbg(FYI, "leaving %s [automount failed]\n" , __func__);
 		return newmnt;
-- 
2.39.2



