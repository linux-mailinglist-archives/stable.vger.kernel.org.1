Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97287B8447
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 17:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242947AbjJDP4S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 11:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjJDP4R (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 11:56:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08D698
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 08:56:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04392C433C7;
        Wed,  4 Oct 2023 15:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696434973;
        bh=9mHi72Iix4tzOvU4k3tx9hoiAfjIYbQeej7JNoJNMzU=;
        h=Subject:To:Cc:From:Date:From;
        b=jmgRVkZwY6aLxRLh/81iVBtG/YcduJOowTydewtgnI/quLITWxVB90yRX6h26EuH5
         qIH0rb6XyKCZgsJokhQGCeZSzuKDp/eKR+eRfpUB2L/poGmD8zfl9XepxIgja8sG3H
         T7WqnnX5bEXdfC3KCHtG1M90YcuGHDM+4x8nL30A=
Subject: FAILED: patch "[PATCH] btrfs: don't clear uptodate on write errors" failed to apply to 6.1-stable tree
To:     josef@toxicpanda.com, dsterba@suse.com, wqu@suse.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 04 Oct 2023 17:56:02 +0200
Message-ID: <2023100402-reprint-snugness-793f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b595d25996329427b2c09d4b90395a165fb3ef8e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100402-reprint-snugness-793f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b595d25996329427b2c09d4b90395a165fb3ef8e Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 8 Sep 2023 15:31:39 -0400
Subject: [PATCH] btrfs: don't clear uptodate on write errors

We have been consistently seeing hangs with generic/648 in our subpage
GitHub CI setup.  This is a classic deadlock, we are calling
btrfs_read_folio() on a folio, which requires holding the folio lock on
the folio, and then finding a ordered extent that overlaps that range
and calling btrfs_start_ordered_extent(), which then tries to write out
the dirty page, which requires taking the folio lock and then we
deadlock.

The hang happens because we're writing to range [1271750656, 1271767040),
page index [77621, 77622], and page 77621 is !Uptodate.  It is also Dirty,
so we call btrfs_read_folio() for 77621 and which does
btrfs_lock_and_flush_ordered_range() for that range, and we find an ordered
extent which is [1271644160, 1271746560), page index [77615, 77621].
The page indexes overlap, but the actual bytes don't overlap.  We're
holding the page lock for 77621, then call
btrfs_lock_and_flush_ordered_range() which tries to flush the dirty
page, and tries to lock 77621 again and then we deadlock.

The byte ranges do not overlap, but with subpage support if we clear
uptodate on any portion of the page we mark the entire thing as not
uptodate.

We have been clearing page uptodate on write errors, but no other file
system does this, and is in fact incorrect.  This doesn't hurt us in the
!subpage case because we can't end up with overlapped ranges that don't
also overlap on the page.

Fix this by not clearing uptodate when we have a write error.  The only
thing we should be doing in this case is setting the mapping error and
carrying on.  This makes it so we would no longer call
btrfs_read_folio() on the page as it's uptodate and eliminates the
deadlock.

With this patch we're now able to make it through a full fstests run on
our subpage blocksize VMs.

Note for stable backports: this probably goes beyond 6.1 but the code
has been cleaned up and clearing the uptodate bit must be verified on
each version independently.

CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ac3fca5a5e41..6954ae763b86 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -484,10 +484,8 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 				   bvec->bv_offset, bvec->bv_len);
 
 		btrfs_finish_ordered_extent(bbio->ordered, page, start, len, !error);
-		if (error) {
-			btrfs_page_clear_uptodate(fs_info, page, start, len);
+		if (error)
 			mapping_set_error(page->mapping, error);
-		}
 		btrfs_page_clear_writeback(fs_info, page, start, len);
 	}
 
@@ -1456,8 +1454,6 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 	if (ret) {
 		btrfs_mark_ordered_io_finished(BTRFS_I(inode), page, page_start,
 					       PAGE_SIZE, !ret);
-		btrfs_page_clear_uptodate(btrfs_sb(inode->i_sb), page,
-					  page_start, PAGE_SIZE);
 		mapping_set_error(page->mapping, ret);
 	}
 	unlock_page(page);
@@ -1624,8 +1620,6 @@ static void extent_buffer_write_end_io(struct btrfs_bio *bbio)
 		struct page *page = bvec->bv_page;
 		u32 len = bvec->bv_len;
 
-		if (!uptodate)
-			btrfs_page_clear_uptodate(fs_info, page, start, len);
 		btrfs_page_clear_writeback(fs_info, page, start, len);
 		bio_offset += len;
 	}
@@ -2201,7 +2195,6 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 		if (ret) {
 			btrfs_mark_ordered_io_finished(BTRFS_I(inode), page,
 						       cur, cur_len, !ret);
-			btrfs_page_clear_uptodate(fs_info, page, cur, cur_len);
 			mapping_set_error(page->mapping, ret);
 		}
 		btrfs_page_unlock_writer(fs_info, page, cur, cur_len);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e211e88c6545..616fdcf40467 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1085,9 +1085,6 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 			btrfs_mark_ordered_io_finished(inode, locked_page,
 						       page_start, PAGE_SIZE,
 						       !ret);
-			btrfs_page_clear_uptodate(inode->root->fs_info,
-						  locked_page, page_start,
-						  PAGE_SIZE);
 			mapping_set_error(locked_page->mapping, ret);
 			unlock_page(locked_page);
 		}
@@ -2791,7 +2788,6 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		mapping_set_error(page->mapping, ret);
 		btrfs_mark_ordered_io_finished(inode, page, page_start,
 					       PAGE_SIZE, !ret);
-		btrfs_page_clear_uptodate(fs_info, page, page_start, PAGE_SIZE);
 		clear_page_dirty_for_io(page);
 	}
 	btrfs_page_clear_checked(fs_info, page, page_start, PAGE_SIZE);

