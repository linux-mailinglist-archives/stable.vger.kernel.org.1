Return-Path: <stable+bounces-165369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E6EB15CF0
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 641907B38DA
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6FA280033;
	Wed, 30 Jul 2025 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="av4Mx7KS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF67E276058;
	Wed, 30 Jul 2025 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868852; cv=none; b=kbK9+pNBZf7dykxZYcoMiqY8O35wL4wHZtX0fUOLXCiHTmF8lSwJYG3Boyj5gd8LtynUZGWBGLohbJvoGu/wcSCw3mkBJLQhJqSXj1e1v8sqb0zUvxiIeWElHhh1VAGXTP7zlicv1Af2+gvW3aowmPTV6GBZ3cWi9lrw6RNVKWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868852; c=relaxed/simple;
	bh=EI/hIrdyOUVsOGpC40jnBIAZy+QB5cndkl0jTVHdIjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzxuNxc/YdtPMOVqsoIH7rJ1obqHOqwtrjaXaPF+FTo47EhVqQeWLLjlgny5OJWNFJW+cNpG7/ORvV0MtirV48v73PBsuNu+SblQVJObdvpvj1H1Z2wRZ13blWU3y/Qnyp2UKveoqS/VB62MuY15sT3pkIahqhKEl1xvyFQVEdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=av4Mx7KS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDB5C4CEF5;
	Wed, 30 Jul 2025 09:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753868852;
	bh=EI/hIrdyOUVsOGpC40jnBIAZy+QB5cndkl0jTVHdIjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=av4Mx7KSY8fYlFZXTMvN+fuPTVHN1QYG65+V7LN1YcktqDxdHZ/vUicHoC84CtKVg
	 jiQ3nTnaIkcyoEC2C0ejAf57Siyd7v3Dd3bw5uDf6zDw/YiF4Rqf8ZkssQ/vAQJC1J
	 HY/kXPQdmsqhtc6AqN6h3WuljdGjXxcp61OhjYas=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 092/117] ext4: move out common parts into ext4_fallocate()
Date: Wed, 30 Jul 2025 11:36:01 +0200
Message-ID: <20250730093237.370598132@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730093233.592541778@linuxfoundation.org>
References: <20250730093233.592541778@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 2890e5e0f49e10f3dadc5f7b7ea434e3e77e12a6 ]

Currently, all zeroing ranges, punch holes, collapse ranges, and insert
ranges first wait for all existing direct I/O workers to complete, and
then they acquire the mapping's invalidate lock before performing the
actual work. These common components are nearly identical, so we can
simplify the code by factoring them out into the ext4_fallocate().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/20241220011637.1157197-11-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 29ec9bed2395 ("ext4: fix incorrect punch max_end")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/extents.c |  124 ++++++++++++++++++------------------------------------
 fs/ext4/inode.c   |   25 +---------
 2 files changed, 45 insertions(+), 104 deletions(-)

--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4569,7 +4569,6 @@ static long ext4_zero_range(struct file
 			    loff_t len, int mode)
 {
 	struct inode *inode = file_inode(file);
-	struct address_space *mapping = file->f_mapping;
 	handle_t *handle = NULL;
 	loff_t new_size = 0;
 	loff_t end = offset + len;
@@ -4593,23 +4592,6 @@ static long ext4_zero_range(struct file
 			return ret;
 	}
 
-	/* Wait all existing dio workers, newcomers will block on i_rwsem */
-	inode_dio_wait(inode);
-
-	ret = file_modified(file);
-	if (ret)
-		return ret;
-
-	/*
-	 * Prevent page faults from reinstantiating pages we have released
-	 * from page cache.
-	 */
-	filemap_invalidate_lock(mapping);
-
-	ret = ext4_break_layouts(inode);
-	if (ret)
-		goto out_invalidate_lock;
-
 	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
 	/* Preallocate the range including the unaligned edges */
 	if (!IS_ALIGNED(offset | end, blocksize)) {
@@ -4619,17 +4601,17 @@ static long ext4_zero_range(struct file
 		ret = ext4_alloc_file_blocks(file, alloc_lblk, len_lblk,
 					     new_size, flags);
 		if (ret)
-			goto out_invalidate_lock;
+			return ret;
 	}
 
 	ret = ext4_update_disksize_before_punch(inode, offset, len);
 	if (ret)
-		goto out_invalidate_lock;
+		return ret;
 
 	/* Now release the pages and zero block aligned part of pages */
 	ret = ext4_truncate_page_cache_block_range(inode, offset, end);
 	if (ret)
-		goto out_invalidate_lock;
+		return ret;
 
 	/* Zero range excluding the unaligned edges */
 	start_lblk = EXT4_B_TO_LBLK(inode, offset);
@@ -4641,11 +4623,11 @@ static long ext4_zero_range(struct file
 		ret = ext4_alloc_file_blocks(file, start_lblk, zero_blks,
 					     new_size, flags);
 		if (ret)
-			goto out_invalidate_lock;
+			return ret;
 	}
 	/* Finish zeroing out if it doesn't contain partial block */
 	if (IS_ALIGNED(offset | end, blocksize))
-		goto out_invalidate_lock;
+		return ret;
 
 	/*
 	 * In worst case we have to writeout two nonadjacent unwritten
@@ -4658,7 +4640,7 @@ static long ext4_zero_range(struct file
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
 		ext4_std_error(inode->i_sb, ret);
-		goto out_invalidate_lock;
+		return ret;
 	}
 
 	/* Zero out partial block at the edges of the range */
@@ -4678,8 +4660,6 @@ static long ext4_zero_range(struct file
 
 out_handle:
 	ext4_journal_stop(handle);
-out_invalidate_lock:
-	filemap_invalidate_unlock(mapping);
 	return ret;
 }
 
@@ -4712,13 +4692,6 @@ static long ext4_do_fallocate(struct fil
 			goto out;
 	}
 
-	/* Wait all existing dio workers, newcomers will block on i_rwsem */
-	inode_dio_wait(inode);
-
-	ret = file_modified(file);
-	if (ret)
-		goto out;
-
 	ret = ext4_alloc_file_blocks(file, start_lblk, len_lblk, new_size,
 				     EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
 	if (ret)
@@ -4743,6 +4716,7 @@ out:
 long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
 	struct inode *inode = file_inode(file);
+	struct address_space *mapping = file->f_mapping;
 	int ret;
 
 	/*
@@ -4766,6 +4740,29 @@ long ext4_fallocate(struct file *file, i
 	if (ret)
 		goto out_inode_lock;
 
+	/* Wait all existing dio workers, newcomers will block on i_rwsem */
+	inode_dio_wait(inode);
+
+	ret = file_modified(file);
+	if (ret)
+		return ret;
+
+	if ((mode & FALLOC_FL_MODE_MASK) == FALLOC_FL_ALLOCATE_RANGE) {
+		ret = ext4_do_fallocate(file, offset, len, mode);
+		goto out_inode_lock;
+	}
+
+	/*
+	 * Follow-up operations will drop page cache, hold invalidate lock
+	 * to prevent page faults from reinstantiating pages we have
+	 * released from page cache.
+	 */
+	filemap_invalidate_lock(mapping);
+
+	ret = ext4_break_layouts(inode);
+	if (ret)
+		goto out_invalidate_lock;
+
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		ret = ext4_punch_hole(file, offset, len);
 	else if (mode & FALLOC_FL_COLLAPSE_RANGE)
@@ -4775,7 +4772,10 @@ long ext4_fallocate(struct file *file, i
 	else if (mode & FALLOC_FL_ZERO_RANGE)
 		ret = ext4_zero_range(file, offset, len, mode);
 	else
-		ret = ext4_do_fallocate(file, offset, len, mode);
+		ret = -EOPNOTSUPP;
+
+out_invalidate_lock:
+	filemap_invalidate_unlock(mapping);
 out_inode_lock:
 	inode_unlock(inode);
 	return ret;
@@ -5297,23 +5297,6 @@ static int ext4_collapse_range(struct fi
 	if (end >= inode->i_size)
 		return -EINVAL;
 
-	/* Wait for existing dio to complete */
-	inode_dio_wait(inode);
-
-	ret = file_modified(file);
-	if (ret)
-		return ret;
-
-	/*
-	 * Prevent page faults from reinstantiating pages we have released from
-	 * page cache.
-	 */
-	filemap_invalidate_lock(mapping);
-
-	ret = ext4_break_layouts(inode);
-	if (ret)
-		goto out_invalidate_lock;
-
 	/*
 	 * Write tail of the last page before removed range and data that
 	 * will be shifted since they will get removed from the page cache
@@ -5327,16 +5310,15 @@ static int ext4_collapse_range(struct fi
 	if (!ret)
 		ret = filemap_write_and_wait_range(mapping, end, LLONG_MAX);
 	if (ret)
-		goto out_invalidate_lock;
+		return ret;
 
 	truncate_pagecache(inode, start);
 
 	credits = ext4_writepage_trans_blocks(inode);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
-	if (IS_ERR(handle)) {
-		ret = PTR_ERR(handle);
-		goto out_invalidate_lock;
-	}
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
 	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
 
 	start_lblk = offset >> inode->i_blkbits;
@@ -5375,8 +5357,6 @@ static int ext4_collapse_range(struct fi
 
 out_handle:
 	ext4_journal_stop(handle);
-out_invalidate_lock:
-	filemap_invalidate_unlock(mapping);
 	return ret;
 }
 
@@ -5417,23 +5397,6 @@ static int ext4_insert_range(struct file
 	if (len > inode->i_sb->s_maxbytes - inode->i_size)
 		return -EFBIG;
 
-	/* Wait for existing dio to complete */
-	inode_dio_wait(inode);
-
-	ret = file_modified(file);
-	if (ret)
-		return ret;
-
-	/*
-	 * Prevent page faults from reinstantiating pages we have released from
-	 * page cache.
-	 */
-	filemap_invalidate_lock(mapping);
-
-	ret = ext4_break_layouts(inode);
-	if (ret)
-		goto out_invalidate_lock;
-
 	/*
 	 * Write out all dirty pages. Need to round down to align start offset
 	 * to page size boundary for page size > block size.
@@ -5441,16 +5404,15 @@ static int ext4_insert_range(struct file
 	start = round_down(offset, PAGE_SIZE);
 	ret = filemap_write_and_wait_range(mapping, start, LLONG_MAX);
 	if (ret)
-		goto out_invalidate_lock;
+		return ret;
 
 	truncate_pagecache(inode, start);
 
 	credits = ext4_writepage_trans_blocks(inode);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
-	if (IS_ERR(handle)) {
-		ret = PTR_ERR(handle);
-		goto out_invalidate_lock;
-	}
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
 	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
 
 	/* Expand file to avoid data loss if there is error while shifting */
@@ -5521,8 +5483,6 @@ static int ext4_insert_range(struct file
 
 out_handle:
 	ext4_journal_stop(handle);
-out_invalidate_lock:
-	filemap_invalidate_unlock(mapping);
 	return ret;
 }
 
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3992,7 +3992,6 @@ int ext4_punch_hole(struct file *file, l
 	struct inode *inode = file_inode(file);
 	struct super_block *sb = inode->i_sb;
 	ext4_lblk_t start_lblk, end_lblk;
-	struct address_space *mapping = inode->i_mapping;
 	loff_t max_end = EXT4_SB(sb)->s_bitmap_maxbytes - sb->s_blocksize;
 	loff_t end = offset + length;
 	handle_t *handle;
@@ -4027,31 +4026,15 @@ int ext4_punch_hole(struct file *file, l
 			return ret;
 	}
 
-	/* Wait all existing dio workers, newcomers will block on i_rwsem */
-	inode_dio_wait(inode);
-
-	ret = file_modified(file);
-	if (ret)
-		return ret;
-
-	/*
-	 * Prevent page faults from reinstantiating pages we have released from
-	 * page cache.
-	 */
-	filemap_invalidate_lock(mapping);
-
-	ret = ext4_break_layouts(inode);
-	if (ret)
-		goto out_invalidate_lock;
 
 	ret = ext4_update_disksize_before_punch(inode, offset, length);
 	if (ret)
-		goto out_invalidate_lock;
+		return ret;
 
 	/* Now release the pages and zero block aligned part of pages*/
 	ret = ext4_truncate_page_cache_block_range(inode, offset, end);
 	if (ret)
-		goto out_invalidate_lock;
+		return ret;
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		credits = ext4_writepage_trans_blocks(inode);
@@ -4061,7 +4044,7 @@ int ext4_punch_hole(struct file *file, l
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
 		ext4_std_error(sb, ret);
-		goto out_invalidate_lock;
+		return ret;
 	}
 
 	ret = ext4_zero_partial_blocks(handle, inode, offset, length);
@@ -4106,8 +4089,6 @@ int ext4_punch_hole(struct file *file, l
 		ext4_handle_sync(handle);
 out_handle:
 	ext4_journal_stop(handle);
-out_invalidate_lock:
-	filemap_invalidate_unlock(mapping);
 	return ret;
 }
 



