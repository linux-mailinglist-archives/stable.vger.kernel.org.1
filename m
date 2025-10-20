Return-Path: <stable+bounces-188252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C372BF3805
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 22:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52F124F91B2
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 20:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2A62E2825;
	Mon, 20 Oct 2025 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3FwBTVs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9322D63FF
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993492; cv=none; b=hnYdBVyop+W+WJZGXvrtdjaHKqGm4YA3lne6os9Sdv3gnb1+1tEmv8HiVLzPqfVZ8aGBifGb0nS8rKYAoCg5lP37m+4u2kCWQkNf+zQyaHNri0lhxbm85OWw9Gxl9tBOdRZFJTn+wCCIKWZEZ6kX1BZfb3YlM9Qbgpa6GTa0tvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993492; c=relaxed/simple;
	bh=paFBVqWIqM5ZQX7Xp5XvsaCi48Md90Mr09Z59JPHcu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCD7XXAc/jKa4dDbaJZoIagGHAtuB+i4v5qhIFw/Q2Zqe9/8mfZwvB2gwQsvqFvUpLXC8DL5QWTXbYa572VtsbRao//lQTPh0/RPtOw7yaoGUF6TEgAXHrQjybMF5U9f2otYYIiPbeYKlq5PkQjSyeVgHXwjL4L8VsDVltZHRiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3FwBTVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58497C116C6;
	Mon, 20 Oct 2025 20:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760993492;
	bh=paFBVqWIqM5ZQX7Xp5XvsaCi48Md90Mr09Z59JPHcu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o3FwBTVsgQq4xYHFt+OYWunti7TsqJ87SG5UnP9Ol2U9AuePudoUdynrpKfWBW74d
	 hFNNJzjvEmgnvHN43Nki3onMMogwRzeikhAj4u2GDGgy97AuJculaVXrg0L/3YKsYH
	 cQ88Fkzc725o2MU7SF5A9jUewOjTvftE2qWehAcHlf0xTV2p7vBOBtVaYBloyyAfQY
	 emmgUMJ9Ygx+MlLrE9Gg7qu+52ZBTUp7IGJqzmXDQZ93rgGU8q7H/+tkc/mipmraPU
	 y+CSE4w+8e8nWFP7xBWsUutkUM6AW8UqPS9h+DIwROZpGxIs6ysib+7Lcg/U2Vux6W
	 2RjBZZLzLNvhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] f2fs: remove the create argument to f2fs_map_blocks
Date: Mon, 20 Oct 2025 16:51:26 -0400
Message-ID: <20251020205128.1912678-2-sashal@kernel.org>
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

[ Upstream commit cd8fc5226bef3a1fda13a0e61794a039ca46744a ]

The create argument is always identicaly to map->m_may_create, so use
that consistently.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 9d5c4f5c7a2c ("f2fs: fix wrong block mapping for multi-devices")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c              | 63 ++++++++++++++++---------------------
 fs/f2fs/f2fs.h              |  3 +-
 fs/f2fs/file.c              | 12 +++----
 include/trace/events/f2fs.h | 11 +++----
 4 files changed, 38 insertions(+), 51 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e1df8241ebd1e..75c1af00c6892 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1464,8 +1464,7 @@ int f2fs_get_block_locked(struct dnode_of_data *dn, pgoff_t index)
  * maps continuous logical blocks to physical blocks, and return such
  * info via f2fs_map_blocks structure.
  */
-int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
-						int create, int flag)
+int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 {
 	unsigned int maxblocks = map->m_len;
 	struct dnode_of_data dn;
@@ -1494,38 +1493,31 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	pgofs =	(pgoff_t)map->m_lblk;
 	end = pgofs + maxblocks;
 
-	if (!create && f2fs_lookup_read_extent_cache(inode, pgofs, &ei)) {
-		if (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO &&
-							map->m_may_create)
-			goto next_dnode;
+	if (map->m_may_create ||
+	    !f2fs_lookup_read_extent_cache(inode, pgofs, &ei))
+		goto next_dnode;
 
-		map->m_pblk = ei.blk + pgofs - ei.fofs;
-		map->m_len = min((pgoff_t)maxblocks, ei.fofs + ei.len - pgofs);
-		map->m_flags = F2FS_MAP_MAPPED;
-		if (map->m_next_extent)
-			*map->m_next_extent = pgofs + map->m_len;
+	/* Found the map in read extent cache */
+	map->m_pblk = ei.blk + pgofs - ei.fofs;
+	map->m_len = min((pgoff_t)maxblocks, ei.fofs + ei.len - pgofs);
+	map->m_flags = F2FS_MAP_MAPPED;
+	if (map->m_next_extent)
+		*map->m_next_extent = pgofs + map->m_len;
 
-		/* for hardware encryption, but to avoid potential issue in future */
-		if (flag == F2FS_GET_BLOCK_DIO)
-			f2fs_wait_on_block_writeback_range(inode,
+	/* for hardware encryption, but to avoid potential issue in future */
+	if (flag == F2FS_GET_BLOCK_DIO)
+		f2fs_wait_on_block_writeback_range(inode,
 						map->m_pblk, map->m_len);
 
-		if (map->m_multidev_dio) {
-			block_t blk_addr = map->m_pblk;
-
-			bidx = f2fs_target_device_index(sbi, map->m_pblk);
+	if (map->m_multidev_dio) {
+		bidx = f2fs_target_device_index(sbi, map->m_pblk);
 
-			map->m_bdev = FDEV(bidx).bdev;
-			map->m_pblk -= FDEV(bidx).start_blk;
-			map->m_len = min(map->m_len,
+		map->m_bdev = FDEV(bidx).bdev;
+		map->m_pblk -= FDEV(bidx).start_blk;
+		map->m_len = min(map->m_len,
 				FDEV(bidx).end_blk + 1 - map->m_pblk);
-
-			if (map->m_may_create)
-				f2fs_update_device_state(sbi, inode->i_ino,
-							blk_addr, map->m_len);
-		}
-		goto out;
 	}
+	goto out;
 
 next_dnode:
 	if (map->m_may_create)
@@ -1589,7 +1581,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 			set_inode_flag(inode, FI_APPEND_WRITE);
 		}
 	} else {
-		if (create) {
+		if (map->m_may_create) {
 			if (unlikely(f2fs_cp_error(sbi))) {
 				err = -EIO;
 				goto sync_out;
@@ -1764,7 +1756,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		f2fs_balance_fs(sbi, dn.node_changed);
 	}
 out:
-	trace_f2fs_map_blocks(inode, map, create, flag, err);
+	trace_f2fs_map_blocks(inode, map, flag, err);
 	return err;
 }
 
@@ -1786,7 +1778,7 @@ bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
 
 	while (map.m_lblk < last_lblk) {
 		map.m_len = last_lblk - map.m_lblk;
-		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_DEFAULT);
+		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DEFAULT);
 		if (err || map.m_len == 0)
 			return false;
 		map.m_lblk += map.m_len;
@@ -1960,7 +1952,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		map.m_len = cluster_size - count_in_cluster;
 	}
 
-	ret = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_FIEMAP);
+	ret = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_FIEMAP);
 	if (ret)
 		goto out;
 
@@ -2093,7 +2085,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	map->m_lblk = block_in_file;
 	map->m_len = last_block - block_in_file;
 
-	ret = f2fs_map_blocks(inode, map, 0, F2FS_GET_BLOCK_DEFAULT);
+	ret = f2fs_map_blocks(inode, map, F2FS_GET_BLOCK_DEFAULT);
 	if (ret)
 		goto out;
 got_it:
@@ -3850,7 +3842,7 @@ static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 		map.m_next_pgofs = NULL;
 		map.m_seg_type = NO_CHECK_TYPE;
 
-		if (!f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_BMAP))
+		if (!f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_BMAP))
 			blknr = map.m_pblk;
 	}
 out:
@@ -3958,7 +3950,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 		map.m_seg_type = NO_CHECK_TYPE;
 		map.m_may_create = false;
 
-		ret = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_FIEMAP);
+		ret = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_FIEMAP);
 		if (ret)
 			goto out;
 
@@ -4187,8 +4179,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (flags & IOMAP_WRITE)
 		map.m_may_create = true;
 
-	err = f2fs_map_blocks(inode, &map, flags & IOMAP_WRITE,
-			      F2FS_GET_BLOCK_DIO);
+	err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DIO);
 	if (err)
 		return err;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index db7ecd55b732e..d8a32a02bcbc4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3794,8 +3794,7 @@ struct page *f2fs_get_lock_data_page(struct inode *inode, pgoff_t index,
 struct page *f2fs_get_new_data_page(struct inode *inode,
 			struct page *ipage, pgoff_t index, bool new_i_size);
 int f2fs_do_write_data_page(struct f2fs_io_info *fio);
-int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
-			int create, int flag);
+int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			u64 start, u64 len);
 int f2fs_encrypt_one_page(struct f2fs_io_info *fio);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f34692864ed11..7411416fa51ee 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1800,7 +1800,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 		f2fs_unlock_op(sbi);
 
 		map.m_seg_type = CURSEG_COLD_DATA_PINNED;
-		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_DIO);
+		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_PRE_DIO);
 		file_dont_truncate(inode);
 
 		f2fs_up_write(&sbi->pin_sem);
@@ -1813,7 +1813,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 
 		map.m_len = expanded;
 	} else {
-		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
+		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_PRE_AIO);
 		expanded = map.m_len;
 	}
 out_err:
@@ -2710,7 +2710,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	 */
 	while (map.m_lblk < pg_end) {
 		map.m_len = pg_end - map.m_lblk;
-		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_DEFAULT);
+		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DEFAULT);
 		if (err)
 			goto out;
 
@@ -2757,7 +2757,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 
 do_map:
 		map.m_len = pg_end - map.m_lblk;
-		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_DEFAULT);
+		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DEFAULT);
 		if (err)
 			goto clear_out;
 
@@ -3352,7 +3352,7 @@ int f2fs_precache_extents(struct inode *inode)
 		map.m_len = end - map.m_lblk;
 
 		f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
-		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_PRECACHE);
+		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_PRECACHE);
 		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 		if (err)
 			return err;
@@ -4635,7 +4635,7 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 		flag = F2FS_GET_BLOCK_PRE_AIO;
 	}
 
-	ret = f2fs_map_blocks(inode, &map, 1, flag);
+	ret = f2fs_map_blocks(inode, &map, flag);
 	/* -ENOSPC|-EDQUOT are fine to report the number of allocated blocks. */
 	if (ret < 0 && !((ret == -ENOSPC || ret == -EDQUOT) && map.m_len > 0))
 		return ret;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 9f0883e9ab3eb..e341ea2fc9794 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -564,10 +564,10 @@ TRACE_EVENT(f2fs_file_write_iter,
 );
 
 TRACE_EVENT(f2fs_map_blocks,
-	TP_PROTO(struct inode *inode, struct f2fs_map_blocks *map,
-				int create, int flag, int ret),
+	TP_PROTO(struct inode *inode, struct f2fs_map_blocks *map, int flag,
+		 int ret),
 
-	TP_ARGS(inode, map, create, flag, ret),
+	TP_ARGS(inode, map, flag, ret),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
@@ -579,7 +579,6 @@ TRACE_EVENT(f2fs_map_blocks,
 		__field(int,	m_seg_type)
 		__field(bool,	m_may_create)
 		__field(bool,	m_multidev_dio)
-		__field(int,	create)
 		__field(int,	flag)
 		__field(int,	ret)
 	),
@@ -594,7 +593,6 @@ TRACE_EVENT(f2fs_map_blocks,
 		__entry->m_seg_type	= map->m_seg_type;
 		__entry->m_may_create	= map->m_may_create;
 		__entry->m_multidev_dio	= map->m_multidev_dio;
-		__entry->create		= create;
 		__entry->flag		= flag;
 		__entry->ret		= ret;
 	),
@@ -602,7 +600,7 @@ TRACE_EVENT(f2fs_map_blocks,
 	TP_printk("dev = (%d,%d), ino = %lu, file offset = %llu, "
 		"start blkaddr = 0x%llx, len = 0x%llx, flags = %u, "
 		"seg_type = %d, may_create = %d, multidevice = %d, "
-		"create = %d, flag = %d, err = %d",
+		"flag = %d, err = %d",
 		show_dev_ino(__entry),
 		(unsigned long long)__entry->m_lblk,
 		(unsigned long long)__entry->m_pblk,
@@ -611,7 +609,6 @@ TRACE_EVENT(f2fs_map_blocks,
 		__entry->m_seg_type,
 		__entry->m_may_create,
 		__entry->m_multidev_dio,
-		__entry->create,
 		__entry->flag,
 		__entry->ret)
 );
-- 
2.51.0


