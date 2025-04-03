Return-Path: <stable+bounces-127896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3305A7ACFB
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492F0167120
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35333290091;
	Thu,  3 Apr 2025 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvoaXDna"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2B9290088;
	Thu,  3 Apr 2025 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707340; cv=none; b=VVfzvwPb7MnVDcJhyKTtT6hYJIINL2yZ7U2By+lS/bC3tX21y8VpdZxOAtFYFGZ5QKMsTRX6AOJoTxrwwbY+gFNzKDjRr5GYthwOa918kD4GQ4lv/nJ3vZYWVVY9RvvcXLn+nlpJ5Em3CKfyUg0g+/i17JD33h4kYPMWXeV3qM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707340; c=relaxed/simple;
	bh=ttmiWx3+Mwc3SZYHTVvJ7P+mUP0prsrgRiAnl8RsPlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CWzSrAeu0bmBoKxEKOLxa2qR7ZMMyLAThADwHy+96TkmQ0yyFs4ztWzhJTlcfpP2Z2xJAXZg39MifRRTKEyRZGyWlEOJayMZPks5wxqqii7zTqk3im2nrvti+1/XqGBvwZX4aURkoM7mCw++RIoiVGLeB3P6Xy8poHviUePaf1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvoaXDna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787B0C4CEE8;
	Thu,  3 Apr 2025 19:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707339;
	bh=ttmiWx3+Mwc3SZYHTVvJ7P+mUP0prsrgRiAnl8RsPlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dvoaXDnaRwRisjOh8VKNr+WNoOY6OVxJjx4QorpCol9otrUEO4LlwTVDGqX4eImQD
	 gupEwlLR6FOnjmSipaP6m1I37X/1f022gSzUmBz7ljq+zWkST9WWiv39QM15Csd87u
	 xlutJxw+PW8+yBoCGA1UZ60qsorjfWW7alOs/pGd6ulWg9/MsIqUbkM8NlVCW+6URQ
	 dbmUw4HvPnyAvTItjbo8jr+l0ry7J0mScrUq0AeuJxSeG2Ea2JLhc5+0k4cCrzgrKm
	 cRufUePurED47lbF/AR1F8/t0acEb5JkoteCL9ZE1deG+TV59qRTjOZ4pFHnJ9ZW2k
	 laxXIAB7tyDzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	eadavis@qq.com,
	peili.dev@gmail.com,
	ghanshyam1898@gmail.com,
	niharchaithanya@gmail.com,
	aha310510@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.1 05/18] fs/jfs: Prevent integer overflow in AG size calculation
Date: Thu,  3 Apr 2025 15:08:31 -0400
Message-Id: <20250403190845.2678025-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190845.2678025-1-sashal@kernel.org>
References: <20250403190845.2678025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
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
index 3d4c7373a25e0..11b6be462575c 100644
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


