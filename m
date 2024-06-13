Return-Path: <stable+bounces-51715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E15907141
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F81281C0D
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FE61E519;
	Thu, 13 Jun 2024 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mE9hZs8l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCC8384;
	Thu, 13 Jun 2024 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282103; cv=none; b=qvjKnkZovrd3o1bG8EnWHWDOH2iu4dfPRwyp3GzxxB+SMCiw/alDfPnqTU4OXuio4SjZcH45k7VDOk7zr46IPfV//Rg7TyF0nQyWDYDE3ZCR/rP06SAo82PatbitKR4v46qkIU+1+WwksbpvsE4257OXe2cCUJpAwRYrAEwtvtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282103; c=relaxed/simple;
	bh=JIJ3euAQG7hFdGLreKh2Ye3RtvZ3k3RvQUZSCsMHYco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tw+1iAqzMBHwwLtKZc3QnybKEV2RREZ1svJ9FTS4gCgHUJAy0e10QvOAaA4GRgD+GCr2M83X923VO4/mLvJWA/Z6U69aX2Ii/yy0x5XTSnBWliEzyN4zgwNXtdAF4FbQOHi3T2hdVKIBGhRqTHcfqbApw4ci5i+RcswcGKKK1Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mE9hZs8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB927C2BBFC;
	Thu, 13 Jun 2024 12:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282103;
	bh=JIJ3euAQG7hFdGLreKh2Ye3RtvZ3k3RvQUZSCsMHYco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mE9hZs8l+6Kz2wpuEomdkN+yqdJ9CAKXRm3GfG2PIgWNrgzAK3eQY8MFROfr8TfpI
	 oCq919U8o0xpL8A5uB88jo7N2XUrMQ9Laf5Crb7DYQ/vGqCYH9jT0acYIFFGwhasU0
	 9//O1XWbD7gT4qfTtB8eQs2BY0Gj/wF417e5fSu0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Theodore Tso <tytso@mit.edu>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 164/402] ext4: try all groups in ext4_mb_new_blocks_simple
Date: Thu, 13 Jun 2024 13:32:01 +0200
Message-ID: <20240613113308.532857775@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kemeng Shi <shikemeng@huaweicloud.com>

[ Upstream commit 19a043bb1fd1b5cb2652ca33536c55e6c0a70df0 ]

ext4_mb_new_blocks_simple ignores the group before goal, so it will fail
if free blocks reside in group before goal. Try all groups to avoid
unexpected failure.
Search finishes either if any free block is found or if no available
blocks are found. Simpliy check "i >= max" to distinguish the above
cases.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Suggested-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://lore.kernel.org/r/20230603150327.3596033-8-shikemeng@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 3f4830abd236 ("ext4: fix potential unnitialized variable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 383703e20ea36..a346ab8f3e5f4 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5887,7 +5887,7 @@ static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
 	struct buffer_head *bitmap_bh;
 	struct super_block *sb = ar->inode->i_sb;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	ext4_group_t group;
+	ext4_group_t group, nr;
 	ext4_grpblk_t blkoff;
 	ext4_grpblk_t max = EXT4_CLUSTERS_PER_GROUP(sb);
 	ext4_grpblk_t i = 0;
@@ -5901,7 +5901,7 @@ static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
 
 	ar->len = 0;
 	ext4_get_group_no_and_offset(sb, goal, &group, &blkoff);
-	for (; group < ext4_get_groups_count(sb); group++) {
+	for (nr = ext4_get_groups_count(sb); nr > 0; nr--) {
 		bitmap_bh = ext4_read_block_bitmap(sb, group);
 		if (IS_ERR(bitmap_bh)) {
 			*errp = PTR_ERR(bitmap_bh);
@@ -5925,10 +5925,13 @@ static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
 		if (i < max)
 			break;
 
+		if (++group >= ext4_get_groups_count(sb))
+			group = 0;
+
 		blkoff = 0;
 	}
 
-	if (group >= ext4_get_groups_count(sb) || i >= max) {
+	if (i >= max) {
 		*errp = -ENOSPC;
 		return 0;
 	}
-- 
2.43.0




