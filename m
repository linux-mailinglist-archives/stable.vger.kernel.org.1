Return-Path: <stable+bounces-49637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A93D8FEE3A
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA0C6B27433
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D3D1A01C2;
	Thu,  6 Jun 2024 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fG/3YMcO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2789E1A01B6;
	Thu,  6 Jun 2024 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683634; cv=none; b=C8yjpq+439JcEj/G0Tm1e7sKnIgtLIGYuUs2D2ULELq+fiH0uZT65RXI+v6Ail3TQJWSoO0g28L7ycu83grfE+lp9stYVnRWFvOfHw/JrTG8AT2RD6xg6kJPCVI1LtgzG+GPnAP/ONbudpc1t1tWfzsxHjwRae2izYegk7Z0JuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683634; c=relaxed/simple;
	bh=4gO/N4rV/NfFeoZNgUzy1LeeGTODqNBlQyeAr50FUN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/DJdFBa96IBZbcUjM5hoOffgWgUHYiQ1A+aCK0X2Y4Vzh4gHZl2eSWbHRpfxwtxRkYa6HIuBpX8bT3lNy0CoP696YoQFIDPIW8VLkPEuPoJbVJwbf40QuRb0J0k+Dr5WJ2K6pT0ZJvLhnyN0VlBJKvF42+saXBMc9jvZnTpHdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fG/3YMcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03526C32781;
	Thu,  6 Jun 2024 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683634;
	bh=4gO/N4rV/NfFeoZNgUzy1LeeGTODqNBlQyeAr50FUN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fG/3YMcOZiA3RKaZEaH7eCYEPek45HnL6TuBCCG4Cl/+hAyioSqfShkfmKy5ykehK
	 Dmz1FTtV46OxYNWvlqwoAMgG0ti+d+IkJnE/gDqMTw8g6wUT6e4MARJ2Uh+jPsg6Fe
	 btjmSLkDcQXn+QgicV5WGbQSjdk2W7HCRHKWLMWs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liao Yuanhong <liaoyuanhong@vivo.com>,
	Wu Bo <bo.wu@vivo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 506/744] f2fs: fix block migration when section is not aligned to pow2
Date: Thu,  6 Jun 2024 16:02:58 +0200
Message-ID: <20240606131748.676663457@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: Wu Bo <bo.wu@vivo.com>

[ Upstream commit aa4074e8fec4d2e686daee627fcafb3503efe365 ]

As for zoned-UFS, f2fs section size is forced to zone size. And zone
size may not aligned to pow2.

Fixes: 859fca6b706e ("f2fs: swap: support migrating swapfile in aligned write mode")
Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
Signed-off-by: Wu Bo <bo.wu@vivo.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3558fc3387f54..b639299a55f27 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3974,15 +3974,14 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	struct address_space *mapping = swap_file->f_mapping;
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	sector_t cur_lblock;
-	sector_t last_lblock;
-	sector_t pblock;
-	sector_t lowest_pblock = -1;
-	sector_t highest_pblock = 0;
+	block_t cur_lblock;
+	block_t last_lblock;
+	block_t pblock;
+	block_t lowest_pblock = -1;
+	block_t highest_pblock = 0;
 	int nr_extents = 0;
-	unsigned long nr_pblocks;
+	unsigned int nr_pblocks;
 	unsigned int blks_per_sec = BLKS_PER_SEC(sbi);
-	unsigned int sec_blks_mask = BLKS_PER_SEC(sbi) - 1;
 	unsigned int not_aligned = 0;
 	int ret = 0;
 
@@ -4020,8 +4019,8 @@ static int check_swap_activate(struct swap_info_struct *sis,
 		pblock = map.m_pblk;
 		nr_pblocks = map.m_len;
 
-		if ((pblock - SM_I(sbi)->main_blkaddr) & sec_blks_mask ||
-				nr_pblocks & sec_blks_mask ||
+		if ((pblock - SM_I(sbi)->main_blkaddr) % blks_per_sec ||
+				nr_pblocks % blks_per_sec ||
 				!f2fs_valid_pinned_area(sbi, pblock)) {
 			bool last_extent = false;
 
-- 
2.43.0




