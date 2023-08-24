Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FCF7876B2
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242479AbjHXRTC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242428AbjHXRSc (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:18:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF31612C
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:18:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75E0C674D8
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8726EC433C7;
        Thu, 24 Aug 2023 17:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897509;
        bh=mtX9/JcztyHXhc3kSSZUeWa6hQOUtYYNZ3BSKEk+rlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FGtRbl9R7+1ceKE9tPuED7x6iGujqTIeK5LNzadWB2enGulhb76avmZ+nVHycBg3G
         t9Jj6IEhvigNsLE8g9mFD45VYfHRQ96IdhjjT4mAscMrzWI3ZTiofREla3OHYLKBNG
         BEv4M9Gom4IH5jc+yxBfwIuh7L5JK2dld+d9Heqg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Immad Mir <mirimmad17@gmail.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 026/135] FS: JFS: Check for read-only mounted filesystem in txBegin
Date:   Thu, 24 Aug 2023 19:08:18 +0200
Message-ID: <20230824170618.281634052@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Immad Mir <mirimmad17@gmail.com>

[ Upstream commit 95e2b352c03b0a86c5717ba1d24ea20969abcacc ]

 This patch adds a check for read-only mounted filesystem
 in txBegin before starting a transaction potentially saving
 from NULL pointer deref.

Signed-off-by: Immad Mir <mirimmad17@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_txnmgr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index c8ce7f1bc5942..6f6a5b9203d3f 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -354,6 +354,11 @@ tid_t txBegin(struct super_block *sb, int flag)
 	jfs_info("txBegin: flag = 0x%x", flag);
 	log = JFS_SBI(sb)->log;
 
+	if (!log) {
+		jfs_error(sb, "read-only filesystem\n");
+		return 0;
+	}
+
 	TXN_LOCK();
 
 	INCREMENT(TxStat.txBegin);
-- 
2.40.1



