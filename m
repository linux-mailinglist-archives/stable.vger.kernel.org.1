Return-Path: <stable+bounces-204264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC2CEA527
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 18:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83B533012942
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 17:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6903E260565;
	Tue, 30 Dec 2025 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnrg60VN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AC4CA52
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767116095; cv=none; b=CRejgfyvXSgdG7PmZHFc+kc17IPr2Eu1tktrqUHiTrTogAV/8MTcafeRcFEARVE9JWmxOdMtsFUiSbMKxvBvgCTzEZmJrjtksLGMexCd/7LqFQHtPZz8O7iy1KVVy5Nkc1Cko8vmYFW+4/OW2Jgw3rKvSP7gOo8qD7e/SCEgWSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767116095; c=relaxed/simple;
	bh=k0Nr4oN1ikAZrl1J5dv9Y7bGVLcB79ATiCIUI5FKjM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZ7Y6YxfbBPrNTSJzMnglkNXG85LW09piBcuXEQZjlQdNT99lFBv1uNaTlY40tkqQGibKNfB9QXxXGvBFoFGulYCaOjDc/hHO8HMTyViwQ8kU6FbWpwGS1sSxlwmYJHpfbbjutS+od97FuxnZmeUt5PrNizj4wSY011/JCjxXaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnrg60VN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632A8C4CEFB;
	Tue, 30 Dec 2025 17:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767116095;
	bh=k0Nr4oN1ikAZrl1J5dv9Y7bGVLcB79ATiCIUI5FKjM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nnrg60VNnllli7XGghdTwpq/95ou2Q1lupGAYSTUUKfQfv7Bzetp1mvN6ro0xs/XI
	 MxEsTvQgfxwKRdSvARXO9Cta2HNBg/qkHRfQ2lS6yrZyyfJf9NJvIje6LuA2Osl10P
	 XFSO12nzP6rrvn9fJTnJMXRlru0h5C0Em7mhGnf8tTfbkKbZ2haD+dyajbQ4M2gjS5
	 y9wi/5SkcxriCQh2nyhFokGysG4G0Tk/4+SpGGC8trWr99IVySUQYCRJFGrSDYk9v4
	 aDsUnpsaSIYFpjm5aH0oI3ov/n0k0wkh+ydsqWDxwYoy9E+bFEVZiQsZYAXwFRcYU1
	 KZw43zXYo0Apw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] f2fs: fix to propagate error from f2fs_enable_checkpoint()
Date: Tue, 30 Dec 2025 12:34:52 -0500
Message-ID: <20251230173452.2352003-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122947-fantastic-savage-cc4b@gregkh>
References: <2025122947-fantastic-savage-cc4b@gregkh>
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
index b9da3074a1af..2868160ab41d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2178,9 +2178,10 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 	return err;
 }
 
-static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
+static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 {
 	int retry = DEFAULT_RETRY_IO_COUNT;
+	int ret;
 
 	/* we should flush all the data to keep data consistency */
 	do {
@@ -2198,10 +2199,14 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 	up_write(&sbi->gc_lock);
 
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
@@ -2417,7 +2422,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 			if (err)
 				goto restore_discard;
 		} else {
-			f2fs_enable_checkpoint(sbi);
+			err = f2fs_enable_checkpoint(sbi);
+			if (err)
+				goto restore_discard;
 		}
 	}
 
@@ -4398,13 +4405,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
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


