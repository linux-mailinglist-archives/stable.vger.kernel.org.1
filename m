Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076567D32C6
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjJWLXm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbjJWLXd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:23:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAD110E7
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:23:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED272C433C9;
        Mon, 23 Oct 2023 11:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060202;
        bh=YYY4fRfzog/KkbMSs00mKCZrh3sPR3sESk0ke43gneQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CBxJC0EMJCXkreTDRc6V56afQWfPSDDUPeK6a7FnMbaHy6t5riPzxWfzBhIZ+7LgA
         OUdF6KC0NkvrgCEvpa/YbuSr3sAtSIYxtzLp4TTej70+wJPGr9vhrBhwZTqg803/2N
         hLNyYyM9Z6DwlwXnUhVJCup6pgdtkPj30qTTmNVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chunhai Guo <guochunhai@vivo.com>,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 093/196] fs-writeback: do not requeue a clean inode having skipped pages
Date:   Mon, 23 Oct 2023 12:55:58 +0200
Message-ID: <20231023104831.162505644@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chunhai Guo <guochunhai@vivo.com>

[ Upstream commit be049c3a088d512187407b7fd036cecfab46d565 ]

When writing back an inode and performing an fsync on it concurrently, a
deadlock issue may arise as shown below. In each writeback iteration, a
clean inode is requeued to the wb->b_dirty queue due to non-zero
pages_skipped, without anything actually being written. This causes an
infinite loop and prevents the plug from being flushed, resulting in a
deadlock. We now avoid requeuing the clean inode to prevent this issue.

    wb_writeback        fsync (inode-Y)
blk_start_plug(&plug)
for (;;) {
  iter i-1: some reqs with page-X added into plug->mq_list // f2fs node page-X with PG_writeback
                        filemap_fdatawrite
                          __filemap_fdatawrite_range // write inode-Y with sync_mode WB_SYNC_ALL
                           do_writepages
                            f2fs_write_data_pages
                             __f2fs_write_data_pages // wb_sync_req[DATA]++ for WB_SYNC_ALL
                              f2fs_write_cache_pages
                               f2fs_write_single_data_page
                                f2fs_do_write_data_page
                                 f2fs_outplace_write_data
                                  f2fs_update_data_blkaddr
                                   f2fs_wait_on_page_writeback
                                     wait_on_page_writeback // wait for f2fs node page-X
  iter i:
    progress = __writeback_inodes_wb(wb, work)
    . writeback_sb_inodes
    .   __writeback_single_inode // write inode-Y with sync_mode WB_SYNC_NONE
    .   . do_writepages
    .   .   f2fs_write_data_pages
    .   .   .  __f2fs_write_data_pages // skip writepages due to (wb_sync_req[DATA]>0)
    .   .   .   wbc->pages_skipped += get_dirty_pages(inode) // wbc->pages_skipped = 1
    .   if (!(inode->i_state & I_DIRTY_ALL)) // i_state = I_SYNC | I_SYNC_QUEUED
    .    total_wrote++;  // total_wrote = 1
    .   requeue_inode // requeue inode-Y to wb->b_dirty queue due to non-zero pages_skipped
    if (progress) // progress = 1
      continue;
  iter i+1:
      queue_io
      // similar process with iter i, infinite for-loop !
}
blk_finish_plug(&plug)   // flush plug won't be called

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Message-Id: <20230916045131.957929-1-guochunhai@vivo.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fs-writeback.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index d387708977a50..a5c31a479aacc 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1522,10 +1522,15 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 
 	if (wbc->pages_skipped) {
 		/*
-		 * writeback is not making progress due to locked
-		 * buffers. Skip this inode for now.
+		 * Writeback is not making progress due to locked buffers.
+		 * Skip this inode for now. Although having skipped pages
+		 * is odd for clean inodes, it can happen for some
+		 * filesystems so handle that gracefully.
 		 */
-		redirty_tail_locked(inode, wb);
+		if (inode->i_state & I_DIRTY_ALL)
+			redirty_tail_locked(inode, wb);
+		else
+			inode_cgwb_move_to_attached(inode, wb);
 		return;
 	}
 
-- 
2.40.1



