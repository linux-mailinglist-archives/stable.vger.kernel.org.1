Return-Path: <stable+bounces-127789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C33A7ABC1
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4133BA960
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A39264A60;
	Thu,  3 Apr 2025 19:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvZ4XwH5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863C526463D;
	Thu,  3 Apr 2025 19:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707095; cv=none; b=psQDGM/E1tsE3BXLrxLDU5QpPj2/A/29an72wsfOKy31hOakqEenQQ4Hw0BWTxvgpXJtRhfBaXkiIOtdCjtZA4UxgtACQfX8JuDHEiAFV7nDXu3DOSqL5KU1ok/ycXBVMP2a9niV0yKLdzMgv+I8EqrYkFkDoKBIG3izsEhZfo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707095; c=relaxed/simple;
	bh=W2ATL21afu9p6lw2AOIcDWMnQ5dX22vrVpbWXYRsq4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rf+zSBG9xkbbikozs4Tt3XLrGiJiWkYWAQG8wz08m5bG9VH6+zEfSOYCz22inwf2zsVcK7F4q0TLhwDn630A7Dzaojapj3Z96ao0FLUCL6zllcyomp+A9eBFZQ6AsfRGQfaUGrzvPemvZzaF+d6BFDvie7PIFE730E1IAaSzhOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvZ4XwH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150FFC4CEE3;
	Thu,  3 Apr 2025 19:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707095;
	bh=W2ATL21afu9p6lw2AOIcDWMnQ5dX22vrVpbWXYRsq4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qvZ4XwH5yCxyp+RQN0m3971EPqmwxJ+OYfGDlRMvLDVJz4pmnjahTkmf9KWXh7G1E
	 VvPUdh+p0Bp1Ky979BjF3vahI2f91c2hV3Vs10qMXex/Y+vft10OqHgXR84BwRwsZI
	 Zh4NOHRlRXNLE0fg/ccSKuwW7nYf0uR/7ThsBGnYQy5FVUsHUNoYqh5NaCLkiCWj00
	 +FZ9dmj11QaSrV2cXQ50q4ytQiQxt7RLsvp9GuD+rnPOGKDn2yGnGPDivrszm+bZIH
	 rkQbw/yiDqEIXIO0PafWNwB8aQHIWq8U6RlI5AzTor4Z7G7Z5NcJROG8AQXj1EdwXQ
	 zy3Yf5YWkPgKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	eadavis@qq.com,
	rbrasga@uci.edu,
	aha310510@gmail.com,
	peili.dev@gmail.com,
	niharchaithanya@gmail.com,
	ghanshyam1898@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.13 20/49] fs/jfs: Prevent integer overflow in AG size calculation
Date: Thu,  3 Apr 2025 15:03:39 -0400
Message-Id: <20250403190408.2676344-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Rand Deeb <rand.sec96@gmail.com>

[ Upstream commit 7fcbf789629cdb9fbf4e2172ce31136cfed11e5e ]

The JFS filesystem calculates allocation group (AG) size using 1 <<
l2agsize in dbExtendFS(). When l2agsize exceeds 31 (possible with >2TB
aggregates on 32-bit systems), this 32-bit shift operation causes undefined
behavior and improper AG sizing.

On 32-bit architectures:
- Left-shifting 1 by 32+ bits results in 0 due to integer overflow
- This creates invalid AG sizes (0 or garbage values) in
sbi->bmap->db_agsize
- Subsequent block allocations would reference invalid AG structures
- Could lead to:
  - Filesystem corruption during extend operations
  - Kernel crashes due to invalid memory accesses
  - Security vulnerabilities via malformed on-disk structures

Fix by casting to s64 before shifting:
bmp->db_agsize = (s64)1 << l2agsize;

This ensures 64-bit arithmetic even on 32-bit architectures. The cast
matches the data type of db_agsize (s64) and follows similar patterns in
JFS block calculation code.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index f89f07c9580ea..9ac1fc2ed05bc 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -3403,7 +3403,7 @@ int dbExtendFS(struct inode *ipbmap, s64 blkno,	s64 nblocks)
 	oldl2agsize = bmp->db_agl2size;
 
 	bmp->db_agl2size = l2agsize;
-	bmp->db_agsize = 1 << l2agsize;
+	bmp->db_agsize = (s64)1 << l2agsize;
 
 	/* compute new number of AG */
 	agno = bmp->db_numag;
-- 
2.39.5


