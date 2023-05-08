Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493F36FA995
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjEHKxY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbjEHKwu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:52:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA892FCFA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:52:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DFA662951
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9102CC433D2;
        Mon,  8 May 2023 10:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543119;
        bh=v7ZkMBBHs4eAOBljkwszUkK0taYsw31Y3yi/Js/SBNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X/e8XZu2AIf2hQwhWxLgCjr7vYSZqjCUU6y5Sqzf8W7QaXi/zZ23fR1c4hqZdkA33
         2EqIFrJA2uZmqsAI+PDCzl/3P+iKIkWGjSQzwsE9RIUyOkiPx/+fsuh8uyQZ+aPren
         sxySC48u0c7gHOyfe5U4MrQ3Hy4M6QMvXvvxXNMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.2 655/663] cifs: fix potential race when tree connecting ipc
Date:   Mon,  8 May 2023 11:48:01 +0200
Message-Id: <20230508094451.396156217@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paulo Alcantara <pc@manguebit.com>

commit ee20d7c6100752eaf2409d783f4f1449c29ea33d upstream.

Protect access of TCP_Server_Info::hostname when building the ipc tree
name as it might get freed in cifsd thread and thus causing an
use-after-free bug in __tree_connect_dfs_target().  Also, while at it,
update status of IPC tcon on success and then avoid any extra tree
connects.

Cc: stable@vger.kernel.org # v6.2+
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/dfs.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 7 deletions(-)

--- a/fs/cifs/dfs.c
+++ b/fs/cifs/dfs.c
@@ -398,6 +398,54 @@ static int target_share_matches_server(s
 	return rc;
 }
 
+static void __tree_connect_ipc(const unsigned int xid, char *tree,
+			       struct cifs_sb_info *cifs_sb,
+			       struct cifs_ses *ses)
+{
+	struct TCP_Server_Info *server = ses->server;
+	struct cifs_tcon *tcon = ses->tcon_ipc;
+	int rc;
+
+	spin_lock(&ses->ses_lock);
+	spin_lock(&ses->chan_lock);
+	if (cifs_chan_needs_reconnect(ses, server) ||
+	    ses->ses_status != SES_GOOD) {
+		spin_unlock(&ses->chan_lock);
+		spin_unlock(&ses->ses_lock);
+		cifs_server_dbg(FYI, "%s: skipping ipc reconnect due to disconnected ses\n",
+				__func__);
+		return;
+	}
+	spin_unlock(&ses->chan_lock);
+	spin_unlock(&ses->ses_lock);
+
+	cifs_server_lock(server);
+	scnprintf(tree, MAX_TREE_SIZE, "\\\\%s\\IPC$", server->hostname);
+	cifs_server_unlock(server);
+
+	rc = server->ops->tree_connect(xid, ses, tree, tcon,
+				       cifs_sb->local_nls);
+	cifs_server_dbg(FYI, "%s: tree_reconnect %s: %d\n", __func__, tree, rc);
+	spin_lock(&tcon->tc_lock);
+	if (rc) {
+		tcon->status = TID_NEED_TCON;
+	} else {
+		tcon->status = TID_GOOD;
+		tcon->need_reconnect = false;
+	}
+	spin_unlock(&tcon->tc_lock);
+}
+
+static void tree_connect_ipc(const unsigned int xid, char *tree,
+			     struct cifs_sb_info *cifs_sb,
+			     struct cifs_tcon *tcon)
+{
+	struct cifs_ses *ses = tcon->ses;
+
+	__tree_connect_ipc(xid, tree, cifs_sb, ses);
+	__tree_connect_ipc(xid, tree, cifs_sb, CIFS_DFS_ROOT_SES(ses));
+}
+
 static int __tree_connect_dfs_target(const unsigned int xid, struct cifs_tcon *tcon,
 				     struct cifs_sb_info *cifs_sb, char *tree, bool islink,
 				     struct dfs_cache_tgt_list *tl)
@@ -406,7 +454,6 @@ static int __tree_connect_dfs_target(con
 	struct TCP_Server_Info *server = tcon->ses->server;
 	const struct smb_version_operations *ops = server->ops;
 	struct cifs_ses *root_ses = CIFS_DFS_ROOT_SES(tcon->ses);
-	struct cifs_tcon *ipc = root_ses->tcon_ipc;
 	char *share = NULL, *prefix = NULL;
 	struct dfs_cache_tgt_iterator *tit;
 	bool target_match;
@@ -442,18 +489,14 @@ static int __tree_connect_dfs_target(con
 		}
 
 		dfs_cache_noreq_update_tgthint(server->current_fullpath + 1, tit);
-
-		if (ipc->need_reconnect) {
-			scnprintf(tree, MAX_TREE_SIZE, "\\\\%s\\IPC$", server->hostname);
-			rc = ops->tree_connect(xid, ipc->ses, tree, ipc, cifs_sb->local_nls);
-			cifs_dbg(FYI, "%s: reconnect ipc: %d\n", __func__, rc);
-		}
+		tree_connect_ipc(xid, tree, cifs_sb, tcon);
 
 		scnprintf(tree, MAX_TREE_SIZE, "\\%s", share);
 		if (!islink) {
 			rc = ops->tree_connect(xid, tcon->ses, tree, tcon, cifs_sb->local_nls);
 			break;
 		}
+
 		/*
 		 * If no dfs referrals were returned from link target, then just do a TREE_CONNECT
 		 * to it.  Otherwise, cache the dfs referral and then mark current tcp ses for


