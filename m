Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D53675516C
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjGPT4O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjGPT4N (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:56:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08B2E4F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:56:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F419660E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2B9C433C8;
        Sun, 16 Jul 2023 19:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537370;
        bh=SpZhzP6S0qK3K6Xo2c9rWiU/6kotMYrVoZnFLKyJ5xU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=spNMARiUPVStW0Ooy5ibJOMW66vok8G+pyFGIxjtkkSS5nIc5ym2UAWyCJRHvYVMY
         4r7lP1C2jOggDvzt395S4meLgYg3EAvfzaHimOnvJkTGtv6b7Hquu2KOH5Uyd23Uyc
         4BuYEoCtcIuvRvRt7OZK8ozFw+CBRMrPQ7NxrTUY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 054/800] btrfs: submit a writeback bio per extent_buffer
Date:   Sun, 16 Jul 2023 21:38:27 +0200
Message-ID: <20230716194950.344649049@linuxfoundation.org>
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

[ Upstream commit 50b21d7a066f9a702b1d54ca11fc577302e875cb ]

Stop trying to cluster writes of multiple extent_buffers into a single
bio.  There is no need for that as the blk_plug mechanism used all the
way up in writeback_inodes_wb gives us the same I/O pattern even with
multiple bios.  Removing the clustering simplifies
lock_extent_buffer_for_io a lot and will also allow passing the eb
as private data to the end I/O handler.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 7027f87108ce ("btrfs: don't treat zoned writeback as being from an async helper thread")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 102 ++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 65 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 28d0792359968..0c9538bb3c852 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1669,41 +1669,24 @@ static void end_extent_buffer_writeback(struct extent_buffer *eb)
 /*
  * Lock extent buffer status and pages for writeback.
  *
- * May try to flush write bio if we can't get the lock.
- *
  * Return %false if the extent buffer doesn't need to be submitted (e.g. the
  * extent buffer is not dirty)
  * Return %true is the extent buffer is submitted to bio.
  */
 static noinline_for_stack bool lock_extent_buffer_for_io(struct extent_buffer *eb,
-			  struct btrfs_bio_ctrl *bio_ctrl)
+			  struct writeback_control *wbc)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	int i, num_pages;
-	int flush = 0;
 	bool ret = false;
+	int i;
 
-	if (!btrfs_try_tree_write_lock(eb)) {
-		submit_write_bio(bio_ctrl, 0);
-		flush = 1;
-		btrfs_tree_lock(eb);
-	}
-
-	if (test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags)) {
+	btrfs_tree_lock(eb);
+	while (test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags)) {
 		btrfs_tree_unlock(eb);
-		if (bio_ctrl->wbc->sync_mode != WB_SYNC_ALL)
+		if (wbc->sync_mode != WB_SYNC_ALL)
 			return false;
-		if (!flush) {
-			submit_write_bio(bio_ctrl, 0);
-			flush = 1;
-		}
-		while (1) {
-			wait_on_extent_buffer_writeback(eb);
-			btrfs_tree_lock(eb);
-			if (!test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags))
-				break;
-			btrfs_tree_unlock(eb);
-		}
+		wait_on_extent_buffer_writeback(eb);
+		btrfs_tree_lock(eb);
 	}
 
 	/*
@@ -1735,19 +1718,8 @@ static noinline_for_stack bool lock_extent_buffer_for_io(struct extent_buffer *e
 	if (!ret || fs_info->nodesize < PAGE_SIZE)
 		return ret;
 
-	num_pages = num_extent_pages(eb);
-	for (i = 0; i < num_pages; i++) {
-		struct page *p = eb->pages[i];
-
-		if (!trylock_page(p)) {
-			if (!flush) {
-				submit_write_bio(bio_ctrl, 0);
-				flush = 1;
-			}
-			lock_page(p);
-		}
-	}
-
+	for (i = 0; i < num_extent_pages(eb); i++)
+		lock_page(eb->pages[i]);
 	return ret;
 }
 
@@ -1977,11 +1949,16 @@ static void prepare_eb_write(struct extent_buffer *eb)
  * Page locking is only utilized at minimum to keep the VMM code happy.
  */
 static void write_one_subpage_eb(struct extent_buffer *eb,
-				 struct btrfs_bio_ctrl *bio_ctrl)
+				 struct writeback_control *wbc)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct page *page = eb->pages[0];
 	bool no_dirty_ebs = false;
+	struct btrfs_bio_ctrl bio_ctrl = {
+		.wbc = wbc,
+		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
+		.end_io_func = end_bio_subpage_eb_writepage,
+	};
 
 	prepare_eb_write(eb);
 
@@ -1995,40 +1972,43 @@ static void write_one_subpage_eb(struct extent_buffer *eb,
 	if (no_dirty_ebs)
 		clear_page_dirty_for_io(page);
 
-	bio_ctrl->end_io_func = end_bio_subpage_eb_writepage;
-
-	submit_extent_page(bio_ctrl, eb->start, page, eb->len,
+	submit_extent_page(&bio_ctrl, eb->start, page, eb->len,
 			   eb->start - page_offset(page));
 	unlock_page(page);
+	submit_one_bio(&bio_ctrl);
 	/*
 	 * Submission finished without problem, if no range of the page is
 	 * dirty anymore, we have submitted a page.  Update nr_written in wbc.
 	 */
 	if (no_dirty_ebs)
-		bio_ctrl->wbc->nr_to_write--;
+		wbc->nr_to_write--;
 }
 
 static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
-			struct btrfs_bio_ctrl *bio_ctrl)
+					    struct writeback_control *wbc)
 {
 	u64 disk_bytenr = eb->start;
 	int i, num_pages;
+	struct btrfs_bio_ctrl bio_ctrl = {
+		.wbc = wbc,
+		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
+		.end_io_func = end_bio_extent_buffer_writepage,
+	};
 
 	prepare_eb_write(eb);
 
-	bio_ctrl->end_io_func = end_bio_extent_buffer_writepage;
-
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
 
 		clear_page_dirty_for_io(p);
 		set_page_writeback(p);
-		submit_extent_page(bio_ctrl, disk_bytenr, p, PAGE_SIZE, 0);
+		submit_extent_page(&bio_ctrl, disk_bytenr, p, PAGE_SIZE, 0);
 		disk_bytenr += PAGE_SIZE;
-		bio_ctrl->wbc->nr_to_write--;
+		wbc->nr_to_write--;
 		unlock_page(p);
 	}
+	submit_one_bio(&bio_ctrl);
 }
 
 /*
@@ -2045,7 +2025,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
  * Return >=0 for the number of submitted extent buffers.
  * Return <0 for fatal error.
  */
-static int submit_eb_subpage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl)
+static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
 	int submitted = 0;
@@ -2097,8 +2077,8 @@ static int submit_eb_subpage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl)
 		if (!eb)
 			continue;
 
-		if (lock_extent_buffer_for_io(eb, bio_ctrl)) {
-			write_one_subpage_eb(eb, bio_ctrl);
+		if (lock_extent_buffer_for_io(eb, wbc)) {
+			write_one_subpage_eb(eb, wbc);
 			submitted++;
 		}
 		free_extent_buffer(eb);
@@ -2126,7 +2106,7 @@ static int submit_eb_subpage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl)
  * previous call.
  * Return <0 for fatal error.
  */
-static int submit_eb_page(struct page *page, struct btrfs_bio_ctrl *bio_ctrl,
+static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 			  struct extent_buffer **eb_context)
 {
 	struct address_space *mapping = page->mapping;
@@ -2138,7 +2118,7 @@ static int submit_eb_page(struct page *page, struct btrfs_bio_ctrl *bio_ctrl,
 		return 0;
 
 	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
-		return submit_eb_subpage(page, bio_ctrl);
+		return submit_eb_subpage(page, wbc);
 
 	spin_lock(&mapping->private_lock);
 	if (!PagePrivate(page)) {
@@ -2171,8 +2151,7 @@ static int submit_eb_page(struct page *page, struct btrfs_bio_ctrl *bio_ctrl,
 		 * If for_sync, this hole will be filled with
 		 * trasnsaction commit.
 		 */
-		if (bio_ctrl->wbc->sync_mode == WB_SYNC_ALL &&
-		    !bio_ctrl->wbc->for_sync)
+		if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
 			ret = -EAGAIN;
 		else
 			ret = 0;
@@ -2182,12 +2161,12 @@ static int submit_eb_page(struct page *page, struct btrfs_bio_ctrl *bio_ctrl,
 
 	*eb_context = eb;
 
-	if (!lock_extent_buffer_for_io(eb, bio_ctrl)) {
+	if (!lock_extent_buffer_for_io(eb, wbc)) {
 		btrfs_revert_meta_write_pointer(cache, eb);
 		if (cache)
 			btrfs_put_block_group(cache);
 		free_extent_buffer(eb);
-		return ret;
+		return 0;
 	}
 	if (cache) {
 		/*
@@ -2196,7 +2175,7 @@ static int submit_eb_page(struct page *page, struct btrfs_bio_ctrl *bio_ctrl,
 		btrfs_schedule_zone_finish_bg(cache, eb);
 		btrfs_put_block_group(cache);
 	}
-	write_one_eb(eb, bio_ctrl);
+	write_one_eb(eb, wbc);
 	free_extent_buffer(eb);
 	return 1;
 }
@@ -2205,11 +2184,6 @@ int btree_write_cache_pages(struct address_space *mapping,
 				   struct writeback_control *wbc)
 {
 	struct extent_buffer *eb_context = NULL;
-	struct btrfs_bio_ctrl bio_ctrl = {
-		.wbc = wbc,
-		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
-		.extent_locked = 0,
-	};
 	struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root->fs_info;
 	int ret = 0;
 	int done = 0;
@@ -2251,7 +2225,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		for (i = 0; i < nr_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			ret = submit_eb_page(&folio->page, &bio_ctrl, &eb_context);
+			ret = submit_eb_page(&folio->page, wbc, &eb_context);
 			if (ret == 0)
 				continue;
 			if (ret < 0) {
@@ -2312,8 +2286,6 @@ int btree_write_cache_pages(struct address_space *mapping,
 		ret = 0;
 	if (!ret && BTRFS_FS_ERROR(fs_info))
 		ret = -EROFS;
-	submit_write_bio(&bio_ctrl, ret);
-
 	btrfs_zoned_meta_io_unlock(fs_info);
 	return ret;
 }
-- 
2.39.2



