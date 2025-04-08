Return-Path: <stable+bounces-129279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E5EA7FEFA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9B216E997
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D352686A8;
	Tue,  8 Apr 2025 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fJDOi+6H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6209E268684;
	Tue,  8 Apr 2025 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110597; cv=none; b=HThplteDq+8AuTqztsZYyMWkpqPDr0M9WOrvUN7mM2BeqvCdbfIPo+at/fpQPTn5IglRuV5yk588JRk/GcNrxGV/rVGFJw6JyZrs/z2oeLosD08xt0NU+ULWnYYPJSgJDTtOUeLQGoML7uvhl0JAIiDecBxS+z5bJBJFG6PO53A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110597; c=relaxed/simple;
	bh=gZ/w/1wNSA0i1Ou16XB2Tte4wQVsfZX0EcFFgCLpjQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umve0DEj//+hdlgcs5sAhve8toT0486nbdKTHLJEKoT83ImMof8fuX9WlpgAArnjYkwStAxroC1z1+q1pFlknFEIWX4YWDoKEyjKtnANVYUrZMg56Kfn3BZtO0xSdXvSfF/8JUYnhHlbbGi5kl8lzU/KEuyGqPciCSE3OJnMufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fJDOi+6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EBFC4CEE5;
	Tue,  8 Apr 2025 11:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744110597;
	bh=gZ/w/1wNSA0i1Ou16XB2Tte4wQVsfZX0EcFFgCLpjQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fJDOi+6HkwQa7Od4oz+/nLAh5njpeHifZUCvB3v1Qy/aAjzXBoMcyIeO0Q/JbFwNV
	 7suEx1SlRo38DVVkKUhLisowtpf3ZziFijRY231nanCCJ6PPYMebdyYPlKuCUNin0N
	 lBLl4H3UiLSt6EtEsREOD6TZ2gL62J3OiMeB2yf4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 086/731] f2fs: quota: fix to avoid warning in dquot_writeback_dquots()
Date: Tue,  8 Apr 2025 12:39:43 +0200
Message-ID: <20250408104916.270733391@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

[ Upstream commit eb85c2410d6f581e957cd03a644ff6ddbe592af9 ]

F2FS-fs (dm-59): checkpoint=enable has some unwritten data.

------------[ cut here ]------------
WARNING: CPU: 6 PID: 8013 at fs/quota/dquot.c:691 dquot_writeback_dquots+0x2fc/0x308
pc : dquot_writeback_dquots+0x2fc/0x308
lr : f2fs_quota_sync+0xcc/0x1c4
Call trace:
dquot_writeback_dquots+0x2fc/0x308
f2fs_quota_sync+0xcc/0x1c4
f2fs_write_checkpoint+0x3d4/0x9b0
f2fs_issue_checkpoint+0x1bc/0x2c0
f2fs_sync_fs+0x54/0x150
f2fs_do_sync_file+0x2f8/0x814
__f2fs_ioctl+0x1960/0x3244
f2fs_ioctl+0x54/0xe0
__arm64_sys_ioctl+0xa8/0xe4
invoke_syscall+0x58/0x114

checkpoint and f2fs_remount may race as below, resulting triggering warning
in dquot_writeback_dquots().

atomic write                                    remount
                                                - do_remount
                                                 - down_write(&sb->s_umount);
                                                  - f2fs_remount
- ioctl
 - f2fs_do_sync_file
  - f2fs_sync_fs
   - f2fs_write_checkpoint
    - block_operations
     - locked = down_read_trylock(&sbi->sb->s_umount)
       : fail to lock due to the write lock was held by remount
                                                 - up_write(&sb->s_umount);
     - f2fs_quota_sync
      - dquot_writeback_dquots
       - WARN_ON_ONCE(!rwsem_is_locked(&sb->s_umount))
       : trigger warning because s_umount lock was unlocked by remount

If checkpoint comes from mount/umount/remount/freeze/quotactl, caller of
checkpoint has already held s_umount lock, calling dquot_writeback_dquots()
in the context should be safe.

So let's record task to sbi->umount_lock_holder, so that checkpoint can
know whether the lock has held in the context or not by checking current
w/ it.

In addition, in order to not misrepresent caller of checkpoint, we should
not allow to trigger async checkpoint for those callers: mount/umount/remount/
freeze/quotactl.

Fixes: af033b2aa8a8 ("f2fs: guarantee journalled quota data by checkpoint")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c | 15 ++++++----
 fs/f2fs/f2fs.h       |  3 +-
 fs/f2fs/super.c      | 65 ++++++++++++++++++++++++++++++++++----------
 3 files changed, 61 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index efda9a0229816..bd890738b94d7 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1237,7 +1237,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
 retry_flush_quotas:
 	f2fs_lock_all(sbi);
 	if (__need_flush_quota(sbi)) {
-		int locked;
+		bool need_lock = sbi->umount_lock_holder != current;
 
 		if (++cnt > DEFAULT_RETRY_QUOTA_FLUSH_COUNT) {
 			set_sbi_flag(sbi, SBI_QUOTA_SKIP_FLUSH);
@@ -1246,11 +1246,13 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		}
 		f2fs_unlock_all(sbi);
 
-		/* only failed during mount/umount/freeze/quotactl */
-		locked = down_read_trylock(&sbi->sb->s_umount);
-		f2fs_quota_sync(sbi->sb, -1);
-		if (locked)
+		/* don't grab s_umount lock during mount/umount/remount/freeze/quotactl */
+		if (!need_lock) {
+			f2fs_do_quota_sync(sbi->sb, -1);
+		} else if (down_read_trylock(&sbi->sb->s_umount)) {
+			f2fs_do_quota_sync(sbi->sb, -1);
 			up_read(&sbi->sb->s_umount);
+		}
 		cond_resched();
 		goto retry_flush_quotas;
 	}
@@ -1867,7 +1869,8 @@ int f2fs_issue_checkpoint(struct f2fs_sb_info *sbi)
 	struct cp_control cpc;
 
 	cpc.reason = __get_cp_reason(sbi);
-	if (!test_opt(sbi, MERGE_CHECKPOINT) || cpc.reason != CP_SYNC) {
+	if (!test_opt(sbi, MERGE_CHECKPOINT) || cpc.reason != CP_SYNC ||
+		sbi->umount_lock_holder == current) {
 		int ret;
 
 		f2fs_down_write(&sbi->gc_lock);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1afa7be16e7da..493dda2d4b663 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1659,6 +1659,7 @@ struct f2fs_sb_info {
 
 	unsigned int nquota_files;		/* # of quota sysfile */
 	struct f2fs_rwsem quota_sem;		/* blocking cp for flags */
+	struct task_struct *umount_lock_holder;	/* s_umount lock holder */
 
 	/* # of pages, see count_type */
 	atomic_t nr_pages[NR_COUNT_TYPE];
@@ -3624,7 +3625,7 @@ int f2fs_inode_dirtied(struct inode *inode, bool sync);
 void f2fs_inode_synced(struct inode *inode);
 int f2fs_dquot_initialize(struct inode *inode);
 int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly);
-int f2fs_quota_sync(struct super_block *sb, int type);
+int f2fs_do_quota_sync(struct super_block *sb, int type);
 loff_t max_file_blocks(struct inode *inode);
 void f2fs_quota_off_umount(struct super_block *sb);
 void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 19b67828ae325..1beff52ae80b3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1737,22 +1737,28 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 
 static int f2fs_freeze(struct super_block *sb)
 {
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+
 	if (f2fs_readonly(sb))
 		return 0;
 
 	/* IO error happened before */
-	if (unlikely(f2fs_cp_error(F2FS_SB(sb))))
+	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
 
 	/* must be clean, since sync_filesystem() was already called */
-	if (is_sbi_flag_set(F2FS_SB(sb), SBI_IS_DIRTY))
+	if (is_sbi_flag_set(sbi, SBI_IS_DIRTY))
 		return -EINVAL;
 
+	sbi->umount_lock_holder = current;
+
 	/* Let's flush checkpoints and stop the thread. */
-	f2fs_flush_ckpt_thread(F2FS_SB(sb));
+	f2fs_flush_ckpt_thread(sbi);
+
+	sbi->umount_lock_holder = NULL;
 
 	/* to avoid deadlock on f2fs_evict_inode->SB_FREEZE_FS */
-	set_sbi_flag(F2FS_SB(sb), SBI_IS_FREEZING);
+	set_sbi_flag(sbi, SBI_IS_FREEZING);
 	return 0;
 }
 
@@ -2329,6 +2335,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	org_mount_opt = sbi->mount_opt;
 	old_sb_flags = sb->s_flags;
 
+	sbi->umount_lock_holder = current;
+
 #ifdef CONFIG_QUOTA
 	org_mount_opt.s_jquota_fmt = F2FS_OPTION(sbi).s_jquota_fmt;
 	for (i = 0; i < MAXQUOTAS; i++) {
@@ -2552,6 +2560,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 
 	limit_reserve_root(sbi);
 	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
+
+	sbi->umount_lock_holder = NULL;
 	return 0;
 restore_checkpoint:
 	if (need_enable_checkpoint) {
@@ -2592,6 +2602,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 #endif
 	sbi->mount_opt = org_mount_opt;
 	sb->s_flags = old_sb_flags;
+
+	sbi->umount_lock_holder = NULL;
 	return err;
 }
 
@@ -2908,7 +2920,7 @@ static int f2fs_quota_sync_file(struct f2fs_sb_info *sbi, int type)
 	return ret;
 }
 
-int f2fs_quota_sync(struct super_block *sb, int type)
+int f2fs_do_quota_sync(struct super_block *sb, int type)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	struct quota_info *dqopt = sb_dqopt(sb);
@@ -2956,11 +2968,21 @@ int f2fs_quota_sync(struct super_block *sb, int type)
 	return ret;
 }
 
+static int f2fs_quota_sync(struct super_block *sb, int type)
+{
+	int ret;
+
+	F2FS_SB(sb)->umount_lock_holder = current;
+	ret = f2fs_do_quota_sync(sb, type);
+	F2FS_SB(sb)->umount_lock_holder = NULL;
+	return ret;
+}
+
 static int f2fs_quota_on(struct super_block *sb, int type, int format_id,
 							const struct path *path)
 {
 	struct inode *inode;
-	int err;
+	int err = 0;
 
 	/* if quota sysfile exists, deny enabling quota with specific file */
 	if (f2fs_sb_has_quota_ino(F2FS_SB(sb))) {
@@ -2971,31 +2993,34 @@ static int f2fs_quota_on(struct super_block *sb, int type, int format_id,
 	if (path->dentry->d_sb != sb)
 		return -EXDEV;
 
-	err = f2fs_quota_sync(sb, type);
+	F2FS_SB(sb)->umount_lock_holder = current;
+
+	err = f2fs_do_quota_sync(sb, type);
 	if (err)
-		return err;
+		goto out;
 
 	inode = d_inode(path->dentry);
 
 	err = filemap_fdatawrite(inode->i_mapping);
 	if (err)
-		return err;
+		goto out;
 
 	err = filemap_fdatawait(inode->i_mapping);
 	if (err)
-		return err;
+		goto out;
 
 	err = dquot_quota_on(sb, type, format_id, path);
 	if (err)
-		return err;
+		goto out;
 
 	inode_lock(inode);
 	F2FS_I(inode)->i_flags |= F2FS_QUOTA_DEFAULT_FL;
 	f2fs_set_inode_flags(inode);
 	inode_unlock(inode);
 	f2fs_mark_inode_dirty_sync(inode, false);
-
-	return 0;
+out:
+	F2FS_SB(sb)->umount_lock_holder = NULL;
+	return err;
 }
 
 static int __f2fs_quota_off(struct super_block *sb, int type)
@@ -3006,7 +3031,7 @@ static int __f2fs_quota_off(struct super_block *sb, int type)
 	if (!inode || !igrab(inode))
 		return dquot_quota_off(sb, type);
 
-	err = f2fs_quota_sync(sb, type);
+	err = f2fs_do_quota_sync(sb, type);
 	if (err)
 		goto out_put;
 
@@ -3029,6 +3054,8 @@ static int f2fs_quota_off(struct super_block *sb, int type)
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	int err;
 
+	F2FS_SB(sb)->umount_lock_holder = current;
+
 	err = __f2fs_quota_off(sb, type);
 
 	/*
@@ -3038,6 +3065,9 @@ static int f2fs_quota_off(struct super_block *sb, int type)
 	 */
 	if (is_journalled_quota(sbi))
 		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+
+	F2FS_SB(sb)->umount_lock_holder = NULL;
+
 	return err;
 }
 
@@ -3170,7 +3200,7 @@ int f2fs_dquot_initialize(struct inode *inode)
 	return 0;
 }
 
-int f2fs_quota_sync(struct super_block *sb, int type)
+int f2fs_do_quota_sync(struct super_block *sb, int type)
 {
 	return 0;
 }
@@ -4703,6 +4733,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		goto free_compress_inode;
 
+	sbi->umount_lock_holder = current;
 #ifdef CONFIG_QUOTA
 	/* Enable quota usage during mount */
 	if (f2fs_sb_has_quota_ino(sbi) && !f2fs_readonly(sb)) {
@@ -4829,6 +4860,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	f2fs_update_time(sbi, CP_TIME);
 	f2fs_update_time(sbi, REQ_TIME);
 	clear_sbi_flag(sbi, SBI_CP_DISABLED_QUICK);
+
+	sbi->umount_lock_holder = NULL;
 	return 0;
 
 sync_free_meta:
@@ -4931,6 +4964,8 @@ static void kill_f2fs_super(struct super_block *sb)
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 
 	if (sb->s_root) {
+		sbi->umount_lock_holder = current;
+
 		set_sbi_flag(sbi, SBI_IS_CLOSE);
 		f2fs_stop_gc_thread(sbi);
 		f2fs_stop_discard_thread(sbi);
-- 
2.39.5




