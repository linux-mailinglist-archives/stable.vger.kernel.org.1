Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC6774C3CF
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjGILgf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjGILge (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:36:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6526B18F
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:36:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEC3960BC0
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A12AC433C8;
        Sun,  9 Jul 2023 11:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902592;
        bh=x+28kpWmZQdeLWlt7tmdzOTsl0M0gVch2iz4GXcLp4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TIhxIFC/voZbhuaSn0upzPYczM+SArzsCx+RMdH/UVMmrjJWNtNotJB7tXjEM+bDH
         ggxQJsA2aUoN5bLm3VAwV3NkZXjzSrQXjuEaC4OBY/Q7WikEyhY0bpLV63/wPil67W
         WC1YypnHamvKFSmNn+yHBSk0UmWw7O/3Wec8fpn8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 424/431] cifs: prevent use-after-free by freeing the cfile later
Date:   Sun,  9 Jul 2023 13:16:12 +0200
Message-ID: <20230709111501.123331535@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit 33f736187d08f6bc822117629f263b97d3df4165 ]

In smb2_compound_op we have a possible use-after-free
which can cause hard to debug problems later on.

This was revealed during stress testing with KASAN enabled
kernel. Fixing it by moving the cfile free call to
a few lines below, after the usage.

Fixes: 76894f3e2f71 ("cifs: improve symlink handling for smb2+")
Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/smb2inode.c b/fs/cifs/smb2inode.c
index 163a03298430d..7e3ac4cb4efa6 100644
--- a/fs/cifs/smb2inode.c
+++ b/fs/cifs/smb2inode.c
@@ -398,9 +398,6 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 					rsp_iov);
 
  finished:
-	if (cfile)
-		cifsFileInfo_put(cfile);
-
 	SMB2_open_free(&rqst[0]);
 	if (rc == -EREMCHG) {
 		pr_warn_once("server share %s deleted\n", tcon->tree_name);
@@ -529,6 +526,9 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 		break;
 	}
 
+	if (cfile)
+		cifsFileInfo_put(cfile);
+
 	if (rc && err_iov && err_buftype) {
 		memcpy(err_iov, rsp_iov, 3 * sizeof(*err_iov));
 		memcpy(err_buftype, resp_buftype, 3 * sizeof(*err_buftype));
-- 
2.39.2



