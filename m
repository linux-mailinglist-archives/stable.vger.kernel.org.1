Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FA7754E42
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 12:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjGPKQL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 06:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjGPKQK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 06:16:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F95810E6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 03:16:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6C3960C80
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 10:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67ACC433C8;
        Sun, 16 Jul 2023 10:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689502568;
        bh=9JOo0LrwPHd8qSaw7DVdYxd9kmQM28XjPOasPBA49Hw=;
        h=Subject:To:Cc:From:Date:From;
        b=2QKpgQ4a35ce4JMDfktiST2Yx5NViXxGQVRHiEj+N2ZCjsbPqdfM6in+1pFL8nGch
         i5M2bo6yRguBuB3xmYAn4vJqaEh/f6f0B4O+mGnkwP5Q+mx5uuzNhT/tuPjUMMgbmx
         T6owK0x/F9gNvYm+bpe7DsSd8qkE8DFE1IWyRaag=
Subject: FAILED: patch "[PATCH] btrfs: fix range_end calculation in extent_write_locked_range" failed to apply to 6.1-stable tree
To:     hch@lst.de, dsterba@suse.com, josef@toxicpanda.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 12:16:02 +0200
Message-ID: <2023071602-swinger-darn-2b82@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 36614a3beba33a05ad78d4dcb9aa1d00e8a7d01
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071602-swinger-darn-2b82@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 36614a3beba33a05ad78d4dcb9aa1d00e8a7d01f Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 31 May 2023 08:04:50 +0200
Subject: [PATCH] btrfs: fix range_end calculation in extent_write_locked_range

The range_end field in struct writeback_control is inclusive, just like
the end parameter passed to extent_write_locked_range.  Not doing this
could cause extra writeout, which is harmless but suboptimal.

Fixes: 771ed689d2cd ("Btrfs: Optimize compressed writeback and reads")
CC: stable@vger.kernel.org # 5.9+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d5b3b15f7ab2..0726c82db309 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2310,7 +2310,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 	struct writeback_control wbc_writepages = {
 		.sync_mode	= WB_SYNC_ALL,
 		.range_start	= start,
-		.range_end	= end + 1,
+		.range_end	= end,
 		.no_cgroup_owner = 1,
 	};
 	struct btrfs_bio_ctrl bio_ctrl = {

