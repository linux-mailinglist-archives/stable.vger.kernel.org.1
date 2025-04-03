Return-Path: <stable+bounces-127874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C522EA7AC9D
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C52707A5BAD
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AEC280A3C;
	Thu,  3 Apr 2025 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyQ1cPtz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F98280A35;
	Thu,  3 Apr 2025 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707289; cv=none; b=oPiuHLf72TAQDiJ8e3/s1X4dS/dvXX/zoSUnV+WyPaSwBORkhutwyEGaLhpkvderE7RZgB96U/tvwKSgrtqFx1bC3zrUUiNHb+AMWAD1Q7DVKL+1g/DHjJl4YkQHfpoQjGNEJ3WfgLF27r/wQqYOQ9miclToAhG/XsLfMdefpIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707289; c=relaxed/simple;
	bh=W2ATL21afu9p6lw2AOIcDWMnQ5dX22vrVpbWXYRsq4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wg3SjmirTz04SzDVhfR1JGPQya3rHU0mVwVGd2tgm/sCEZqRwczdEZ1uaFKBhhJ1FZ+MdTdGf85WXwa10rU0QMVZvhYRc4s2vdZL6WCH6LGeTP/Qo1vFhab+HV334NZjG3fXi/VEk8xENVe8FF01LT2mxq/R8kIVyuxS0VW2FuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyQ1cPtz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1307BC4CEE8;
	Thu,  3 Apr 2025 19:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707289;
	bh=W2ATL21afu9p6lw2AOIcDWMnQ5dX22vrVpbWXYRsq4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NyQ1cPtzWg1U4/5cY4mIGzuuU3EZsRSWSH7+0jR+02xZwcZ4byHe3wUAhOWG/nUbp
	 iw+Y9ywqa3WQrn5ruUkbQ344/euCL+grmsdS+Tee6QvhYAinUbiXEaK+V387qtfIBO
	 MMxro1Rp3II2g5aOJm/suR/jn1v7O5dcwmkn0f5XmXwtm4FqzWyvQ6qYfmujea+HAG
	 RSqezsM3WXnLs6TKAUg0Jf03GbKJqF3rlXNExMsZX4dEMivRhdT5UpSGS0a3iAF/D4
	 0nkUAbuLlVyTtL/17HMCDuxrK78xkRhDBCy0qA+WWPBdAKYuk5mPrLL2sT3CCpQNFZ
	 VqJD8EcEsxQcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	eadavis@qq.com,
	aha310510@gmail.com,
	ghanshyam1898@gmail.com,
	peili.dev@gmail.com,
	rbrasga@uci.edu,
	niharchaithanya@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 09/26] fs/jfs: Prevent integer overflow in AG size calculation
Date: Thu,  3 Apr 2025 15:07:28 -0400
Message-Id: <20250403190745.2677620-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190745.2677620-1-sashal@kernel.org>
References: <20250403190745.2677620-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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


