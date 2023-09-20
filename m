Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C177A7B33
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjITLuC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbjITLuB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:50:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2387CF
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:49:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44063C433C8;
        Wed, 20 Sep 2023 11:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210594;
        bh=ziEw72CBP9e4nt/AiasBsmS3wdwP1rEfGfbvtCKAuzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLuVnS1U9O0BskBS11TWv1fHR7lh30xKWCQZ9UeR+6v3v7Czlxv6E9knDLyBr9xPt
         SU+K605b+1v/tZ3jHacmheHfC31c0UKN/eCxcdi7LJdW6ItzIz88JtuwQZMH2vjrNK
         zU4hyRyeZXwxsJzitkpIXxomigMYuWi+rmap5DYg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 135/211] btrfs: zoned: introduce block group context to btrfs_eb_write_context
Date:   Wed, 20 Sep 2023 13:29:39 +0200
Message-ID: <20230920112850.017585634@linuxfoundation.org>
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

[ Upstream commit 7db94301a980c9da4168ac7ce61e7bde297306ba ]

For metadata write out on the zoned mode, we call
btrfs_check_meta_write_pointer() to check if an extent buffer to be written
is aligned to the write pointer.

We look up a block group containing the extent buffer for every extent
buffer, which takes unnecessary effort as the writing extent buffers are
mostly contiguous.

Introduce "zoned_bg" to cache the block group working on.  Also, while
at it, rename "cache" to "block_group".

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 13bb483d32ab ("btrfs: zoned: activate metadata block group on write time")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 15 +++++++--------
 fs/btrfs/extent_io.h |  2 ++
 fs/btrfs/zoned.c     | 35 ++++++++++++++++++++---------------
 fs/btrfs/zoned.h     |  6 ++----
 4 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b3bf2e2704888..c2be1561a52cb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1881,7 +1881,6 @@ static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
 {
 	struct writeback_control *wbc = ctx->wbc;
 	struct address_space *mapping = page->mapping;
-	struct btrfs_block_group *cache = NULL;
 	struct extent_buffer *eb;
 	int ret;
 
@@ -1919,7 +1918,7 @@ static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
 
 	ctx->eb = eb;
 
-	if (!btrfs_check_meta_write_pointer(eb->fs_info, eb, &cache)) {
+	if (!btrfs_check_meta_write_pointer(eb->fs_info, ctx)) {
 		/*
 		 * If for_sync, this hole will be filled with
 		 * trasnsaction commit.
@@ -1933,18 +1932,15 @@ static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
 	}
 
 	if (!lock_extent_buffer_for_io(eb, wbc)) {
-		btrfs_revert_meta_write_pointer(cache, eb);
-		if (cache)
-			btrfs_put_block_group(cache);
+		btrfs_revert_meta_write_pointer(ctx->zoned_bg, eb);
 		free_extent_buffer(eb);
 		return 0;
 	}
-	if (cache) {
+	if (ctx->zoned_bg) {
 		/*
 		 * Implies write in zoned mode. Mark the last eb in a block group.
 		 */
-		btrfs_schedule_zone_finish_bg(cache, eb);
-		btrfs_put_block_group(cache);
+		btrfs_schedule_zone_finish_bg(ctx->zoned_bg, eb);
 	}
 	write_one_eb(eb, wbc);
 	free_extent_buffer(eb);
@@ -2057,6 +2053,9 @@ int btree_write_cache_pages(struct address_space *mapping,
 		ret = 0;
 	if (!ret && BTRFS_FS_ERROR(fs_info))
 		ret = -EROFS;
+
+	if (ctx.zoned_bg)
+		btrfs_put_block_group(ctx.zoned_bg);
 	btrfs_zoned_meta_io_unlock(fs_info);
 	return ret;
 }
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index ecc1660007c11..f61b7896320a1 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -97,6 +97,8 @@ struct extent_buffer {
 struct btrfs_eb_write_context {
 	struct writeback_control *wbc;
 	struct extent_buffer *eb;
+	/* Block group @eb resides in. Only used for zoned mode. */
+	struct btrfs_block_group *zoned_bg;
 };
 
 /*
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d9e6df2da272c..92f11176216b5 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1759,30 +1759,35 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
 }
 
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-				    struct extent_buffer *eb,
-				    struct btrfs_block_group **cache_ret)
+				    struct btrfs_eb_write_context *ctx)
 {
-	struct btrfs_block_group *cache;
-	bool ret = true;
+	const struct extent_buffer *eb = ctx->eb;
+	struct btrfs_block_group *block_group = ctx->zoned_bg;
 
 	if (!btrfs_is_zoned(fs_info))
 		return true;
 
-	cache = btrfs_lookup_block_group(fs_info, eb->start);
-	if (!cache)
-		return true;
+	if (block_group) {
+		if (block_group->start > eb->start ||
+		    block_group->start + block_group->length <= eb->start) {
+			btrfs_put_block_group(block_group);
+			block_group = NULL;
+			ctx->zoned_bg = NULL;
+		}
+	}
 
-	if (cache->meta_write_pointer != eb->start) {
-		btrfs_put_block_group(cache);
-		cache = NULL;
-		ret = false;
-	} else {
-		cache->meta_write_pointer = eb->start + eb->len;
+	if (!block_group) {
+		block_group = btrfs_lookup_block_group(fs_info, eb->start);
+		if (!block_group)
+			return true;
+		ctx->zoned_bg = block_group;
 	}
 
-	*cache_ret = cache;
+	if (block_group->meta_write_pointer != eb->start)
+		return false;
+	block_group->meta_write_pointer = eb->start + eb->len;
 
-	return ret;
+	return true;
 }
 
 void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 27322b926038c..49d5bd87245c5 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -59,8 +59,7 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 bool btrfs_use_zone_append(struct btrfs_bio *bbio);
 void btrfs_record_physical_zoned(struct btrfs_bio *bbio);
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-				    struct extent_buffer *eb,
-				    struct btrfs_block_group **cache_ret);
+				    struct btrfs_eb_write_context *ctx);
 void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 				     struct extent_buffer *eb);
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 length);
@@ -190,8 +189,7 @@ static inline void btrfs_record_physical_zoned(struct btrfs_bio *bbio)
 }
 
 static inline bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-			       struct extent_buffer *eb,
-			       struct btrfs_block_group **cache_ret)
+						  struct btrfs_eb_write_context *ctx)
 {
 	return true;
 }
-- 
2.40.1



