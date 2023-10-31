Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054907DD503
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376317AbjJaRqT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376319AbjJaRqR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:46:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F1810C
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:46:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F7EC433C7;
        Tue, 31 Oct 2023 17:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774374;
        bh=zDNgz73GxyBhcfkX0G2Ofk1OK9oUxKLq7xBOJTjN5RI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S6RuZ1aZFEUhGbqZV7MVqRPgXihJ0r8lpAKxmnfad2pj8orjqE+bs1RD1/4LtHEc2
         lQGbYZpemuu+GEJkDmrenP6WeKBLqk9a2qr1jw9Qw65RmfC/h3xMST6Ux5ltCmyd3h
         kCgl/8GLhkAS6aNG1SXNitgMD6N+Zb3j2z2ggV8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 006/112] smb: client: do not start laundromat thread on nohandlecache
Date:   Tue, 31 Oct 2023 18:00:07 +0100
Message-ID: <20231031165901.519724163@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 3b8bb3171571f92eda863e5f78b063604c61f72a ]

Honor 'nohandlecache' mount option by not starting laundromat thread
even when SMB server supports directory leases. Do not waste system
resources by having laundromat thread running with no directory
caching at all.

Fixes: 2da338ff752a ("smb3: do not start laundromat thread when dir leases  disabled")
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/connect.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index e70203d07d5d1..bd33661dcb57f 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2474,8 +2474,9 @@ cifs_put_tcon(struct cifs_tcon *tcon)
 static struct cifs_tcon *
 cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 {
-	int rc, xid;
 	struct cifs_tcon *tcon;
+	bool nohandlecache;
+	int rc, xid;
 
 	tcon = cifs_find_tcon(ses, ctx);
 	if (tcon) {
@@ -2493,14 +2494,17 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 		goto out_fail;
 	}
 
-	if (ses->server->capabilities & SMB2_GLOBAL_CAP_DIRECTORY_LEASING)
-		tcon = tcon_info_alloc(true);
+	if (ses->server->dialect >= SMB20_PROT_ID &&
+	    (ses->server->capabilities & SMB2_GLOBAL_CAP_DIRECTORY_LEASING))
+		nohandlecache = ctx->nohandlecache;
 	else
-		tcon = tcon_info_alloc(false);
+		nohandlecache = true;
+	tcon = tcon_info_alloc(!nohandlecache);
 	if (tcon == NULL) {
 		rc = -ENOMEM;
 		goto out_fail;
 	}
+	tcon->nohandlecache = nohandlecache;
 
 	if (ctx->snapshot_time) {
 		if (ses->server->vals->protocol_id == 0) {
@@ -2662,10 +2666,6 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 	tcon->nocase = ctx->nocase;
 	tcon->broken_sparse_sup = ctx->no_sparse;
 	tcon->max_cached_dirs = ctx->max_cached_dirs;
-	if (ses->server->capabilities & SMB2_GLOBAL_CAP_DIRECTORY_LEASING)
-		tcon->nohandlecache = ctx->nohandlecache;
-	else
-		tcon->nohandlecache = true;
 	tcon->nodelete = ctx->nodelete;
 	tcon->local_lease = ctx->local_lease;
 	INIT_LIST_HEAD(&tcon->pending_opens);
-- 
2.42.0



