Return-Path: <stable+bounces-65537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88BE94A950
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FD7EB28473
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EB12BB0D;
	Wed,  7 Aug 2024 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GaYZtN+h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430FF2AF16
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039421; cv=none; b=MOh5taul0uUarq5QcYqOgZpQ0SRblpjOg9uV/CzKSruzCrYF0Ael8fWnCS2Khy0gt2JJ/gxFkZNJmVEOTvFwGA2wf3TRnVKzQ89ZE8ajgvZcwv3AvOEMLMhDT8ij/RMOwTE8sycOsf+Tq7Qg4cByJiBaebCPlKzStlkYOglxAwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039421; c=relaxed/simple;
	bh=YLfICH39S9Oyzzem2LTmzEkhHB+FcrjdcxZW70foA6k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j6wSm5CxXRfBedNUtsX91klm5kanZuEB2U/1xk8S8t3fg8oE43EYk2tyhyw0JDiU6vRt1qC7u8BG2JU0Dg2Tc+XIPKLAcS7BaUH2Xt0WnxmV26Yerzec0U7kX8UoOpq6lA0KTNno3ktKOlnmPKQ9PGdvGKaovMF4Igct4AwwtxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GaYZtN+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FC8C32781;
	Wed,  7 Aug 2024 14:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723039420;
	bh=YLfICH39S9Oyzzem2LTmzEkhHB+FcrjdcxZW70foA6k=;
	h=Subject:To:Cc:From:Date:From;
	b=GaYZtN+hZ18w8EHtWzuzIcyEtCx74cq5+unTgvcb/6qgjQGlr/MCdSgBYrKaKgKHR
	 POeX3+uqBbKCSg41nnP09sUUtEVGaGk4D9Lk5JuzzSv6t/xcRI33x9QEgu4iPEYLVe
	 dXj/iUN6HhxwzhSGs/e3/L0iJ96d24tJurGIDlw0=
Subject: FAILED: patch "[PATCH] btrfs: fix corruption after buffer fault in during direct IO" failed to apply to 6.1-stable tree
To: fdmanana@suse.com,dsterba@suse.com,hreitz@redhat.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:03:34 +0200
Message-ID: <2024080734-dripping-residence-d803@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 939b656bc8ab203fdbde26ccac22bcb7f0985be5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080734-dripping-residence-d803@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

939b656bc8ab ("btrfs: fix corruption after buffer fault in during direct IO append write")
9aa29a20b700 ("btrfs: move the direct IO code into its own file")
04ef7631bfa5 ("btrfs: cleanup duplicated parameters related to btrfs_create_dio_extent()")
9fec848b3a33 ("btrfs: cleanup duplicated parameters related to create_io_em()")
e9ea31fb5c1f ("btrfs: cleanup duplicated parameters related to btrfs_alloc_ordered_extent")
cdc627e65c7e ("btrfs: cleanup duplicated parameters related to can_nocow_file_extent_args")
c77a8c61002e ("btrfs: remove extent_map::block_start member")
e28b851ed9b2 ("btrfs: remove extent_map::block_len member")
4aa7b5d1784f ("btrfs: remove extent_map::orig_start member")
3f255ece2f1e ("btrfs: introduce extra sanity checks for extent maps")
3d2ac9922465 ("btrfs: introduce new members for extent_map")
87a6962f73b1 ("btrfs: export the expected file extent through can_nocow_extent()")
e8fe524da027 ("btrfs: rename extent_map::orig_block_len to disk_num_bytes")
8996f61ab9ff ("btrfs: move fiemap code into its own file")
56b7169f691c ("btrfs: use a btrfs_inode local variable at btrfs_sync_file()")
e641e323abb3 ("btrfs: pass a btrfs_inode to btrfs_wait_ordered_range()")
cef2daba4268 ("btrfs: pass a btrfs_inode to btrfs_fdatawrite_range()")
4e660ca3a98d ("btrfs: use a regular rb_root instead of cached rb_root for extent_map_tree")
7f5830bc964d ("btrfs: rename rb_root member of extent_map_tree from map to root")
f13e01b89daf ("btrfs: ensure fast fsync waits for ordered extents after a write failure")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 939b656bc8ab203fdbde26ccac22bcb7f0985be5 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Fri, 26 Jul 2024 11:12:52 +0100
Subject: [PATCH] btrfs: fix corruption after buffer fault in during direct IO
 append write

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

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c8568b1a61c4..75fa563e4cac 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -459,6 +459,7 @@ struct btrfs_file_private {
 	void *filldir_buf;
 	u64 last_index;
 	struct extent_state *llseek_cached_state;
+	bool fsync_skip_inode_lock;
 };
 
 static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *info)
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index f9fb2db6a1e4..67adbe9d294a 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -856,21 +856,37 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
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
+		 * If we have a synchronous write, we must make sure the fsync
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
@@ -897,10 +913,12 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
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
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 21381de906f6..9f10a9f23fcc 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1603,6 +1603,7 @@ static inline bool skip_inode_logging(const struct btrfs_log_ctx *ctx)
  */
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 {
+	struct btrfs_file_private *private = file->private_data;
 	struct dentry *dentry = file_dentry(file);
 	struct btrfs_inode *inode = BTRFS_I(d_inode(dentry));
 	struct btrfs_root *root = inode->root;
@@ -1612,6 +1613,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	int ret = 0, err;
 	u64 len;
 	bool full_sync;
+	const bool skip_ilock = (private ? private->fsync_skip_inode_lock : false);
 
 	trace_btrfs_sync_file(file, datasync);
 
@@ -1639,7 +1641,10 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	if (ret)
 		goto out;
 
-	btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
+	if (skip_ilock)
+		down_write(&inode->i_mmap_lock);
+	else
+		btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
 
 	atomic_inc(&root->log_batch);
 
@@ -1663,7 +1668,10 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 */
 	ret = start_ordered_ops(inode, start, end);
 	if (ret) {
-		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
+		if (skip_ilock)
+			up_write(&inode->i_mmap_lock);
+		else
+			btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 		goto out;
 	}
 
@@ -1788,7 +1796,10 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * file again, but that will end up using the synchronization
 	 * inside btrfs_sync_log to keep things safe.
 	 */
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
+	if (skip_ilock)
+		up_write(&inode->i_mmap_lock);
+	else
+		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 
 	if (ret == BTRFS_NO_LOG_SYNC) {
 		ret = btrfs_end_transaction(trans);


