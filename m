Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2A675515F
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjGPTzm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGPTzl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:55:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7BC1B4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 325E860EB6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4552FC433C8;
        Sun, 16 Jul 2023 19:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537339;
        bh=f8S7KZuukXt7H/DNDWo6ajFuqzJYxJ12szC5z26tHlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kjg3Xb1116DZt4CwsmJxinY7cG1abC7gDqRagAK5NQxaqLe8/XmNRvrQbmqSHL+Vr
         AADPlMFoszGqU8S1hI0JPSwR5jObxOVvkjtPVZ8SGfADFdaBPjl8o404JWV2WS7vdi
         v5sAWly9r5U6gFFJdbV9gnbHQebOZWmBnd7wfgc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 053/800] btrfs: return bool from lock_extent_buffer_for_io
Date:   Sun, 16 Jul 2023 21:38:26 +0200
Message-ID: <20230716194950.322140132@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 9fdd160160f002ac2604c5b8f90598febad44ae7 ]

lock_extent_buffer_for_io never returns a negative error value, so switch
the return value to a simple bool.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
[ keep noinline_for_stack ]
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 7027f87108ce ("btrfs: don't treat zoned writeback as being from an async helper thread")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 51f0f28fb9b2c..28d0792359968 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1671,18 +1671,17 @@ static void end_extent_buffer_writeback(struct extent_buffer *eb)
  *
  * May try to flush write bio if we can't get the lock.
  *
- * Return  0 if the extent buffer doesn't need to be submitted.
- *           (E.g. the extent buffer is not dirty)
- * Return >0 is the extent buffer is submitted to bio.
- * Return <0 if something went wrong, no page is locked.
+ * Return %false if the extent buffer doesn't need to be submitted (e.g. the
+ * extent buffer is not dirty)
+ * Return %true is the extent buffer is submitted to bio.
  */
-static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb,
+static noinline_for_stack bool lock_extent_buffer_for_io(struct extent_buffer *eb,
 			  struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	int i, num_pages;
 	int flush = 0;
-	int ret = 0;
+	bool ret = false;
 
 	if (!btrfs_try_tree_write_lock(eb)) {
 		submit_write_bio(bio_ctrl, 0);
@@ -1693,7 +1692,7 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 	if (test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags)) {
 		btrfs_tree_unlock(eb);
 		if (bio_ctrl->wbc->sync_mode != WB_SYNC_ALL)
-			return 0;
+			return false;
 		if (!flush) {
 			submit_write_bio(bio_ctrl, 0);
 			flush = 1;
@@ -1720,7 +1719,7 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 		percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
 					 -eb->len,
 					 fs_info->dirty_metadata_batch);
-		ret = 1;
+		ret = true;
 	} else {
 		spin_unlock(&eb->refs_lock);
 	}
@@ -2053,7 +2052,6 @@ static int submit_eb_subpage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl)
 	u64 page_start = page_offset(page);
 	int bit_start = 0;
 	int sectors_per_node = fs_info->nodesize >> fs_info->sectorsize_bits;
-	int ret;
 
 	/* Lock and write each dirty extent buffers in the range */
 	while (bit_start < fs_info->subpage_info->bitmap_nr_bits) {
@@ -2099,25 +2097,13 @@ static int submit_eb_subpage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl)
 		if (!eb)
 			continue;
 
-		ret = lock_extent_buffer_for_io(eb, bio_ctrl);
-		if (ret == 0) {
-			free_extent_buffer(eb);
-			continue;
+		if (lock_extent_buffer_for_io(eb, bio_ctrl)) {
+			write_one_subpage_eb(eb, bio_ctrl);
+			submitted++;
 		}
-		if (ret < 0) {
-			free_extent_buffer(eb);
-			goto cleanup;
-		}
-		write_one_subpage_eb(eb, bio_ctrl);
 		free_extent_buffer(eb);
-		submitted++;
 	}
 	return submitted;
-
-cleanup:
-	/* We hit error, end bio for the submitted extent buffers */
-	submit_write_bio(bio_ctrl, ret);
-	return ret;
 }
 
 /*
@@ -2196,8 +2182,7 @@ static int submit_eb_page(struct page *page, struct btrfs_bio_ctrl *bio_ctrl,
 
 	*eb_context = eb;
 
-	ret = lock_extent_buffer_for_io(eb, bio_ctrl);
-	if (ret <= 0) {
+	if (!lock_extent_buffer_for_io(eb, bio_ctrl)) {
 		btrfs_revert_meta_write_pointer(cache, eb);
 		if (cache)
 			btrfs_put_block_group(cache);
-- 
2.39.2



