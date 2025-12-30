Return-Path: <stable+bounces-204262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C688CEA512
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 18:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B2FD301AD2F
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 17:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5975C2E093C;
	Tue, 30 Dec 2025 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlkGsxVG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198CE1C84DC
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767115569; cv=none; b=ajU7/WgAKCbO4M2l0drWPWLGnNYM4zy2jcB79lum5wPkMLkPf/kIgQFC99lucZ/DCoXVOANa+jvwxjRyCW64YOGdTUzW+iH7L8hU8QN7Onvr9uw6+6CxjG0BLDKd/URA1bOuhDVfErEOnfnLWr3Hscv6T/hnu+mrpnCwjGEU4Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767115569; c=relaxed/simple;
	bh=YBR50PXoL/E10xODeJ5iP0s6Z2923jLz37ejO935Ul0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifsPTZh8dozeRa4WR4Vkd/isCMEYgXq/Dzh2JzZD71n0ilQuIAxTiZE8GwR1dpUJ8X3li/nCgQ81sFXaPoh1oPvUDi61tO0+t7vJNE9JewclzKoDYLpxyGPWS0a0ZR3acrPvivW9mzBc40vi25ZV0Z0KQQEDt3uBd5ZODS1eXqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlkGsxVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543D8C4CEFB;
	Tue, 30 Dec 2025 17:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767115568;
	bh=YBR50PXoL/E10xODeJ5iP0s6Z2923jLz37ejO935Ul0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mlkGsxVGn0SqCno4KrTBtje0Fgn7R7dcr7yfIOnth7irlsn8k9u1H5gUBl7ahy7Ss
	 PfsyVLTtwlKFcQ91kKimtKSKZKv6Dp+xaVhExYHMjE27Q6+EpI3rUUlCXV33YJOVwg
	 PsqtUPyDIPbcL25qiEYWvOfWaHF1oN5s5A0EZLlJ6nMMnrsIeXghf8k6axd/Bj5w0g
	 nrR4xyIHZXL7HrAtg1PmJ19d1jB21eUvYvSIb7HsuPZ/aB95RfZQVnrSRSQE7KfWUS
	 pIff/D/bhR+Kq0r/eMilz+tcvy2Sxtu27/ZwdduAhMFZ/8fLhIGojk0l2LlerkBr4E
	 rXQJ266t0ebPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: fix to propagate error from f2fs_enable_checkpoint()
Date: Tue, 30 Dec 2025 12:26:06 -0500
Message-ID: <20251230172606.2349129-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122947-gully-quickness-659f@gregkh>
References: <2025122947-gully-quickness-659f@gregkh>
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
index 84fc6591e3f9..f05b6d8b4314 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2219,9 +2219,10 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 	return err;
 }
 
-static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
+static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 {
 	int retry = DEFAULT_RETRY_IO_COUNT;
+	int ret;
 
 	/* we should flush all the data to keep data consistency */
 	do {
@@ -2239,10 +2240,14 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
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
@@ -2457,7 +2462,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 			if (err)
 				goto restore_discard;
 		} else {
-			f2fs_enable_checkpoint(sbi);
+			err = f2fs_enable_checkpoint(sbi);
+			if (err)
+				goto restore_discard;
 		}
 	}
 
@@ -4521,13 +4528,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
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


