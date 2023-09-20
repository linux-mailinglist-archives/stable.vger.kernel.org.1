Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3777A7B35
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbjITLuI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbjITLuH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:50:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1922E5
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:50:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF02AC433C9;
        Wed, 20 Sep 2023 11:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210600;
        bh=QdI0Yfb91rTpMHV+CPJ7IkEQfH6XVBJl7vVzgHnJUHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kn8f3T2kh3W1hneuTZCsqVg7d4KcdJWzpfI0xoQKu6YbbZVIHQMFErkirkVvmiM4+
         kOTRT/e8Gbx6RcfsujkMiki3I65WmFy/TnTNe2tMyj83G/M+1pALh+3JXZ3xAwZ9QS
         niRnCFT5CFwQX3u4T3igv+tBZjQejEGX30RtLnyM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 137/211] btrfs: zoned: defer advancing meta write pointer
Date:   Wed, 20 Sep 2023 13:29:41 +0200
Message-ID: <20230920112850.083690312@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naohiro Aota <naohiro.aota@wdc.com>

[ Upstream commit 0356ad41e0ddb8cf0ea4d68820c92598413e445b ]

We currently advance the meta_write_pointer in
btrfs_check_meta_write_pointer(). That makes it necessary to revert it
when locking the buffer failed. Instead, we can advance it just before
sending the buffer.

Also, this is necessary for the following commit. In the commit, it needs
to release the zoned_meta_io_lock to allow IOs to come in and wait for them
to fill the currently active block group. If we advance the
meta_write_pointer before locking the extent buffer, the following extent
buffer can pass the meta_write_pointer check, resulting in an unaligned
write failure.

Advancing the pointer is still thread-safe as the extent buffer is locked.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 13bb483d32ab ("btrfs: zoned: activate metadata block group on write time")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c |  7 +++----
 fs/btrfs/zoned.c     | 15 +--------------
 fs/btrfs/zoned.h     |  8 --------
 3 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d4bac66cee533..2ebc982e8eccb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1927,15 +1927,14 @@ static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
 	}
 
 	if (!lock_extent_buffer_for_io(eb, wbc)) {
-		btrfs_revert_meta_write_pointer(ctx->zoned_bg, eb);
 		free_extent_buffer(eb);
 		return 0;
 	}
+	/* Implies write in zoned mode. */
 	if (ctx->zoned_bg) {
-		/*
-		 * Implies write in zoned mode. Mark the last eb in a block group.
-		 */
+		/* Mark the last eb in the block group. */
 		btrfs_schedule_zone_finish_bg(ctx->zoned_bg, eb);
+		ctx->zoned_bg->meta_write_pointer += eb->len;
 	}
 	write_one_eb(eb, wbc);
 	free_extent_buffer(eb);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 6e406f1b0d21e..cc117283d0c88 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1792,11 +1792,8 @@ int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 		ctx->zoned_bg = block_group;
 	}
 
-	if (block_group->meta_write_pointer == eb->start) {
-		block_group->meta_write_pointer = eb->start + eb->len;
-
+	if (block_group->meta_write_pointer == eb->start)
 		return 0;
-	}
 
 	/* If for_sync, this hole will be filled with trasnsaction commit. */
 	if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
@@ -1804,16 +1801,6 @@ int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 	return -EBUSY;
 }
 
-void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
-				     struct extent_buffer *eb)
-{
-	if (!btrfs_is_zoned(eb->fs_info) || !cache)
-		return;
-
-	ASSERT(cache->meta_write_pointer == eb->start + eb->len);
-	cache->meta_write_pointer = eb->start;
-}
-
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 length)
 {
 	if (!btrfs_dev_is_sequential(device, physical))
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index c0859d8be1520..74ec37a25808a 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -60,8 +60,6 @@ bool btrfs_use_zone_append(struct btrfs_bio *bbio);
 void btrfs_record_physical_zoned(struct btrfs_bio *bbio);
 int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 				   struct btrfs_eb_write_context *ctx);
-void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
-				     struct extent_buffer *eb);
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 length);
 int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
 				  u64 physical_start, u64 physical_pos);
@@ -194,12 +192,6 @@ static inline int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-static inline void btrfs_revert_meta_write_pointer(
-						struct btrfs_block_group *cache,
-						struct extent_buffer *eb)
-{
-}
-
 static inline int btrfs_zoned_issue_zeroout(struct btrfs_device *device,
 					    u64 physical, u64 length)
 {
-- 
2.40.1



