Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD26C77ACE8
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjHMVia (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjHMVia (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:38:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E7010DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:38:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 923BF636ED
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAB1C433C8;
        Sun, 13 Aug 2023 21:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962711;
        bh=af5j18Hd8UVp9zJDmr5zw0LkJt+032SAnrb1pNFXKKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LKMZpAj0/thBp7DzwnGGyR8BjB/CC+m/5rlAk4pFw0utLQ1Ci3v/CLIP2XV9kxZ4v
         27hgx3ANYEdyFaK6oNfrPvTtvdfCOVsrTJaRYCxAe1vGoLJaezt8HNe75lHU3T/VxL
         +8q5Ulweyc1giiMyZPIY/GUO3xkY2OvMJ3dpbmJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Boris Burkov <boris@bur.io>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 127/149] btrfs: wait for actual caching progress during allocation
Date:   Sun, 13 Aug 2023 23:19:32 +0200
Message-ID: <20230813211722.521930099@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit fc1f91b9231a28fba333f931a031bf776bc6ef0e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/block-group.c |   17 +++++++++++++++--
 fs/btrfs/block-group.h |    2 ++
 2 files changed, 17 insertions(+), 2 deletions(-)

--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -436,13 +436,23 @@ void btrfs_wait_block_group_cache_progre
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
@@ -660,8 +670,10 @@ next:
 
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
@@ -767,6 +779,7 @@ int btrfs_cache_block_group(struct btrfs
 	init_waitqueue_head(&caching_ctl->wait);
 	caching_ctl->block_group = cache;
 	refcount_set(&caching_ctl->count, 2);
+	atomic_set(&caching_ctl->progress, 0);
 	btrfs_init_work(&caching_ctl->work, caching_thread, NULL, NULL);
 
 	spin_lock(&cache->lock);
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -70,6 +70,8 @@ struct btrfs_caching_control {
 	wait_queue_head_t wait;
 	struct btrfs_work work;
 	struct btrfs_block_group *block_group;
+	/* Track progress of caching during allocation. */
+	atomic_t progress;
 	refcount_t count;
 };
 


