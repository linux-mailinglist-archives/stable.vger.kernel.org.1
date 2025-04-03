Return-Path: <stable+bounces-127837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7C0A7AC3B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C13C1895C69
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE30257444;
	Thu,  3 Apr 2025 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmujmMXj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AE6257443;
	Thu,  3 Apr 2025 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707207; cv=none; b=JtJ30ngLcCVrtwTiY6EGy2Jd1W3h4uS3jNuJP+/jQJwaMGzmP9HzPHJ09vcKNuGnveQaGm1l1+MDAdKc1DH+Qyg0cwTlsvIJcQHnfI1EamBWfVr8f2nB4mYcP0m+BlxCL5LhXg927Wz/hlFPAFA8nLW/4AxYjFZWR8oaU073tHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707207; c=relaxed/simple;
	bh=Yi6NBWvt1kWSbty3oBCwzar1OFqmjwSEF8xkY7+ToHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WVw/EdLLtatTuT+fpUN5qsKh7IM1Fd+qlmJUhP9Rg1QzNOCfGY/FGzCT7uDeOw4a2LgiU7OKgRvgCyegCt+i0ZSh0ouKrC+D8ugKRQTLFIct2Db7PTsDMbhkgXGsVByTLwwjk2ZFop/F4YT/PAIgOdv+5VWGRu1ul40LaAyjeCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmujmMXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DF6C4CEE8;
	Thu,  3 Apr 2025 19:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707204;
	bh=Yi6NBWvt1kWSbty3oBCwzar1OFqmjwSEF8xkY7+ToHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmujmMXj5R4y8bUv+2NxUaHxgh/mEOFCbjq8i0B9e/KcgR+jVgj8W1M1CEyBBWXMx
	 CWPMGK2b7aZDF4SirviVEl2YVX64q4BBcHIRokB6hfR1yU18v7+BGg1NeP7MwvBmIE
	 CDOfnur1RiUDW7Aid+0MAOjbo9LXAOinvKZsdtVNx4jCeaLjOP904m0aIvpDL8k5jq
	 w8v16oXGhR/6CxkM4LG30Eq/X0waRmVhK7pDEF1SvoqXwW52dzzCxuy/BDoP930+ha
	 GLb11sWl+1HyJz4BpKfx98e58nVfHIdiQAc2+I3crAvu34u99QBId5APVNp5hAIcaD
	 8LrAyPPeu6tFQ==
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
	rbrasga@uci.edu,
	niharchaithanya@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.12 19/47] fs/jfs: cast inactags to s64 to prevent potential overflow
Date: Thu,  3 Apr 2025 15:05:27 -0400
Message-Id: <20250403190555.2677001-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Rand Deeb <rand.sec96@gmail.com>

[ Upstream commit 70ca3246ad201b53a9f09380b3f29d8bac320383 ]

The expression "inactags << bmp->db_agl2size" in the function
dbFinalizeBmap() is computed using int operands. Although the
values (inactags and db_agl2size) are derived from filesystem
parameters and are usually small, there is a theoretical risk that
the shift could overflow a 32-bit int if extreme values occur.

According to the C standard, shifting a signed 32-bit int can lead
to undefined behavior if the result exceeds its range. In our
case, an overflow could miscalculate free blocks, potentially
leading to erroneous filesystem accounting.

To ensure the arithmetic is performed in 64-bit space, we cast
"inactags" to s64 before shifting. This defensive fix prevents any
risk of overflow and complies with kernel coding best practices.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index f9009e4f9ffd8..f89f07c9580ea 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -3666,8 +3666,8 @@ void dbFinalizeBmap(struct inode *ipbmap)
 	 * system size is not a multiple of the group size).
 	 */
 	inactfree = (inactags && ag_rem) ?
-	    ((inactags - 1) << bmp->db_agl2size) + ag_rem
-	    : inactags << bmp->db_agl2size;
+	    (((s64)inactags - 1) << bmp->db_agl2size) + ag_rem
+	    : ((s64)inactags << bmp->db_agl2size);
 
 	/* determine how many free blocks are in the active
 	 * allocation groups plus the average number of free blocks
-- 
2.39.5


