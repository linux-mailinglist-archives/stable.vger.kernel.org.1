Return-Path: <stable+bounces-164539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8463AB0FF01
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 04:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534841C86E6A
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEBA1CEACB;
	Thu, 24 Jul 2025 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTKL52j9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8A622097
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 02:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753325853; cv=none; b=jbX8ID1nRCh2Aqh8rUI0RtF9aBHykshoKIXQf/CQ5XRKdOdY6+MyKKXydDli9VHK8zjzXHc/LOwfISIeYWJk7eTa8X8NZjWEWeqwuXy+X/cRL5Yc6fgs89P+zk4ncrhjH9CdjFSz/p4ptLgqmDtp9Cpyb5q9kU7Feh6JRj18LMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753325853; c=relaxed/simple;
	bh=2utx718+aomX8+nDE9qVHD40gPaMbiWf71yXvq5Nc8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h7I2Np9VkBrpCO8nn9px0i/2bAdsLxIl9iov+KQb6Fcif4tERZ5Wsm+eDA41m6TTUXJ+AHtLNdXuJchQQ/p96PkcVoFSelYn9OGIEhX0lIo/f0+ub1JdrXSbtYqo6o2gEcSPggCi5leQkB0J0Gswn5vcIOncHvpAXiLUdcKX37M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTKL52j9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C93C4CEE7;
	Thu, 24 Jul 2025 02:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753325852;
	bh=2utx718+aomX8+nDE9qVHD40gPaMbiWf71yXvq5Nc8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTKL52j93v2UkavWxs+524aW+n6RFWcCW6NeU1YQGU3m7OXjN1Peh8jqaxVjDe5zJ
	 bJLQJRN5h9FO3y1JzDDknYo+RxbI6BwT5YU3+MBKyhrwQHdI0VoRPr7Al44UxJF/Y3
	 Fc8DfQKG3o/NO/xkVPdw238fUblnqUlvHxSO0FWv0g8nyC6yoTMbZ6Um0BC9lhwY4k
	 OYDsPfnYkQi69aItng44fv87VwuKa7Q0dJhG1RUxnJ3lVvBxercYm1HOyZLQDIQyAq
	 YHiiMrxiYKUmUVgE+jvPytZbBIRI5cmv7RtbDXvHZT4GamtUCDP7YbZ5LfU4VVEJ3D
	 xCY5vgBZImrcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 06/11] ext4: factor out ext4_do_fallocate()
Date: Wed, 23 Jul 2025 22:57:13 -0400
Message-Id: <20250724025718.1277650-6-sashal@kernel.org>
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

[ Upstream commit fd2f764826df5489b849a8937b5a093aae5b1816 ]

Now the real job of normal fallocate are open coded in ext4_fallocate(),
factor out a new helper ext4_do_fallocate() to do the real job, like
others functions (e.g. ext4_zero_range()) in ext4_fallocate() do, this
can make the code more clear, no functional changes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/20241220011637.1157197-9-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 29ec9bed2395 ("ext4: fix incorrect punch max_end")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 125 ++++++++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 65 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 961e7b634401d..eb58f7a1ab5aa 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4690,6 +4690,58 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	return ret;
 }
 
+static long ext4_do_fallocate(struct file *file, loff_t offset,
+			      loff_t len, int mode)
+{
+	struct inode *inode = file_inode(file);
+	loff_t end = offset + len;
+	loff_t new_size = 0;
+	ext4_lblk_t start_lblk, len_lblk;
+	int ret;
+
+	trace_ext4_fallocate_enter(inode, offset, len, mode);
+
+	start_lblk = offset >> inode->i_blkbits;
+	len_lblk = EXT4_MAX_BLOCKS(len, offset, inode->i_blkbits);
+
+	inode_lock(inode);
+
+	/* We only support preallocation for extent-based files only. */
+	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
+	    (end > inode->i_size || end > EXT4_I(inode)->i_disksize)) {
+		new_size = end;
+		ret = inode_newsize_ok(inode, new_size);
+		if (ret)
+			goto out;
+	}
+
+	/* Wait all existing dio workers, newcomers will block on i_rwsem */
+	inode_dio_wait(inode);
+
+	ret = file_modified(file);
+	if (ret)
+		goto out;
+
+	ret = ext4_alloc_file_blocks(file, start_lblk, len_lblk, new_size,
+				     EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
+	if (ret)
+		goto out;
+
+	if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal) {
+		ret = ext4_fc_commit(EXT4_SB(inode->i_sb)->s_journal,
+					EXT4_I(inode)->i_sync_tid);
+	}
+out:
+	inode_unlock(inode);
+	trace_ext4_fallocate_exit(inode, offset, len_lblk, ret);
+	return ret;
+}
+
 /*
  * preallocate space for a file. This implements ext4's fallocate file
  * operation, which gets called from sys_fallocate system call.
@@ -4700,12 +4752,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
 	struct inode *inode = file_inode(file);
-	loff_t new_size = 0;
-	unsigned int max_blocks;
-	int ret = 0;
-	int flags;
-	ext4_lblk_t lblk;
-	unsigned int blkbits = inode->i_blkbits;
+	int ret;
 
 	/*
 	 * Encrypted inodes can't handle collapse range or insert
@@ -4727,71 +4774,19 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	ret = ext4_convert_inline_data(inode);
 	inode_unlock(inode);
 	if (ret)
-		goto exit;
+		return ret;
 
-	if (mode & FALLOC_FL_PUNCH_HOLE) {
+	if (mode & FALLOC_FL_PUNCH_HOLE)
 		ret = ext4_punch_hole(file, offset, len);
-		goto exit;
-	}
-
-	if (mode & FALLOC_FL_COLLAPSE_RANGE) {
+	else if (mode & FALLOC_FL_COLLAPSE_RANGE)
 		ret = ext4_collapse_range(file, offset, len);
-		goto exit;
-	}
-
-	if (mode & FALLOC_FL_INSERT_RANGE) {
+	else if (mode & FALLOC_FL_INSERT_RANGE)
 		ret = ext4_insert_range(file, offset, len);
-		goto exit;
-	}
-
-	if (mode & FALLOC_FL_ZERO_RANGE) {
+	else if (mode & FALLOC_FL_ZERO_RANGE)
 		ret = ext4_zero_range(file, offset, len, mode);
-		goto exit;
-	}
-	trace_ext4_fallocate_enter(inode, offset, len, mode);
-	lblk = offset >> blkbits;
-
-	max_blocks = EXT4_MAX_BLOCKS(len, offset, blkbits);
-	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
-
-	inode_lock(inode);
-
-	/*
-	 * We only support preallocation for extent-based files only
-	 */
-	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
-	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
-	    (offset + len > inode->i_size ||
-	     offset + len > EXT4_I(inode)->i_disksize)) {
-		new_size = offset + len;
-		ret = inode_newsize_ok(inode, new_size);
-		if (ret)
-			goto out;
-	}
-
-	/* Wait all existing dio workers, newcomers will block on i_rwsem */
-	inode_dio_wait(inode);
-
-	ret = file_modified(file);
-	if (ret)
-		goto out;
-
-	ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size, flags);
-	if (ret)
-		goto out;
+	else
+		ret = ext4_do_fallocate(file, offset, len, mode);
 
-	if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal) {
-		ret = ext4_fc_commit(EXT4_SB(inode->i_sb)->s_journal,
-					EXT4_I(inode)->i_sync_tid);
-	}
-out:
-	inode_unlock(inode);
-	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
-exit:
 	return ret;
 }
 
-- 
2.39.5


