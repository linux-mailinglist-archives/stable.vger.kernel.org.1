Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505CF7A7B34
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjITLuH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbjITLuG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:50:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C56DE
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:49:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E05AC433C7;
        Wed, 20 Sep 2023 11:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210597;
        bh=N3kq6sXwXoTQ7f7HyN0IoTkvtsa//Z/gwxpzt/uL0lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhbrl0woWYcd4F0xyO7w8v39Yb6ZIlRI1wZuhXCqDOMlr9jWZ8Trtm1QLPHopkCWy
         DIGLudDlQiXbX1nzyfmRYui3uU2H3XVXio73h0DCjcPHK+Ol2ZeDqSFAg+XrAhxSAc
         Q/vnekLwfZ2bVQEvNVQZ61E8ULfWQBzQr0loH5gU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 136/211] btrfs: zoned: return int from btrfs_check_meta_write_pointer
Date:   Wed, 20 Sep 2023 13:29:40 +0200
Message-ID: <20230920112850.051609823@linuxfoundation.org>
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

[ Upstream commit 2ad8c0510a965113404cfe670b41ddc34fb66100 ]

Now that we have writeback_control passed to
btrfs_check_meta_write_pointer(), we can move the wbc condition in
submit_eb_page() to btrfs_check_meta_write_pointer() and return int.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 13bb483d32ab ("btrfs: zoned: activate metadata block group on write time")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 11 +++--------
 fs/btrfs/zoned.c     | 30 ++++++++++++++++++++++--------
 fs/btrfs/zoned.h     | 10 +++++-----
 3 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c2be1561a52cb..d4bac66cee533 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1918,14 +1918,9 @@ static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
 
 	ctx->eb = eb;
 
-	if (!btrfs_check_meta_write_pointer(eb->fs_info, ctx)) {
-		/*
-		 * If for_sync, this hole will be filled with
-		 * trasnsaction commit.
-		 */
-		if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
-			ret = -EAGAIN;
-		else
+	ret = btrfs_check_meta_write_pointer(eb->fs_info, ctx);
+	if (ret) {
+		if (ret == -EBUSY)
 			ret = 0;
 		free_extent_buffer(eb);
 		return ret;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 92f11176216b5..6e406f1b0d21e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1758,14 +1758,23 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
 	}
 }
 
-bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-				    struct btrfs_eb_write_context *ctx)
+/*
+ * Check if @ctx->eb is aligned to the write pointer.
+ *
+ * Return:
+ *   0:        @ctx->eb is at the write pointer. You can write it.
+ *   -EAGAIN:  There is a hole. The caller should handle the case.
+ *   -EBUSY:   There is a hole, but the caller can just bail out.
+ */
+int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+				   struct btrfs_eb_write_context *ctx)
 {
+	const struct writeback_control *wbc = ctx->wbc;
 	const struct extent_buffer *eb = ctx->eb;
 	struct btrfs_block_group *block_group = ctx->zoned_bg;
 
 	if (!btrfs_is_zoned(fs_info))
-		return true;
+		return 0;
 
 	if (block_group) {
 		if (block_group->start > eb->start ||
@@ -1779,15 +1788,20 @@ bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 	if (!block_group) {
 		block_group = btrfs_lookup_block_group(fs_info, eb->start);
 		if (!block_group)
-			return true;
+			return 0;
 		ctx->zoned_bg = block_group;
 	}
 
-	if (block_group->meta_write_pointer != eb->start)
-		return false;
-	block_group->meta_write_pointer = eb->start + eb->len;
+	if (block_group->meta_write_pointer == eb->start) {
+		block_group->meta_write_pointer = eb->start + eb->len;
 
-	return true;
+		return 0;
+	}
+
+	/* If for_sync, this hole will be filled with trasnsaction commit. */
+	if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
+		return -EAGAIN;
+	return -EBUSY;
 }
 
 void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 49d5bd87245c5..c0859d8be1520 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -58,8 +58,8 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 bool btrfs_use_zone_append(struct btrfs_bio *bbio);
 void btrfs_record_physical_zoned(struct btrfs_bio *bbio);
-bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-				    struct btrfs_eb_write_context *ctx);
+int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+				   struct btrfs_eb_write_context *ctx);
 void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 				     struct extent_buffer *eb);
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 length);
@@ -188,10 +188,10 @@ static inline void btrfs_record_physical_zoned(struct btrfs_bio *bbio)
 {
 }
 
-static inline bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-						  struct btrfs_eb_write_context *ctx)
+static inline int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+						 struct btrfs_eb_write_context *ctx)
 {
-	return true;
+	return 0;
 }
 
 static inline void btrfs_revert_meta_write_pointer(
-- 
2.40.1



