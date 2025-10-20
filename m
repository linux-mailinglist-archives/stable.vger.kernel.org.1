Return-Path: <stable+bounces-188253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A16BF3808
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 22:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804B51895896
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 20:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417C22E0415;
	Mon, 20 Oct 2025 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbTFCDz8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C6C2D63FF
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993493; cv=none; b=LLyTEDSnmuvKYOdpupL1r9aL/h5hDSmKTPPO1mb+gSsrk9SapasUQE9YRjbkm5h59Sr7wMPZaDbocZ39KbJbTcgfpWivfoj8wjl+MhFNua3AqDduxajwYkQBxlr5LzJZsG8kBZEqtjFT/O+t9imhixi8P26dezEyvEynMZgBl3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993493; c=relaxed/simple;
	bh=2by6wNmHZE15GcXv4V7ekpNvmTGdJfdUWCRbsW94gbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IC1h/CqGsEMlZjtUSGYJ5wFdNo6wPBuQAfKG0n26u3sfo3WfHt01I2/2JObQGkOjaa8xN7nD9N++wmk7RbLTDJwZSqvx6IStNuEukGA1pXGiroUFrnkyP1fZMK6ms9uQuD9gLkAOtpnpTbUG+fe9xtnDt+s8NBMKXmTY0ak4Raw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbTFCDz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D876C116D0;
	Mon, 20 Oct 2025 20:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760993492;
	bh=2by6wNmHZE15GcXv4V7ekpNvmTGdJfdUWCRbsW94gbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JbTFCDz87eEBfr98EJ0jTxugRNMXpQeixh0pudxZlyCEwjDI8nzQwb/x77mck7QDd
	 CdZwfi38xUV/Xx5R0JGgBe2LIsr21ogp/KKF9pW2C9CZ6iu86lwZ3wou04hZUFi+8U
	 vrH6+vY9D16IG2OTtZLhzTZPC1tIHPnKAdyY4c1Vggos8Bf1fffs/xh80yPTquQ4Sr
	 gBUFbPrry6YtAcBqkx20yNQSf3V+EJeN5xY7bQeS3NQeYSaKTEugSeKyQvoSXrPoJb
	 DIEyvTMBMqV9v2+2uzX6i6WW3NaQ8Yq+ipESBrQazKcI3TfkDP+dYyLhUFAh+DttpA
	 k4bOuVWu2d0QQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] f2fs: factor a f2fs_map_blocks_cached helper
Date: Mon, 20 Oct 2025 16:51:27 -0400
Message-ID: <20251020205128.1912678-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020205128.1912678-1-sashal@kernel.org>
References: <2025102052-work-collected-f03f@gregkh>
 <20251020205128.1912678-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 0094e98bd1477a6b7d97c25b47b19a7317c35279 ]

Add a helper to deal with everything needed to return a f2fs_map_blocks
structure based on a lookup in the extent cache.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 9d5c4f5c7a2c ("f2fs: fix wrong block mapping for multi-devices")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 65 +++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 75c1af00c6892..dc1ffdcbae889 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1459,6 +1459,41 @@ int f2fs_get_block_locked(struct dnode_of_data *dn, pgoff_t index)
 	return err;
 }
 
+static bool f2fs_map_blocks_cached(struct inode *inode,
+		struct f2fs_map_blocks *map, int flag)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	unsigned int maxblocks = map->m_len;
+	pgoff_t pgoff = (pgoff_t)map->m_lblk;
+	struct extent_info ei = {};
+
+	if (!f2fs_lookup_read_extent_cache(inode, pgoff, &ei))
+		return false;
+
+	map->m_pblk = ei.blk + pgoff - ei.fofs;
+	map->m_len = min((pgoff_t)maxblocks, ei.fofs + ei.len - pgoff);
+	map->m_flags = F2FS_MAP_MAPPED;
+	if (map->m_next_extent)
+		*map->m_next_extent = pgoff + map->m_len;
+
+	/* for hardware encryption, but to avoid potential issue in future */
+	if (flag == F2FS_GET_BLOCK_DIO)
+		f2fs_wait_on_block_writeback_range(inode,
+					map->m_pblk, map->m_len);
+
+	if (f2fs_allow_multi_device_dio(sbi, flag)) {
+		int bidx = f2fs_target_device_index(sbi, map->m_pblk);
+		struct f2fs_dev_info *dev = &sbi->devs[bidx];
+
+		map->m_bdev = dev->bdev;
+		map->m_pblk -= dev->start_blk;
+		map->m_len = min(map->m_len, dev->end_blk + 1 - map->m_pblk);
+	} else {
+		map->m_bdev = inode->i_sb->s_bdev;
+	}
+	return true;
+}
+
 /*
  * f2fs_map_blocks() tries to find or build mapping relationship which
  * maps continuous logical blocks to physical blocks, and return such
@@ -1474,7 +1509,6 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	int err = 0, ofs = 1;
 	unsigned int ofs_in_node, last_ofs_in_node;
 	blkcnt_t prealloc;
-	struct extent_info ei = {0, };
 	block_t blkaddr;
 	unsigned int start_pgofs;
 	int bidx = 0;
@@ -1482,6 +1516,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	if (!maxblocks)
 		return 0;
 
+	if (!map->m_may_create && f2fs_map_blocks_cached(inode, map, flag))
+		goto out;
+
 	map->m_bdev = inode->i_sb->s_bdev;
 	map->m_multidev_dio =
 		f2fs_allow_multi_device_dio(F2FS_I_SB(inode), flag);
@@ -1493,32 +1530,6 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	pgofs =	(pgoff_t)map->m_lblk;
 	end = pgofs + maxblocks;
 
-	if (map->m_may_create ||
-	    !f2fs_lookup_read_extent_cache(inode, pgofs, &ei))
-		goto next_dnode;
-
-	/* Found the map in read extent cache */
-	map->m_pblk = ei.blk + pgofs - ei.fofs;
-	map->m_len = min((pgoff_t)maxblocks, ei.fofs + ei.len - pgofs);
-	map->m_flags = F2FS_MAP_MAPPED;
-	if (map->m_next_extent)
-		*map->m_next_extent = pgofs + map->m_len;
-
-	/* for hardware encryption, but to avoid potential issue in future */
-	if (flag == F2FS_GET_BLOCK_DIO)
-		f2fs_wait_on_block_writeback_range(inode,
-						map->m_pblk, map->m_len);
-
-	if (map->m_multidev_dio) {
-		bidx = f2fs_target_device_index(sbi, map->m_pblk);
-
-		map->m_bdev = FDEV(bidx).bdev;
-		map->m_pblk -= FDEV(bidx).start_blk;
-		map->m_len = min(map->m_len,
-				FDEV(bidx).end_blk + 1 - map->m_pblk);
-	}
-	goto out;
-
 next_dnode:
 	if (map->m_may_create)
 		f2fs_do_map_lock(sbi, flag, true);
-- 
2.51.0


