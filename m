Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B60873E767
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjFZSO5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjFZSOp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:14:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7AD10C1
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:14:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AADF960F52
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE045C433C0;
        Mon, 26 Jun 2023 18:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803284;
        bh=EEgIrj2hFldh456ixCZUq4PUi8lbRH7PEELfX7Ug3K4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PIE9VlJdKnYUkBqAT/VSXidL51IDXGQVuA6RCOO5unqs0quVLJ0kmUrQuK6I2ss3j
         aBxCQJlJckB5sAN0bGCl7ZXNPrlLOQZ4vnZFa6TxIY9ObKQP/Gu1qS2oArlGB6dY5q
         ZwA/bIyfDV73KkuvvOKE28FqcgK4vGAtyki5T09o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 001/199] cifs: fix status checks in cifs_tree_connect
Date:   Mon, 26 Jun 2023 20:08:27 +0200
Message-ID: <20230626180805.707594369@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit 91f4480c41f56f7c723323cf7f581f1d95d9ffbc ]

The ordering of status checks at the beginning of
cifs_tree_connect is wrong. As a result, a tcon
which is good may stay marked as needing reconnect
infinitely.

Fixes: 2f0e4f034220 ("cifs: check only tcon status on tcon related functions")
Cc: stable@vger.kernel.org # 6.3
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 9 +++++----
 fs/cifs/dfs.c     | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 8e9a672320ab7..1250d156619b7 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
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
 
diff --git a/fs/cifs/dfs.c b/fs/cifs/dfs.c
index 2f93bf8c3325a..2390b2fedd6a3 100644
--- a/fs/cifs/dfs.c
+++ b/fs/cifs/dfs.c
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
 
-- 
2.39.2



