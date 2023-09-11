Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BE279B55B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345764AbjIKVWO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240796AbjIKOyB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:54:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAECAE40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:53:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFCAC433C8;
        Mon, 11 Sep 2023 14:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444036;
        bh=/wSlVXKeXyjA6gRbyAV/QlWNN9gVcTRSO9kpCM2NlC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eef9oHy4+uNKFtlWNTOR8T80RiGK/wAk6VRLFkgYQ75B6+0y3m5dAiHt1wvoLS8Qe
         wGd4AmNVq75nU2pizqPofLxapsFu/MNp+6YXp2PEFv5ma3dVCPKQlMJ/isIO0GjL7s
         lXaux86qr0NQc6+TTOMPEgZK7nWPLTCO11VjPa9s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 580/737] f2fs: fix to drop all dirty meta/node pages during umount()
Date:   Mon, 11 Sep 2023 15:47:19 +0200
Message-ID: <20230911134706.730957963@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

[ Upstream commit 20872584b8c0b006c007da9588a272c9e28d2e18 ]

For cp error case, there will be dirty meta/node pages remained after
f2fs_write_checkpoint() in f2fs_put_super(), drop them explicitly, and
do sanity check on reference count of dirty pages and inflight IOs.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: eb61c2cca2eb ("f2fs: fix to account cp stats correctly")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 751ac088bc19e..20f1bda0e1a17 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1571,6 +1571,7 @@ static void f2fs_put_super(struct super_block *sb)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	int i;
+	int err = 0;
 	bool done;
 
 	/* unregister procfs/sysfs entries in advance to avoid race case */
@@ -1597,7 +1598,7 @@ static void f2fs_put_super(struct super_block *sb)
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT,
 		};
-		f2fs_write_checkpoint(sbi, &cpc);
+		err = f2fs_write_checkpoint(sbi, &cpc);
 	}
 
 	/* be sure to wait for any on-going discard commands */
@@ -1606,7 +1607,7 @@ static void f2fs_put_super(struct super_block *sb)
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT | CP_TRIMMED,
 		};
-		f2fs_write_checkpoint(sbi, &cpc);
+		err = f2fs_write_checkpoint(sbi, &cpc);
 	}
 
 	/*
@@ -1623,6 +1624,19 @@ static void f2fs_put_super(struct super_block *sb)
 
 	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
 
+	if (err) {
+		truncate_inode_pages_final(NODE_MAPPING(sbi));
+		truncate_inode_pages_final(META_MAPPING(sbi));
+	}
+
+	for (i = 0; i < NR_COUNT_TYPE; i++) {
+		if (!get_pages(sbi, i))
+			continue;
+		f2fs_err(sbi, "detect filesystem reference count leak during "
+			"umount, type: %d, count: %lld", i, get_pages(sbi, i));
+		f2fs_bug_on(sbi, 1);
+	}
+
 	f2fs_bug_on(sbi, sbi->fsync_node_num);
 
 	f2fs_destroy_compress_inode(sbi);
-- 
2.40.1



