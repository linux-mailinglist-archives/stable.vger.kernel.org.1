Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9CA77A5C7
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 11:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjHMJTQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 05:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMJTP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 05:19:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028D6B4
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 02:19:18 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bda3d0f0f1so4130225ad.0
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 02:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691918357; x=1692523157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xa0kIwhdOb8NyT48ZWSbYl7SkLbmiBsouQXOJkV/XXU=;
        b=dPMoot99LF2bNKPnVKvfLWbRqO7w1wGvOwYw530qvob0aF9csksLIHrYaKZ3rAwUol
         DKBU4NbKKN8agxNtETwc+PsbNt5RKlIxmdwd+sY3d7AkF77dMad/AqlkmD8TD6L2Oo4z
         V6FdX4dX7lARMa31EtmxS+Kns3DVhV9D3fbehMQd09LeEqpinBc3rpopnK9YVw3yz/Pw
         osUb6s9JrbZ6Hixg947R04uE52O1UhWWbSpje45MRgerfIC/CQ/gVJ4yq7OPrfXe3bw2
         bGDyX2HigycTwGahj2NQ8CCykHVASkn1Bn3VEGIpEc/V997mWyvOWPakDCwLgCVslhFq
         9mRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691918357; x=1692523157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xa0kIwhdOb8NyT48ZWSbYl7SkLbmiBsouQXOJkV/XXU=;
        b=MAax9b0m8+C3nQODWk+r7My4HyKYR+x8DAA4AHp1z1KqW+rcydlCvkMyfukbaxPO5t
         A/DGZTd+TkZDvN6TDF9BN+hJTWC0eSt2f+6ZHW7vKNdisJ4HqtNVxwqApgAZ5A1d0Qy7
         oyOhvEsyOb60kt5YCz8wTYPvoS4tv0oXzUSeUlX6WtK4Cl8CC7HB3+vxnBg4fv4ldDOc
         bcCgD8PnQdhoFMSycP/F8LejsUwgFPkoFaAS6qJFznscLHd8/G6fNBmG8wBHSklN4Mcr
         uhfKKzZnYTka6AQ1k7Gylg/ZNl5NmYppQfkSGeuvLnBVg8EAw05GjARM5N8TPWjG2kfs
         ZaRg==
X-Gm-Message-State: AOJu0YwS6FkrTc4eMm2ms6hCn7QHtbvYQGIP8ccUnFh/xZoTQ4vSgnU5
        5wYNP9NHfIf9rMvYYO12h8s5iT5JR3E30w==
X-Google-Smtp-Source: AGHT+IFJCQ4JLA/MzM92O3VGs8CGVsphlGqwem9Bz9QxDhdUB88uE92AfZVtShjoHWnp34V3/zPflg==
X-Received: by 2002:a17:902:e745:b0:1bb:ac37:384b with SMTP id p5-20020a170902e74500b001bbac37384bmr7720173plf.6.1691918357266;
        Sun, 13 Aug 2023 02:19:17 -0700 (PDT)
Received: from arch-workstation.flets-east.jp ([240b:10:bf02:8300:786f:8bc1:2bf6:8e55])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b001bbdf32f011sm7050311plg.269.2023.08.13.02.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 02:19:17 -0700 (PDT)
From:   Luhao Liu <liuluhao0000@gmail.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org,
        Boris Burkov <boris@bur.io>, David Sterba <dsterba@suse.com>,
        Luhao Liu <liuluhao0000@gmail.com>
Subject: [PATCH 1/8] btrfs: wait for actual caching progress during allocation
Date:   Sun, 13 Aug 2023 18:19:12 +0900
Message-ID: <20230813091913.38289-1-liuluhao0000@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

Recently we've been having mysterious hangs while running generic/475 on
the CI system.  This turned out to be something like this:

  Task 1
  dmsetup suspend --nolockfs
  -> __dm_suspend
   -> dm_wait_for_completion
    -> dm_wait_for_bios_completion
     -> Unable to complete because of IO's on a plug in Task 2

  Task 2
  wb_workfn
  -> wb_writeback
   -> blk_start_plug
    -> writeback_sb_inodes
     -> Infinite loop unable to make an allocation

  Task 3
  cache_block_group
  ->read_extent_buffer_pages
   ->Waiting for IO to complete that can't be submitted because Task 1
     suspended the DM device

The problem here is that we need Task 2 to be scheduled completely for
the blk plug to flush.  Normally this would happen, we normally wait for
the block group caching to finish (Task 3), and this schedule would
result in the block plug flushing.

However if there's enough free space available from the current caching
to satisfy the allocation we won't actually wait for the caching to
complete.  This check however just checks that we have enough space, not
that we can make the allocation.  In this particular case we were trying
to allocate 9MiB, and we had 10MiB of free space, but we didn't have
9MiB of contiguous space to allocate, and thus the allocation failed and
we looped.

We specifically don't cycle through the FFE loop until we stop finding
cached block groups because we don't want to allocate new block groups
just because we're caching, so we short circuit the normal loop once we
hit LOOP_CACHING_WAIT and we found a caching block group.

This is normally fine, except in this particular case where the caching
thread can't make progress because the DM device has been suspended.

Fix this by not only waiting for free space to >= the amount of space we
want to allocate, but also that we make some progress in caching from
the time we start waiting.  This will keep us from busy looping when the
caching is taking a while but still theoretically has enough space for
us to allocate from, and fixes this particular case by forcing us to
actually sleep and wait for forward progress, which will flush the plug.

With this fix we're no longer hanging with generic/475.

CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Luhao Liu <liuluhao0000@gmail.com>
---
 fs/btrfs/block-group.c | 17 +++++++++++++++--
 fs/btrfs/block-group.h |  2 ++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 63c3b7172ba5..1e4b70f5280d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -441,13 +441,23 @@ void btrfs_wait_block_group_cache_progress(struct btrfs_block_group *cache,
 					   u64 num_bytes)
 {
 	struct btrfs_caching_control *caching_ctl;
+	int progress;
 
 	caching_ctl = btrfs_get_caching_control(cache);
 	if (!caching_ctl)
 		return;
 
+	/*
+	 * We've already failed to allocate from this block group, so even if
+	 * there's enough space in the block group it isn't contiguous enough to
+	 * allow for an allocation, so wait for at least the next wakeup tick,
+	 * or for the thing to be done.
+	 */
+	progress = atomic_read(&caching_ctl->progress);
+
 	wait_event(caching_ctl->wait, btrfs_block_group_done(cache) ||
-		   (cache->free_space_ctl->free_space >= num_bytes));
+		   (progress != atomic_read(&caching_ctl->progress) &&
+		    (cache->free_space_ctl->free_space >= num_bytes)));
 
 	btrfs_put_caching_control(caching_ctl);
 }
@@ -802,8 +812,10 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 
 			if (total_found > CACHING_CTL_WAKE_UP) {
 				total_found = 0;
-				if (wakeup)
+				if (wakeup) {
+					atomic_inc(&caching_ctl->progress);
 					wake_up(&caching_ctl->wait);
+				}
 			}
 		}
 		path->slots[0]++;
@@ -910,6 +922,7 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait)
 	init_waitqueue_head(&caching_ctl->wait);
 	caching_ctl->block_group = cache;
 	refcount_set(&caching_ctl->count, 2);
+	atomic_set(&caching_ctl->progress, 0);
 	btrfs_init_work(&caching_ctl->work, caching_thread, NULL, NULL);
 
 	spin_lock(&cache->lock);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index aba5dff66c19..74b61e663028 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -90,6 +90,8 @@ struct btrfs_caching_control {
 	wait_queue_head_t wait;
 	struct btrfs_work work;
 	struct btrfs_block_group *block_group;
+	/* Track progress of caching during allocation. */
+	atomic_t progress;
 	refcount_t count;
 };
 
-- 
2.41.0

