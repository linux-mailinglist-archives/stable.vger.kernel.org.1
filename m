Return-Path: <stable+bounces-1464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054467F7FCE
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64FF5B218E4
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBA639FCC;
	Fri, 24 Nov 2023 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tJa783q1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB89364B7;
	Fri, 24 Nov 2023 18:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAF8C433C8;
	Fri, 24 Nov 2023 18:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851464;
	bh=FbuyliK0xGMd+82zc/qQRe2BUbAUtJV2ObiKBW8Pnmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tJa783q1ErVyheR6bfH4iwI/xAJDyN9Pii7oErP30Ooanu9zb3SZs4c4AHow+lOu/
	 pdAzIFrXcNXUQvYxRYaqlZiTiz0tXVT/tcqJTeQh5XCDfntYPBDXTUEaIWNJE3+k4K
	 K/WRsW18pZtHBjqOFlyEC6fcfY7Ym/rWY1LqR388=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.5 458/491] ext4: fix race between writepages and remount
Date: Fri, 24 Nov 2023 17:51:34 +0000
Message-ID: <20231124172038.383609662@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

commit 745f17a4166e79315e4b7f33ce89d03e75a76983 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/ext4.h  |    3 ++-
 fs/ext4/super.c |   14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1674,7 +1674,8 @@ struct ext4_sb_info {
 
 	/*
 	 * Barrier between writepages ops and changing any inode's JOURNAL_DATA
-	 * or EXTENTS flag.
+	 * or EXTENTS flag or between writepages ops and changing DELALLOC or
+	 * DIOREAD_NOLOCK mount options on remount.
 	 */
 	struct percpu_rw_semaphore s_writepages_rwsem;
 	struct dax_device *s_daxdev;
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6425,6 +6425,7 @@ static int __ext4_remount(struct fs_cont
 	struct ext4_mount_options old_opts;
 	ext4_group_t g;
 	int err = 0;
+	int alloc_ctx;
 #ifdef CONFIG_QUOTA
 	int enable_quota = 0;
 	int i, j;
@@ -6465,7 +6466,16 @@ static int __ext4_remount(struct fs_cont
 
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
@@ -6683,6 +6693,8 @@ restore_opts:
 	if ((sb->s_flags & SB_RDONLY) && !(old_sb_flags & SB_RDONLY) &&
 	    sb_any_quota_suspended(sb))
 		dquot_resume(sb, -1);
+
+	alloc_ctx = ext4_writepages_down_write(sb);
 	sb->s_flags = old_sb_flags;
 	sbi->s_mount_opt = old_opts.s_mount_opt;
 	sbi->s_mount_opt2 = old_opts.s_mount_opt2;
@@ -6691,6 +6703,8 @@ restore_opts:
 	sbi->s_commit_interval = old_opts.s_commit_interval;
 	sbi->s_min_batch_time = old_opts.s_min_batch_time;
 	sbi->s_max_batch_time = old_opts.s_max_batch_time;
+	ext4_writepages_up_write(sb, alloc_ctx);
+
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
 #ifdef CONFIG_QUOTA



