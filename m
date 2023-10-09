Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01547BDFF6
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377200AbjJINgK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377180AbjJINgI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:36:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA8BAB
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:36:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573B6C433CC;
        Mon,  9 Oct 2023 13:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858566;
        bh=ISCTTLa+jL2QkDp0d72HEooQhDzDnDkI+oAI7Lc5RoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G4+wtIw3WUUTyOpqJGLSiQvElzVB/mvEC88nk+aomwM/uoST4hqDCGiM901nEI6Uy
         PShnehP17SzJ8QNWHn8a03jl3al0Vjwq296OZ9RjWeSWezce7zvC2aNa4aeS5butvg
         ONqJAKJvYZ9bvz6VTuEzuHrr6AbfPZ7Xj2Q81h04=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andreas Dilger <adilger@dilger.ca>,
        Wang Jianchao <wangjianchao@kuaishou.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 008/226] ext4: add new helper interface ext4_try_to_trim_range()
Date:   Mon,  9 Oct 2023 14:59:29 +0200
Message-ID: <20231009130126.936681834@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Jianchao <wangjianchao@kuaishou.com>

[ Upstream commit 6920b3913235f517728bb69abe9b39047a987113 ]

There is no functional change in this patch but just split the
codes, which serachs free block and does trim, into a new function
ext4_try_to_trim_range. This is preparing for the following async
backgroup discard.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20210724074124.25731-3-jianchao.wan9@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 45e4ab320c9b ("ext4: move setting of trimmed bit into ext4_try_to_trim_range()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 102 ++++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 45 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 342225c1cf332..54c718d471978 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5894,6 +5894,54 @@ __acquires(bitlock)
 	return ret;
 }
 
+static int ext4_try_to_trim_range(struct super_block *sb,
+		struct ext4_buddy *e4b, ext4_grpblk_t start,
+		ext4_grpblk_t max, ext4_grpblk_t minblocks)
+{
+	ext4_grpblk_t next, count, free_count;
+	void *bitmap;
+	int ret = 0;
+
+	bitmap = e4b->bd_bitmap;
+	start = (e4b->bd_info->bb_first_free > start) ?
+		e4b->bd_info->bb_first_free : start;
+	count = 0;
+	free_count = 0;
+
+	while (start <= max) {
+		start = mb_find_next_zero_bit(bitmap, max + 1, start);
+		if (start > max)
+			break;
+		next = mb_find_next_bit(bitmap, max + 1, start);
+
+		if ((next - start) >= minblocks) {
+			ret = ext4_trim_extent(sb, start, next - start, e4b);
+			if (ret && ret != -EOPNOTSUPP)
+				break;
+			ret = 0;
+			count += next - start;
+		}
+		free_count += next - start;
+		start = next + 1;
+
+		if (fatal_signal_pending(current)) {
+			count = -ERESTARTSYS;
+			break;
+		}
+
+		if (need_resched()) {
+			ext4_unlock_group(sb, e4b->bd_group);
+			cond_resched();
+			ext4_lock_group(sb, e4b->bd_group);
+		}
+
+		if ((e4b->bd_info->bb_free - free_count) < minblocks)
+			break;
+	}
+
+	return count;
+}
+
 /**
  * ext4_trim_all_free -- function to trim all free space in alloc. group
  * @sb:			super block for file system
@@ -5917,10 +5965,8 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 		   ext4_grpblk_t start, ext4_grpblk_t max,
 		   ext4_grpblk_t minblocks)
 {
-	void *bitmap;
-	ext4_grpblk_t next, count = 0, free_count = 0;
 	struct ext4_buddy e4b;
-	int ret = 0;
+	int ret;
 
 	trace_ext4_trim_all_free(sb, group, start, max);
 
@@ -5930,57 +5976,23 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 			     ret, group);
 		return ret;
 	}
-	bitmap = e4b.bd_bitmap;
 
 	ext4_lock_group(sb, group);
-	if (EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) &&
-	    minblocks >= atomic_read(&EXT4_SB(sb)->s_last_trim_minblks))
-		goto out;
-
-	start = (e4b.bd_info->bb_first_free > start) ?
-		e4b.bd_info->bb_first_free : start;
 
-	while (start <= max) {
-		start = mb_find_next_zero_bit(bitmap, max + 1, start);
-		if (start > max)
-			break;
-		next = mb_find_next_bit(bitmap, max + 1, start);
-
-		if ((next - start) >= minblocks) {
-			ret = ext4_trim_extent(sb, start, next - start, &e4b);
-			if (ret && ret != -EOPNOTSUPP)
-				break;
-			ret = 0;
-			count += next - start;
-		}
-		free_count += next - start;
-		start = next + 1;
-
-		if (fatal_signal_pending(current)) {
-			count = -ERESTARTSYS;
-			break;
-		}
-
-		if (need_resched()) {
-			ext4_unlock_group(sb, group);
-			cond_resched();
-			ext4_lock_group(sb, group);
-		}
-
-		if ((e4b.bd_info->bb_free - free_count) < minblocks)
-			break;
+	if (!EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) ||
+	    minblocks < atomic_read(&EXT4_SB(sb)->s_last_trim_minblks)) {
+		ret = ext4_try_to_trim_range(sb, &e4b, start, max, minblocks);
+		if (ret >= 0)
+			EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
+	} else {
+		ret = 0;
 	}
 
-	if (!ret) {
-		ret = count;
-		EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
-	}
-out:
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
 
 	ext4_debug("trimmed %d blocks in the group %d\n",
-		count, group);
+		ret, group);
 
 	return ret;
 }
-- 
2.40.1



