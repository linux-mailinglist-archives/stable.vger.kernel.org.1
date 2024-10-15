Return-Path: <stable+bounces-86239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FBA99ED8E
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC765285231
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36C22296C4;
	Tue, 15 Oct 2024 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2jIqmIA5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E3A212640;
	Tue, 15 Oct 2024 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998241; cv=none; b=IqsKK3k7DbHmcWLJIm3CV2iNJgtzxuHV2LPWGkTYtJ6fc+iK3LgQGf2rSfNHO21dzolg0YwSF/KPuJiieazhEuvyyR+MP6ppx7H296FGaIlB9iYtVg1GKACZu3G12/W7/dCRbdGAisFYDYj74La1BALj7UqNWm0QQ4nN5RJEaqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998241; c=relaxed/simple;
	bh=I5nLxbA89vxUdK1u3quq9R8A7rkkQtxd5PiE6jvuB50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYsM2RIbrRhchB7VmpmJ5NGenVSWG8BlW4BKqb0MuNMcAdxPgAs13wG6/qYMR6V2C+F9MUWJ7O4TF/LagQTIg9alqZc9plCbkXuLAPWjsm5gtpNYfrWPis0IrGFUsajjZg38NLUvYJcaOGOc0+z2r0y7OxbjB2FrYFbmDhXmW6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2jIqmIA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3AAC4CEC6;
	Tue, 15 Oct 2024 13:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728998241;
	bh=I5nLxbA89vxUdK1u3quq9R8A7rkkQtxd5PiE6jvuB50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2jIqmIA5NMjqIvP7ExGPqtmiaVLNO4VeDGYEggu4jLrI6dKmJh6Y4tjFjQwxp1hZk
	 JduGMuMontieG37AhAj5Ig9kwJdH6CGV+08TI8fsFcS4YBdq7yLVQyz37wnbLjYuiy
	 E8ShnvsHUArJo92OJDye4qdwzD44uJdH3Jlw1IXM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Jan Kara <jack@suse.cz>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 420/518] ext4: properly sync file size update after O_SYNC direct IO
Date: Tue, 15 Oct 2024 14:45:24 +0200
Message-ID: <20241015123933.206968840@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

[ Upstream commit 91562895f8030cb9a0470b1db49de79346a69f91 ]

Gao Xiang has reported that on ext4 O_SYNC direct IO does not properly
sync file size update and thus if we crash at unfortunate moment, the
file can have smaller size although O_SYNC IO has reported successful
completion. The problem happens because update of on-disk inode size is
handled in ext4_dio_write_iter() *after* iomap_dio_rw() (and thus
dio_complete() in particular) has returned and generic_file_sync() gets
called by dio_complete(). Fix the problem by handling on-disk inode size
update directly in our ->end_io completion handler.

References: https://lore.kernel.org/all/02d18236-26ef-09b0-90ad-030c4fe3ee20@linux.alibaba.com
Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: stable@vger.kernel.org
Fixes: 378f32bab371 ("ext4: introduce direct I/O write using iomap infrastructure")
Signed-off-by: Jan Kara <jack@suse.cz>
Tested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reviewed-by: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Link: https://lore.kernel.org/r/20231013121350.26872-1-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: dda898d7ffe8 ("ext4: dax: fix overflowing extents beyond inode size when partially writing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/file.c | 153 +++++++++++++++++++++----------------------------
 1 file changed, 65 insertions(+), 88 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index f42cc1fe0ba1d..15f45499f491a 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -280,80 +280,38 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 }
 
 static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
-					   ssize_t written, size_t count)
+					   ssize_t count)
 {
 	handle_t *handle;
-	bool truncate = false;
-	u8 blkbits = inode->i_blkbits;
-	ext4_lblk_t written_blk, end_blk;
-	int ret;
-
-	/*
-	 * Note that EXT4_I(inode)->i_disksize can get extended up to
-	 * inode->i_size while the I/O was running due to writeback of delalloc
-	 * blocks. But, the code in ext4_iomap_alloc() is careful to use
-	 * zeroed/unwritten extents if this is possible; thus we won't leave
-	 * uninitialized blocks in a file even if we didn't succeed in writing
-	 * as much as we intended.
-	 */
-	WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize);
-	if (offset + count <= EXT4_I(inode)->i_disksize) {
-		/*
-		 * We need to ensure that the inode is removed from the orphan
-		 * list if it has been added prematurely, due to writeback of
-		 * delalloc blocks.
-		 */
-		if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
-			handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
-
-			if (IS_ERR(handle)) {
-				ext4_orphan_del(NULL, inode);
-				return PTR_ERR(handle);
-			}
-
-			ext4_orphan_del(handle, inode);
-			ext4_journal_stop(handle);
-		}
-
-		return written;
-	}
-
-	if (written < 0)
-		goto truncate;
 
+	lockdep_assert_held_write(&inode->i_rwsem);
 	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
-	if (IS_ERR(handle)) {
-		written = PTR_ERR(handle);
-		goto truncate;
-	}
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
 
-	if (ext4_update_inode_size(inode, offset + written)) {
-		ret = ext4_mark_inode_dirty(handle, inode);
+	if (ext4_update_inode_size(inode, offset + count)) {
+		int ret = ext4_mark_inode_dirty(handle, inode);
 		if (unlikely(ret)) {
-			written = ret;
 			ext4_journal_stop(handle);
-			goto truncate;
+			return ret;
 		}
 	}
 
-	/*
-	 * We may need to truncate allocated but not written blocks beyond EOF.
-	 */
-	written_blk = ALIGN(offset + written, 1 << blkbits);
-	end_blk = ALIGN(offset + count, 1 << blkbits);
-	if (written_blk < end_blk && ext4_can_truncate(inode))
-		truncate = true;
-
-	/*
-	 * Remove the inode from the orphan list if it has been extended and
-	 * everything went OK.
-	 */
-	if (!truncate && inode->i_nlink)
+	if (inode->i_nlink)
 		ext4_orphan_del(handle, inode);
 	ext4_journal_stop(handle);
 
-	if (truncate) {
-truncate:
+	return count;
+}
+
+/*
+ * Clean up the inode after DIO or DAX extending write has completed and the
+ * inode size has been updated using ext4_handle_inode_extension().
+ */
+static void ext4_inode_extension_cleanup(struct inode *inode, ssize_t count)
+{
+	lockdep_assert_held_write(&inode->i_rwsem);
+	if (count < 0) {
 		ext4_truncate_failed_write(inode);
 		/*
 		 * If the truncate operation failed early, then the inode may
@@ -362,9 +320,28 @@ static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
 		 */
 		if (inode->i_nlink)
 			ext4_orphan_del(NULL, inode);
+		return;
 	}
+	/*
+	 * If i_disksize got extended due to writeback of delalloc blocks while
+	 * the DIO was running we could fail to cleanup the orphan list in
+	 * ext4_handle_inode_extension(). Do it now.
+	 */
+	if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
+		handle_t *handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
 
-	return written;
+		if (IS_ERR(handle)) {
+			/*
+			 * The write has successfully completed. Not much to
+			 * do with the error here so just cleanup the orphan
+			 * list and hope for the best.
+			 */
+			ext4_orphan_del(NULL, inode);
+			return;
+		}
+		ext4_orphan_del(handle, inode);
+		ext4_journal_stop(handle);
+	}
 }
 
 static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
@@ -373,31 +350,22 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
 	loff_t pos = iocb->ki_pos;
 	struct inode *inode = file_inode(iocb->ki_filp);
 
+	if (!error && size && flags & IOMAP_DIO_UNWRITTEN)
+		error = ext4_convert_unwritten_extents(NULL, inode, pos, size);
 	if (error)
 		return error;
-
-	if (size && flags & IOMAP_DIO_UNWRITTEN) {
-		error = ext4_convert_unwritten_extents(NULL, inode, pos, size);
-		if (error < 0)
-			return error;
-	}
 	/*
-	 * If we are extending the file, we have to update i_size here before
-	 * page cache gets invalidated in iomap_dio_rw(). Otherwise racing
-	 * buffered reads could zero out too much from page cache pages. Update
-	 * of on-disk size will happen later in ext4_dio_write_iter() where
-	 * we have enough information to also perform orphan list handling etc.
-	 * Note that we perform all extending writes synchronously under
-	 * i_rwsem held exclusively so i_size update is safe here in that case.
-	 * If the write was not extending, we cannot see pos > i_size here
-	 * because operations reducing i_size like truncate wait for all
-	 * outstanding DIO before updating i_size.
+	 * Note that EXT4_I(inode)->i_disksize can get extended up to
+	 * inode->i_size while the I/O was running due to writeback of delalloc
+	 * blocks. But the code in ext4_iomap_alloc() is careful to use
+	 * zeroed/unwritten extents if this is possible; thus we won't leave
+	 * uninitialized blocks in a file even if we didn't succeed in writing
+	 * as much as we intended.
 	 */
-	pos += size;
-	if (pos > i_size_read(inode))
-		i_size_write(inode, pos);
-
-	return 0;
+	WARN_ON_ONCE(i_size_read(inode) < READ_ONCE(EXT4_I(inode)->i_disksize));
+	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize))
+		return size;
+	return ext4_handle_inode_extension(inode, pos, size);
 }
 
 static const struct iomap_dio_ops ext4_dio_write_ops = {
@@ -572,9 +540,16 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			   is_sync_kiocb(iocb) || unaligned_io || extend);
 	if (ret == -ENOTBLK)
 		ret = 0;
-
-	if (extend)
-		ret = ext4_handle_inode_extension(inode, offset, ret, count);
+	if (extend) {
+		/*
+		 * We always perform extending DIO write synchronously so by
+		 * now the IO is completed and ext4_handle_inode_extension()
+		 * was called. Cleanup the inode in case of error or race with
+		 * writeback of delalloc blocks.
+		 */
+		WARN_ON_ONCE(ret == -EIOCBQUEUED);
+		ext4_inode_extension_cleanup(inode, ret);
+	}
 
 out:
 	if (ilock_shared)
@@ -655,8 +630,10 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
 
-	if (extend)
-		ret = ext4_handle_inode_extension(inode, offset, ret, count);
+	if (extend) {
+		ret = ext4_handle_inode_extension(inode, offset, ret);
+		ext4_inode_extension_cleanup(inode, ret);
+	}
 out:
 	inode_unlock(inode);
 	if (ret > 0)
-- 
2.43.0




