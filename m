Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17DB7897D6
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 17:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjHZPsq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 11:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjHZPs2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 11:48:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5620B1BCC
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 08:48:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFEA5628D9
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 15:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC88C433C7;
        Sat, 26 Aug 2023 15:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693064905;
        bh=7gtLUxg0lSTc3JRi06rwA3DESA+g4rdzqtXjpQNOTh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1lOAMJNgjbMp9Cv3AK60bl9mne0v/ZiaboVhj6PdtoHqM0RPlAMocpuGsoIMWACmN
         QrYWZxfRmD5WDQrd05d3//gI/MgxJR34XEn6taLCjxfXi+6AF7qi/xrvGkUTxs9tHj
         axnxZFP29oDWdbO081/B1lOwLdT6fdmLl2pDRSKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>,
        Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Yangtao Li <frank.li@vivo.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 3/4] Revert "f2fs: fix to set flush_merge opt and show noflush_merge"
Date:   Sat, 26 Aug 2023 17:47:59 +0200
Message-ID: <20230826154625.618039918@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230826154625.450325166@linuxfoundation.org>
References: <20230826154625.450325166@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 6ba0594a81f91d6fd8ca9bd4ad23aa1618635a0f which is
commit 967eaad1fed5f6335ea97a47d45214744dc57925 upstream.

Something is currently broken in the f2fs code, Guenter has reported
boot problems with it for a few releases now, so revert the most recent
f2fs changes in the hope to get this back to a working filesystem.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/b392e1a8-b987-4993-bd45-035db9415a6e@roeck-us.net
Cc: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Yangtao Li <frank.li@vivo.com>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/super.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1347,12 +1347,6 @@ default_check:
 		return -EINVAL;
 	}
 
-	if ((f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb)) &&
-		test_opt(sbi, FLUSH_MERGE)) {
-		f2fs_err(sbi, "FLUSH_MERGE not compatible with readonly mode");
-		return -EINVAL;
-	}
-
 	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
 		f2fs_err(sbi, "Allow to mount readonly mode only");
 		return -EROFS;
@@ -1939,10 +1933,8 @@ static int f2fs_show_options(struct seq_
 		seq_puts(seq, ",inline_dentry");
 	else
 		seq_puts(seq, ",noinline_dentry");
-	if (test_opt(sbi, FLUSH_MERGE))
+	if (!f2fs_readonly(sbi->sb) && test_opt(sbi, FLUSH_MERGE))
 		seq_puts(seq, ",flush_merge");
-	else
-		seq_puts(seq, ",noflush_merge");
 	if (test_opt(sbi, NOBARRIER))
 		seq_puts(seq, ",nobarrier");
 	if (test_opt(sbi, FASTBOOT))
@@ -2071,8 +2063,7 @@ static void default_options(struct f2fs_
 	set_opt(sbi, MERGE_CHECKPOINT);
 	F2FS_OPTION(sbi).unusable_cap = 0;
 	sbi->sb->s_flags |= SB_LAZYTIME;
-	if (!f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb))
-		set_opt(sbi, FLUSH_MERGE);
+	set_opt(sbi, FLUSH_MERGE);
 	if (f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi))
 		set_opt(sbi, DISCARD);
 	if (f2fs_sb_has_blkzoned(sbi)) {


