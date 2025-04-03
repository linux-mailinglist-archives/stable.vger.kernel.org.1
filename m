Return-Path: <stable+bounces-127737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3379A7AA2A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC947A7131
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4819257AFF;
	Thu,  3 Apr 2025 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMmvf74m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90278257AD8;
	Thu,  3 Apr 2025 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706984; cv=none; b=TAsHdRHjLEMhQIAPr78XhbJl15uWSWpXhA2NWZvuc8TCvSnl9hqhzZo/vPbiObPBQwX7HKO4A54kfjaCsMms3XItQiqb9NIZVPj4K6h7ASjVR4OyqueIW9I5e/ADx6TP0jL56u0B8+EU875YO25AI6b0I5/THdoOKYLhazJRfuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706984; c=relaxed/simple;
	bh=W2ATL21afu9p6lw2AOIcDWMnQ5dX22vrVpbWXYRsq4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jFHoKkCWvEDL6ABF0KbzCtEx+cbbwP44X0+Ad8Xe52XuwvEJQtmCqmB9O8FIPbxGlBq/ok4qG17Wp+cs2sbTYGepydaUOVbGvEoksou4bzpfXGV7o7mFY5/QGoYrmFGyoD4GhTkL8iL38WV7crcu9c8B3IRutHySixjea7lCbjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMmvf74m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7740C4CEE8;
	Thu,  3 Apr 2025 19:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706984;
	bh=W2ATL21afu9p6lw2AOIcDWMnQ5dX22vrVpbWXYRsq4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gMmvf74mbVFrzAG73/LUJ8ra3Z7dWuRJiN0iDz1r1dV+2mF1kPDvqGNbbdLiVKNJm
	 YTXQpBeIZF9/HtPwfmDW04U2ud26wme0Mtg3T7F+cB2fexd0VUVS91JjT+xqJSq/9+
	 KZq8l7PgvVY1zgH9sC/wDVRbeaQhctJ59fiYfqMnnyI7ihtzl0FPI5av6w6cQpOTgC
	 nsv9Z/t5GSp+TVgaz4LyKmvHhVnlNKJ2mKJ6VCw+CVxdhH2l59M3SY9rE8n63w43XE
	 1fBLQQflF7iPQyZNNbF0GRLOe7/e6bC1S6fXG0BxnoAWshHDUM6Evd/CmE7XmKwLgh
	 P1t55yW8Cr8og==
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
	niharchaithanya@gmail.com,
	ghanshyam1898@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.14 22/54] fs/jfs: Prevent integer overflow in AG size calculation
Date: Thu,  3 Apr 2025 15:01:37 -0400
Message-Id: <20250403190209.2675485-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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


