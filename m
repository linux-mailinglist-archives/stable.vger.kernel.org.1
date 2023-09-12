Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2939D79B92D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345486AbjIKVU4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240774AbjIKOx3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:53:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F416F118
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:53:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E75DC433C7;
        Mon, 11 Sep 2023 14:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444004;
        bh=rfMiuZx2ORAiiXxIXbIi+5kBj7sgkYIfHb41+OR2lTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=elK1dP+C6oipXF2Xz1De1eRwkQLL3QAyWUjPZOLztpzRk8bEUdd8CrbvZDuKrf0+c
         U5e+ARkkwZe3ux8UpHb2suJ22Xzq3cysOHcAF/utnqZLvsUaHphuorGBVD3XcLs05x
         E89OZaRs1n4cdCuJdCiw0V4AnNzpUR31hi5S7Sgs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chunhai Guo <guochunhai@vivo.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 576/737] f2fs: Only lfs mode is allowed with zoned block device feature
Date:   Mon, 11 Sep 2023 15:47:15 +0200
Message-ID: <20230911134706.623916253@linuxfoundation.org>
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

From: Chunhai Guo <guochunhai@vivo.com>

[ Upstream commit 2bd4df8fcbc72f58ce3c62ed021ab291ca42de0b ]

Now f2fs support four block allocation modes: lfs, adaptive,
fragment:segment, fragment:block. Only lfs mode is allowed with zoned block
device feature.

Fixes: 6691d940b0e0 ("f2fs: introduce fragment allocation mode mount option")
Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3d91b5313947f..72b7ea71f55df 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -860,11 +860,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			if (!name)
 				return -ENOMEM;
 			if (!strcmp(name, "adaptive")) {
-				if (f2fs_sb_has_blkzoned(sbi)) {
-					f2fs_warn(sbi, "adaptive mode is not allowed with zoned block device feature");
-					kfree(name);
-					return -EINVAL;
-				}
 				F2FS_OPTION(sbi).fs_mode = FS_MODE_ADAPTIVE;
 			} else if (!strcmp(name, "lfs")) {
 				F2FS_OPTION(sbi).fs_mode = FS_MODE_LFS;
@@ -1329,6 +1324,11 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			F2FS_OPTION(sbi).discard_unit =
 					DISCARD_UNIT_SECTION;
 		}
+
+		if (F2FS_OPTION(sbi).fs_mode != FS_MODE_LFS) {
+			f2fs_info(sbi, "Only lfs mode is allowed with zoned block device feature");
+			return -EINVAL;
+		}
 #else
 		f2fs_err(sbi, "Zoned block device support is not enabled");
 		return -EINVAL;
-- 
2.40.1



