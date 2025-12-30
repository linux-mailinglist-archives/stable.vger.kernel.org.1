Return-Path: <stable+bounces-204253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 172E7CEA463
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 18:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E54C303E64C
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 17:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D2C32E750;
	Tue, 30 Dec 2025 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTujy8ce"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C476232E13E
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767114346; cv=none; b=OXRMi4NMgV/ZzfhCsV+jqSUHHluxbL38HgTa1XCgS5Y7R2bfmPViL0IX9y5DFTNinOQ3uWr4k0N2q/N2/6IX5rrAtOhuHhmxmlKk+IFktAI0I3JjxYCyIYsunXJFlk45h+hX6P3mL9kwur+3tTqVg8Idy701AIR4IGEJIhSIzLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767114346; c=relaxed/simple;
	bh=FhS8EhANtrBrtnK4G+P3xN1LEDhzcv2EqD8kcbl5sc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6dmmn7dqeYluU4MO4zhXoWiluEuhXiMjpwnm4ESECupxlFhOwzMt/juXGVnVud3pdFue6RDsjeGVcedMOzjGwLB8aXCvjzWZlGJs/QIOfiLI6oUeUcFxbHv5PPUAwrIELC7+VKuPynEIhVqX2cwqZ4ISL3XtXI7vltJMfwx0TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTujy8ce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA38C4CEFB;
	Tue, 30 Dec 2025 17:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767114346;
	bh=FhS8EhANtrBrtnK4G+P3xN1LEDhzcv2EqD8kcbl5sc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WTujy8cezv3n/KQ/RZUWoqYezvisMilWxj51M9o60UmFnjoAMU2ve0zGbl3HMHetK
	 XoT06qpTpMnRC5ZowzrlFONUMcwzOlxYOKpwUGtzRvEu0zyjUG84NZ9MFGelS0xwM2
	 Dk+tL6gROcn3iStyIXWDOdHyzPIk7K8d1Dz3EKjhh1TRDz+98pAzaxAb18KdGcDPQy
	 LnKfgdk8zDykj15VwtrypMsMnzEx8KNJGgHOvq+RdfsUeXEnzN1db3fPoB/RJMjBdQ
	 bq5RVy80TdaSQ8hxljAlr5Ihf3spFNwe1FWcHml/M5v9Gh8wecak/AGf0Vq97eK2Ko
	 eRmgA+VhWBUfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	"Bai, Shuangpeng" <sjb7183@psu.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] f2fs: fix to avoid updating compression context during writeback
Date: Tue, 30 Dec 2025 12:05:40 -0500
Message-ID: <20251230170540.2336679-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230170540.2336679-1-sashal@kernel.org>
References: <2025122922-tyke-slip-919d@gregkh>
 <20251230170540.2336679-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 10b591e7fb7cdc8c1e53e9c000dc0ef7069aaa76 ]

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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c  | 17 +++++++++++++++++
 fs/f2fs/f2fs.h  |  3 ++-
 fs/f2fs/file.c  |  5 +++--
 fs/f2fs/super.c |  1 +
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f5252f3e840a..c863e27fd846 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3233,6 +3233,19 @@ static inline bool __should_serialize_io(struct inode *inode,
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
@@ -3282,10 +3295,14 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
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
index 4b295671df8b..b45f7ce568e6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -863,6 +863,7 @@ struct f2fs_inode_info {
 	unsigned char i_compress_level;		/* compress level (lz4hc,zstd) */
 	unsigned char i_compress_flag;		/* compress flag */
 	unsigned int i_cluster_size;		/* cluster size */
+	atomic_t writeback;			/* count # of writeback thread */
 
 	unsigned int atomic_write_cnt;
 	loff_t original_i_size;		/* original i_size before atomic write */
@@ -4480,7 +4481,7 @@ static inline bool f2fs_disable_compressed_file(struct inode *inode)
 		f2fs_up_write(&F2FS_I(inode)->i_sem);
 		return true;
 	}
-	if (f2fs_is_mmap_file(inode) ||
+	if (f2fs_is_mmap_file(inode) || atomic_read(&fi->writeback) ||
 		(S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))) {
 		f2fs_up_write(&F2FS_I(inode)->i_sem);
 		return false;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7bdf0da5ba69..8cc0b7f5c35d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2042,8 +2042,9 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 
 			f2fs_down_write(&F2FS_I(inode)->i_sem);
 			if (!f2fs_may_compress(inode) ||
-					(S_ISREG(inode->i_mode) &&
-					F2FS_HAS_BLOCKS(inode))) {
+				atomic_read(&fi->writeback) ||
+				(S_ISREG(inode->i_mode) &&
+				F2FS_HAS_BLOCKS(inode))) {
 				f2fs_up_write(&F2FS_I(inode)->i_sem);
 				return -EINVAL;
 			}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0523e21fa951..30b57755ceef 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1410,6 +1410,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	atomic_set(&fi->dirty_pages, 0);
 	atomic_set(&fi->i_compr_blocks, 0);
 	atomic_set(&fi->open_count, 0);
+	atomic_set(&fi->writeback, 0);
 	init_f2fs_rwsem(&fi->i_sem);
 	spin_lock_init(&fi->i_size_lock);
 	INIT_LIST_HEAD(&fi->dirty_list);
-- 
2.51.0


