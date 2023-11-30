Return-Path: <stable+bounces-3448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D623F7FF5B2
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900EE2816E9
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DED11C9B;
	Thu, 30 Nov 2023 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LhGMD9Fg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7209537F9;
	Thu, 30 Nov 2023 16:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438FDC433C7;
	Thu, 30 Nov 2023 16:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361857;
	bh=MoORLIuFywKYtjAYyYlOGDO/NSoI95fbAI9X6rGTv+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LhGMD9Fg7CZtnBMBMnyrkUdWMjCxnzmUb4P5LqBbZrKTHelC5PLTKTr4awARnXiaR
	 D1LLUV2XdFcW7mrBxzmVDQ4DbB/SkoS7YRwWTap6lY0fvowfxMw0C5AL7tGm/jFExM
	 NBXCKlcPYVKPEAKMc16MG8pZpppbzk3guixd3vBI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yikebaer Aizezi <yikebaer61@gmail.com>,
	stable@kernel.org,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 51/82] ext4: fix slab-use-after-free in ext4_es_insert_extent()
Date: Thu, 30 Nov 2023 16:22:22 +0000
Message-ID: <20231130162137.590872130@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162135.977485944@linuxfoundation.org>
References: <20231130162135.977485944@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 768d612f79822d30a1e7d132a4d4b05337ce42ec ]

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
Stable-dep-of: 8e387c89e96b ("ext4: make sure allocate pending entry not fail")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents_status.c | 44 +++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 934c14f9edb9f..e8533b4f891bf 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -882,23 +882,29 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
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
@@ -1495,8 +1501,12 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
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
@@ -2055,19 +2065,25 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
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




