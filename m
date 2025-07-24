Return-Path: <stable+bounces-164538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E4FB0FF00
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 04:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCFCD5468A8
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865A11C84B2;
	Thu, 24 Jul 2025 02:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iv+iLLH4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468C822097
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 02:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753325851; cv=none; b=K9HuCgVF/u1rcmcIbXr4RPVRgNxExE90xVUeZLU6mMI1KRgVdjqHiTZYBA/UIhGBgAkK2Z0Av05ARdd8//0KIgwPCuymr4ig5lZhtkHIzR+AESaUEveJ8EIc3443ou+8JYno2Bd9O8tKqaDYAVw8yYNNHJM83oHVfqBsp0gFV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753325851; c=relaxed/simple;
	bh=BvGza0N03sFQz7k/Jq+LmP29O3J6L0BJ+QZza5SNtcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jKvsiUn0EC//5RsvzZYKUwKueGwWnP4DkXoaNyc3UYqdn6/S8+aHdSOqaX53OkV8iCDPn3uo5dargfZwq+yAa3nNmO2flScMYACjFseMQVFUzaGvIJZ2Vvqi/VAK5M6JX0CS6UvGuyC2mlN7qFBw3ATiUZ88z+BdCBveXQBT8rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iv+iLLH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EF6C4CEEF;
	Thu, 24 Jul 2025 02:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753325851;
	bh=BvGza0N03sFQz7k/Jq+LmP29O3J6L0BJ+QZza5SNtcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iv+iLLH401FJ+30zS9lDQUrp+A9l7oZiSlvTaa876kRlWEEDq5PQyDJZ6ANf6cu34
	 ygS8bnP6fLF0bdiOSyZgzeZ16ABq3nxLxPQQbuxDPkt54n7nq9DD9fMOV4tSPNPUPj
	 52cg4JzhVg04vzGXF7VIZ2rP3CKHINmXmxBLxmwiYaOJMaYc4T61ojXOTTLM2ZL8Vg
	 LfM/vlQUtxNlqFNeCMGiZP0HUoKNeJhWS2Cnk2dCrpV5U8Y4M45IvRFpPZGtgnALbA
	 lEkBfm0qtD8v8aKRt/G4LCb9KZLQ3ofWs+MJypwguQXpob8gDxGDC8vLHrwROUj4gK
	 1fhrkhhEnZCRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 05/11] ext4: refactor ext4_insert_range()
Date: Wed, 23 Jul 2025 22:57:12 -0400
Message-Id: <20250724025718.1277650-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724025718.1277650-1-sashal@kernel.org>
References: <2025062009-junior-thriving-f882@gregkh>
 <20250724025718.1277650-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 49425504376c335c68f7be54ae7c32312afd9475 ]

Simplify ext4_insert_range() and align its code style with that of
ext4_collapse_range(). Refactor it by: a) renaming variables, b)
removing redundant input parameter checks and moving the remaining
checks under i_rwsem in preparation for future refactoring, and c)
renaming the three stale error tags.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/20241220011637.1157197-8-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 29ec9bed2395 ("ext4: fix incorrect punch max_end")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 101 ++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 53 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 54fbeba3a929d..961e7b634401d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5421,45 +5421,37 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	handle_t *handle;
 	struct ext4_ext_path *path;
 	struct ext4_extent *extent;
-	ext4_lblk_t offset_lblk, len_lblk, ee_start_lblk = 0;
+	ext4_lblk_t start_lblk, len_lblk, ee_start_lblk = 0;
 	unsigned int credits, ee_len;
-	int ret = 0, depth, split_flag = 0;
-	loff_t ioffset;
-
-	/*
-	 * We need to test this early because xfstests assumes that an
-	 * insert range of (0, 1) will return EOPNOTSUPP if the file
-	 * system does not support insert range.
-	 */
-	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		return -EOPNOTSUPP;
-
-	/* Insert range works only on fs cluster size aligned regions. */
-	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
-		return -EINVAL;
+	int ret, depth, split_flag = 0;
+	loff_t start;
 
 	trace_ext4_insert_range(inode, offset, len);
 
-	offset_lblk = offset >> EXT4_BLOCK_SIZE_BITS(sb);
-	len_lblk = len >> EXT4_BLOCK_SIZE_BITS(sb);
-
 	inode_lock(inode);
+
 	/* Currently just for extent based files */
 	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
 		ret = -EOPNOTSUPP;
-		goto out_mutex;
+		goto out;
 	}
 
-	/* Check whether the maximum file size would be exceeded */
-	if (len > inode->i_sb->s_maxbytes - inode->i_size) {
-		ret = -EFBIG;
-		goto out_mutex;
+	/* Insert range works only on fs cluster size aligned regions. */
+	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb))) {
+		ret = -EINVAL;
+		goto out;
 	}
 
 	/* Offset must be less than i_size */
 	if (offset >= inode->i_size) {
 		ret = -EINVAL;
-		goto out_mutex;
+		goto out;
+	}
+
+	/* Check whether the maximum file size would be exceeded */
+	if (len > inode->i_sb->s_maxbytes - inode->i_size) {
+		ret = -EFBIG;
+		goto out;
 	}
 
 	/* Wait for existing dio to complete */
@@ -5467,7 +5459,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 
 	ret = file_modified(file);
 	if (ret)
-		goto out_mutex;
+		goto out;
 
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
@@ -5477,25 +5469,24 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 
 	ret = ext4_break_layouts(inode);
 	if (ret)
-		goto out_mmap;
+		goto out_invalidate_lock;
 
 	/*
-	 * Need to round down to align start offset to page size boundary
-	 * for page size > block size.
+	 * Write out all dirty pages. Need to round down to align start offset
+	 * to page size boundary for page size > block size.
 	 */
-	ioffset = round_down(offset, PAGE_SIZE);
-	/* Write out all dirty pages */
-	ret = filemap_write_and_wait_range(inode->i_mapping, ioffset,
-			LLONG_MAX);
+	start = round_down(offset, PAGE_SIZE);
+	ret = filemap_write_and_wait_range(mapping, start, LLONG_MAX);
 	if (ret)
-		goto out_mmap;
-	truncate_pagecache(inode, ioffset);
+		goto out_invalidate_lock;
+
+	truncate_pagecache(inode, start);
 
 	credits = ext4_writepage_trans_blocks(inode);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
-		goto out_mmap;
+		goto out_invalidate_lock;
 	}
 	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
 
@@ -5504,16 +5495,19 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	EXT4_I(inode)->i_disksize += len;
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (ret)
-		goto out_stop;
+		goto out_handle;
+
+	start_lblk = offset >> inode->i_blkbits;
+	len_lblk = len >> inode->i_blkbits;
 
 	down_write(&EXT4_I(inode)->i_data_sem);
 	ext4_discard_preallocations(inode);
 
-	path = ext4_find_extent(inode, offset_lblk, NULL, 0);
+	path = ext4_find_extent(inode, start_lblk, NULL, 0);
 	if (IS_ERR(path)) {
 		up_write(&EXT4_I(inode)->i_data_sem);
 		ret = PTR_ERR(path);
-		goto out_stop;
+		goto out_handle;
 	}
 
 	depth = ext_depth(inode);
@@ -5523,16 +5517,16 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 		ee_len = ext4_ext_get_actual_len(extent);
 
 		/*
-		 * If offset_lblk is not the starting block of extent, split
-		 * the extent @offset_lblk
+		 * If start_lblk is not the starting block of extent, split
+		 * the extent @start_lblk
 		 */
-		if ((offset_lblk > ee_start_lblk) &&
-				(offset_lblk < (ee_start_lblk + ee_len))) {
+		if ((start_lblk > ee_start_lblk) &&
+				(start_lblk < (ee_start_lblk + ee_len))) {
 			if (ext4_ext_is_unwritten(extent))
 				split_flag = EXT4_EXT_MARK_UNWRIT1 |
 					EXT4_EXT_MARK_UNWRIT2;
 			path = ext4_split_extent_at(handle, inode, path,
-					offset_lblk, split_flag,
+					start_lblk, split_flag,
 					EXT4_EX_NOCACHE |
 					EXT4_GET_BLOCKS_PRE_IO |
 					EXT4_GET_BLOCKS_METADATA_NOFAIL);
@@ -5541,31 +5535,32 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 		if (IS_ERR(path)) {
 			up_write(&EXT4_I(inode)->i_data_sem);
 			ret = PTR_ERR(path);
-			goto out_stop;
+			goto out_handle;
 		}
 	}
 
 	ext4_free_ext_path(path);
-	ext4_es_remove_extent(inode, offset_lblk, EXT_MAX_BLOCKS - offset_lblk);
+	ext4_es_remove_extent(inode, start_lblk, EXT_MAX_BLOCKS - start_lblk);
 
 	/*
-	 * if offset_lblk lies in a hole which is at start of file, use
+	 * if start_lblk lies in a hole which is at start of file, use
 	 * ee_start_lblk to shift extents
 	 */
 	ret = ext4_ext_shift_extents(inode, handle,
-		max(ee_start_lblk, offset_lblk), len_lblk, SHIFT_RIGHT);
-
+		max(ee_start_lblk, start_lblk), len_lblk, SHIFT_RIGHT);
 	up_write(&EXT4_I(inode)->i_data_sem);
+	if (ret)
+		goto out_handle;
+
+	ext4_update_inode_fsync_trans(handle, inode, 1);
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
-	if (ret >= 0)
-		ext4_update_inode_fsync_trans(handle, inode, 1);
 
-out_stop:
+out_handle:
 	ext4_journal_stop(handle);
-out_mmap:
+out_invalidate_lock:
 	filemap_invalidate_unlock(mapping);
-out_mutex:
+out:
 	inode_unlock(inode);
 	return ret;
 }
-- 
2.39.5


