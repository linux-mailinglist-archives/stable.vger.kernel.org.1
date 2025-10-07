Return-Path: <stable+bounces-183503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3EFBC01E6
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 05:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968F0188F35C
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 03:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A72216E1B;
	Tue,  7 Oct 2025 03:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzFhcbwm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE0E20322;
	Tue,  7 Oct 2025 03:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759809225; cv=none; b=p9XuySZS0cRlipR+rh2vHysikEncScQtKE/6uoQNPCWCyOu2lgSoD2VjU9wP9qZBFGXHcVv8kG5uK0L1ncy4kRLAEPppF5PoafI68mZnzXEqFuznhH5u+LOxF8c+8g2X26IYiJsk7IJP5RRNFJx5is0s75sgu7DYKHmaami8jyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759809225; c=relaxed/simple;
	bh=h6Jczh/Fz0AUxzV1CKO9gaYdchSp5gAD7ftbxcwDyUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ujFQ//wpcyMlO9MXytD6/prO0Gs9qH8EtF405dXAVostIV9yg8vBFQ67OVyIENuWxz/PrrmbMjPzOwH2CXqpF9tWMigpNehfE/uEtIUEZPyqPNmk8XYXmEn2wPN03MQTgf08FZWtTiZb6oZvDyCoT599+vwAoEugVVDQQ0WZibA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzFhcbwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122C1C4CEF1;
	Tue,  7 Oct 2025 03:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759809225;
	bh=h6Jczh/Fz0AUxzV1CKO9gaYdchSp5gAD7ftbxcwDyUg=;
	h=From:To:Cc:Subject:Date:From;
	b=PzFhcbwmmInvQaN42CgurB0j8XEH+v3cidshNWYZ4JAIdaIBPibAuFlo4m1fCXZ08
	 XjDdk7mH4pti7Ro0oNMX+jrD1RIF3TroxgtuVRaoqhgQPVNVeCxqA/qVEzfiMtpNlL
	 ZrC4QPwFUpIWkUfzsqUHSF68vWi4hI2G+Xezo0DZpW0P5eU/ZQ7A2y4R/CbqZhBnoO
	 M59W99HS6wSGK3vJGngL60qnYy5RPcuUIsHIzquaB2OvNxps2pRr+qNJj/ylm5vfYk
	 8mBZgXj/3a2Q9qnqat63q64mg6F+HgWhHeTe+6fK8qw/eAvY+Ajq3Z9+fx3TkUIbbT
	 sX9PGjWlttJAQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: fix wrong block mapping for multi-devices
Date: Tue,  7 Oct 2025 03:53:43 +0000
Message-ID: <20251007035343.806273-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ef38e62cda8f..775aa4f63aa3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1497,8 +1497,8 @@ static bool f2fs_map_blocks_cached(struct inode *inode,
 		struct f2fs_dev_info *dev = &sbi->devs[bidx];
 
 		map->m_bdev = dev->bdev;
-		map->m_pblk -= dev->start_blk;
 		map->m_len = min(map->m_len, dev->end_blk + 1 - map->m_pblk);
+		map->m_pblk -= dev->start_blk;
 	} else {
 		map->m_bdev = inode->i_sb->s_bdev;
 	}
-- 
2.51.0.710.ga91ca5db03-goog


