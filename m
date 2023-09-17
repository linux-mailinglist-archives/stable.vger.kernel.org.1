Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1039A7A39C2
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbjIQTyJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240157AbjIQTxs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:53:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC1C9F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:53:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77031C433C9;
        Sun, 17 Sep 2023 19:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980422;
        bh=EQ9pktDE7+lLm00YJ3KwzztnmjM4cwLBqFy2Q/o8xQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YPMMzjMrM4NHCTzknjdZoCyO6M6HEyLVAlPRd1H2Egbe9xcYiO0phKOADueL2D1EW
         TbNaz+J9xwEom0EKa34m0bAWYfQTL2c+kIYWiSiwTiHlYhn4Dp4RshGpvD0E8uasJ3
         /9ber5xRcrDGQcB5reHf4q1Hn+pDBHXwWOA7yFjQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yikebaer Aizezi <yikebaer61@gmail.com>,
        stable@kernel.org, Baokun Li <libaokun1@huawei.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.5 187/285] ext4: fix slab-use-after-free in ext4_es_insert_extent()
Date:   Sun, 17 Sep 2023 21:13:07 +0200
Message-ID: <20230917191058.083977809@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

commit 768d612f79822d30a1e7d132a4d4b05337ce42ec upstream.

Yikebaer reported an issue:
==================================================================
BUG: KASAN: slab-use-after-free in ext4_es_insert_extent+0xc68/0xcb0
fs/ext4/extents_status.c:894
Read of size 4 at addr ffff888112ecc1a4 by task syz-executor/8438

CPU: 1 PID: 8438 Comm: syz-executor Not tainted 6.5.0-rc5 #1
Call Trace:
 [...]
 kasan_report+0xba/0xf0 mm/kasan/report.c:588
 ext4_es_insert_extent+0xc68/0xcb0 fs/ext4/extents_status.c:894
 ext4_map_blocks+0x92a/0x16f0 fs/ext4/inode.c:680
 ext4_alloc_file_blocks.isra.0+0x2df/0xb70 fs/ext4/extents.c:4462
 ext4_zero_range fs/ext4/extents.c:4622 [inline]
 ext4_fallocate+0x251c/0x3ce0 fs/ext4/extents.c:4721
 [...]

Allocated by task 8438:
 [...]
 kmem_cache_zalloc include/linux/slab.h:693 [inline]
 __es_alloc_extent fs/ext4/extents_status.c:469 [inline]
 ext4_es_insert_extent+0x672/0xcb0 fs/ext4/extents_status.c:873
 ext4_map_blocks+0x92a/0x16f0 fs/ext4/inode.c:680
 ext4_alloc_file_blocks.isra.0+0x2df/0xb70 fs/ext4/extents.c:4462
 ext4_zero_range fs/ext4/extents.c:4622 [inline]
 ext4_fallocate+0x251c/0x3ce0 fs/ext4/extents.c:4721
 [...]

Freed by task 8438:
 [...]
 kmem_cache_free+0xec/0x490 mm/slub.c:3823
 ext4_es_try_to_merge_right fs/ext4/extents_status.c:593 [inline]
 __es_insert_extent+0x9f4/0x1440 fs/ext4/extents_status.c:802
 ext4_es_insert_extent+0x2ca/0xcb0 fs/ext4/extents_status.c:882
 ext4_map_blocks+0x92a/0x16f0 fs/ext4/inode.c:680
 ext4_alloc_file_blocks.isra.0+0x2df/0xb70 fs/ext4/extents.c:4462
 ext4_zero_range fs/ext4/extents.c:4622 [inline]
 ext4_fallocate+0x251c/0x3ce0 fs/ext4/extents.c:4721
 [...]
==================================================================

The flow of issue triggering is as follows:
1. remove es
      raw es               es  removed  es1
|-------------------| -> |----|.......|------|

2. insert es
  es   insert   es1      merge with es  es1     merge with es and free es1
|----|.......|------| -> |------------|------| -> |-------------------|

es merges with newes, then merges with es1, frees es1, then determines
if es1->es_len is 0 and triggers a UAF.

The code flow is as follows:
ext4_es_insert_extent
  es1 = __es_alloc_extent(true);
  es2 = __es_alloc_extent(true);
  __es_remove_extent(inode, lblk, end, NULL, es1)
    __es_insert_extent(inode, &newes, es1) ---> insert es1 to es tree
  __es_insert_extent(inode, &newes, es2)
    ext4_es_try_to_merge_right
      ext4_es_free_extent(inode, es1) --->  es1 is freed
  if (es1 && !es1->es_len)
    // Trigger UAF by determining if es1 is used.

We determine whether es1 or es2 is used immediately after calling
__es_remove_extent() or __es_insert_extent() to avoid triggering a
UAF if es1 or es2 is freed.

Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>
Closes: https://lore.kernel.org/lkml/CALcu4raD4h9coiyEBL4Bm0zjDwxC2CyPiTwsP3zFuhot6y9Beg@mail.gmail.com
Fixes: 2a69c450083d ("ext4: using nofail preallocation in ext4_es_insert_extent()")
Cc: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230815070808.3377171-1-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/extents_status.c | 44 +++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 9b5b8951afb4..6f7de14c0fa8 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -878,23 +878,29 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	err1 = __es_remove_extent(inode, lblk, end, NULL, es1);
 	if (err1 != 0)
 		goto error;
+	/* Free preallocated extent if it didn't get used. */
+	if (es1) {
+		if (!es1->es_len)
+			__es_free_extent(es1);
+		es1 = NULL;
+	}
 
 	err2 = __es_insert_extent(inode, &newes, es2);
 	if (err2 == -ENOMEM && !ext4_es_must_keep(&newes))
 		err2 = 0;
 	if (err2 != 0)
 		goto error;
+	/* Free preallocated extent if it didn't get used. */
+	if (es2) {
+		if (!es2->es_len)
+			__es_free_extent(es2);
+		es2 = NULL;
+	}
 
 	if (sbi->s_cluster_ratio > 1 && test_opt(inode->i_sb, DELALLOC) &&
 	    (status & EXTENT_STATUS_WRITTEN ||
 	     status & EXTENT_STATUS_UNWRITTEN))
 		__revise_pending(inode, lblk, len);
-
-	/* es is pre-allocated but not used, free it. */
-	if (es1 && !es1->es_len)
-		__es_free_extent(es1);
-	if (es2 && !es2->es_len)
-		__es_free_extent(es2);
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 	if (err1 || err2)
@@ -1491,8 +1497,12 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	 */
 	write_lock(&EXT4_I(inode)->i_es_lock);
 	err = __es_remove_extent(inode, lblk, end, &reserved, es);
-	if (es && !es->es_len)
-		__es_free_extent(es);
+	/* Free preallocated extent if it didn't get used. */
+	if (es) {
+		if (!es->es_len)
+			__es_free_extent(es);
+		es = NULL;
+	}
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 	if (err)
 		goto retry;
@@ -2047,19 +2057,25 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 	err1 = __es_remove_extent(inode, lblk, lblk, NULL, es1);
 	if (err1 != 0)
 		goto error;
+	/* Free preallocated extent if it didn't get used. */
+	if (es1) {
+		if (!es1->es_len)
+			__es_free_extent(es1);
+		es1 = NULL;
+	}
 
 	err2 = __es_insert_extent(inode, &newes, es2);
 	if (err2 != 0)
 		goto error;
+	/* Free preallocated extent if it didn't get used. */
+	if (es2) {
+		if (!es2->es_len)
+			__es_free_extent(es2);
+		es2 = NULL;
+	}
 
 	if (allocated)
 		__insert_pending(inode, lblk);
-
-	/* es is pre-allocated but not used, free it. */
-	if (es1 && !es1->es_len)
-		__es_free_extent(es1);
-	if (es2 && !es2->es_len)
-		__es_free_extent(es2);
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 	if (err1 || err2)
-- 
2.42.0



