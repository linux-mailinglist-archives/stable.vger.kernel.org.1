Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F42E7E23EB
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjKFNQS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjKFNQJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:16:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6644810B
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:16:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F9DC433C8;
        Mon,  6 Nov 2023 13:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276565;
        bh=ZyK+4G9qhIwtIsUAReI0ITxChgZMGEisjshEZgikof0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uIUN9LdA9NiminCgmpr1AidGW+fGvyQvtuI9VfgCSmNqpF4wNwN43+ZD+Y9OHYiF5
         ZkoAv9aZ/hMOIgh85V1bnXmQ0eDGyduhg88MPsRniq6GOJVR8Ztb1lcMRSq8a6BCg4
         gindy4in+q4zoykjh8y+neBOPL/EuEvykMHrYrPc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 23/88] fs/ntfs3: Fix alternative boot searching
Date:   Mon,  6 Nov 2023 14:03:17 +0100
Message-ID: <20231106130306.632696587@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit dcc852e509a4cba0ac6ac734077cef260e4e0fe6 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/super.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index bcb17a1723465..9124d74ea676b 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -838,7 +838,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	int err;
 	u32 mb, gb, boot_sector_size, sct_per_clst, record_size;
-	u64 sectors, clusters, mlcn, mlcn2;
+	u64 sectors, clusters, mlcn, mlcn2, dev_size0;
 	struct NTFS_BOOT *boot;
 	struct buffer_head *bh;
 	struct MFT_REC *rec;
@@ -847,6 +847,9 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	u32 boot_off = 0;
 	const char *hint = "Primary boot";
 
+	/* Save original dev_size. Used with alternative boot. */
+	dev_size0 = dev_size;
+
 	sbi->volume.blocks = dev_size >> PAGE_SHIFT;
 
 	bh = ntfs_bread(sb, 0);
@@ -1084,9 +1087,9 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	}
 
 out:
-	if (err == -EINVAL && !bh->b_blocknr && dev_size > PAGE_SHIFT) {
+	if (err == -EINVAL && !bh->b_blocknr && dev_size0 > PAGE_SHIFT) {
 		u32 block_size = min_t(u32, sector_size, PAGE_SIZE);
-		u64 lbo = dev_size - sizeof(*boot);
+		u64 lbo = dev_size0 - sizeof(*boot);
 
 		/*
 	 	 * Try alternative boot (last sector)
@@ -1100,6 +1103,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 		boot_off = lbo & (block_size - 1);
 		hint = "Alternative boot";
+		dev_size = dev_size0; /* restore original size. */
 		goto check_boot;
 	}
 	brelse(bh);
-- 
2.42.0



