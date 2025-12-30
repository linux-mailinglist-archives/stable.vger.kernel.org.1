Return-Path: <stable+bounces-204246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75545CEA291
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 17:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D50A3024881
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 16:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D4D3191A7;
	Tue, 30 Dec 2025 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioHlsKuB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57057320A0C
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767111777; cv=none; b=budFEyFNzdJ5ttY5uVTLLY5NDDFZ2aTjEiXHBmouA0jExg4Pr3xA4TsutHCn9T4wz0sAVMWWutKiXuPyTt3QuzBK3eWowBn2Pm57m6x2JUwXJep5zBXixpG700wG23YwwAEpM/7tNoD585OcVZPEMxX02/sB3q19xmkNZvXJoEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767111777; c=relaxed/simple;
	bh=ITaAOlHxT+MYJGL1FSyLGZCFyf4xUqXZnlDrFOVdNm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+s0+cpxp69LAvtLPZr1quyEZw+ZeXcHJa3tEim+iKY8IpRBp2QgjtMY0ezM0Elan763+vBD6XJQFRC0DCIV/Uai2SCSQFGyehmAQUFaIQ/A2Q3lYmrloOK5PkDTef/SvCtzecoEZ4F6aiEz2zjHlEwpgfhQGynE3X9he53VmU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioHlsKuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BDAC116C6;
	Tue, 30 Dec 2025 16:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767111777;
	bh=ITaAOlHxT+MYJGL1FSyLGZCFyf4xUqXZnlDrFOVdNm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ioHlsKuBgJrYJt4+mAuZpxhj3ifEPGu2oOTy3KtlFr5MQ7DcmFoZB6zNwcMAqD75n
	 83JXb3jhWVS3oSDnokklUpj30xym4cUB/QDCs+tnDMaMLOgVbXEj8vZwqdk0Nae8re
	 Hwx9jBK6B4wq4HBWxQc63tydRvOkz892D9/KDT484TZyJakbfbCKjiJk7B36Dbt14h
	 Hlqm+88J4hpj/3SR10fK25N5FzF/aKCjAAaFmuFaAuH5fjn5fYqBlLsux6H5CBWQ7a
	 l6ep6wm2D+tp4E9/y2Ybk5gVz0Td/OrWxuswh2OE6Kt47PZmZfZgYyK8+oP0gEc7U1
	 yXJYLFZx5/8HQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] f2fs: add timeout in f2fs_enable_checkpoint()
Date: Tue, 30 Dec 2025 11:22:52 -0500
Message-ID: <20251230162254.2306864-2-sashal@kernel.org>
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

[ Upstream commit 4bc347779698b5e67e1514bab105c2c083e55502 ]

During f2fs_enable_checkpoint() in remount(), if we flush a large
amount of dirty pages into slow device, it may take long time which
will block write IO, let's add a timeout machanism during dirty
pages flush to avoid long time block in f2fs_enable_checkpoint().

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: be112e7449a6 ("f2fs: fix to propagate error from f2fs_enable_checkpoint()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h  |  2 ++
 fs/f2fs/super.c | 21 +++++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 695f74875b8f..073eff7fa081 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -249,6 +249,7 @@ enum {
 #define DEF_CP_INTERVAL			60	/* 60 secs */
 #define DEF_IDLE_INTERVAL		5	/* 5 secs */
 #define DEF_DISABLE_INTERVAL		5	/* 5 secs */
+#define DEF_ENABLE_INTERVAL		16	/* 16 secs */
 #define DEF_DISABLE_QUICK_INTERVAL	1	/* 1 secs */
 #define DEF_UMOUNT_DISCARD_TIMEOUT	5	/* 5 secs */
 
@@ -1343,6 +1344,7 @@ enum {
 	DISCARD_TIME,
 	GC_TIME,
 	DISABLE_TIME,
+	ENABLE_TIME,
 	UMOUNT_DISCARD_TIMEOUT,
 	MAX_TIME,
 };
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7d4a0a906614..3f2aa031ef3b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2281,16 +2281,24 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 
 static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 {
-	int retry = DEFAULT_RETRY_IO_COUNT;
+	unsigned int nr_pages = get_pages(sbi, F2FS_DIRTY_DATA) / 16;
+
+	f2fs_update_time(sbi, ENABLE_TIME);
 
 	/* we should flush all the data to keep data consistency */
-	do {
-		sync_inodes_sb(sbi->sb);
+	while (get_pages(sbi, F2FS_DIRTY_DATA)) {
+		writeback_inodes_sb_nr(sbi->sb, nr_pages, WB_REASON_SYNC);
 		f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
-	} while (get_pages(sbi, F2FS_DIRTY_DATA) && retry--);
 
-	if (unlikely(retry < 0))
-		f2fs_warn(sbi, "checkpoint=enable has some unwritten data.");
+		if (f2fs_time_over(sbi, ENABLE_TIME))
+			break;
+	}
+
+	sync_inodes_sb(sbi->sb);
+
+	if (unlikely(get_pages(sbi, F2FS_DIRTY_DATA)))
+		f2fs_warn(sbi, "checkpoint=enable has some unwritten data: %lld",
+					get_pages(sbi, F2FS_DIRTY_DATA));
 
 	f2fs_down_write(&sbi->gc_lock);
 	f2fs_dirty_to_prefree(sbi);
@@ -3866,6 +3874,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->interval_time[DISCARD_TIME] = DEF_IDLE_INTERVAL;
 	sbi->interval_time[GC_TIME] = DEF_IDLE_INTERVAL;
 	sbi->interval_time[DISABLE_TIME] = DEF_DISABLE_INTERVAL;
+	sbi->interval_time[ENABLE_TIME] = DEF_ENABLE_INTERVAL;
 	sbi->interval_time[UMOUNT_DISCARD_TIMEOUT] =
 				DEF_UMOUNT_DISCARD_TIMEOUT;
 	clear_sbi_flag(sbi, SBI_NEED_FSCK);
-- 
2.51.0


