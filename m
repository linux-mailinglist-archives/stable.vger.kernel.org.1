Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB49775517A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjGPT4y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjGPT4x (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:56:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D5CE51
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:56:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7F6D60E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0D5C433C9;
        Sun, 16 Jul 2023 19:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537409;
        bh=uUvAuPd1gtkCACbnUzoDUt2rvqd95ocRlAL/LKiDz4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J4Rrc1qvF4rghxY9NtSUaHSI19QGshSLQDlUcesPKiA6VyHvzBLiZxpxVW+I63WL2
         yBU4IfonjHFfQ9uYS/gFwEuyZr/tc1oO/Lei1eztOA8Z3WfPIHQNzWsK0Ged/Th4wz
         6BN5D5Yf2Ug2xMPLii35agozKK3MQ9B+knmrwCEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 058/800] btrfs: dont treat zoned writeback as being from an async helper thread
Date:   Sun, 16 Jul 2023 21:38:31 +0200
Message-ID: <20230716194950.436876831@linuxfoundation.org>
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

[ Upstream commit 7027f87108ce3d23ea542e1a9a79056530db4a87 ]

When extent_write_locked_range was originally added, it was only used
writing back compressed pages from an async helper thread.  But it is
now also used for writing back pages on zoned devices, where it is
called directly from the ->writepage context.  In this case we want to
be able to pass on the writeback_control instead of creating a new one,
and more importantly want to use all the normal cgroup interaction
instead of potentially deferring writeback to another helper.

Fixes: 898793d992c2 ("btrfs: zoned: write out partially allocated region")
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 20 +++++++-------------
 fs/btrfs/extent_io.h |  3 ++-
 fs/btrfs/inode.c     | 20 +++++++++++++++-----
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6116da5d0a1ed..a69a488605b21 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2432,7 +2432,8 @@ static int extent_write_cache_pages(struct address_space *mapping,
  * already been ran (aka, ordered extent inserted) and all pages are still
  * locked.
  */
-int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
+int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
+			      struct writeback_control *wbc)
 {
 	bool found_error = false;
 	int first_error = 0;
@@ -2442,22 +2443,16 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 	const u32 sectorsize = fs_info->sectorsize;
 	loff_t i_size = i_size_read(inode);
 	u64 cur = start;
-	struct writeback_control wbc_writepages = {
-		.sync_mode	= WB_SYNC_ALL,
-		.range_start	= start,
-		.range_end	= end,
-		.no_cgroup_owner = 1,
-	};
 	struct btrfs_bio_ctrl bio_ctrl = {
-		.wbc = &wbc_writepages,
-		/* We're called from an async helper function */
-		.opf = REQ_OP_WRITE | REQ_BTRFS_CGROUP_PUNT |
-			wbc_to_write_flags(&wbc_writepages),
+		.wbc = wbc,
+		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
 	};
 
+	if (wbc->no_cgroup_owner)
+		bio_ctrl.opf |= REQ_BTRFS_CGROUP_PUNT;
+
 	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(end + 1, sectorsize));
 
-	wbc_attach_fdatawrite_inode(&wbc_writepages, inode);
 	while (cur <= end) {
 		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
 		struct page *page;
@@ -2497,7 +2492,6 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 
 	submit_write_bio(&bio_ctrl, found_error ? ret : 0);
 
-	wbc_detach_inode(&wbc_writepages);
 	if (found_error)
 		return first_error;
 	return ret;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 4341ad978fb8e..aac7e6817e8ff 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -179,7 +179,8 @@ int try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
 
 int btrfs_read_folio(struct file *file, struct folio *folio);
-int extent_write_locked_range(struct inode *inode, u64 start, u64 end);
+int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
+			      struct writeback_control *wbc);
 int extent_writepages(struct address_space *mapping,
 		      struct writeback_control *wbc);
 int btree_write_cache_pages(struct address_space *mapping,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3d12dba145152..2e6eed4b1b3cc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -934,6 +934,12 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
 	unsigned long nr_written = 0;
 	int page_started = 0;
 	int ret;
+	struct writeback_control wbc = {
+		.sync_mode		= WB_SYNC_ALL,
+		.range_start		= start,
+		.range_end		= end,
+		.no_cgroup_owner	= 1,
+	};
 
 	/*
 	 * Call cow_file_range() to run the delalloc range directly, since we
@@ -965,7 +971,10 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
 	}
 
 	/* All pages will be unlocked, including @locked_page */
-	return extent_write_locked_range(&inode->vfs_inode, start, end);
+	wbc_attach_fdatawrite_inode(&wbc, &inode->vfs_inode);
+	ret = extent_write_locked_range(&inode->vfs_inode, start, end, &wbc);
+	wbc_detach_inode(&wbc);
+	return ret;
 }
 
 static int submit_one_async_extent(struct btrfs_inode *inode,
@@ -1617,7 +1626,8 @@ static bool cow_file_range_async(struct btrfs_inode *inode,
 static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
 				       struct page *locked_page, u64 start,
 				       u64 end, int *page_started,
-				       unsigned long *nr_written)
+				       unsigned long *nr_written,
+				       struct writeback_control *wbc)
 {
 	u64 done_offset = end;
 	int ret;
@@ -1649,8 +1659,8 @@ static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
 			account_page_redirty(locked_page);
 		}
 		locked_page_done = true;
-		extent_write_locked_range(&inode->vfs_inode, start, done_offset);
-
+		extent_write_locked_range(&inode->vfs_inode, start, done_offset,
+					  wbc);
 		start = done_offset + 1;
 	}
 
@@ -2224,7 +2234,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 
 	if (zoned)
 		ret = run_delalloc_zoned(inode, locked_page, start, end,
-					 page_started, nr_written);
+					 page_started, nr_written, wbc);
 	else
 		ret = cow_file_range(inode, locked_page, start, end,
 				     page_started, nr_written, 1, NULL);
-- 
2.39.2



