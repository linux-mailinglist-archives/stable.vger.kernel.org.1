Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739B275CDC1
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjGUQOh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjGUQOY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:14:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053043A84
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:13:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1788061D2D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294C2C433CA;
        Fri, 21 Jul 2023 16:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956027;
        bh=J93i8bXCRCpaMi01j61ocHjX+VfVknjwjaL4vnht0YQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPZM1+zyfhkd7niTt4xs3SdhUbUnxy+9u1RYCOz3Y65qs8SUTM5a6G4ZEfS97tG8d
         xMJvhZpKTw7VktCI5hSaEjaHqJXaN59asO9m2kvNCtveOBAO2H11G3jSB2jTxl3cWm
         qglX1CtPvVO/H1laLatS5OHb8so7ilwIshmFTYdo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.4 108/292] smb: client: improve DFS mount check
Date:   Fri, 21 Jul 2023 18:03:37 +0200
Message-ID: <20230721160533.446313732@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
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

From: Paulo Alcantara <pc@manguebit.com>

commit 5f2a0afa9890e728428db2ed9281bddca242e90b upstream.

Some servers may return error codes from REQ_GET_DFS_REFERRAL requests
that are unexpected by the client, so to make it easier, assume
non-DFS mounts when the client can't get the initial DFS referral of
@ctx->UNC in dfs_mount_share().

Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/dfs.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/smb/client/dfs.c
+++ b/fs/smb/client/dfs.c
@@ -296,8 +296,9 @@ int dfs_mount_share(struct cifs_mount_ct
 	if (!nodfs) {
 		rc = dfs_get_referral(mnt_ctx, ctx->UNC + 1, NULL, NULL);
 		if (rc) {
-			if (rc != -ENOENT && rc != -EOPNOTSUPP && rc != -EIO)
-				return rc;
+			cifs_dbg(FYI, "%s: no dfs referral for %s: %d\n",
+				 __func__, ctx->UNC + 1, rc);
+			cifs_dbg(FYI, "%s: assuming non-dfs mount...\n", __func__);
 			nodfs = true;
 		}
 	}


