Return-Path: <stable+bounces-203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187A77F757A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E7C281FEE
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DD628E32;
	Fri, 24 Nov 2023 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lbUovT37"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297B6200B2
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE57C433C7;
	Fri, 24 Nov 2023 13:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700833626;
	bh=tHC68sH6ozf6VBcDnetINEjf3EqRG/L1Fo4YdxdrRGg=;
	h=Subject:To:Cc:From:Date:From;
	b=lbUovT37GOSeCOCw17zh29mUG1KnwpyNBe4kNQeE/LvQwjGDHi+uIbe3LOQIhDGJh
	 WUx5BWMQGRTaHRpbosUT+oTrAuYkBRhjP1zTN0itqPjdBmJGcJoDLuyUntYHhjygig
	 MhW7zgv0BtGHOVrgWDBKuDmGbJJnn7Cy1m7vdmgo=
Subject: FAILED: patch "[PATCH] ext4: fix race between writepages and remount" failed to apply to 4.14-stable tree
To: libaokun1@huawei.com,jack@suse.cz,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 13:46:59 +0000
Message-ID: <2023112459-footman-slicer-8193@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 745f17a4166e79315e4b7f33ce89d03e75a76983
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112459-footman-slicer-8193@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

745f17a4166e ("ext4: fix race between writepages and remount")
1b2924393309 ("Revert "ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled"")
eb1f822c76be ("ext4: enable the lazy init thread when remounting read/write")
4c0b4818b1f6 ("ext4: improve error recovery code paths in __ext4_remount()")
a44be64bbecb ("ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled")
3b50d5018ed0 ("ext4: reflect error codes from ext4_multi_mount_protect() to its callers")
7edfd85b1ffd ("ext4: Completely separate options parsing and sb setup")
6e47a3cc68fc ("ext4: get rid of super block and sbi from handle_mount_ops()")
b6bd243500b6 ("ext4: check ext2/3 compatibility outside handle_mount_opt()")
e6e268cb6822 ("ext4: move quota configuration out of handle_mount_opt()")
da812f611934 ("ext4: Allow sb to be NULL in ext4_msg()")
461c3af045d3 ("ext4: Change handle_mount_opt() to use fs_parameter")
4c94bff967d9 ("ext4: move option validation to a separate function")
3bbef91bdd21 ("ext4: remove an unused variable warning with CONFIG_QUOTA=n")
2e5fd489a4e5 ("Merge tag 'libnvdimm-for-5.15' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 745f17a4166e79315e4b7f33ce89d03e75a76983 Mon Sep 17 00:00:00 2001
From: Baokun Li <libaokun1@huawei.com>
Date: Wed, 24 May 2023 15:25:38 +0800
Subject: [PATCH] ext4: fix race between writepages and remount

We got a WARNING in ext4_add_complete_io:
==================================================================
 WARNING: at fs/ext4/page-io.c:231 ext4_put_io_end_defer+0x182/0x250
 CPU: 10 PID: 77 Comm: ksoftirqd/10 Tainted: 6.3.0-rc2 #85
 RIP: 0010:ext4_put_io_end_defer+0x182/0x250 [ext4]
 [...]
 Call Trace:
  <TASK>
  ext4_end_bio+0xa8/0x240 [ext4]
  bio_endio+0x195/0x310
  blk_update_request+0x184/0x770
  scsi_end_request+0x2f/0x240
  scsi_io_completion+0x75/0x450
  scsi_finish_command+0xef/0x160
  scsi_complete+0xa3/0x180
  blk_complete_reqs+0x60/0x80
  blk_done_softirq+0x25/0x40
  __do_softirq+0x119/0x4c8
  run_ksoftirqd+0x42/0x70
  smpboot_thread_fn+0x136/0x3c0
  kthread+0x140/0x1a0
  ret_from_fork+0x2c/0x50
==================================================================

Above issue may happen as follows:

            cpu1                        cpu2
----------------------------|----------------------------
mount -o dioread_lock
ext4_writepages
 ext4_do_writepages
  *if (ext4_should_dioread_nolock(inode))*
    // rsv_blocks is not assigned here
                                 mount -o remount,dioread_nolock
  ext4_journal_start_with_reserve
   __ext4_journal_start
    __ext4_journal_start_sb
     jbd2__journal_start
      *if (rsv_blocks)*
        // h_rsv_handle is not initialized here
  mpage_map_and_submit_extent
    mpage_map_one_extent
      dioread_nolock = ext4_should_dioread_nolock(inode)
      if (dioread_nolock && (map->m_flags & EXT4_MAP_UNWRITTEN))
        mpd->io_submit.io_end->handle = handle->h_rsv_handle
        ext4_set_io_unwritten_flag
          io_end->flag |= EXT4_IO_END_UNWRITTEN
      // now io_end->handle is NULL but has EXT4_IO_END_UNWRITTEN flag

scsi_finish_command
 scsi_io_completion
  scsi_io_completion_action
   scsi_end_request
    blk_update_request
     req_bio_endio
      bio_endio
       bio->bi_end_io  > ext4_end_bio
        ext4_put_io_end_defer
	 ext4_add_complete_io
	  // trigger WARN_ON(!io_end->handle && sbi->s_journal);

The immediate cause of this problem is that ext4_should_dioread_nolock()
function returns inconsistent values in the ext4_do_writepages() and
mpage_map_one_extent(). There are four conditions in this function that
can be changed at mount time to cause this problem. These four conditions
can be divided into two categories:

    (1) journal_data and EXT4_EXTENTS_FL, which can be changed by ioctl
    (2) DELALLOC and DIOREAD_NOLOCK, which can be changed by remount

The two in the first category have been fixed by commit c8585c6fcaf2
("ext4: fix races between changing inode journal mode and ext4_writepages")
and commit cb85f4d23f79 ("ext4: fix race between writepages and enabling
EXT4_EXTENTS_FL") respectively.

Two cases in the other category have not yet been fixed, and the above
issue is caused by this situation. We refer to the fix for the first
category, when applying options during remount, we grab s_writepages_rwsem
to avoid racing with writepages ops to trigger this problem.

Fixes: 6b523df4fb5a ("ext4: use transaction reservation for extent conversion in ext4_end_io")
Cc: stable@vger.kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230524072538.2883391-1-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9418359b1d9d..cd4ccae1e28a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1676,7 +1676,8 @@ struct ext4_sb_info {
 
 	/*
 	 * Barrier between writepages ops and changing any inode's JOURNAL_DATA
-	 * or EXTENTS flag.
+	 * or EXTENTS flag or between writepages ops and changing DELALLOC or
+	 * DIOREAD_NOLOCK mount options on remount.
 	 */
 	struct percpu_rw_semaphore s_writepages_rwsem;
 	struct dax_device *s_daxdev;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6f48dec19f4a..d062383ea50e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6443,6 +6443,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	struct ext4_mount_options old_opts;
 	ext4_group_t g;
 	int err = 0;
+	int alloc_ctx;
 #ifdef CONFIG_QUOTA
 	int enable_quota = 0;
 	int i, j;
@@ -6483,7 +6484,16 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 
 	}
 
+	/*
+	 * Changing the DIOREAD_NOLOCK or DELALLOC mount options may cause
+	 * two calls to ext4_should_dioread_nolock() to return inconsistent
+	 * values, triggering WARN_ON in ext4_add_complete_io(). we grab
+	 * here s_writepages_rwsem to avoid race between writepages ops and
+	 * remount.
+	 */
+	alloc_ctx = ext4_writepages_down_write(sb);
 	ext4_apply_options(fc, sb);
+	ext4_writepages_up_write(sb, alloc_ctx);
 
 	if ((old_opts.s_mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) ^
 	    test_opt(sb, JOURNAL_CHECKSUM)) {
@@ -6701,6 +6711,8 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	if (sb_rdonly(sb) && !(old_sb_flags & SB_RDONLY) &&
 	    sb_any_quota_suspended(sb))
 		dquot_resume(sb, -1);
+
+	alloc_ctx = ext4_writepages_down_write(sb);
 	sb->s_flags = old_sb_flags;
 	sbi->s_mount_opt = old_opts.s_mount_opt;
 	sbi->s_mount_opt2 = old_opts.s_mount_opt2;
@@ -6709,6 +6721,8 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	sbi->s_commit_interval = old_opts.s_commit_interval;
 	sbi->s_min_batch_time = old_opts.s_min_batch_time;
 	sbi->s_max_batch_time = old_opts.s_max_batch_time;
+	ext4_writepages_up_write(sb, alloc_ctx);
+
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
 #ifdef CONFIG_QUOTA


