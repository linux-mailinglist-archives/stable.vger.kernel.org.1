Return-Path: <stable+bounces-188265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED07BF3C9E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 23:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E15C4E548B
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 21:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581012E7F11;
	Mon, 20 Oct 2025 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghE8kOoq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C041E51FA
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760997140; cv=none; b=uoG51mi3juAj1oFXpVuddeicSgyv3Vwbjw8LlIPp3hX2IDTWvzcMqDOTWkc6/X8EqUG71wufHhhquaRnAmuc4LIJyotEe1EW49225aQNdAF/S1ezcH1x7NPoBqiZBY3Z7fH3q9CLhUgQ1+9eKi3cUPClMBth9Aeh1kVamlCCb7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760997140; c=relaxed/simple;
	bh=eZz3AqtKwhNbMuysRY6IAo+y2X77FUelEBvfoi3JHs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtGeHj3+GSnwCRTaHuuopCM7i+qweNX2/Ez8yML5ThOvM79nS2lPmem4smOiQXQACX2NVZ1ADeEMbqFDw8yQMIMoxHoly4Uev3XnolbhhePp5K7BFjPko+HakzajSSfrP9nujogTmdCeou6XMS8GNU7yUy4W1huCOB5weNRhEfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghE8kOoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DBFC4CEFB;
	Mon, 20 Oct 2025 21:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760997139;
	bh=eZz3AqtKwhNbMuysRY6IAo+y2X77FUelEBvfoi3JHs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ghE8kOoqAhhGAX9uySVpKOrNSlsVoZZ9gzDpI0msAlOt61Hv2h5BWUEsjWpo6TCPg
	 Te8E/ngCXGhtLPxlX1AjwmnNIVX0S8p7ryaz2MaSC+3/6rQnsIWVd4GjY/cUuiVhq6
	 MFpyDymszeTZ3ZiAhfubX+pZwveGFSQ1OL14luf/qpdaNPfXD1OMk1oEQeWqLyCunw
	 5SKzF9VtnLfJqE9pmJ+RzQV49m4OMJRg70HM0ig1D5fsE4Dvtsm3Pjhl+0pAy0FFIs
	 RpHa6lDoQvonKF06saxyt7zMP2DaCGLA1vzzTHFYRDxB4nvtUPdIeMDTl6WSdFq0zG
	 pgdkNgC8S95kA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] f2fs: fix wrong block mapping for multi-devices
Date: Mon, 20 Oct 2025 17:52:17 -0400
Message-ID: <20251020215217.1928651-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102053-joylessly-pony-8641@gregkh>
References: <2025102053-joylessly-pony-8641@gregkh>
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
[ applied fix to f2fs_map_blocks() instead of f2fs_map_blocks_cached() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8843f2bd613d5..6798efda7d0d3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1505,9 +1505,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 			bidx = f2fs_target_device_index(sbi, map->m_pblk);
 
 			map->m_bdev = FDEV(bidx).bdev;
-			map->m_pblk -= FDEV(bidx).start_blk;
 			map->m_len = min(map->m_len,
 				FDEV(bidx).end_blk + 1 - map->m_pblk);
+			map->m_pblk -= FDEV(bidx).start_blk;
 
 			if (map->m_may_create)
 				f2fs_update_device_state(sbi, inode->i_ino,
-- 
2.51.0


