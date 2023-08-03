Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505D376E1C7
	for <lists+stable@lfdr.de>; Thu,  3 Aug 2023 09:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjHCHhd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 3 Aug 2023 03:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjHCHgS (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 3 Aug 2023 03:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D5035B0
        for <stable@vger.kernel.org>; Thu,  3 Aug 2023 00:32:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C99D461BF4
        for <stable@vger.kernel.org>; Thu,  3 Aug 2023 07:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6F5C433C7;
        Thu,  3 Aug 2023 07:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691047960;
        bh=kc5uytkJ+upaWA6Yrn9fZA5iORpmtJDY13IxBWE6I/o=;
        h=Subject:To:Cc:From:Date:From;
        b=wS2q1I++2ZhWvBu7YQgMLF89okYUb8ESsnJ7R/yCVwbI68cw2pU2pUnLsVKho8PpW
         ZIfBrdvVxqT1NTVsHC56uOsSTEAuF+qdEXs9AzOaPs7iqktaX8AEuDdsElj6OQzxiw
         Z2sALgb4mKyCEeKvzRuklnXqwgTBqHx3mRb7rsb8=
Subject: FAILED: patch "[PATCH] f2fs: fix to set flush_merge opt and show noflush_merge" failed to apply to 6.1-stable tree
To:     frank.li@vivo.com, chao@kernel.org, jaegeuk@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 03 Aug 2023 09:32:37 +0200
Message-ID: <2023080337-improper-headed-6f72@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 967eaad1fed5f6335ea97a47d45214744dc57925
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080337-improper-headed-6f72@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

967eaad1fed5 ("f2fs: fix to set flush_merge opt and show noflush_merge")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 967eaad1fed5f6335ea97a47d45214744dc57925 Mon Sep 17 00:00:00 2001
From: Yangtao Li <frank.li@vivo.com>
Date: Thu, 10 Nov 2022 17:15:01 +0800
Subject: [PATCH] f2fs: fix to set flush_merge opt and show noflush_merge

Some minor modifications to flush_merge and related parameters:

  1.The FLUSH_MERGE opt is set by default only in non-ro mode.
  2.When ro and merge are set at the same time, an error is reported.
  3.Display noflush_merge mount opt.

Suggested-by: Chao Yu <chao@kernel.org>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8f4fc3ad6765..75027ff85cd9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1353,6 +1353,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
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
@@ -1941,8 +1947,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
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
 	else
@@ -2073,7 +2081,8 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, MERGE_CHECKPOINT);
 	F2FS_OPTION(sbi).unusable_cap = 0;
 	sbi->sb->s_flags |= SB_LAZYTIME;
-	set_opt(sbi, FLUSH_MERGE);
+	if (!f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb))
+		set_opt(sbi, FLUSH_MERGE);
 	if (f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi))
 		set_opt(sbi, DISCARD);
 	if (f2fs_sb_has_blkzoned(sbi)) {

