Return-Path: <stable+bounces-79095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAD398D68C
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBD91C21FAE
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2991D0949;
	Wed,  2 Oct 2024 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q9dq61hr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32E31D0796;
	Wed,  2 Oct 2024 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876425; cv=none; b=i59mAVAdyq6X44O5IENySk8dpxxxe+sDerL1DPydhoxbsK/IvcuMwg5FATk0njHF9v9NnF5BoZAK12ypB1piKY2WYAtnZFaD3HmpbKiIEOdMFEL8HrUhn23g2jQiUAEGCaj2PiIi3cLMdmjNqXQcb28VIn+U8R4p8qN5IlZi6Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876425; c=relaxed/simple;
	bh=yUU5qs/abwtzxWjToN3j8ma0bVgdaqOBinKobAfnkQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0lSE9mkLyA6Bxmgs9R3nyJEd5eRrG7ZsoNF39cHlqIKVcq8MTcuS+SgokKk/PykDf3Gk3JvqBA9lwln0T4b4sKVxp40fs8N/ezX6t+eRliliiAeMKCpYA96eTZGFmUX4w97M+nhuPSvKIFKZcaXyLOVpfUPTJGD+4vw6ArPz1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q9dq61hr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D59EC4CECE;
	Wed,  2 Oct 2024 13:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876424;
	bh=yUU5qs/abwtzxWjToN3j8ma0bVgdaqOBinKobAfnkQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9dq61hrVez409jFrbhq2TytYY0Bym6y978gCeSVByN01phBIfxrknVqH6z6nHJOB
	 tq0uV6q0OkUmXJzVYxQ5atmhd6Iz73zZ2WNeMfbkrnYuT5tUZ24Tzw3/ZC7E3u5pJk
	 scz/EsxxMlsXE3B7FCWuROoTgM/lreHcCkuWLsNg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 440/695] f2fs: fix to avoid use-after-free in f2fs_stop_gc_thread()
Date: Wed,  2 Oct 2024 14:57:18 +0200
Message-ID: <20241002125840.021904660@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

[ Upstream commit c7f114d864ac91515bb07ac271e9824a20f5ed95 ]

syzbot reports a f2fs bug as below:

 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_report+0xe8/0x550 mm/kasan/report.c:491
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
 __refcount_add include/linux/refcount.h:184 [inline]
 __refcount_inc include/linux/refcount.h:241 [inline]
 refcount_inc include/linux/refcount.h:258 [inline]
 get_task_struct include/linux/sched/task.h:118 [inline]
 kthread_stop+0xca/0x630 kernel/kthread.c:704
 f2fs_stop_gc_thread+0x65/0xb0 fs/f2fs/gc.c:210
 f2fs_do_shutdown+0x192/0x540 fs/f2fs/file.c:2283
 f2fs_ioc_shutdown fs/f2fs/file.c:2325 [inline]
 __f2fs_ioctl+0x443a/0xbe60 fs/f2fs/file.c:4325
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The root cause is below race condition, it may cause use-after-free
issue in sbi->gc_th pointer.

- remount
 - f2fs_remount
  - f2fs_stop_gc_thread
   - kfree(gc_th)
				- f2fs_ioc_shutdown
				 - f2fs_do_shutdown
				  - f2fs_stop_gc_thread
				   - kthread_stop(gc_th->f2fs_gc_task)
   : sbi->gc_thread = NULL;

We will call f2fs_do_shutdown() in two paths:
- for f2fs_ioc_shutdown() path, we should grab sb->s_umount semaphore
for fixing.
- for f2fs_shutdown() path, it's safe since caller has already grabbed
sb->s_umount semaphore.

Reported-by: syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/0000000000005c7ccb061e032b9b@google.com
Fixes: 7950e9ac638e ("f2fs: stop gc/discard thread after fs shutdown")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h  |  2 +-
 fs/f2fs/file.c  | 11 +++++++++--
 fs/f2fs/super.c |  2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index eb6b3e62e6575..f4342622dec6a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3503,7 +3503,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 int f2fs_truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count);
 int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
-							bool readonly);
+						bool readonly, bool need_lock);
 int f2fs_precache_extents(struct inode *inode);
 int f2fs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
 int f2fs_fileattr_set(struct mnt_idmap *idmap,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5558a75f29b79..869f4744b443e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2280,7 +2280,7 @@ static int f2fs_ioc_abort_atomic_write(struct file *filp)
 }
 
 int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
-							bool readonly)
+						bool readonly, bool need_lock)
 {
 	struct super_block *sb = sbi->sb;
 	int ret = 0;
@@ -2327,12 +2327,19 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 	if (readonly)
 		goto out;
 
+	/* grab sb->s_umount to avoid racing w/ remount() */
+	if (need_lock)
+		down_read(&sbi->sb->s_umount);
+
 	f2fs_stop_gc_thread(sbi);
 	f2fs_stop_discard_thread(sbi);
 
 	f2fs_drop_discard_cmd(sbi);
 	clear_opt(sbi, DISCARD);
 
+	if (need_lock)
+		up_read(&sbi->sb->s_umount);
+
 	f2fs_update_time(sbi, REQ_TIME);
 out:
 
@@ -2369,7 +2376,7 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		}
 	}
 
-	ret = f2fs_do_shutdown(sbi, in, readonly);
+	ret = f2fs_do_shutdown(sbi, in, readonly, true);
 
 	if (need_drop)
 		mnt_drop_write_file(filp);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3959fd137cc9b..4e46cbd1fc2ba 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2561,7 +2561,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 
 static void f2fs_shutdown(struct super_block *sb)
 {
-	f2fs_do_shutdown(F2FS_SB(sb), F2FS_GOING_DOWN_NOSYNC, false);
+	f2fs_do_shutdown(F2FS_SB(sb), F2FS_GOING_DOWN_NOSYNC, false, false);
 }
 
 #ifdef CONFIG_QUOTA
-- 
2.43.0




