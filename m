Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D40375D3A9
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjGUTNO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjGUTNN (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:13:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D09330E3
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:13:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1D4F61D7C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A9FC433C8;
        Fri, 21 Jul 2023 19:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966787;
        bh=ga/tk4+Sc52I/4IUdqv/cI9bSqHNoZlprhx99MIrdtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=19fp1i4qZzPu3N/vwT/p1WP0hLbl6FAkRo+qs8fV5M0Ey7dM0U9DpmWrHNaqfol1X
         w+PfQxErxJ2Df4Ae/nMPQFZLHlOlt0IvYz0U2joJVUxFtX/OZStEKXKhf0N19v706/
         DeBhSWxKs3IRh1OoRElNyLIc3xzODC22+hLQpldc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Baokun Li <libaokun1@huawei.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.15 467/532] ext4: only update i_reserved_data_blocks on successful block allocation
Date:   Fri, 21 Jul 2023 18:06:11 +0200
Message-ID: <20230721160639.864178990@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Baokun Li <libaokun1@huawei.com>

commit de25d6e9610a8b30cce9bbb19b50615d02ebca02 upstream.

In our fault injection test, we create an ext4 file, migrate it to
non-extent based file, then punch a hole and finally trigger a WARN_ON
in the ext4_da_update_reserve_space():

EXT4-fs warning (device sda): ext4_da_update_reserve_space:369:
ino 14, used 11 with only 10 reserved data blocks

When writing back a non-extent based file, if we enable delalloc, the
number of reserved blocks will be subtracted from the number of blocks
mapped by ext4_ind_map_blocks(), and the extent status tree will be
updated. We update the extent status tree by first removing the old
extent_status and then inserting the new extent_status. If the block range
we remove happens to be in an extent, then we need to allocate another
extent_status with ext4_es_alloc_extent().

       use old    to remove   to add new
    |----------|------------|------------|
              old extent_status

The problem is that the allocation of a new extent_status failed due to a
fault injection, and __es_shrink() did not get free memory, resulting in
a return of -ENOMEM. Then do_writepages() retries after receiving -ENOMEM,
we map to the same extent again, and the number of reserved blocks is again
subtracted from the number of blocks in that extent. Since the blocks in
the same extent are subtracted twice, we end up triggering WARN_ON at
ext4_da_update_reserve_space() because used > ei->i_reserved_data_blocks.

For non-extent based file, we update the number of reserved blocks after
ext4_ind_map_blocks() is executed, which causes a problem that when we call
ext4_ind_map_blocks() to create a block, it doesn't always create a block,
but we always reduce the number of reserved blocks. So we move the logic
for updating reserved blocks to ext4_ind_map_blocks() to ensure that the
number of reserved blocks is updated only after we do succeed in allocating
some new blocks.

Fixes: 5f634d064c70 ("ext4: Fix quota accounting error with fallocate")
Cc: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230424033846.4732-2-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/indirect.c |    8 ++++++++
 fs/ext4/inode.c    |   10 ----------
 2 files changed, 8 insertions(+), 10 deletions(-)

--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -651,6 +651,14 @@ int ext4_ind_map_blocks(handle_t *handle
 
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 	count = ar.len;
+
+	/*
+	 * Update reserved blocks/metadata blocks after successful block
+	 * allocation which had been deferred till now.
+	 */
+	if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
+		ext4_da_update_reserve_space(inode, count, 1);
+
 got_it:
 	map->m_flags |= EXT4_MAP_MAPPED;
 	map->m_pblk = le32_to_cpu(chain[depth-1].key);
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -654,16 +654,6 @@ found:
 			 */
 			ext4_clear_inode_state(inode, EXT4_STATE_EXT_MIGRATE);
 		}
-
-		/*
-		 * Update reserved blocks/metadata blocks after successful
-		 * block allocation which had been deferred till now. We don't
-		 * support fallocate for non extent files. So we can update
-		 * reserve space here.
-		 */
-		if ((retval > 0) &&
-			(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE))
-			ext4_da_update_reserve_space(inode, retval, 1);
 	}
 
 	if (retval > 0) {


