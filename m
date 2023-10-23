Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBABA7D344A
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbjJWLiN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbjJWLiN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:38:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A630DB
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:38:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC81C433C7;
        Mon, 23 Oct 2023 11:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061091;
        bh=TwDpC+q51O/3NsdUjclj0z0PBX6fNngtzISxaMvu09o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tCdKoRS3hc7sPTofj4Uky+R99acXVL9v4gGJKP9el9Hz+jT4kwEuBV5dk+MVGwMD4
         XnjzA1Cl11dmjXUKwOa5moGB/k/cdCUTX6YP5IFM51B5VI1oMPIItvMm6l1pXZV4KS
         uX3dUwJ+hUW8Orx/yOHSauzlc3abswgxFwFCeDXA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chunhai Guo <guochunhai@vivo.com>,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 069/137] fs-writeback: do not requeue a clean inode having skipped pages
Date:   Mon, 23 Oct 2023 12:57:06 +0200
Message-ID: <20231023104823.276538278@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index c76537a6826a7..5f0abea107e46 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1557,10 +1557,15 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 
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



