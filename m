Return-Path: <stable+bounces-203587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00207CE6F31
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6544E30072A7
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AD731A545;
	Mon, 29 Dec 2025 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="afcWwlZQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5D331985E
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016807; cv=none; b=JGgLNd9Zu/IpxIgIRROYZO2uFNnXZat7cELVDI6qFASi0SqehMwzKEI9jb6OpK+NQPRGAK0IMBENgutgZaTm1v0l4RoetPIYT15mXzP69J4N5Q02gOJi+vtz4x1BCfzFawi2QNJdfTyJNcQrisp48fIswYwwStBZwoPUhdP9rqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016807; c=relaxed/simple;
	bh=SZWE/IVENxn7nch8TN+DEOKeNAGouNjz7mH0ImqoxIM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BQFf0qu/ymxgapqvBXB9hUsKt9AeN5ex7CAxaQRsCpM8GVm2otrFqtgVyV0axBjSbQnq34G425/l+qsDNlR7JUEX1tPr2C8yqHzUI1PSPlsPBud0bJZorx+eJO6gA6phKDxPWWtvJc0S+F8XudZHUhdAKG2H3vyA/RTCm6+j54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=afcWwlZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB96C116C6;
	Mon, 29 Dec 2025 14:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767016806;
	bh=SZWE/IVENxn7nch8TN+DEOKeNAGouNjz7mH0ImqoxIM=;
	h=Subject:To:Cc:From:Date:From;
	b=afcWwlZQ6HnC/1gA2xd/De3B63xWF290qa1LwbipJuxXytviFufmfABxJV4vwJNBR
	 /iVQkQgluDW1QBeoLQXM0SK8BQg7OXA3UIcSd4hXIkJtUrR48sxMETTRJHT72gaxeM
	 WD0iosPzY/yXFv7QBtMByVvFeXl0VfMr/q5sumn8=
Subject: FAILED: patch "[PATCH] f2fs: fix to propagate error from f2fs_enable_checkpoint()" failed to apply to 5.10-stable tree
To: chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 14:59:48 +0100
Message-ID: <2025122948-corner-dyslexia-2933@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x be112e7449a6e1b54aa9feac618825d154b3a5c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122948-corner-dyslexia-2933@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From be112e7449a6e1b54aa9feac618825d154b3a5c7 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Mon, 27 Oct 2025 14:35:33 +0800
Subject: [PATCH] f2fs: fix to propagate error from f2fs_enable_checkpoint()

In order to let userspace detect such error rather than suffering
silent failure.

Fixes: 4354994f097d ("f2fs: checkpoint disabling")
Cc: stable@kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f76ba2b08be0..60382c9b5293 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2632,10 +2632,11 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 	return err;
 }
 
-static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
+static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 {
 	unsigned int nr_pages = get_pages(sbi, F2FS_DIRTY_DATA) / 16;
 	long long start, writeback, end;
+	int ret;
 
 	f2fs_info(sbi, "f2fs_enable_checkpoint() starts, meta: %lld, node: %lld, data: %lld",
 					get_pages(sbi, F2FS_DIRTY_META),
@@ -2669,7 +2670,9 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 	f2fs_up_write(&sbi->gc_lock);
 
-	f2fs_sync_fs(sbi->sb, 1);
+	ret = f2fs_sync_fs(sbi->sb, 1);
+	if (ret)
+		f2fs_err(sbi, "%s sync_fs failed, ret: %d", __func__, ret);
 
 	/* Let's ensure there's no pending checkpoint anymore */
 	f2fs_flush_ckpt_thread(sbi);
@@ -2679,6 +2682,7 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	f2fs_info(sbi, "f2fs_enable_checkpoint() finishes, writeback:%llu, sync:%llu",
 					ktime_ms_delta(writeback, start),
 					ktime_ms_delta(end, writeback));
+	return ret;
 }
 
 static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
@@ -2892,7 +2896,9 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 				goto restore_discard;
 			need_enable_checkpoint = true;
 		} else {
-			f2fs_enable_checkpoint(sbi);
+			err = f2fs_enable_checkpoint(sbi);
+			if (err)
+				goto restore_discard;
 			need_disable_checkpoint = true;
 		}
 	}
@@ -2935,7 +2941,8 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 	return 0;
 restore_checkpoint:
 	if (need_enable_checkpoint) {
-		f2fs_enable_checkpoint(sbi);
+		if (f2fs_enable_checkpoint(sbi))
+			f2fs_warn(sbi, "checkpoint has not been enabled");
 	} else if (need_disable_checkpoint) {
 		if (f2fs_disable_checkpoint(sbi))
 			f2fs_warn(sbi, "checkpoint has not been disabled");
@@ -5212,13 +5219,12 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		goto sync_free_meta;
 
-	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
 		err = f2fs_disable_checkpoint(sbi);
-		if (err)
-			goto sync_free_meta;
-	} else if (is_set_ckpt_flags(sbi, CP_DISABLED_FLAG)) {
-		f2fs_enable_checkpoint(sbi);
-	}
+	else if (is_set_ckpt_flags(sbi, CP_DISABLED_FLAG))
+		err = f2fs_enable_checkpoint(sbi);
+	if (err)
+		goto sync_free_meta;
 
 	/*
 	 * If filesystem is not mounted as read-only then


