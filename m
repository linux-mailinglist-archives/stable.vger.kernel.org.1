Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF0A7611F7
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjGYK6e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjGYK5q (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:57:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBD244BF
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:54:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2786961465
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3438CC433C8;
        Tue, 25 Jul 2023 10:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282496;
        bh=hgIB7wDY7o7xJ/mD4Iwu80nvl03r5+RTjcaRzqfmX3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2o/I4eFVnW8/hYzmz+TZmfnYF/x7plsTMHC6OMaVg14d3NJgyzBPqY+U4XQFvHgs6
         JcC3YimmV7Vg2XM0DpXkFZTpGcFKSJxbcTwyVFCYiXFO41cfQ6lMLu26kK10hPyP35
         SPOmdt58OA+VeN7KXXujOKnbIOTk+xdZPhpPpWjs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 150/227] smb: client: fix missed ses refcounting
Date:   Tue, 25 Jul 2023 12:45:17 +0200
Message-ID: <20230725104521.111120972@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit bf99f6be2d20146942bce6f9e90a0ceef12cbc1e ]

Use new cifs_smb_ses_inc_refcount() helper to get an active reference
of @ses and @ses->dfs_root_ses (if set).  This will prevent
@ses->dfs_root_ses of being put in the next call to cifs_put_smb_ses()
and thus potentially causing an use-after-free bug.

Fixes: 8e3554150d6c ("cifs: fix sharing of DFS connections")
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/dfs.c           | 26 ++++++++++----------------
 fs/smb/client/smb2transport.c |  2 +-
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/smb/client/dfs.c b/fs/smb/client/dfs.c
index 26d14dd0482ef..cf83617236d8b 100644
--- a/fs/smb/client/dfs.c
+++ b/fs/smb/client/dfs.c
@@ -66,6 +66,12 @@ static int get_session(struct cifs_mount_ctx *mnt_ctx, const char *full_path)
 	return rc;
 }
 
+/*
+ * Track individual DFS referral servers used by new DFS mount.
+ *
+ * On success, their lifetime will be shared by final tcon (dfs_ses_list).
+ * Otherwise, they will be put by dfs_put_root_smb_sessions() in cifs_mount().
+ */
 static int add_root_smb_session(struct cifs_mount_ctx *mnt_ctx)
 {
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
@@ -80,11 +86,12 @@ static int add_root_smb_session(struct cifs_mount_ctx *mnt_ctx)
 		INIT_LIST_HEAD(&root_ses->list);
 
 		spin_lock(&cifs_tcp_ses_lock);
-		ses->ses_count++;
+		cifs_smb_ses_inc_refcount(ses);
 		spin_unlock(&cifs_tcp_ses_lock);
 		root_ses->ses = ses;
 		list_add_tail(&root_ses->list, &mnt_ctx->dfs_ses_list);
 	}
+	/* Select new DFS referral server so that new referrals go through it */
 	ctx->dfs_root_ses = ses;
 	return 0;
 }
@@ -244,7 +251,6 @@ static int __dfs_mount_share(struct cifs_mount_ctx *mnt_ctx)
 int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx, bool *isdfs)
 {
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
-	struct cifs_ses *ses;
 	bool nodfs = ctx->nodfs;
 	int rc;
 
@@ -278,20 +284,8 @@ int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx, bool *isdfs)
 	}
 
 	*isdfs = true;
-	/*
-	 * Prevent DFS root session of being put in the first call to
-	 * cifs_mount_put_conns().  If another DFS root server was not found
-	 * while chasing the referrals (@ctx->dfs_root_ses == @ses), then we
-	 * can safely put extra refcount of @ses.
-	 */
-	ses = mnt_ctx->ses;
-	mnt_ctx->ses = NULL;
-	mnt_ctx->server = NULL;
-	rc = __dfs_mount_share(mnt_ctx);
-	if (ses == ctx->dfs_root_ses)
-		cifs_put_smb_ses(ses);
-
-	return rc;
+	add_root_smb_session(mnt_ctx);
+	return __dfs_mount_share(mnt_ctx);
 }
 
 /* Update dfs referral path of superblock */
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 22954a9c7a6c7..355e8700530fc 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -159,7 +159,7 @@ smb2_find_smb_ses_unlocked(struct TCP_Server_Info *server, __u64 ses_id)
 			spin_unlock(&ses->ses_lock);
 			continue;
 		}
-		++ses->ses_count;
+		cifs_smb_ses_inc_refcount(ses);
 		spin_unlock(&ses->ses_lock);
 		return ses;
 	}
-- 
2.39.2



