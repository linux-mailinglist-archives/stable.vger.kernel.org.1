Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7537B7C56
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 11:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242061AbjJDJhg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 05:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242028AbjJDJhf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 05:37:35 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C13EF9
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 02:37:28 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
        by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <othacehe@gnu.org>)
        id 1qnyJp-0004ew-14; Wed, 04 Oct 2023 05:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
        s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
        references; bh=1FxGJeDk+OIVWAl9nCuHsvEDqzwu4ZDxmOQmc1dafFw=; b=GG3pZQDZ4/FKFO
        rSeT94ms9isox0G3ikQjCspGD4a0rAdC86pRD87VUM3gIiXdHyopWzWL/xqbdZTBfpQUBJL/nxlO9
        cck54yHnu8XicLSF/j5u9yonvXnsbslIEbZU1XvwRUeuTdJETwaswZIv1cHRYADWm+TwvBXErbcSv
        rMp2XqqtKV9eS7Mrbu9cpy99PKiPSLzT474JvKF6f0OnDzke6Id1S4o7i1czxTcHh3UxDx6tHZnlI
        pDZJe20RQ6UUMLVnU3ryw1Ye3BYiG4T7VotF9eTSj2CN1atMA+ZMtqxYwReowBpqKhmCzStMDdSwS
        O9r6G16wEqU7I/1WKrtQ==;
From:   Mathieu Othacehe <othacehe@gnu.org>
To:     stable@vger.kernel.org
Cc:     jack@suse.cz, Marcus Hoffmann <marcus.hoffmann@othermo.de>,
        tytso@mit.edu, famzah@icdsoft.com, gregkh@linuxfoundation.org,
        anton.reding@landisgyr.com
Subject: kernel BUG at fs/ext4/inode.c:1914 - page_buffers()
Date:   Wed, 04 Oct 2023 11:37:22 +0200
Message-ID: <871qeau3sd.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

--=-=-=
Content-Type: text/plain


Hello,

I have been experimenting this issue:
https://www.spinics.net/lists/linux-ext4/msg86259.html, on a 5.15
kernel.

This issue caused by 5c48a7df9149 ("ext4: fix an use-after-free issue
about data=journal writeback mode") is affecting ext4 users with
data=journal on all stable kernels.

Jan proposed a fix here
https://www.spinics.net/lists/linux-ext4/msg87054.html which solves the
situation for me.

Now this fix is not upstream because the data journaling support has
been rewritten. As suggested by Jan, that would mean that we could
either backport the following patches from upstream:

bd159398a2d2 ("jdb2: Don't refuse invalidation of already invalidated buffers")
d84c9ebdac1e ("ext4: Mark pages with journalled data dirty")
265e72efa99f ("ext4: Keep pages with journalled data dirty")
5e1bdea6391d ("ext4: Clear dirty bit from pages without data to write")
1f1a55f0bf06 ("ext4: Commit transaction before writing back pages in data=journal mode")
e360c6ed7274 ("ext4: Drop special handling of journalled data from ext4_sync_file()")
c000dfec7e88 ("ext4: Drop special handling of journalled data from extent shifting operations")
783ae448b7a2 ("ext4: Fix special handling of journalled data from extent zeroing")
56c2a0e3d90d ("ext4: Drop special handling of journalled data from ext4_evict_inode()")
7c375870fdc5 ("ext4: Drop special handling of journalled data from ext4_quota_on()")
951cafa6b80e ("ext4: Simplify handling of journalled data in ext4_bmap()")
ab382539adcb ("ext4: Update comment in mpage_prepare_extent_to_map()")
d0ab8368c175 ("Revert "ext4: Fix warnings when freezing filesystem with journaled data"")
1077b2d53ef5 ("ext4: fix fsync for non-directories")

Or apply the proposed, attached patch. Do you think that would be an
option?

Thanks,

Mathieu


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=0001-fix-ext4-journalled-crash.patch

From 17ec3d08a7878625c08ab37c45a8dc3c619db7fb Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@xxxxxxx>
Date: Thu, 12 Jan 2023 14:46:12 +0100
Subject: [PATCH] ext4: Fix crash in __ext4_journalled_writepage()

When __ext4_journalled_writepage() unlocks the page, there's nothing
that prevents another process from finding the page and reclaiming
buffers from it (because we have cleaned the page dirty bit and buffers
needn't have the dirty bit set). When that happens we crash in
__ext4_journalled_writepage() when trying to get the page buffers. Fix
the problem by redirtying the page before unlocking it (so that reclaim
and other users know the page isn't written yet) and by checking the
page is still dirty after reacquiring the page lock. This should also
make sure the page still has buffers.

Fixes: 5c48a7df9149 ("ext4: fix an use-after-free issue about data=journal writeback mode")
CC: stable@xxxxxxxxxxxxxxx
Signed-off-by: Jan Kara <jack@xxxxxxx>
---
 fs/ext4/inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 64a783f22105..b9f1fd05cec6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -138,7 +138,6 @@ static inline int ext4_begin_ordered_truncate(struct inode *inode,
 
 static void ext4_invalidatepage(struct page *page, unsigned int offset,
 				unsigned int length);
-static int __ext4_journalled_writepage(struct page *page, unsigned int len);
 static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 				  int pextents);
 
@@ -1858,7 +1857,8 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 	return 0;
 }
 
-static int __ext4_journalled_writepage(struct page *page,
+static int __ext4_journalled_writepage(struct writeback_control *wbc,
+				       struct page *page,
 				       unsigned int len)
 {
 	struct address_space *mapping = page->mapping;
@@ -1869,8 +1869,6 @@ static int __ext4_journalled_writepage(struct page *page,
 	struct buffer_head *inode_bh = NULL;
 	loff_t size;
 
-	ClearPageChecked(page);
-
 	if (inline_data) {
 		BUG_ON(page->index != 0);
 		BUG_ON(len > ext4_get_max_inline_size(inode));
@@ -1884,6 +1882,7 @@ static int __ext4_journalled_writepage(struct page *page,
 	 * out from under us.
 	 */
 	get_page(page);
+	redirty_page_for_writepage(wbc, page);
 	unlock_page(page);
 
 	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE,
@@ -1897,8 +1896,10 @@ static int __ext4_journalled_writepage(struct page *page,
 
 	lock_page(page);
 	put_page(page);
+	ClearPageChecked(page);
 	size = i_size_read(inode);
-	if (page->mapping != mapping || page_offset(page) > size) {
+	if (page->mapping != mapping || page_offset(page) >= size ||
+	    !clear_page_dirty_for_io(page)) {
 		/* The page got truncated from under us */
 		ext4_journal_stop(handle);
 		ret = 0;
@@ -2055,7 +2056,7 @@ static int ext4_writepage(struct page *page,
 		 * It's mmapped pagecache.  Add buffers and journal it.  There
 		 * doesn't seem much point in redirtying the page here.
 		 */
-		return __ext4_journalled_writepage(page, len);
+		return __ext4_journalled_writepage(wbc, page, len);
 
 	ext4_io_submit_init(&io_submit, wbc);
 	io_submit.io_end = ext4_init_io_end(inode, GFP_NOFS);

--=-=-=--
