Return-Path: <stable+bounces-127928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0433CA7AD57
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B664E176CAA
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C887253331;
	Thu,  3 Apr 2025 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uStRUhsO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295582BF3D3;
	Thu,  3 Apr 2025 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707413; cv=none; b=LBuX67YEvja18hikhsMMxE3/ZZd6K1o+dMlk3DBeJUfcl78Pb6WeXP8gy1uFO03iFSbEgXZkPIuyR0/WJ9+wcBOYcAl2e5hLLy9SRj3ZpOKhTgN/UcopagP8fHM1bHCcSGL82D3zQ7oWUT0iVMFyBjjTfnpV71dRCNI8+iJbIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707413; c=relaxed/simple;
	bh=yVE+Gb/UncW9E68OJMQJZ5u/qrK+FuITcVfMxUpuaBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oZzYaaOpFe9fvC6aSJ+mVu+20jduZ1lfTrL4jJMHfeGHXVuLqCmq5Y3nofPb/wKaAGm0kRH6rrAFSgiB2HSlO9jlYHchDE3qKwjdWLfZQJQMIZGbDi9W8wMEmzJAHK0tDW30wrfqsRpHJ7dAIRF0xMLAFEA8cLV+PDldc9yGrwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uStRUhsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF811C4CEE8;
	Thu,  3 Apr 2025 19:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707413;
	bh=yVE+Gb/UncW9E68OJMQJZ5u/qrK+FuITcVfMxUpuaBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uStRUhsOH6XwBCV3VrrXoozqy37+9svYkChSPHQ1VLTfX0RhyoxzGwnkM1bVLgi5U
	 Aak9kfV5+kchhCeFtLOaQyF9Cw49BtiUt3Qbtt2VNSt2ma1LY3vFWDvmcXrimVcZFh
	 ZmVag0D+7z/YKWFHtyDPTuQODJaqLzoIqf7sIshDfyQHRT3fhBiAkd5/a3QCo4bhnr
	 MKgeZ0qfG59kNyNpnEvQCvcpcUTWp1uukw76f7SdhUu+YnnGz+1ZsXdknyNFcRuYd4
	 ZGRl75MbL/wCb8WD/fIKFgx/C7BCO351X0QwwCGCLjgE9tNya8PluPfKGAk68fmS3m
	 i+/W1XRTjjlHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	eadavis@qq.com,
	aha310510@gmail.com,
	peili.dev@gmail.com,
	niharchaithanya@gmail.com,
	rbrasga@uci.edu,
	ghanshyam1898@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.10 03/15] fs/jfs: Prevent integer overflow in AG size calculation
Date: Thu,  3 Apr 2025 15:09:50 -0400
Message-Id: <20250403191002.2678588-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191002.2678588-1-sashal@kernel.org>
References: <20250403191002.2678588-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
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
index 389dafd23d15e..3cc10f9bf9f8b 100644
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


