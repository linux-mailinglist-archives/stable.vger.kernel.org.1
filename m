Return-Path: <stable+bounces-203580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C81CE6F13
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76E3C3009105
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1718B1E51E0;
	Mon, 29 Dec 2025 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vITtnvlz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFA131960F
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016776; cv=none; b=nqt0aZninCv98wXMG2I51JUpDK6gVQTZFEPwKZDtHQ2Dsn5STxhdWtOeQYGXfpAEMAs3tbW0gUl5gxVdhXjJv0Chlv1f1AVnyL4ZUyaZ5YsK+8jTGmUE+oSWrozapD2w60lkOneykaXOB/CRSMe8Bg3xe85/noYixllrjjyfSoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016776; c=relaxed/simple;
	bh=QVQOWmBzPVEzPbVQu1EgQ40oVVjC683tyfhkDI3FVAg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NyCInnwv03jcMtsA11uYVlo4RjRpznHTTeDS8gQZ2W/+WGJ/tvR4TgNnhLR6LouvTlsQ6JCQQ6Bxr2X3OqJ6osiE8MJLQ0oCCb3kuK/kakUQJQigwtPgsqz0L0BkulEvH0DbvuiKkKcak4+M9P3I5xsSPo5UWWrcyeOa/om1Rpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vITtnvlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88FEC4CEF7;
	Mon, 29 Dec 2025 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767016776;
	bh=QVQOWmBzPVEzPbVQu1EgQ40oVVjC683tyfhkDI3FVAg=;
	h=Subject:To:Cc:From:Date:From;
	b=vITtnvlzJdnyRPSiGRRgKuG+/9zXvens7pik7Wl1ywIT6kRTx4Fgmug75TO12jaDQ
	 EoVgp8CLPGy+QFbCR/G/imWM+hUy07HrVrJkD50VgsmGMO9VVGixInfnQlQ8apw3Yy
	 i2s/q1YNIGSffxP9OTi4+wIRCrrfIAE9WStn9DXg=
Subject: FAILED: patch "[PATCH] f2fs: fix to avoid updating compression context during" failed to apply to 5.15-stable tree
To: chao@kernel.org,jaegeuk@kernel.org,sjb7183@psu.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 14:59:24 +0100
Message-ID: <2025122923-chip-convene-ab02@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 10b591e7fb7cdc8c1e53e9c000dc0ef7069aaa76
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122923-chip-convene-ab02@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 10b591e7fb7cdc8c1e53e9c000dc0ef7069aaa76 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Wed, 22 Oct 2025 11:06:36 +0800
Subject: [PATCH] f2fs: fix to avoid updating compression context during
 writeback

Bai, Shuangpeng <sjb7183@psu.edu> reported a bug as below:

Oops: divide error: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 11441 Comm: syz.0.46 Not tainted 6.17.0 #1 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:f2fs_all_cluster_page_ready+0x106/0x550 fs/f2fs/compress.c:857
Call Trace:
 <TASK>
 f2fs_write_cache_pages fs/f2fs/data.c:3078 [inline]
 __f2fs_write_data_pages fs/f2fs/data.c:3290 [inline]
 f2fs_write_data_pages+0x1c19/0x3600 fs/f2fs/data.c:3317
 do_writepages+0x38e/0x640 mm/page-writeback.c:2634
 filemap_fdatawrite_wbc mm/filemap.c:386 [inline]
 __filemap_fdatawrite_range mm/filemap.c:419 [inline]
 file_write_and_wait_range+0x2ba/0x3e0 mm/filemap.c:794
 f2fs_do_sync_file+0x6e6/0x1b00 fs/f2fs/file.c:294
 generic_write_sync include/linux/fs.h:3043 [inline]
 f2fs_file_write_iter+0x76e/0x2700 fs/f2fs/file.c:5259
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x7e9/0xe00 fs/read_write.c:686
 ksys_write+0x19d/0x2d0 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf7/0x470 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The bug was triggered w/ below race condition:

fsync				setattr			ioctl
- f2fs_do_sync_file
 - file_write_and_wait_range
  - f2fs_write_cache_pages
  : inode is non-compressed
  : cc.cluster_size =
    F2FS_I(inode)->i_cluster_size = 0
   - tag_pages_for_writeback
				- f2fs_setattr
				 - truncate_setsize
				 - f2fs_truncate
							- f2fs_fileattr_set
							 - f2fs_setflags_common
							  - set_compress_context
							  : F2FS_I(inode)->i_cluster_size = 4
							  : set_inode_flag(inode, FI_COMPRESSED_FILE)
   - f2fs_compressed_file
   : return true
   - f2fs_all_cluster_page_ready
   : "pgidx % cc->cluster_size" trigger dividing 0 issue

Let's change as below to fix this issue:
- introduce a new atomic type variable .writeback in structure f2fs_inode_info
to track the number of threads which calling f2fs_write_cache_pages().
- use .i_sem lock to protect .writeback update.
- check .writeback before update compression context in f2fs_setflags_common()
to avoid race w/ ->writepages.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Cc: stable@kernel.org
Reported-by: Bai, Shuangpeng <sjb7183@psu.edu>
Tested-by: Bai, Shuangpeng <sjb7183@psu.edu>
Closes: https://lore.kernel.org/lkml/44D8F7B3-68AD-425F-9915-65D27591F93F@psu.edu
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index eec691262fec..b92d362a02d6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3222,6 +3222,19 @@ static inline bool __should_serialize_io(struct inode *inode,
 	return false;
 }
 
+static inline void account_writeback(struct inode *inode, bool inc)
+{
+	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
+		return;
+
+	f2fs_down_read(&F2FS_I(inode)->i_sem);
+	if (inc)
+		atomic_inc(&F2FS_I(inode)->writeback);
+	else
+		atomic_dec(&F2FS_I(inode)->writeback);
+	f2fs_up_read(&F2FS_I(inode)->i_sem);
+}
+
 static int __f2fs_write_data_pages(struct address_space *mapping,
 						struct writeback_control *wbc,
 						enum iostat_type io_type)
@@ -3267,10 +3280,14 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 		locked = true;
 	}
 
+	account_writeback(inode, true);
+
 	blk_start_plug(&plug);
 	ret = f2fs_write_cache_pages(mapping, wbc, io_type);
 	blk_finish_plug(&plug);
 
+	account_writeback(inode, false);
+
 	if (locked)
 		mutex_unlock(&sbi->writepages);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 575f9666c3b7..e69b01c1173a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -947,6 +947,7 @@ struct f2fs_inode_info {
 	unsigned char i_compress_level;		/* compress level (lz4hc,zstd) */
 	unsigned char i_compress_flag;		/* compress flag */
 	unsigned int i_cluster_size;		/* cluster size */
+	atomic_t writeback;			/* count # of writeback thread */
 
 	unsigned int atomic_write_cnt;
 	loff_t original_i_size;		/* original i_size before atomic write */
@@ -4663,7 +4664,7 @@ static inline bool f2fs_disable_compressed_file(struct inode *inode)
 		f2fs_up_write(&fi->i_sem);
 		return true;
 	}
-	if (f2fs_is_mmap_file(inode) ||
+	if (f2fs_is_mmap_file(inode) || atomic_read(&fi->writeback) ||
 		(S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))) {
 		f2fs_up_write(&fi->i_sem);
 		return false;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c045e38e60ee..6d42e2d28861 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2128,8 +2128,9 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 
 			f2fs_down_write(&fi->i_sem);
 			if (!f2fs_may_compress(inode) ||
-					(S_ISREG(inode->i_mode) &&
-					F2FS_HAS_BLOCKS(inode))) {
+				atomic_read(&fi->writeback) ||
+				(S_ISREG(inode->i_mode) &&
+				F2FS_HAS_BLOCKS(inode))) {
 				f2fs_up_write(&fi->i_sem);
 				return -EINVAL;
 			}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index cb65ca90f9f6..d0b5791a1f8c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1759,6 +1759,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	atomic_set(&fi->dirty_pages, 0);
 	atomic_set(&fi->i_compr_blocks, 0);
 	atomic_set(&fi->open_count, 0);
+	atomic_set(&fi->writeback, 0);
 	init_f2fs_rwsem(&fi->i_sem);
 	spin_lock_init(&fi->i_size_lock);
 	INIT_LIST_HEAD(&fi->dirty_list);


