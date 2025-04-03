Return-Path: <stable+bounces-127788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5D0A7AB8A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923BF189A4E2
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32A0264614;
	Thu,  3 Apr 2025 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQ5hHXz8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD1026461B;
	Thu,  3 Apr 2025 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707092; cv=none; b=m2yw+Z0EFJ9pnI1o5AORTtr0I4isPwMHp7mRDE1o6UBGGQq/D0AR9Hclq4bUKpEjIecV+P9v9LkgCLlh8KbV0WNGzygABWcG3cwaXKlyZaFd6r+Ol4RTavZd0XR6+VVmQPMviUgCGkHfnBTzrahKtStsJ2I4pS+E5keBK+sU3to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707092; c=relaxed/simple;
	bh=Yi6NBWvt1kWSbty3oBCwzar1OFqmjwSEF8xkY7+ToHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JqC+RcUD+44+ySccjfqxoFDHoJO6Qv4sQ31zvuHgbN+sj+6ujnRfg19JwNmZQuyAdNDWKsCa/BmG4OYh8vAs+jBAcEtmlHXZ4NPmD5cRoeKIgS0iC6gOFfeOycXJbPVol8/+4wAP/9PqfHDGI0rtpauBX7/OH5WXaN74vwzDfDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQ5hHXz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAE8C4CEE3;
	Thu,  3 Apr 2025 19:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707092;
	bh=Yi6NBWvt1kWSbty3oBCwzar1OFqmjwSEF8xkY7+ToHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mQ5hHXz8jPoX1Ner5/PGHEyXlEDdos5dA3aJ3MYqtK265fca8yhTd91G+wCa2Ntal
	 Sv/Zlpz5VqsGjFLegKOqWmiHok4uMdGhaBmzomSmFkh9kWmBytRpt4gKJ+auxvWAsK
	 4U731va58WN9jdVegFVAi4NwCHuiwNu0gaIvhv8CVKP0bPMe5YR8TO5soIKWVjxxrd
	 Z4V5TgJ2r3UhYk+wBZAA/AX4ykJ8vwVRlDiZL3YEsLZz+Lv5qC1Nadq2CUHQDihl5Y
	 dVhTziuGLsNmr2a2Fl8ovIU3pY4/HnowiHJ7Jt8h9ZrH/Sb6/rTz1WQF+lNW3bEUT2
	 wZVfzNbLkKd4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	eadavis@qq.com,
	ghanshyam1898@gmail.com,
	rbrasga@uci.edu,
	aha310510@gmail.com,
	peili.dev@gmail.com,
	niharchaithanya@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.13 19/49] fs/jfs: cast inactags to s64 to prevent potential overflow
Date: Thu,  3 Apr 2025 15:03:38 -0400
Message-Id: <20250403190408.2676344-19-sashal@kernel.org>
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


