Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD44733F87
	for <lists+stable@lfdr.de>; Sat, 17 Jun 2023 10:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjFQIPf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 17 Jun 2023 04:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjFQIPe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Jun 2023 04:15:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A11D1732
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 01:15:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE60E6068F
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 08:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054BBC433C8;
        Sat, 17 Jun 2023 08:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686989732;
        bh=FDD3IdeZy3YEUMqZfujTBuRPLpW2rBbXvVlxbYHjO8E=;
        h=Subject:To:Cc:From:Date:From;
        b=QsHy9KeT+ADYHVIdJ2U9LM4+E6sEJqEnJL2UGbgv+v3Qg42U6ToumOSYzwcTATPR9
         QDvKGTt1G84QbJVT9vRNVQ+OtP49FIiikpHvEuGg1JNbSJf2b3/vaLNQRtA5pv698b
         UhttNOlQrZfzBTyUeP2wmFy4EEdo2pHglis7H1uo=
Subject: FAILED: patch "[PATCH] cifs: fix status checks in cifs_tree_connect" failed to apply to 6.3-stable tree
To:     sprasad@microsoft.com, stfrench@microsoft.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 17 Jun 2023 10:15:29 +0200
Message-ID: <2023061729-prankster-wildcard-db1f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x 91f4480c41f56f7c723323cf7f581f1d95d9ffbc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061729-prankster-wildcard-db1f@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 91f4480c41f56f7c723323cf7f581f1d95d9ffbc Mon Sep 17 00:00:00 2001
From: Shyam Prasad N <sprasad@microsoft.com>
Date: Fri, 9 Jun 2023 17:46:54 +0000
Subject: [PATCH] cifs: fix status checks in cifs_tree_connect

The ordering of status checks at the beginning of
cifs_tree_connect is wrong. As a result, a tcon
which is good may stay marked as needing reconnect
infinitely.

Fixes: 2f0e4f034220 ("cifs: check only tcon status on tcon related functions")
Cc: stable@vger.kernel.org # 6.3
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 8e9a672320ab..1250d156619b 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -4086,16 +4086,17 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
 
 	/* only send once per connect */
 	spin_lock(&tcon->tc_lock);
+	if (tcon->status == TID_GOOD) {
+		spin_unlock(&tcon->tc_lock);
+		return 0;
+	}
+
 	if (tcon->status != TID_NEW &&
 	    tcon->status != TID_NEED_TCON) {
 		spin_unlock(&tcon->tc_lock);
 		return -EHOSTDOWN;
 	}
 
-	if (tcon->status == TID_GOOD) {
-		spin_unlock(&tcon->tc_lock);
-		return 0;
-	}
 	tcon->status = TID_IN_TCON;
 	spin_unlock(&tcon->tc_lock);
 
diff --git a/fs/smb/client/dfs.c b/fs/smb/client/dfs.c
index 2f93bf8c3325..2390b2fedd6a 100644
--- a/fs/smb/client/dfs.c
+++ b/fs/smb/client/dfs.c
@@ -575,16 +575,17 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
 
 	/* only send once per connect */
 	spin_lock(&tcon->tc_lock);
+	if (tcon->status == TID_GOOD) {
+		spin_unlock(&tcon->tc_lock);
+		return 0;
+	}
+
 	if (tcon->status != TID_NEW &&
 	    tcon->status != TID_NEED_TCON) {
 		spin_unlock(&tcon->tc_lock);
 		return -EHOSTDOWN;
 	}
 
-	if (tcon->status == TID_GOOD) {
-		spin_unlock(&tcon->tc_lock);
-		return 0;
-	}
 	tcon->status = TID_IN_TCON;
 	spin_unlock(&tcon->tc_lock);
 

