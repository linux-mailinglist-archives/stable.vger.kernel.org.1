Return-Path: <stable+bounces-204267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4494CEA5F9
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 18:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92466301D662
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 17:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8E032B99C;
	Tue, 30 Dec 2025 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdUInTms"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C76219E819
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767117423; cv=none; b=PZwJzFx7dj8bFPa3ii9LmGU5Bjs1hGCNC2wQovLSiLBS5kzUXU3xjVeZUpQOW5d7kGLwxJ9DbeImyHO+zbGFe6Nq0b39nhHkonWjQDaSDfRfNzHDNVVPDyTTBn+LSBFTTdV1tM0cLHrsYeXa2toeN6JBaWjrP4+Ts2AecjeBRbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767117423; c=relaxed/simple;
	bh=rWIVz7pr5DLmJtbnbrgncsD0Tc3NL1+BN0H+r0l1jfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXLlZ8M+i0vck4n5VhEJxZfmfujqnO+qF0TERFx81T2ekYvICm8e1dXH+7hN6dnMhdg/eoQJG9PlZ8WqihuxST85H5ZJZ62Y0m/pPAB9+GIe8oIst88yphFKASRQMF2COlsWjWp2AMiUoYzsvt+tgmJkQgzQUtOQ+D+GQDGgTsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdUInTms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE50C4CEFB;
	Tue, 30 Dec 2025 17:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767117423;
	bh=rWIVz7pr5DLmJtbnbrgncsD0Tc3NL1+BN0H+r0l1jfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WdUInTmsvnBvC86wOoA73w7MBMN4tR54ICGoWbMyCsjDvjVOvH1tzqke3B+w/kC3A
	 4NaW7gdM+CD6qT53jYwRQAXywCN2w8YHPZHgj73LOGKjkEZOrzzxdUqNxVcuZpe0R1
	 eDfqmIbXo+dXCENZb3ciasVGrIMYDYkd5NF5ZJMz+GWUuFku+OhMS9ZXyQcZTtfBRH
	 k7z7TE5zF10aKBczrR05BtM8iezj6+OpKsvyOVHc1nqGFbTs1Fq79k1Q+VkQ7enUcK
	 Qjtj64gQANxUl+/1NiE2c5n0bsOTtaecilxe+Y6gtCaT/xi+nYJT6ewIoQYfT2k2xD
	 vL9FXqkDf6n3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] f2fs: fix to propagate error from f2fs_enable_checkpoint()
Date: Tue, 30 Dec 2025 12:57:00 -0500
Message-ID: <20251230175700.2368734-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122948-corner-dyslexia-2933@gregkh>
References: <2025122948-corner-dyslexia-2933@gregkh>
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
[ adapted error handling to use restore_gc ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d7fd28a47701..0ec0b8f9dc9a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1837,9 +1837,10 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 	return err;
 }
 
-static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
+static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 {
 	int retry = DEFAULT_RETRY_IO_COUNT;
+	int ret;
 
 	/* we should flush all the data to keep data consistency */
 	do {
@@ -1858,7 +1859,11 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 	up_write(&sbi->gc_lock);
 
-	f2fs_sync_fs(sbi->sb, 1);
+	ret = f2fs_sync_fs(sbi->sb, 1);
+	if (ret)
+		f2fs_err(sbi, "%s sync_fs failed, ret: %d", __func__, ret);
+
+	return ret;
 }
 
 static int f2fs_remount(struct super_block *sb, int *flags, char *data)
@@ -2006,7 +2011,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 			if (err)
 				goto restore_gc;
 		} else {
-			f2fs_enable_checkpoint(sbi);
+			err = f2fs_enable_checkpoint(sbi);
+			if (err)
+				goto restore_gc;
 		}
 	}
 
@@ -3934,13 +3941,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
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


