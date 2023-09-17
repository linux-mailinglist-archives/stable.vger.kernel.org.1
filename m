Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201467A3B77
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240701AbjIQUSM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240702AbjIQURs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:17:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A549E101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:17:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6D9C433C8;
        Sun, 17 Sep 2023 20:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981862;
        bh=7r2XjeQSronMV+K4uPDGh3gE5PxyFdbnwPFYrDGvyPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hd762e9jPTNb+ZV4rlL/ISHuF+1DLUwRN+mYd0SlHxp0Su+i6SYF/+hrp/2+50zMp
         OjbVQqmW9l1ULRi43T6gMPQ8GEBg9z4KQZYV635WW/QKcTxp0hKZ4LOh1I4Lmk8RzP
         i57QjBcCR7WIoRYiOgKwzo/BjC8/LHewb8tKuQB8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 155/219] btrfs: zoned: do not zone finish data relocation block group
Date:   Sun, 17 Sep 2023 21:14:42 +0200
Message-ID: <20230917191046.648509908@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naohiro Aota <naohiro.aota@wdc.com>

commit 332581bde2a419d5f12a93a1cdc2856af649a3cc upstream.

When multiple writes happen at once, we may need to sacrifice a currently
active block group to be zone finished for a new allocation. We choose a
block group with the least free space left, and zone finish it.

To do the finishing, we need to send IOs for already allocated region
and wait for them and on-going IOs. Otherwise, these IOs fail because the
zone is already finished at the time the IO reach a device.

However, if a block group dedicated to the data relocation is zone
finished, there is a chance that finishing it before an ongoing write IO
reaches the device. That is because there is timing gap between an
allocation is done (block_group->reservations == 0, as pre-allocation is
done) and an ordered extent is created when the relocation IO starts.
Thus, if we finish the zone between them, we can fail the IOs.

We cannot simply use "fs_info->data_reloc_bg == block_group->start" to
avoid the zone finishing. Because, the data_reloc_bg may already switch to
a new block group, while there are still ongoing write IOs to the old
data_reloc_bg.

So, this patch reworks the BLOCK_GROUP_FLAG_ZONED_DATA_RELOC bit to
indicate there is a data relocation allocation and/or ongoing write to the
block group. The bit is set on allocation and cleared in end_io function of
the last IO for the currently allocated region.

To change the timing of the bit setting also solves the issue that the bit
being left even after there is no IO going on. With the current code, if
the data_reloc_bg switches after the last IO to the current data_reloc_bg,
the bit is set at this timing and there is no one clearing that bit. As a
result, that block group is kept unallocatable for anything.

Fixes: 343d8a30851c ("btrfs: zoned: prevent allocation from previous data relocation BG")
Fixes: 74e91b12b115 ("btrfs: zoned: zone finish unused block group")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent-tree.c |   43 +++++++++++++++++++++++--------------------
 fs/btrfs/zoned.c       |   16 +++++++++++++---
 2 files changed, 36 insertions(+), 23 deletions(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3810,7 +3810,8 @@ static int do_allocation_zoned(struct bt
 	       fs_info->data_reloc_bg == 0);
 
 	if (block_group->ro ||
-	    test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags)) {
+	    (!ffe_ctl->for_data_reloc &&
+	     test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags))) {
 		ret = 1;
 		goto out;
 	}
@@ -3853,8 +3854,26 @@ static int do_allocation_zoned(struct bt
 	if (ffe_ctl->for_treelog && !fs_info->treelog_bg)
 		fs_info->treelog_bg = block_group->start;
 
-	if (ffe_ctl->for_data_reloc && !fs_info->data_reloc_bg)
-		fs_info->data_reloc_bg = block_group->start;
+	if (ffe_ctl->for_data_reloc) {
+		if (!fs_info->data_reloc_bg)
+			fs_info->data_reloc_bg = block_group->start;
+		/*
+		 * Do not allow allocations from this block group, unless it is
+		 * for data relocation. Compared to increasing the ->ro, setting
+		 * the ->zoned_data_reloc_ongoing flag still allows nocow
+		 * writers to come in. See btrfs_inc_nocow_writers().
+		 *
+		 * We need to disable an allocation to avoid an allocation of
+		 * regular (non-relocation data) extent. With mix of relocation
+		 * extents and regular extents, we can dispatch WRITE commands
+		 * (for relocation extents) and ZONE APPEND commands (for
+		 * regular extents) at the same time to the same zone, which
+		 * easily break the write pointer.
+		 *
+		 * Also, this flag avoids this block group to be zone finished.
+		 */
+		set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags);
+	}
 
 	ffe_ctl->found_offset = start + block_group->alloc_offset;
 	block_group->alloc_offset += num_bytes;
@@ -3872,24 +3891,8 @@ static int do_allocation_zoned(struct bt
 out:
 	if (ret && ffe_ctl->for_treelog)
 		fs_info->treelog_bg = 0;
-	if (ret && ffe_ctl->for_data_reloc &&
-	    fs_info->data_reloc_bg == block_group->start) {
-		/*
-		 * Do not allow further allocations from this block group.
-		 * Compared to increasing the ->ro, setting the
-		 * ->zoned_data_reloc_ongoing flag still allows nocow
-		 *  writers to come in. See btrfs_inc_nocow_writers().
-		 *
-		 * We need to disable an allocation to avoid an allocation of
-		 * regular (non-relocation data) extent. With mix of relocation
-		 * extents and regular extents, we can dispatch WRITE commands
-		 * (for relocation extents) and ZONE APPEND commands (for
-		 * regular extents) at the same time to the same zone, which
-		 * easily break the write pointer.
-		 */
-		set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags);
+	if (ret && ffe_ctl->for_data_reloc)
 		fs_info->data_reloc_bg = 0;
-	}
 	spin_unlock(&fs_info->relocation_bg_lock);
 	spin_unlock(&fs_info->treelog_bg_lock);
 	spin_unlock(&block_group->lock);
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2009,6 +2009,10 @@ static int do_zone_finish(struct btrfs_b
 	 * and block_group->meta_write_pointer for metadata.
 	 */
 	if (!fully_written) {
+		if (test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags)) {
+			spin_unlock(&block_group->lock);
+			return -EAGAIN;
+		}
 		spin_unlock(&block_group->lock);
 
 		ret = btrfs_inc_block_group_ro(block_group, false);
@@ -2037,7 +2041,9 @@ static int do_zone_finish(struct btrfs_b
 			return 0;
 		}
 
-		if (block_group->reserved) {
+		if (block_group->reserved ||
+		    test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
+			     &block_group->runtime_flags)) {
 			spin_unlock(&block_group->lock);
 			btrfs_dec_block_group_ro(block_group);
 			return -EAGAIN;
@@ -2268,7 +2274,10 @@ void btrfs_zoned_release_data_reloc_bg(s
 
 	/* All relocation extents are written. */
 	if (block_group->start + block_group->alloc_offset == logical + length) {
-		/* Now, release this block group for further allocations. */
+		/*
+		 * Now, release this block group for further allocations and
+		 * zone finish.
+		 */
 		clear_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
 			  &block_group->runtime_flags);
 	}
@@ -2292,7 +2301,8 @@ int btrfs_zone_finish_one_bg(struct btrf
 
 		spin_lock(&block_group->lock);
 		if (block_group->reserved || block_group->alloc_offset == 0 ||
-		    (block_group->flags & BTRFS_BLOCK_GROUP_SYSTEM)) {
+		    (block_group->flags & BTRFS_BLOCK_GROUP_SYSTEM) ||
+		    test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags)) {
 			spin_unlock(&block_group->lock);
 			continue;
 		}


