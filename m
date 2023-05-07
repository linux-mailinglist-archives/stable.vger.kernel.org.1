Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F346F9842
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 12:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjEGKvL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 06:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEGKvK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 06:51:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A9030C6
        for <stable@vger.kernel.org>; Sun,  7 May 2023 03:51:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DC7060C2D
        for <stable@vger.kernel.org>; Sun,  7 May 2023 10:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39481C433EF;
        Sun,  7 May 2023 10:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683456666;
        bh=GZhg4CCeOg3LD67Jq4PQcxXLLqDgnkLoydcranUuBxc=;
        h=Subject:To:Cc:From:Date:From;
        b=JAiB2f8BL3t34aQo7gqNt+98OFwiQgChp8kusvKpYrFjHAaNYklzgE6cKi7ySQKgo
         /dkUOlKh+xMRp/QVLPjRTB3OQca1izz0OTJWylXpV+wui/Qtk1LgHtQG8MoMA0d1gO
         iy9mXv7ogAHGkg9JcGTBAmE+s8uwQVT5nWNPp/gE=
Subject: FAILED: patch "[PATCH] md/raid10: fix null-ptr-deref in raid10_sync_request" failed to apply to 4.14-stable tree
To:     linan122@huawei.com, song@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 07 May 2023 12:51:03 +0200
Message-ID: <2023050703-eldercare-flattery-36cb@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x a405c6f0229526160aa3f177f65e20c86fce84c5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050703-eldercare-flattery-36cb@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

a405c6f02295 ("md/raid10: fix null-ptr-deref in raid10_sync_request")
afeee514ce7f ("md: convert to bioset_init()/mempool_init()")
b126194cbb79 ("MD: Free bioset when md_run fails")
1532d9e87e8b ("raid5-ppl: PPL support for disks with write-back cache enabled")
0202ce8a90ef ("md: release allocated bitset sync_set")
b03e0ccb5ab9 ("md: remove special meaning of ->quiesce(.., 2)")
9e1cc0a54556 ("md: use mddev_suspend/resume instead of ->quiesce()")
b3143b9a38d5 ("md: move suspend_hi/lo handling into core md code")
52a0d49de3d5 ("md: don't call bitmap_create() while array is quiesced.")
385f4d7f946b ("md-cluster: fix wrong condition check in raid1_write_request")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a405c6f0229526160aa3f177f65e20c86fce84c5 Mon Sep 17 00:00:00 2001
From: Li Nan <linan122@huawei.com>
Date: Wed, 22 Feb 2023 12:10:00 +0800
Subject: [PATCH] md/raid10: fix null-ptr-deref in raid10_sync_request

init_resync() inits mempool and sets conf->have_replacemnt at the beginning
of sync, close_sync() frees the mempool when sync is completed.

After [1] recovery might be skipped and init_resync() is called but
close_sync() is not. null-ptr-deref occurs with r10bio->dev[i].repl_bio.

The following is one way to reproduce the issue.

  1) create a array, wait for resync to complete, mddev->recovery_cp is set
     to MaxSector.
  2) recovery is woken and it is skipped. conf->have_replacement is set to
     0 in init_resync(). close_sync() not called.
  3) some io errors and rdev A is set to WantReplacement.
  4) a new device is added and set to A's replacement.
  5) recovery is woken, A have replacement, but conf->have_replacemnt is
     0. r10bio->dev[i].repl_bio will not be alloced and null-ptr-deref
     occurs.

Fix it by not calling init_resync() if recovery skipped.

[1] commit 7e83ccbecd60 ("md/raid10: Allow skipping recovery when clean arrays are assembled")
Fixes: 7e83ccbecd60 ("md/raid10: Allow skipping recovery when clean arrays are assembled")
Cc: stable@vger.kernel.org
Signed-off-by: Li Nan <linan122@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230222041000.3341651-3-linan666@huaweicloud.com

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index db9ee3b637d6..9e0e7bf524aa 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3297,10 +3297,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 	sector_t chunk_mask = conf->geo.chunk_mask;
 	int page_idx = 0;
 
-	if (!mempool_initialized(&conf->r10buf_pool))
-		if (init_resync(conf))
-			return 0;
-
 	/*
 	 * Allow skipping a full rebuild for incremental assembly
 	 * of a clean array, like RAID1 does.
@@ -3316,6 +3312,10 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 		return mddev->dev_sectors - sector_nr;
 	}
 
+	if (!mempool_initialized(&conf->r10buf_pool))
+		if (init_resync(conf))
+			return 0;
+
  skipped:
 	max_sector = mddev->dev_sectors;
 	if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ||

