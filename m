Return-Path: <stable+bounces-204261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6045ECEA4DF
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 18:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6141B300976B
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 17:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1A921CC7B;
	Tue, 30 Dec 2025 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbyTCD4c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3642144C7
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767115258; cv=none; b=or8pHRw221OUK2DpZN3a6R1f4HDaOqdSq0a/4K/FR1NKrg4CVlfUmPMmM3ROTWKeXdLXI/HHspb9PcIRM9Iijj5Q8Jxi5xdMDWOy7QreHlxcrdxqa616ki/FK+em1y4L6WWPnktd0cqVun/U6iOSaCkMd9ZKcMJC1a28dUl5IvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767115258; c=relaxed/simple;
	bh=2hys5B59AH7WhVybOpCqReetXT6dcvsWr2tRaz7XluY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GImU+jNW1U2EPgnaCrKI6+rSLXQUZiY8obmWzCA5FbaseLsgAuY1shItDRjlq3V7sbavRH61wA4YGxzNGMo27ZOc/V/J8zEnjP01QC5R5zwIJIVqQZMHVPeXh2nhnb5g2PchdXMNFZ6R6Y0wpXJxEL8M2OC081kj1/gX1DUZ9rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbyTCD4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BB9C4CEFB;
	Tue, 30 Dec 2025 17:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767115258;
	bh=2hys5B59AH7WhVybOpCqReetXT6dcvsWr2tRaz7XluY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rbyTCD4cD76V9X5uGuilCOPvgHBcE+cAnozUHKXLn5poJtrDYBFEuPjtVeYeb3TI8
	 QVogqGSWy+hcBzG+ang2a80jC7k0FbsowbxGorEPTFSw3fC4V7Rz25CCDooOSTLyZ8
	 VVXUuTz70qGQJax3bqq6b+uoJi7eITgJtHI2X88k5ofT8MHIrFFA8G8aZtY8DY3CIk
	 Cyy9QKN8jB7y4pFQOibhwCPSg/6STq5Pgh3oy57ZbVICMi6R2KYbKm2QRs5mAMESGW
	 tXkuWhSM/RTO1l7va2owOD6teCE3OBlKjY7FjKgnsuWSsFkgvutiljQAeuW0SdxKKi
	 bWt9ynNDKfeig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] f2fs: fix to propagate error from f2fs_enable_checkpoint()
Date: Tue, 30 Dec 2025 12:20:55 -0500
Message-ID: <20251230172055.2345676-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122947-consult-launder-19af@gregkh>
References: <2025122947-consult-launder-19af@gregkh>
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
[ Adjust context, no rollback ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b9913ab526fd..49f5af7fabd0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2263,9 +2263,10 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 	return err;
 }
 
-static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
+static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 {
 	int retry = DEFAULT_RETRY_IO_COUNT;
+	int ret;
 
 	/* we should flush all the data to keep data consistency */
 	do {
@@ -2283,10 +2284,14 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 	f2fs_up_write(&sbi->gc_lock);
 
-	f2fs_sync_fs(sbi->sb, 1);
+	ret = f2fs_sync_fs(sbi->sb, 1);
+	if (ret)
+		f2fs_err(sbi, "%s sync_fs failed, ret: %d", __func__, ret);
 
 	/* Let's ensure there's no pending checkpoint anymore */
 	f2fs_flush_ckpt_thread(sbi);
+
+	return ret;
 }
 
 static int f2fs_remount(struct super_block *sb, int *flags, char *data)
@@ -2507,7 +2512,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 			if (err)
 				goto restore_discard;
 		} else {
-			f2fs_enable_checkpoint(sbi);
+			err = f2fs_enable_checkpoint(sbi);
+			if (err)
+				goto restore_discard;
 		}
 	}
 
@@ -4719,13 +4726,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	/* f2fs_recover_fsync_data() cleared this already */
 	clear_sbi_flag(sbi, SBI_POR_DOING);
 
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


