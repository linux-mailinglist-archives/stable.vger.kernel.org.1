Return-Path: <stable+bounces-204248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A11CEA294
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 17:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6154301B4A7
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 16:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7624630CDBF;
	Tue, 30 Dec 2025 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh4ruALP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3575921D3CA
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767111779; cv=none; b=PHSEj6Gui9fVx3FFaykqasFpXgdll94lTl81DbG7TqekXf2wCCce0HesES86oY090EPfBZGbvo+lKBGGjpjJmsTXr7OdY61BT2XQGuFhKn3j8uPApKUwMQp0G+0jfUcm7ZhQhF3F0JJJPREjchzRsGcqRPycyRzXwoj84+fZlEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767111779; c=relaxed/simple;
	bh=GjFs4KVzuVgUIvrBWi+IAu3s9n/dDrml0tTB9qBnqBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBamsm1uu/82ejxM8rFfe5ozjFwhvE+KgWPuWTnOGCw1dyud3aiAX9TIWEY7FFAj7gyVxVZZP2ROplasCnfOrmply1ZaxZLoQL1EYt4azO8M4FYRQ5h86T5beooYr2FxgXoEC1FNAPlfX0CvyQL7Ddp5RlIwdzW2Osq+iVHjF3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh4ruALP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D2EC4CEFB;
	Tue, 30 Dec 2025 16:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767111778;
	bh=GjFs4KVzuVgUIvrBWi+IAu3s9n/dDrml0tTB9qBnqBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kh4ruALPqg6V4/W+9KZKjOdrplbS3ClsIqH+GsAb11798BlgRS99G+OcI3eK5YaQJ
	 u4hXKi45Rc27ZNmupyMb2W3If+r/wyt4e+CE/tSAbVnpyDek8vHwPfjRIUi/gPbxig
	 rbw28xdryoy14yQBoYQhVwn/yLUYa9P0g9+DcVvMkC7xZisYMiX3j3dhEkNTB5MspF
	 634G0LGn/L5Kfrh1Dg503f7d3rr660OzxL6qcPbXcL+MTnnq1IetmUvusVg+ab6ogk
	 6sV8jvcn34j3ebmp5JXlDYaIvsJ9r44fnAi9Ed5+Y4jTfvIp4avfG1KLEO11bsyfWU
	 cCklVSNZUHVgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] f2fs: fix to propagate error from f2fs_enable_checkpoint()
Date: Tue, 30 Dec 2025 11:22:54 -0500
Message-ID: <20251230162254.2306864-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230162254.2306864-1-sashal@kernel.org>
References: <2025122946-opponent-boozy-7af8@gregkh>
 <20251230162254.2306864-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit be112e7449a6e1b54aa9feac618825d154b3a5c7 ]

In order to let userspace detect such error rather than suffering
silent failure.

Fixes: 4354994f097d ("f2fs: checkpoint disabling")
Cc: stable@kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 04957c14b97c..8ec1a669d44d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2280,10 +2280,11 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
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
@@ -2317,7 +2318,9 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 	f2fs_up_write(&sbi->gc_lock);
 
-	f2fs_sync_fs(sbi->sb, 1);
+	ret = f2fs_sync_fs(sbi->sb, 1);
+	if (ret)
+		f2fs_err(sbi, "%s sync_fs failed, ret: %d", __func__, ret);
 
 	/* Let's ensure there's no pending checkpoint anymore */
 	f2fs_flush_ckpt_thread(sbi);
@@ -2327,6 +2330,7 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	f2fs_info(sbi, "f2fs_enable_checkpoint() finishes, writeback:%llu, sync:%llu",
 					ktime_ms_delta(writeback, start),
 					ktime_ms_delta(end, writeback));
+	return ret;
 }
 
 static int f2fs_remount(struct super_block *sb, int *flags, char *data)
@@ -2541,7 +2545,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
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
@@ -2583,7 +2589,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	return 0;
 restore_checkpoint:
 	if (need_enable_checkpoint) {
-		f2fs_enable_checkpoint(sbi);
+		if (f2fs_enable_checkpoint(sbi))
+			f2fs_warn(sbi, "checkpoint has not been enabled");
 	} else if (need_disable_checkpoint) {
 		if (f2fs_disable_checkpoint(sbi))
 			f2fs_warn(sbi, "checkpoint has not been disabled");
@@ -4875,13 +4882,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
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
-- 
2.51.0


