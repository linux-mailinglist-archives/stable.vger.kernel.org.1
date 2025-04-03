Return-Path: <stable+bounces-127943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7411A7AD77
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61A1167E89
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC6425B690;
	Thu,  3 Apr 2025 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jizet1Wz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB5E25B68A;
	Thu,  3 Apr 2025 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707447; cv=none; b=iP2jtGW/KbDU8KxoiPvBJG/CQZhJ7BOt/xqY5+vVTKe2f2jKnSPYGHOTp+YsNPi3tE69cY5COcJcMcUojkGljrNPJshE5Xg1+k0zjn40y2kUBqrj7BBGiQsxG3SFXKy+2H8iMXD/UTCpIcTUhIzg8IJVTRXo/10/DrVo+QxtdW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707447; c=relaxed/simple;
	bh=fYUSiDF+hdZ8Tfwa8yOd1HL4760yY0ZgPruEJWbN9+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mEV8x48DttCOSbe557fApJiFXMyvPMuTB+eCPr84iQFqMbVF0mw/jZQ9GidXzj8FWzU0G9iEuY06OSOr2AHvXxWN2ERiPE7CS6TCVTswBqRJrAkIp6OcygeONpFYXS34K4dyX6pzd0asaxf/jU0z06+ROGpN7vLSONR4LRnEPCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jizet1Wz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02D1C4CEE3;
	Thu,  3 Apr 2025 19:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707447;
	bh=fYUSiDF+hdZ8Tfwa8yOd1HL4760yY0ZgPruEJWbN9+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jizet1Wzt+oZijI1KZFLChO6ap9Y53fX2cwo1+TjfIpg1pE1N9mMB5HN7M1bmhes6
	 Nj7MRG/cIXtP0u7MpFPz6PZQUVysLUFn7XL3GaTK2+3/S74H2Q65id5Cx0sTZMzNJa
	 QP2jZTr0AD3/rhb80cwNz8p1TfEaWpC8YJUqNWRgaEKTyuJAUKYthZ3sadJkLUZBwN
	 uDwB+RsHh7LbB14D/dy8nO7FMDVaqV53yddZFIXFcRD7AII+wc9VmDeKIACIKdqURU
	 MPGzhM73K/KshUoTdTwj9V9RqPtimvgnSoh0L7zPLrMVxqwteeD7S2EPHvIhU9WKui
	 zt/TtAoN4LkZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	eadavis@qq.com,
	peili.dev@gmail.com,
	niharchaithanya@gmail.com,
	aha310510@gmail.com,
	ghanshyam1898@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.4 03/14] fs/jfs: Prevent integer overflow in AG size calculation
Date: Thu,  3 Apr 2025 15:10:25 -0400
Message-Id: <20250403191036.2678799-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191036.2678799-1-sashal@kernel.org>
References: <20250403191036.2678799-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
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
index 3bc304d4886e6..d4e26744b2005 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -3465,7 +3465,7 @@ int dbExtendFS(struct inode *ipbmap, s64 blkno,	s64 nblocks)
 	oldl2agsize = bmp->db_agl2size;
 
 	bmp->db_agl2size = l2agsize;
-	bmp->db_agsize = 1 << l2agsize;
+	bmp->db_agsize = (s64)1 << l2agsize;
 
 	/* compute new number of AG */
 	agno = bmp->db_numag;
-- 
2.39.5


