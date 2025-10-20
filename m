Return-Path: <stable+bounces-188254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D87BF380A
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 22:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9331A34F05F
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 20:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE1F2E370C;
	Mon, 20 Oct 2025 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eApJyQqh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3BF2D63FF
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993494; cv=none; b=nJ1aiRLh476OsYZ14IJj3rYIdpOWVBwkbu32HgSUC+tgyHCT9Shp7rOOLPDOoVE2IVh+pcYBOpk7b8crNtZTDKvLvLo8bNIYFLCQXjoP+6mS4lK2wBIeAPMTwjeekWFTtnh4T5EVbnHPQQHoNNAZ9JCuJEgRQt9qwf3jnjxql+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993494; c=relaxed/simple;
	bh=IZhI2K19l8WzUqz6/h7zNepNv8JBMRIP3t4TsJgb9E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfKQVBqqrwHNAjAzDWidsocoyic0kOLN2Y6C0mMdySXeWyFI2s7gLNSM57B0qkMRwEKygj6QGZy0nIefWo1X3+s2rJvCszVgGuaxcEru246PgL7jIQYHUf/j+XIdR69inZy3Rv08P+ItBSBgXSNS7a5UpW+hwYsn1eLLA7GpiZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eApJyQqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250BAC16AAE;
	Mon, 20 Oct 2025 20:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760993493;
	bh=IZhI2K19l8WzUqz6/h7zNepNv8JBMRIP3t4TsJgb9E0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eApJyQqhAZdDjCcd4o3DpUykFljdq0ZCOEATVD/c/OZP6gkhdEvACeobNi6OM7AoX
	 fRY3w1zTgKz4oBYt61pFBW333wpwgMyRkCeTQ6Ms13pCtPaDugzVq/5Fo3VFfSucRx
	 4jCd5LqCZn67BNHr+NPFjMNRiTi8EULC3hEfr55t/o+mcnjdnUKr3rkmXp9e8/B5ZV
	 9SIISS6C6nEaN5CeENJKQft8dYSp2X9h1XdrzFL1mfbvl6OPWge/SmsXcgUJlzmB8N
	 2QTme2vwMGV6mPPgj3zLVhBRKSUpHbA0YzjsFGVaxJE/sJnr5IrYfhN/wKMQQTTX4Y
	 l3erNEMRgs8AQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] f2fs: fix wrong block mapping for multi-devices
Date: Mon, 20 Oct 2025 16:51:28 -0400
Message-ID: <20251020205128.1912678-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020205128.1912678-1-sashal@kernel.org>
References: <2025102052-work-collected-f03f@gregkh>
 <20251020205128.1912678-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 9d5c4f5c7a2c7677e1b3942772122b032c265aae ]

Assuming the disk layout as below,

disk0: 0            --- 0x00035abfff
disk1: 0x00035ac000 --- 0x00037abfff
disk2: 0x00037ac000 --- 0x00037ebfff

and we want to read data from offset=13568 having len=128 across the block
devices, we can illustrate the block addresses like below.

0 .. 0x00037ac000 ------------------- 0x00037ebfff, 0x00037ec000 -------
          |          ^            ^                                ^
          |   fofs   0            13568                            13568+128
          |       ------------------------------------------------------
          |   LBA    0x37e8aa9    0x37ebfa9                        0x37ec029
          --- map    0x3caa9      0x3ffa9

In this example, we should give the relative map of the target block device
ranging from 0x3caa9 to 0x3ffa9 where the length should be calculated by
0x37ebfff + 1 - 0x37ebfa9.

In the below equation, however, map->m_pblk was supposed to be the original
address instead of the one from the target block address.

 - map->m_len = min(map->m_len, dev->end_blk + 1 - map->m_pblk);

Cc: stable@vger.kernel.org
Fixes: 71f2c8206202 ("f2fs: multidevice: support direct IO")
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index dc1ffdcbae889..3f67b04fdb747 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1486,8 +1486,8 @@ static bool f2fs_map_blocks_cached(struct inode *inode,
 		struct f2fs_dev_info *dev = &sbi->devs[bidx];
 
 		map->m_bdev = dev->bdev;
-		map->m_pblk -= dev->start_blk;
 		map->m_len = min(map->m_len, dev->end_blk + 1 - map->m_pblk);
+		map->m_pblk -= dev->start_blk;
 	} else {
 		map->m_bdev = inode->i_sb->s_bdev;
 	}
-- 
2.51.0


