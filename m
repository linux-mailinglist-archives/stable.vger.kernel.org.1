Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2004B7B8922
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244115AbjJDSXE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244117AbjJDSXD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:23:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359A79E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:22:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF60C433CB;
        Wed,  4 Oct 2023 18:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443777;
        bh=hiUqqeZjOpXlc88uprOthrifz4+CVbjdIN2ved2epi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zxcjFHqycqXlUWO8IQQP6n3sVh9wyROL4unGfcEhu3yNZb4tamYpBcdyyjTbia3uO
         Y/FvkrifB2uq1TJYaPhujmHR9l0Zjo5hkg8cITKIfkLTF/NoFjZ+cIlEnSn0Tfg7qF
         dIo0J9RRXUevqVo5856jo3bRvkJsUCCti8J4u7gI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 017/321] ext4: move setting of trimmed bit into ext4_try_to_trim_range()
Date:   Wed,  4 Oct 2023 19:52:42 +0200
Message-ID: <20231004175229.987570194@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

From: Jan Kara <jack@suse.cz>

[ Upstream commit 45e4ab320c9b5fa67b1fc3b6a9b381cfcc0c8488 ]

Currently we set the group's trimmed bit in ext4_trim_all_free() based
on return value of ext4_try_to_trim_range(). However when we will want
to abort trimming because of suspend attempt, we want to return success
from ext4_try_to_trim_range() but not set the trimmed bit. Instead
implementing awkward propagation of this information, just move setting
of trimmed bit into ext4_try_to_trim_range() when the whole group is
trimmed.

Cc: stable@kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230913150504.9054-1-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 7d81df6667b9a..63dde4f5f984f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6920,6 +6920,16 @@ __acquires(bitlock)
 	return ret;
 }
 
+static ext4_grpblk_t ext4_last_grp_cluster(struct super_block *sb,
+					   ext4_group_t grp)
+{
+	if (grp < ext4_get_groups_count(sb))
+		return EXT4_CLUSTERS_PER_GROUP(sb) - 1;
+	return (ext4_blocks_count(EXT4_SB(sb)->s_es) -
+		ext4_group_first_block_no(sb, grp) - 1) >>
+					EXT4_CLUSTER_BITS(sb);
+}
+
 static int ext4_try_to_trim_range(struct super_block *sb,
 		struct ext4_buddy *e4b, ext4_grpblk_t start,
 		ext4_grpblk_t max, ext4_grpblk_t minblocks)
@@ -6927,9 +6937,12 @@ __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
 __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 {
 	ext4_grpblk_t next, count, free_count;
+	bool set_trimmed = false;
 	void *bitmap;
 
 	bitmap = e4b->bd_bitmap;
+	if (start == 0 && max >= ext4_last_grp_cluster(sb, e4b->bd_group))
+		set_trimmed = true;
 	start = max(e4b->bd_info->bb_first_free, start);
 	count = 0;
 	free_count = 0;
@@ -6944,16 +6957,14 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 			int ret = ext4_trim_extent(sb, start, next - start, e4b);
 
 			if (ret && ret != -EOPNOTSUPP)
-				break;
+				return count;
 			count += next - start;
 		}
 		free_count += next - start;
 		start = next + 1;
 
-		if (fatal_signal_pending(current)) {
-			count = -ERESTARTSYS;
-			break;
-		}
+		if (fatal_signal_pending(current))
+			return -ERESTARTSYS;
 
 		if (need_resched()) {
 			ext4_unlock_group(sb, e4b->bd_group);
@@ -6965,6 +6976,9 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 			break;
 	}
 
+	if (set_trimmed)
+		EXT4_MB_GRP_SET_TRIMMED(e4b->bd_info);
+
 	return count;
 }
 
@@ -6975,7 +6989,6 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
  * @start:		first group block to examine
  * @max:		last group block to examine
  * @minblocks:		minimum extent block count
- * @set_trimmed:	set the trimmed flag if at least one block is trimmed
  *
  * ext4_trim_all_free walks through group's block bitmap searching for free
  * extents. When the free extent is found, mark it as used in group buddy
@@ -6985,7 +6998,7 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 static ext4_grpblk_t
 ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 		   ext4_grpblk_t start, ext4_grpblk_t max,
-		   ext4_grpblk_t minblocks, bool set_trimmed)
+		   ext4_grpblk_t minblocks)
 {
 	struct ext4_buddy e4b;
 	int ret;
@@ -7002,13 +7015,10 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 	ext4_lock_group(sb, group);
 
 	if (!EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) ||
-	    minblocks < EXT4_SB(sb)->s_last_trim_minblks) {
+	    minblocks < EXT4_SB(sb)->s_last_trim_minblks)
 		ret = ext4_try_to_trim_range(sb, &e4b, start, max, minblocks);
-		if (ret >= 0 && set_trimmed)
-			EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
-	} else {
+	else
 		ret = 0;
-	}
 
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
@@ -7041,7 +7051,6 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 	ext4_fsblk_t first_data_blk =
 			le32_to_cpu(EXT4_SB(sb)->s_es->s_first_data_block);
 	ext4_fsblk_t max_blks = ext4_blocks_count(EXT4_SB(sb)->s_es);
-	bool whole_group, eof = false;
 	int ret = 0;
 
 	start = range->start >> sb->s_blocksize_bits;
@@ -7060,10 +7069,8 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 		if (minlen > EXT4_CLUSTERS_PER_GROUP(sb))
 			goto out;
 	}
-	if (end >= max_blks - 1) {
+	if (end >= max_blks - 1)
 		end = max_blks - 1;
-		eof = true;
-	}
 	if (end <= first_data_blk)
 		goto out;
 	if (start < first_data_blk)
@@ -7077,7 +7084,6 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 
 	/* end now represents the last cluster to discard in this group */
 	end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
-	whole_group = true;
 
 	for (group = first_group; group <= last_group; group++) {
 		grp = ext4_get_group_info(sb, group);
@@ -7096,13 +7102,11 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 		 * change it for the last group, note that last_cluster is
 		 * already computed earlier by ext4_get_group_no_and_offset()
 		 */
-		if (group == last_group) {
+		if (group == last_group)
 			end = last_cluster;
-			whole_group = eof ? true : end == EXT4_CLUSTERS_PER_GROUP(sb) - 1;
-		}
 		if (grp->bb_free >= minlen) {
 			cnt = ext4_trim_all_free(sb, group, first_cluster,
-						 end, minlen, whole_group);
+						 end, minlen);
 			if (cnt < 0) {
 				ret = cnt;
 				break;
-- 
2.40.1



