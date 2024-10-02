Return-Path: <stable+bounces-80340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22EC98DCFE
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923752864BB
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2691D12FF;
	Wed,  2 Oct 2024 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W3Ah5rzb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A501D1302;
	Wed,  2 Oct 2024 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880087; cv=none; b=VI+lKjvQwU5X+Udhrxx0Ludl0hUa1tXbbq65Sdd4yXIiRkGttIZjmMFY3jcv9f6viybq7/c5mPFVPWnz1hiB8ZwsKnmHfHAjD4QnnuLQaLndXpMex5Ip/Tu8eop7eKbSkIhAuLw9K1xVuw7bIqBCe27bnGIyo85tt0Zrgyvj/As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880087; c=relaxed/simple;
	bh=aN9oDsQHx7h0kE7f71xYUw9XtKiodbWXQ0w+qnWRbik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sdzc/YSE0R78BRIUIGg8qbPcg9lWi9jHeOXYiU6sGuiIUndQ4axpl01Rp1nky3hIqBA3lzNMS4x6JZBlCYCy+q0jCedZm6wqy5EDeSm4wusZFMDvJp9unHnjQfeYlCxI4N2CWPQs7Y6k50SEsqiLRMfta89u9JcsfKWmRboGVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W3Ah5rzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571C4C4CEC2;
	Wed,  2 Oct 2024 14:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727880087;
	bh=aN9oDsQHx7h0kE7f71xYUw9XtKiodbWXQ0w+qnWRbik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W3Ah5rzbnmUP9fWjrgdj2YQKggrsHObWTPbwDVWoanFDx8NUul5eyHxFA3JIJCr9z
	 YzQXkbUWFATDwnoZT0pH4uALfGRCkXSVLBctgu6rQ6NrJzgmOvY1qZIj5XdjBjXPBH
	 P0Lr1pCZJvgWXGabJnErlnTrsZVGk+/cQM7+P/uk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 340/538] f2fs: support .shutdown in f2fs_sops
Date: Wed,  2 Oct 2024 14:59:39 +0200
Message-ID: <20241002125805.851835964@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

[ Upstream commit ee745e4736fbf33079d0d0808e1343c2280fd59a ]

Support .shutdown callback in f2fs_sops, then, it can be called to
shut down the file system when underlying block device is marked dead.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: c7f114d864ac ("f2fs: fix to avoid use-after-free in f2fs_stop_gc_thread()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h  |  2 ++
 fs/f2fs/file.c  | 70 ++++++++++++++++++++++++++++++-------------------
 fs/f2fs/super.c |  6 +++++
 3 files changed, 51 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f7a8259b9180f..2059a24a330b2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3507,6 +3507,8 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct iattr *attr);
 int f2fs_truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count);
+int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
+							bool readonly);
 int f2fs_precache_extents(struct inode *inode);
 int f2fs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
 int f2fs_fileattr_set(struct mnt_idmap *idmap,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2f08bf7f29621..085008b208020 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2256,34 +2256,13 @@ static int f2fs_ioc_abort_atomic_write(struct file *filp)
 	return ret;
 }
 
-static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
+int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
+							bool readonly)
 {
-	struct inode *inode = file_inode(filp);
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct super_block *sb = sbi->sb;
-	__u32 in;
 	int ret = 0;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	if (get_user(in, (__u32 __user *)arg))
-		return -EFAULT;
-
-	if (in != F2FS_GOING_DOWN_FULLSYNC) {
-		ret = mnt_want_write_file(filp);
-		if (ret) {
-			if (ret == -EROFS) {
-				ret = 0;
-				f2fs_stop_checkpoint(sbi, false,
-						STOP_CP_REASON_SHUTDOWN);
-				trace_f2fs_shutdown(sbi, in, ret);
-			}
-			return ret;
-		}
-	}
-
-	switch (in) {
+	switch (flag) {
 	case F2FS_GOING_DOWN_FULLSYNC:
 		ret = freeze_bdev(sb->s_bdev);
 		if (ret)
@@ -2317,6 +2296,9 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
+	if (readonly)
+		goto out;
+
 	f2fs_stop_gc_thread(sbi);
 	f2fs_stop_discard_thread(sbi);
 
@@ -2325,10 +2307,44 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 
 	f2fs_update_time(sbi, REQ_TIME);
 out:
-	if (in != F2FS_GOING_DOWN_FULLSYNC)
-		mnt_drop_write_file(filp);
 
-	trace_f2fs_shutdown(sbi, in, ret);
+	trace_f2fs_shutdown(sbi, flag, ret);
+
+	return ret;
+}
+
+static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	__u32 in;
+	int ret;
+	bool need_drop = false, readonly = false;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (get_user(in, (__u32 __user *)arg))
+		return -EFAULT;
+
+	if (in != F2FS_GOING_DOWN_FULLSYNC) {
+		ret = mnt_want_write_file(filp);
+		if (ret) {
+			if (ret != -EROFS)
+				return ret;
+
+			/* fallback to nosync shutdown for readonly fs */
+			in = F2FS_GOING_DOWN_NOSYNC;
+			readonly = true;
+		} else {
+			need_drop = true;
+		}
+	}
+
+	ret = f2fs_do_shutdown(sbi, in, readonly);
+
+	if (need_drop)
+		mnt_drop_write_file(filp);
 
 	return ret;
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e022d8233c0a5..d12603c3b5f50 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2543,6 +2543,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	return err;
 }
 
+static void f2fs_shutdown(struct super_block *sb)
+{
+	f2fs_do_shutdown(F2FS_SB(sb), F2FS_GOING_DOWN_NOSYNC, false);
+}
+
 #ifdef CONFIG_QUOTA
 static bool f2fs_need_recovery(struct f2fs_sb_info *sbi)
 {
@@ -3142,6 +3147,7 @@ static const struct super_operations f2fs_sops = {
 	.unfreeze_fs	= f2fs_unfreeze,
 	.statfs		= f2fs_statfs,
 	.remount_fs	= f2fs_remount,
+	.shutdown	= f2fs_shutdown,
 };
 
 #ifdef CONFIG_FS_ENCRYPTION
-- 
2.43.0




