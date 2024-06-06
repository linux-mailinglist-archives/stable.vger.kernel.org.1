Return-Path: <stable+bounces-48438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 517918FE904
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45851F24C2F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E566B1991A6;
	Thu,  6 Jun 2024 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rV0dE8E5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A483A1990DC;
	Thu,  6 Jun 2024 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682968; cv=none; b=Di0UafqnbqavJEoxU4LpYlLUBkBpii7exjAyRiJqnMPr/+eslIiHGq/nkPBBdTEwX7CluPfGVt3UUTl40e4sB+WFOMlHv+A7Xzolx0GKzfSYoauCweAkCuBZRJyAJyBTkJQ/i+7bIyewO/Rj8L8F4Q6Kj/bHRI6Wulh4d6EPlw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682968; c=relaxed/simple;
	bh=DMcjWPebRPuqGZQSdGkoMDYiLcNyBhEjO1lwIt/oJ78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mhly8PwjzbWz5BwGmfnm0ARx5nRusA3d7lsPBKqMbWqU2DhpaiAk8JJDGneLj8bOF6zKNqXuNTiaRIhMFVDg0mu54yx67nwSyWt0jcP2WZUL5K1MYRVA2d0dezTBuMfUbwgef06MEyWKp5Ut4r+3PmxVg4wYky28KDJZUQpHL+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rV0dE8E5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDEBC32781;
	Thu,  6 Jun 2024 14:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717682968;
	bh=DMcjWPebRPuqGZQSdGkoMDYiLcNyBhEjO1lwIt/oJ78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rV0dE8E5LB8d7lJfv335aFCVnXCWUxJXBG2DQUP/FacyfnjCVcqC6u7IyCDgqsfec
	 sf7MM0CuqbxHgd8Jph6oV2h78uZB4K4O53zhR5JLj0aZb5aGJTPSySvmPys6u4GVR6
	 tBGanB5MH7UFFT89FOwX9pZ8TrFdTd7bU8SJAttE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liao Yuanhong <liaoyuanhong@vivo.com>,
	Wu Bo <bo.wu@vivo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 098/374] f2fs: fix block migration when section is not aligned to pow2
Date: Thu,  6 Jun 2024 16:01:17 +0200
Message-ID: <20240606131655.180846762@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

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
index 5ef1874b572a6..5f77f9df24760 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3896,15 +3896,14 @@ static int check_swap_activate(struct swap_info_struct *sis,
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
 
@@ -3942,8 +3941,8 @@ static int check_swap_activate(struct swap_info_struct *sis,
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




