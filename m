Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEB7762A66
	for <lists+stable@lfdr.de>; Wed, 26 Jul 2023 06:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjGZEr6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 26 Jul 2023 00:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjGZEr4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 26 Jul 2023 00:47:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69B619BD
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 21:47:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38AFD6142E
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 04:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E752C433C8;
        Wed, 26 Jul 2023 04:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690346874;
        bh=UAfr0bV0Z5dYI0udEr13+ysAVrnzsKvnJw+4r7lICPM=;
        h=Subject:To:Cc:From:Date:From;
        b=ZaSBOCBexF0kPUKqjybaGAkQDS7qQ4uD2VUgKOCrCueY8vFtxncgLHQ3kdVeAXTo6
         bpQhEYLLqNhjydL9DIk1v7LpEF9gretNZvryG7lp6qa8mAu2fosyNS0LA7gu8QgFv1
         bY032dmlONSfWPJqCYadwvUh2QxHyChluNgJu1Ek=
Subject: FAILED: patch "[PATCH] ext4: fix to check return value of freeze_bdev() in" failed to apply to 5.10-stable tree
To:     chao@kernel.org, tytso@mit.edu
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 26 Jul 2023 06:47:51 +0200
Message-ID: <2023072651-wreath-moonrise-7e72@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c4d13222afd8a64bf11bc7ec68645496ee8b54b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072651-wreath-moonrise-7e72@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

c4d13222afd8 ("ext4: fix to check return value of freeze_bdev() in ext4_shutdown()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c4d13222afd8a64bf11bc7ec68645496ee8b54b9 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Tue, 6 Jun 2023 15:32:03 +0800
Subject: [PATCH] ext4: fix to check return value of freeze_bdev() in
 ext4_shutdown()

freeze_bdev() can fail due to a lot of reasons, it needs to check its
reason before later process.

Fixes: 783d94854499 ("ext4: add EXT4_IOC_GOINGDOWN ioctl")
Cc: stable@kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20230606073203.1310389-1-chao@kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index f9a430152063..55be1b8a6360 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -797,6 +797,7 @@ static int ext4_shutdown(struct super_block *sb, unsigned long arg)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	__u32 flags;
+	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -815,7 +816,9 @@ static int ext4_shutdown(struct super_block *sb, unsigned long arg)
 
 	switch (flags) {
 	case EXT4_GOING_FLAGS_DEFAULT:
-		freeze_bdev(sb->s_bdev);
+		ret = freeze_bdev(sb->s_bdev);
+		if (ret)
+			return ret;
 		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
 		thaw_bdev(sb->s_bdev);
 		break;

