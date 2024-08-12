Return-Path: <stable+bounces-67356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC2594F50A
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4AF91F2178A
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9016183CD4;
	Mon, 12 Aug 2024 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b051yga6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963E715C127;
	Mon, 12 Aug 2024 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480659; cv=none; b=VC/CQSy8l6snftjOoM70Jtk5Gqz9Tk2E2Dll4/6StWZDO1YX8s4qlS3VUbBK8OP9dZvG16UxyH2gL2WkEpd2cwBKYxpE7XQuSPZmWMX18dQ68lGADNOVm0atp/MLDLf09mlpczaXKFra+cEzsTG1HM3F2ztaCo7c3FQ9yq+CM8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480659; c=relaxed/simple;
	bh=fFMwOJlvKWtyMLiowEU0VvROkjht7lY/mSQuHlNB5CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQqLt6hi3kEXqEffVuuZCOP7iyAKZdEowjlYr+lRC8+O0rmkHh7sHsdF3MjjXavg74F6zubXO3ddvgW5Mm4weY6F6mExVu6q9uzwlhtECNulHhSelsfg37urA0n1vzxMqqziNhDxZdWDkOLWqSpNz92wIl+AY8Cgnm+BT9ELMZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b051yga6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D66C32782;
	Mon, 12 Aug 2024 16:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723480659;
	bh=fFMwOJlvKWtyMLiowEU0VvROkjht7lY/mSQuHlNB5CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b051yga6g02CAHZY5I+jc0UXXaOrqedMpriGMSxV7sC19xxgI6qjPsUA+Og/UyuWi
	 CaiKwqoYH8s0yQ0vYe2NCIUGuy8w23ruv+XW2JAruPUw6wBqlFSDtOLQgsvlW1Shsu
	 12nzA5O7xy09IEOsT1taHQ5ov+gzxoTP95wOOZJg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hanna Czenczek <hreitz@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.10 253/263] btrfs: fix corruption after buffer fault in during direct IO append write
Date: Mon, 12 Aug 2024 18:04:14 +0200
Message-ID: <20240812160156.229078170@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160146.517184156@linuxfoundation.org>
References: <20240812160146.517184156@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 939b656bc8ab203fdbde26ccac22bcb7f0985be5 upstream.

During an append (O_APPEND write flag) direct IO write if the input buffer
was not previously faulted in, we can corrupt the file in a way that the
final size is unexpected and it includes an unexpected hole.

The problem happens like this:

1) We have an empty file, with size 0, for example;

2) We do an O_APPEND direct IO with a length of 4096 bytes and the input
   buffer is not currently faulted in;

3) We enter btrfs_direct_write(), lock the inode and call
   generic_write_checks(), which calls generic_write_checks_count(), and
   that function sets the iocb position to 0 with the following code:

	if (iocb->ki_flags & IOCB_APPEND)
		iocb->ki_pos = i_size_read(inode);

4) We call btrfs_dio_write() and enter into iomap, which will end up
   calling btrfs_dio_iomap_begin() and that calls
   btrfs_get_blocks_direct_write(), where we update the i_size of the
   inode to 4096 bytes;

5) After btrfs_dio_iomap_begin() returns, iomap will attempt to access
   the page of the write input buffer (at iomap_dio_bio_iter(), with a
   call to bio_iov_iter_get_pages()) and fail with -EFAULT, which gets
   returned to btrfs at btrfs_direct_write() via btrfs_dio_write();

6) At btrfs_direct_write() we get the -EFAULT error, unlock the inode,
   fault in the write buffer and then goto to the label 'relock';

7) We lock again the inode, do all the necessary checks again and call
   again generic_write_checks(), which calls generic_write_checks_count()
   again, and there we set the iocb's position to 4K, which is the current
   i_size of the inode, with the following code pointed above:

        if (iocb->ki_flags & IOCB_APPEND)
                iocb->ki_pos = i_size_read(inode);

8) Then we go again to btrfs_dio_write() and enter iomap and the write
   succeeds, but it wrote to the file range [4K, 8K), leaving a hole in
   the [0, 4K) range and an i_size of 8K, which goes against the
   expectations of having the data written to the range [0, 4K) and get an
   i_size of 4K.

Fix this by not unlocking the inode before faulting in the input buffer,
in case we get -EFAULT or an incomplete write, and not jumping to the
'relock' label after faulting in the buffer - instead jump to a location
immediately before calling iomap, skipping all the write checks and
relocking. This solves this problem and it's fine even in case the input
buffer is memory mapped to the same file range, since only holding the
range locked in the inode's io tree can cause a deadlock, it's safe to
keep the inode lock (VFS lock), as was fixed and described in commit
51bd9563b678 ("btrfs: fix deadlock due to page faults during direct IO
reads and writes").

A sample reproducer provided by a reporter is the following:

   $ cat test.c
   #ifndef _GNU_SOURCE
   #define _GNU_SOURCE
   #endif

   #include <fcntl.h>
   #include <stdio.h>
   #include <sys/mman.h>
   #include <sys/stat.h>
   #include <unistd.h>

   int main(int argc, char *argv[])
   {
       if (argc < 2) {
           fprintf(stderr, "Usage: %s <test file>\n", argv[0]);
           return 1;
       }

       int fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT |
                     O_APPEND, 0644);
       if (fd < 0) {
           perror("creating test file");
           return 1;
       }

       char *buf = mmap(NULL, 4096, PROT_READ,
                        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
       ssize_t ret = write(fd, buf, 4096);
       if (ret < 0) {
           perror("pwritev2");
           return 1;
       }

       struct stat stbuf;
       ret = fstat(fd, &stbuf);
       if (ret < 0) {
           perror("stat");
           return 1;
       }

       printf("size: %llu\n", (unsigned long long)stbuf.st_size);
       return stbuf.st_size == 4096 ? 0 : 1;
   }

A test case for fstests will be sent soon.

Reported-by: Hanna Czenczek <hreitz@redhat.com>
Link: https://lore.kernel.org/linux-btrfs/0b841d46-12fe-4e64-9abb-871d8d0de271@redhat.com/
Fixes: 8184620ae212 ("btrfs: fix lost file sync on direct IO write with nowait and dsync iocb")
CC: stable@vger.kernel.org # 6.1+
Tested-by: Hanna Czenczek <hreitz@redhat.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ctree.h |    1 +
 fs/btrfs/file.c  |   55 ++++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 43 insertions(+), 13 deletions(-)

--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -457,6 +457,7 @@ struct btrfs_file_private {
 	void *filldir_buf;
 	u64 last_index;
 	struct extent_state *llseek_cached_state;
+	bool fsync_skip_inode_lock;
 };
 
 static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *info)
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1550,21 +1550,37 @@ relock:
 	 * So here we disable page faults in the iov_iter and then retry if we
 	 * got -EFAULT, faulting in the pages before the retry.
 	 */
+again:
 	from->nofault = true;
 	dio = btrfs_dio_write(iocb, from, written);
 	from->nofault = false;
 
-	/*
-	 * iomap_dio_complete() will call btrfs_sync_file() if we have a dsync
-	 * iocb, and that needs to lock the inode. So unlock it before calling
-	 * iomap_dio_complete() to avoid a deadlock.
-	 */
-	btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
-
-	if (IS_ERR_OR_NULL(dio))
+	if (IS_ERR_OR_NULL(dio)) {
 		ret = PTR_ERR_OR_ZERO(dio);
-	else
+	} else {
+		struct btrfs_file_private stack_private = { 0 };
+		struct btrfs_file_private *private;
+		const bool have_private = (file->private_data != NULL);
+
+		if (!have_private)
+			file->private_data = &stack_private;
+
+		/*
+		 * If we have a synchoronous write, we must make sure the fsync
+		 * triggered by the iomap_dio_complete() call below doesn't
+		 * deadlock on the inode lock - we are already holding it and we
+		 * can't call it after unlocking because we may need to complete
+		 * partial writes due to the input buffer (or parts of it) not
+		 * being already faulted in.
+		 */
+		private = file->private_data;
+		private->fsync_skip_inode_lock = true;
 		ret = iomap_dio_complete(dio);
+		private->fsync_skip_inode_lock = false;
+
+		if (!have_private)
+			file->private_data = NULL;
+	}
 
 	/* No increment (+=) because iomap returns a cumulative value. */
 	if (ret > 0)
@@ -1591,10 +1607,12 @@ relock:
 		} else {
 			fault_in_iov_iter_readable(from, left);
 			prev_left = left;
-			goto relock;
+			goto again;
 		}
 	}
 
+	btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
+
 	/*
 	 * If 'ret' is -ENOTBLK or we have not written all data, then it means
 	 * we must fallback to buffered IO.
@@ -1793,6 +1811,7 @@ static inline bool skip_inode_logging(co
  */
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 {
+	struct btrfs_file_private *private = file->private_data;
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = d_inode(dentry);
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
@@ -1802,6 +1821,7 @@ int btrfs_sync_file(struct file *file, l
 	int ret = 0, err;
 	u64 len;
 	bool full_sync;
+	const bool skip_ilock = (private ? private->fsync_skip_inode_lock : false);
 
 	trace_btrfs_sync_file(file, datasync);
 
@@ -1829,7 +1849,10 @@ int btrfs_sync_file(struct file *file, l
 	if (ret)
 		goto out;
 
-	btrfs_inode_lock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
+	if (skip_ilock)
+		down_write(&BTRFS_I(inode)->i_mmap_lock);
+	else
+		btrfs_inode_lock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
 
 	atomic_inc(&root->log_batch);
 
@@ -1853,7 +1876,10 @@ int btrfs_sync_file(struct file *file, l
 	 */
 	ret = start_ordered_ops(inode, start, end);
 	if (ret) {
-		btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
+		if (skip_ilock)
+			up_write(&BTRFS_I(inode)->i_mmap_lock);
+		else
+			btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
 		goto out;
 	}
 
@@ -1982,7 +2008,10 @@ int btrfs_sync_file(struct file *file, l
 	 * file again, but that will end up using the synchronization
 	 * inside btrfs_sync_log to keep things safe.
 	 */
-	btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
+	if (skip_ilock)
+		up_write(&BTRFS_I(inode)->i_mmap_lock);
+	else
+		btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
 
 	if (ret == BTRFS_NO_LOG_SYNC) {
 		ret = btrfs_end_transaction(trans);



