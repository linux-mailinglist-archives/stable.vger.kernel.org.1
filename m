Return-Path: <stable+bounces-203581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B07CE6F40
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20B2F301142D
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FC9315D22;
	Mon, 29 Dec 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZSfuAzxn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A731960F
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016779; cv=none; b=MUbb4JXOMZObu9a9CsXK5/rEdLAn8aAOyoUimE20SGiCyqvBxWnncPZAw/p3IBMsNFuOWINxRVZhcFtNMMXPQqHy214BcyXlRJ9qEDIriDj6gCqTyR8jmjWaWi2B7Rba4tVV55BwAmZ3csWkYFewEjUwUw/sV3U8PEkuYsPnREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016779; c=relaxed/simple;
	bh=j/CGMtRiVwb8HEMsJo5grJREQD1HBaj0BfqrVWXaEVc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bSsolkayqjYtsj8qizooj5RrM9JoXlzaxWfsEVRUzSrGA2bN4+NPBEY1aZ3L0GI5w820oeWoSDNxlzpffDN3v2CbgSyc9VjS+20y2mV2f1tzWDKSop07xCnVaVyfyRUGEe7MSc/yOT4PG6ycSSFDc/xoF85bXB/KjD5lWZwU9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZSfuAzxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E555C4CEF7;
	Mon, 29 Dec 2025 13:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767016779;
	bh=j/CGMtRiVwb8HEMsJo5grJREQD1HBaj0BfqrVWXaEVc=;
	h=Subject:To:Cc:From:Date:From;
	b=ZSfuAzxnvnpYIagGnj/EiQaoP7foAzjQEfhyIi01GQc0JYHXaaB3ryyYcVxis/H4Y
	 fOFPYzUxwp+oamMQV2BAPZnGoHr2DZku95d6ZyGfmKuoir5au9F4mILZP9O1aFaohq
	 j/eFVVaAZ6H4a+2+U+JuESZosd+cj8QSYM9LE0fI=
Subject: FAILED: patch "[PATCH] f2fs: fix to avoid potential deadlock" failed to apply to 6.6-stable tree
To: chao@kernel.org,jaegeuk@kernel.org,r772577952@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 14:59:36 +0100
Message-ID: <2025122936-footless-sensitize-ae33@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ca8b201f28547e28343a6f00a6e91fa8c09572fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122936-footless-sensitize-ae33@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ca8b201f28547e28343a6f00a6e91fa8c09572fe Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Tue, 14 Oct 2025 19:47:35 +0800
Subject: [PATCH] f2fs: fix to avoid potential deadlock

As Jiaming Zhang and syzbot reported, there is potential deadlock in
f2fs as below:

Chain exists of:
  &sbi->cp_rwsem --> fs_reclaim --> sb_internal#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_internal#2);
                               lock(fs_reclaim);
                               lock(sb_internal#2);
  rlock(&sbi->cp_rwsem);

 *** DEADLOCK ***

3 locks held by kswapd0/73:
 #0: ffffffff8e247a40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:7015 [inline]
 #0: ffffffff8e247a40 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0x951/0x2800 mm/vmscan.c:7389
 #1: ffff8880118400e0 (&type->s_umount_key#50){.+.+}-{4:4}, at: super_trylock_shared fs/super.c:562 [inline]
 #1: ffff8880118400e0 (&type->s_umount_key#50){.+.+}-{4:4}, at: super_cache_scan+0x91/0x4b0 fs/super.c:197
 #2: ffff888011840610 (sb_internal#2){.+.+}-{0:0}, at: f2fs_evict_inode+0x8d9/0x1b60 fs/f2fs/inode.c:890

stack backtrace:
CPU: 0 UID: 0 PID: 73 Comm: kswapd0 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 down_read+0x46/0x2e0 kernel/locking/rwsem.c:1537
 f2fs_down_read fs/f2fs/f2fs.h:2278 [inline]
 f2fs_lock_op fs/f2fs/f2fs.h:2357 [inline]
 f2fs_do_truncate_blocks+0x21c/0x10c0 fs/f2fs/file.c:791
 f2fs_truncate_blocks+0x10a/0x300 fs/f2fs/file.c:867
 f2fs_truncate+0x489/0x7c0 fs/f2fs/file.c:925
 f2fs_evict_inode+0x9f2/0x1b60 fs/f2fs/inode.c:897
 evict+0x504/0x9c0 fs/inode.c:810
 f2fs_evict_inode+0x1dc/0x1b60 fs/f2fs/inode.c:853
 evict+0x504/0x9c0 fs/inode.c:810
 dispose_list fs/inode.c:852 [inline]
 prune_icache_sb+0x21b/0x2c0 fs/inode.c:1000
 super_cache_scan+0x39b/0x4b0 fs/super.c:224
 do_shrink_slab+0x6ef/0x1110 mm/shrinker.c:437
 shrink_slab_memcg mm/shrinker.c:550 [inline]
 shrink_slab+0x7ef/0x10d0 mm/shrinker.c:628
 shrink_one+0x28a/0x7c0 mm/vmscan.c:4955
 shrink_many mm/vmscan.c:5016 [inline]
 lru_gen_shrink_node mm/vmscan.c:5094 [inline]
 shrink_node+0x315d/0x3780 mm/vmscan.c:6081
 kswapd_shrink_node mm/vmscan.c:6941 [inline]
 balance_pgdat mm/vmscan.c:7124 [inline]
 kswapd+0x147c/0x2800 mm/vmscan.c:7389
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

The root cause is deadlock among four locks as below:

kswapd
- fs_reclaim				--- Lock A
 - shrink_one
  - evict
   - f2fs_evict_inode
    - sb_start_intwrite			--- Lock B

- iput
 - evict
  - f2fs_evict_inode
   - sb_start_intwrite			--- Lock B
   - f2fs_truncate
    - f2fs_truncate_blocks
     - f2fs_do_truncate_blocks
      - f2fs_lock_op			--- Lock C

ioctl
- f2fs_ioc_commit_atomic_write
 - f2fs_lock_op				--- Lock C
  - __f2fs_commit_atomic_write
   - __replace_atomic_write_block
    - f2fs_get_dnode_of_data
     - __get_node_folio
      - f2fs_check_nid_range
       - f2fs_handle_error
        - f2fs_record_errors
         - f2fs_down_write		--- Lock D

open
- do_open
 - do_truncate
  - security_inode_need_killpriv
   - f2fs_getxattr
    - lookup_all_xattrs
     - f2fs_handle_error
      - f2fs_record_errors
       - f2fs_down_write		--- Lock D
        - f2fs_commit_super
         - read_mapping_folio
          - filemap_alloc_folio_noprof
           - prepare_alloc_pages
            - fs_reclaim_acquire	--- Lock A

In order to avoid such deadlock, we need to avoid grabbing sb_lock in
f2fs_handle_error(), so, let's use asynchronous method instead:
- remove f2fs_handle_error() implementation
- rename f2fs_handle_error_async() to f2fs_handle_error()
- spread f2fs_handle_error()

Fixes: 95fa90c9e5a7 ("f2fs: support recording errors into superblock")
Cc: stable@kernel.org
Reported-by: syzbot+14b90e1156b9f6fc1266@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/68eae49b.050a0220.ac43.0001.GAE@google.com
Reported-by: Jiaming Zhang <r772577952@gmail.com>
Closes: https://lore.kernel.org/lkml/CANypQFa-Gy9sD-N35o3PC+FystOWkNuN8pv6S75HLT0ga-Tzgw@mail.gmail.com
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 6ad8d3bc6df7..811bfe38e5c0 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -759,10 +759,7 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 		ret = -EFSCORRUPTED;
 
 		/* Avoid f2fs_commit_super in irq context */
-		if (!in_task)
-			f2fs_handle_error_async(sbi, ERROR_FAIL_DECOMPRESSION);
-		else
-			f2fs_handle_error(sbi, ERROR_FAIL_DECOMPRESSION);
+		f2fs_handle_error(sbi, ERROR_FAIL_DECOMPRESSION);
 		goto out_release;
 	}
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9cc3b83b8d10..575f9666c3b7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3800,7 +3800,6 @@ void f2fs_quota_off_umount(struct super_block *sb);
 void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag);
 void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason);
 void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error);
-void f2fs_handle_error_async(struct f2fs_sb_info *sbi, unsigned char error);
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
 int f2fs_sync_fs(struct super_block *sb, int sync);
 int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index db7afb806411..cb65ca90f9f6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4544,48 +4544,7 @@ void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag)
 	spin_unlock_irqrestore(&sbi->error_lock, flags);
 }
 
-static bool f2fs_update_errors(struct f2fs_sb_info *sbi)
-{
-	unsigned long flags;
-	bool need_update = false;
-
-	spin_lock_irqsave(&sbi->error_lock, flags);
-	if (sbi->error_dirty) {
-		memcpy(F2FS_RAW_SUPER(sbi)->s_errors, sbi->errors,
-							MAX_F2FS_ERRORS);
-		sbi->error_dirty = false;
-		need_update = true;
-	}
-	spin_unlock_irqrestore(&sbi->error_lock, flags);
-
-	return need_update;
-}
-
-static void f2fs_record_errors(struct f2fs_sb_info *sbi, unsigned char error)
-{
-	int err;
-
-	f2fs_down_write(&sbi->sb_lock);
-
-	if (!f2fs_update_errors(sbi))
-		goto out_unlock;
-
-	err = f2fs_commit_super(sbi, false);
-	if (err)
-		f2fs_err_ratelimited(sbi,
-			"f2fs_commit_super fails to record errors:%u, err:%d",
-			error, err);
-out_unlock:
-	f2fs_up_write(&sbi->sb_lock);
-}
-
 void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error)
-{
-	f2fs_save_errors(sbi, error);
-	f2fs_record_errors(sbi, error);
-}
-
-void f2fs_handle_error_async(struct f2fs_sb_info *sbi, unsigned char error)
 {
 	f2fs_save_errors(sbi, error);
 


