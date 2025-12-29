Return-Path: <stable+bounces-203586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B402BCE6F4C
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 030A63016728
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B5531A062;
	Mon, 29 Dec 2025 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DnMbW4Mn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3826931281F
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016807; cv=none; b=s1fPor0V4Tj8p9U+gg3b+eqhyuA8CVrjwT39TpRLN7+w4jeYrqEydJPcNG6odmmN1bMprqQPFJKiGzLM1WBfryabqb/DsMGl9P/ztl1Fh/mNavL9y5eQ6fur/qFIZR6X6DWoylxoegi0OrGpZ/f6lY3dKKvaqUhclkxvcUQm0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016807; c=relaxed/simple;
	bh=u/pPoFtd/WBCdAI1TWnMTDFNA4dTdKHU6vBaYffVOSk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ut/a9jbWhamXlV9Kh3OnVTDXpfErw1jNHmtsPqFwc/CSMC/D4z0wPswBTFgqpm7p3FvOETP/LmnL1fP6UKcXH1LmQCMVzDeS3zDh9PKBWT5umKUDOg+636NzYoJgpNTO9aO0DJW/sl3GCgKrFsS9vyAfpQBi7TMeFmj8ZnD4E60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DnMbW4Mn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5B2C4CEF7;
	Mon, 29 Dec 2025 14:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767016803;
	bh=u/pPoFtd/WBCdAI1TWnMTDFNA4dTdKHU6vBaYffVOSk=;
	h=Subject:To:Cc:From:Date:From;
	b=DnMbW4MnHVTH84pleJgS9AKjKqlGKT9m2XBpLm4UCnXOTVpN2qvt2rpBczgbIdLO3
	 v5U1kSKh/lQAcnGjGEmiOtcGK6kC28sMr1CFxfx0oB+WQgkcA9wK2+Z0kBlwg1A+EO
	 j4efrnPOiA+QlH90YSVFlmHHkoHk0KrXrDzDDOyA=
Subject: FAILED: patch "[PATCH] f2fs: fix to propagate error from f2fs_enable_checkpoint()" failed to apply to 6.6-stable tree
To: chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 14:59:47 +0100
Message-ID: <2025122947-consult-launder-19af@gregkh>
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
git cherry-pick -x be112e7449a6e1b54aa9feac618825d154b3a5c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122947-consult-launder-19af@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


