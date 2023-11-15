Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5957ECF42
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbjKOTrX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbjKOTrW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:47:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67505AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:47:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE701C433C7;
        Wed, 15 Nov 2023 19:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077639;
        bh=Vg6EFnd/795qiSWiuf9QYKv5lu2NxdEdMX9KJVec7dI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ugLFCCLgq2sQnuH0O2W6FCpa4GiG62C2eJ58L/KEUnjnHyCgfNFE6XEiOklKxOVPr
         WrYEynv6+pvpzKCHFEK4cwiWAj9bGJ1mcKw5UOHfGqPcya7aXH+Zpg4vjsQRpSMG16
         Fa8aKOGmT+QzWibwTIFz43XNrRNkvS5Kh/SY/vY4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 427/603] f2fs: compress: fix to avoid redundant compress extension
Date:   Wed, 15 Nov 2023 14:16:12 -0500
Message-ID: <20231115191642.384514837@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

[ Upstream commit 7e1b150fece033703a824df1bbc03df091ea53cc ]

With below script, redundant compress extension will be parsed and added
by parse_options(), because parse_options() doesn't check whether the
extension is existed or not, fix it.

1. mount -t f2fs -o compress_extension=so /dev/vdb /mnt/f2fs
2. mount -t f2fs -o remount,compress_extension=so /mnt/f2fs
3. mount|grep f2fs

/dev/vdb on /mnt/f2fs type f2fs (...,compress_extension=so,compress_extension=so,...)

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Fixes: 151b1982be5d ("f2fs: compress: add nocompress extensions support")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a8c8232852bb1..12790bc6e0739 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -547,6 +547,29 @@ static int f2fs_set_test_dummy_encryption(struct super_block *sb,
 }
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
+static bool is_compress_extension_exist(struct f2fs_sb_info *sbi,
+					const char *new_ext, bool is_ext)
+{
+	unsigned char (*ext)[F2FS_EXTENSION_LEN];
+	int ext_cnt;
+	int i;
+
+	if (is_ext) {
+		ext = F2FS_OPTION(sbi).extensions;
+		ext_cnt = F2FS_OPTION(sbi).compress_ext_cnt;
+	} else {
+		ext = F2FS_OPTION(sbi).noextensions;
+		ext_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
+	}
+
+	for (i = 0; i < ext_cnt; i++) {
+		if (!strcasecmp(new_ext, ext[i]))
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * 1. The same extension name cannot not appear in both compress and non-compress extension
  * at the same time.
@@ -1149,6 +1172,11 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				return -EINVAL;
 			}
 
+			if (is_compress_extension_exist(sbi, name, true)) {
+				kfree(name);
+				break;
+			}
+
 			strcpy(ext[ext_cnt], name);
 			F2FS_OPTION(sbi).compress_ext_cnt++;
 			kfree(name);
@@ -1173,6 +1201,11 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				return -EINVAL;
 			}
 
+			if (is_compress_extension_exist(sbi, name, false)) {
+				kfree(name);
+				break;
+			}
+
 			strcpy(noext[noext_cnt], name);
 			F2FS_OPTION(sbi).nocompress_ext_cnt++;
 			kfree(name);
-- 
2.42.0



