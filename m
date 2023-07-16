Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DCE75517F
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjGPT5O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjGPT5C (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:57:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57413199
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:57:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0A7560E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F174FC433C8;
        Sun, 16 Jul 2023 19:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537420;
        bh=FCQ2w1F4hRZMege5MJF0U/G0w5afIh3Nso9C8UJDEd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2kdMIO7Tl/p9elk0/tzKVesgiaNVL4vFn9613yx0Y7HXLyjFi5zpyrsStG/GOODKJ
         qz6hZlo7Zb1co4JGvr359X/q4jRLlheoUwdPPpNxUVljUo55jujfSjrksXu67Lh5CL
         vJaB8DWm33Sw+SLpqeqkufDS+K6IjsX6MuDK76/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 052/800] btrfs: dont use btrfs_bio_ctrl for extent buffer reading
Date:   Sun, 16 Jul 2023 21:38:25 +0200
Message-ID: <20230716194950.299311715@linuxfoundation.org>
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

[ Upstream commit b78b98e06fb7f9860da5a7c28e1edbaefc2f7be1 ]

The btrfs_bio_ctrl machinery is overkill for reading extent_buffers
as we always operate on PAGE_SIZE chunks (or one smaller one for the
subpage case) that are contiguous and are guaranteed to fit into a
single bio.  Replace it with open coded btrfs_bio_alloc, __bio_add_page
and btrfs_submit_bio calls in a helper function shared between
the subpage and node size >= PAGE_SIZE cases.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 7027f87108ce ("btrfs: don't treat zoned writeback as being from an async helper thread")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 99 ++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 63 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d1a635f237688..51f0f28fb9b2c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -98,22 +98,12 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
  */
 struct btrfs_bio_ctrl {
 	struct btrfs_bio *bbio;
-	int mirror_num;
 	enum btrfs_compression_type compress_type;
 	u32 len_to_oe_boundary;
 	blk_opf_t opf;
 	btrfs_bio_end_io_t end_io_func;
 	struct writeback_control *wbc;
 
-	/*
-	 * This is for metadata read, to provide the extra needed verification
-	 * info.  This has to be provided for submit_one_bio(), as
-	 * submit_one_bio() can submit a bio if it ends at stripe boundary.  If
-	 * no such parent_check is provided, the metadata can hit false alert at
-	 * endio time.
-	 */
-	struct btrfs_tree_parent_check *parent_check;
-
 	/*
 	 * Tell writepage not to lock the state bits for this range, it still
 	 * does the unlocking.
@@ -124,7 +114,6 @@ struct btrfs_bio_ctrl {
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct btrfs_bio *bbio = bio_ctrl->bbio;
-	int mirror_num = bio_ctrl->mirror_num;
 
 	if (!bbio)
 		return;
@@ -132,25 +121,14 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bbio->bio.bi_iter.bi_size);
 
-	if (!is_data_inode(&bbio->inode->vfs_inode)) {
-		if (btrfs_op(&bbio->bio) != BTRFS_MAP_WRITE) {
-			/*
-			 * For metadata read, we should have the parent_check,
-			 * and copy it to bbio for metadata verification.
-			 */
-			ASSERT(bio_ctrl->parent_check);
-			memcpy(&bbio->parent_check,
-			       bio_ctrl->parent_check,
-			       sizeof(struct btrfs_tree_parent_check));
-		}
+	if (!is_data_inode(&bbio->inode->vfs_inode))
 		bbio->bio.bi_opf |= REQ_META;
-	}
 
 	if (btrfs_op(&bbio->bio) == BTRFS_MAP_READ &&
 	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
-		btrfs_submit_compressed_read(bbio, mirror_num);
+		btrfs_submit_compressed_read(bbio, 0);
 	else
-		btrfs_submit_bio(bbio, mirror_num);
+		btrfs_submit_bio(bbio, 0);
 
 	/* The bbio is owned by the end_io handler now */
 	bio_ctrl->bbio = NULL;
@@ -4242,6 +4220,36 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 	}
 }
 
+static void __read_extent_buffer_pages(struct extent_buffer *eb, int mirror_num,
+				       struct btrfs_tree_parent_check *check)
+{
+	int num_pages = num_extent_pages(eb), i;
+	struct btrfs_bio *bbio;
+
+	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
+	eb->read_mirror = 0;
+	atomic_set(&eb->io_pages, num_pages);
+	check_buffer_tree_ref(eb);
+
+	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
+			       REQ_OP_READ | REQ_META, eb->fs_info,
+			       end_bio_extent_readpage, NULL);
+	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
+	bbio->inode = BTRFS_I(eb->fs_info->btree_inode);
+	bbio->file_offset = eb->start;
+	memcpy(&bbio->parent_check, check, sizeof(*check));
+	if (eb->fs_info->nodesize < PAGE_SIZE) {
+		__bio_add_page(&bbio->bio, eb->pages[0], eb->len,
+			       eb->start - page_offset(eb->pages[0]));
+	} else {
+		for (i = 0; i < num_pages; i++) {
+			ClearPageError(eb->pages[i]);
+			__bio_add_page(&bbio->bio, eb->pages[i], PAGE_SIZE, 0);
+		}
+	}
+	btrfs_submit_bio(bbio, mirror_num);
+}
+
 static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 				      int mirror_num,
 				      struct btrfs_tree_parent_check *check)
@@ -4250,11 +4258,6 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	struct extent_io_tree *io_tree;
 	struct page *page = eb->pages[0];
 	struct extent_state *cached_state = NULL;
-	struct btrfs_bio_ctrl bio_ctrl = {
-		.opf = REQ_OP_READ,
-		.mirror_num = mirror_num,
-		.parent_check = check,
-	};
 	int ret;
 
 	ASSERT(!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags));
@@ -4282,18 +4285,10 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 		return 0;
 	}
 
-	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
-	eb->read_mirror = 0;
-	atomic_set(&eb->io_pages, 1);
-	check_buffer_tree_ref(eb);
-	bio_ctrl.end_io_func = end_bio_extent_readpage;
-
 	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
-
 	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
-	submit_extent_page(&bio_ctrl, eb->start, page, eb->len,
-			   eb->start - page_offset(page));
-	submit_one_bio(&bio_ctrl);
+
+	__read_extent_buffer_pages(eb, mirror_num, check);
 	if (wait != WAIT_COMPLETE) {
 		free_extent_state(cached_state);
 		return 0;
@@ -4314,11 +4309,6 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 	int locked_pages = 0;
 	int all_uptodate = 1;
 	int num_pages;
-	struct btrfs_bio_ctrl bio_ctrl = {
-		.opf = REQ_OP_READ,
-		.mirror_num = mirror_num,
-		.parent_check = check,
-	};
 
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
 		return 0;
@@ -4368,24 +4358,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 		goto unlock_exit;
 	}
 
-	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
-	eb->read_mirror = 0;
-	atomic_set(&eb->io_pages, num_pages);
-	/*
-	 * It is possible for release_folio to clear the TREE_REF bit before we
-	 * set io_pages. See check_buffer_tree_ref for a more detailed comment.
-	 */
-	check_buffer_tree_ref(eb);
-	bio_ctrl.end_io_func = end_bio_extent_readpage;
-	for (i = 0; i < num_pages; i++) {
-		page = eb->pages[i];
-
-		ClearPageError(page);
-		submit_extent_page(&bio_ctrl, page_offset(page), page,
-				   PAGE_SIZE, 0);
-	}
-
-	submit_one_bio(&bio_ctrl);
+	__read_extent_buffer_pages(eb, mirror_num, check);
 
 	if (wait != WAIT_COMPLETE)
 		return 0;
-- 
2.39.2



