Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BB576ADAC
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjHAJb3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjHAJa7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:30:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BB8EC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFFCB614CF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A68FC433C7;
        Tue,  1 Aug 2023 09:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882191;
        bh=jEEmxnJNWm5CvLpP/5hZyVCCIQ2NhAayBqcW/BFOLA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2dxi28ZR8h2rAIzvP1sMa06fA4tq0o/DCvi3ps0yrdJpYs0ddF4Tb52oa0PVTz9tq
         jTkaap498ARVxM5NgiSw1gpOrzU+uCfmJo+f+BRsdP3wnTP24yQFd1H+Zxe+gIqBZj
         01UVoakf85kUzacnk8RBs2JmXnqTM/E1XdWvoTHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Yangtao Li <frank.li@vivo.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 018/228] f2fs: fix to set flush_merge opt and show noflush_merge
Date:   Tue,  1 Aug 2023 11:17:56 +0200
Message-ID: <20230801091923.504120162@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
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

From: Yangtao Li <frank.li@vivo.com>

[ Upstream commit 967eaad1fed5f6335ea97a47d45214744dc57925 ]

Some minor modifications to flush_merge and related parameters:

  1.The FLUSH_MERGE opt is set by default only in non-ro mode.
  2.When ro and merge are set at the same time, an error is reported.
  3.Display noflush_merge mount opt.

Suggested-by: Chao Yu <chao@kernel.org>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 458c15dfbce6 ("f2fs: don't reset unchangable mount option in f2fs_remount()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b6dad389fa144..36bb1c969e8bb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1347,6 +1347,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 
+	if ((f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb)) &&
+		test_opt(sbi, FLUSH_MERGE)) {
+		f2fs_err(sbi, "FLUSH_MERGE not compatible with readonly mode");
+		return -EINVAL;
+	}
+
 	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
 		f2fs_err(sbi, "Allow to mount readonly mode only");
 		return -EROFS;
@@ -1933,8 +1939,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",inline_dentry");
 	else
 		seq_puts(seq, ",noinline_dentry");
-	if (!f2fs_readonly(sbi->sb) && test_opt(sbi, FLUSH_MERGE))
+	if (test_opt(sbi, FLUSH_MERGE))
 		seq_puts(seq, ",flush_merge");
+	else
+		seq_puts(seq, ",noflush_merge");
 	if (test_opt(sbi, NOBARRIER))
 		seq_puts(seq, ",nobarrier");
 	if (test_opt(sbi, FASTBOOT))
@@ -2063,7 +2071,8 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, MERGE_CHECKPOINT);
 	F2FS_OPTION(sbi).unusable_cap = 0;
 	sbi->sb->s_flags |= SB_LAZYTIME;
-	set_opt(sbi, FLUSH_MERGE);
+	if (!f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb))
+		set_opt(sbi, FLUSH_MERGE);
 	if (f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi))
 		set_opt(sbi, DISCARD);
 	if (f2fs_sb_has_blkzoned(sbi)) {
-- 
2.39.2



