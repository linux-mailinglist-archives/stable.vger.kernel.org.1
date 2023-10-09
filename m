Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8A77BDD22
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376689AbjJINHq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376690AbjJINHp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:07:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124949C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:07:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF85C433C7;
        Mon,  9 Oct 2023 13:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696856862;
        bh=CYhkPMWNklI8j96i5Gip3eAAKmTTkC2fWiJZRWOHIBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PErFPXpC8TViNANe7ZocDyNEpXsJd1UCPxi1EAkhUcLbhXWLtZxjAaTFnFx9lgQCM
         wcSEcW0JvFpAhybOMXw1ZINO0GS0BJbc8el1DgWhVguiiYKKosnwSPn0+MMmCLzyO2
         OTr/39hg8IXRzGJKshCI8x3xDJ6SdBROaprckWng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 016/163] btrfs: remove end_extent_writepage
Date:   Mon,  9 Oct 2023 14:59:40 +0200
Message-ID: <20231009130124.464175935@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 9783e4deed7291996459858a1a16f41a8988dd60 ]

end_extent_writepage is a small helper that combines a call to
btrfs_mark_ordered_io_finished with conditional error-only calls to
btrfs_page_clear_uptodate and mapping_set_error with a somewhat
unfortunate calling convention that passes and inclusive end instead
of the len expected by the underlying functions.

Remove end_extent_writepage and open code it in the 4 callers. Out
of those two already are error-only and thus don't need the extra
conditional, and one already has the mapping_set_error, so a duplicate
call can be avoided.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: b595d2599632 ("btrfs: don't clear uptodate on write errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 44 +++++++++++++++-----------------------------
 fs/btrfs/extent_io.h |  2 --
 fs/btrfs/inode.c     | 42 ++++++++++++++++++++++--------------------
 3 files changed, 37 insertions(+), 51 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b051b6e52022c..009c322c5418d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -497,29 +497,6 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 		btrfs_subpage_end_reader(fs_info, page, start, len);
 }
 
-/* lots and lots of room for performance fixes in the end_bio funcs */
-
-void end_extent_writepage(struct page *page, int err, u64 start, u64 end)
-{
-	struct btrfs_inode *inode;
-	const bool uptodate = (err == 0);
-	int ret = 0;
-	u32 len = end + 1 - start;
-
-	ASSERT(end + 1 - start <= U32_MAX);
-	ASSERT(page && page->mapping);
-	inode = BTRFS_I(page->mapping->host);
-	btrfs_mark_ordered_io_finished(inode, page, start, len, uptodate);
-
-	if (!uptodate) {
-		const struct btrfs_fs_info *fs_info = inode->root->fs_info;
-
-		btrfs_page_clear_uptodate(fs_info, page, start, len);
-		ret = err < 0 ? err : -EIO;
-		mapping_set_error(page->mapping, ret);
-	}
-}
-
 /*
  * after a writepage IO is done, we need to:
  * clear the uptodate bits on error
@@ -1485,7 +1462,6 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 	struct folio *folio = page_folio(page);
 	struct inode *inode = page->mapping->host;
 	const u64 page_start = page_offset(page);
-	const u64 page_end = page_start + PAGE_SIZE - 1;
 	int ret;
 	int nr = 0;
 	size_t pg_offset;
@@ -1529,8 +1505,13 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 		set_page_writeback(page);
 		end_page_writeback(page);
 	}
-	if (ret)
-		end_extent_writepage(page, ret, page_start, page_end);
+	if (ret) {
+		btrfs_mark_ordered_io_finished(BTRFS_I(inode), page, page_start,
+					       PAGE_SIZE, !ret);
+		btrfs_page_clear_uptodate(btrfs_sb(inode->i_sb), page,
+					  page_start, PAGE_SIZE);
+		mapping_set_error(page->mapping, ret);
+	}
 	unlock_page(page);
 	ASSERT(ret <= 0);
 	return ret;
@@ -2248,6 +2229,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 
 	while (cur <= end) {
 		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
+		u32 cur_len = cur_end + 1 - cur;
 		struct page *page;
 		int nr = 0;
 
@@ -2271,9 +2253,13 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 			set_page_writeback(page);
 			end_page_writeback(page);
 		}
-		if (ret)
-			end_extent_writepage(page, ret, cur, cur_end);
-		btrfs_page_unlock_writer(fs_info, page, cur, cur_end + 1 - cur);
+		if (ret) {
+			btrfs_mark_ordered_io_finished(BTRFS_I(inode), page,
+						       cur, cur_len, !ret);
+			btrfs_page_clear_uptodate(fs_info, page, cur, cur_len);
+			mapping_set_error(page->mapping, ret);
+		}
+		btrfs_page_unlock_writer(fs_info, page, cur, cur_len);
 		if (ret < 0) {
 			found_error = true;
 			first_error = ret;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index f61b7896320a1..e7b293717dc14 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -284,8 +284,6 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array);
 
-void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
-
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
 			     struct page *locked_page, u64 *start,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e0bb4018ddb28..b126394ca3dde 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -423,11 +423,10 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 
 	while (index <= end_index) {
 		/*
-		 * For locked page, we will call end_extent_writepage() on it
-		 * in run_delalloc_range() for the error handling.  That
-		 * end_extent_writepage() function will call
-		 * btrfs_mark_ordered_io_finished() to clear page Ordered and
-		 * run the ordered extent accounting.
+		 * For locked page, we will call btrfs_mark_ordered_io_finished
+		 * through btrfs_mark_ordered_io_finished() on it
+		 * in run_delalloc_range() for the error handling, which will
+		 * clear page Ordered and run the ordered extent accounting.
 		 *
 		 * Here we can't just clear the Ordered bit, or
 		 * btrfs_mark_ordered_io_finished() would skip the accounting
@@ -1157,11 +1156,16 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
 		btrfs_cleanup_ordered_extents(inode, locked_page, start, end - start + 1);
 		if (locked_page) {
 			const u64 page_start = page_offset(locked_page);
-			const u64 page_end = page_start + PAGE_SIZE - 1;
 
 			set_page_writeback(locked_page);
 			end_page_writeback(locked_page);
-			end_extent_writepage(locked_page, ret, page_start, page_end);
+			btrfs_mark_ordered_io_finished(inode, locked_page,
+						       page_start, PAGE_SIZE,
+						       !ret);
+			btrfs_page_clear_uptodate(inode->root->fs_info,
+						  locked_page, page_start,
+						  PAGE_SIZE);
+			mapping_set_error(locked_page->mapping, ret);
 			unlock_page(locked_page);
 		}
 		return ret;
@@ -2840,23 +2844,19 @@ struct btrfs_writepage_fixup {
 
 static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 {
-	struct btrfs_writepage_fixup *fixup;
+	struct btrfs_writepage_fixup *fixup =
+		container_of(work, struct btrfs_writepage_fixup, work);
 	struct btrfs_ordered_extent *ordered;
 	struct extent_state *cached_state = NULL;
 	struct extent_changeset *data_reserved = NULL;
-	struct page *page;
-	struct btrfs_inode *inode;
-	u64 page_start;
-	u64 page_end;
+	struct page *page = fixup->page;
+	struct btrfs_inode *inode = fixup->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	u64 page_start = page_offset(page);
+	u64 page_end = page_offset(page) + PAGE_SIZE - 1;
 	int ret = 0;
 	bool free_delalloc_space = true;
 
-	fixup = container_of(work, struct btrfs_writepage_fixup, work);
-	page = fixup->page;
-	inode = fixup->inode;
-	page_start = page_offset(page);
-	page_end = page_offset(page) + PAGE_SIZE - 1;
-
 	/*
 	 * This is similar to page_mkwrite, we need to reserve the space before
 	 * we take the page lock.
@@ -2949,10 +2949,12 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		 * to reflect the errors and clean the page.
 		 */
 		mapping_set_error(page->mapping, ret);
-		end_extent_writepage(page, ret, page_start, page_end);
+		btrfs_mark_ordered_io_finished(inode, page, page_start,
+					       PAGE_SIZE, !ret);
+		btrfs_page_clear_uptodate(fs_info, page, page_start, PAGE_SIZE);
 		clear_page_dirty_for_io(page);
 	}
-	btrfs_page_clear_checked(inode->root->fs_info, page, page_start, PAGE_SIZE);
+	btrfs_page_clear_checked(fs_info, page, page_start, PAGE_SIZE);
 	unlock_page(page);
 	put_page(page);
 	kfree(fixup);
-- 
2.40.1



