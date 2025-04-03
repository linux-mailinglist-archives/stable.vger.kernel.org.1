Return-Path: <stable+bounces-127942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 980B9A7AD42
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD7097A55C3
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4363628A41D;
	Thu,  3 Apr 2025 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XijhNIfY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0012E28A3EE;
	Thu,  3 Apr 2025 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707445; cv=none; b=nZIOE8/nE3kSsKeNVevry6Wo36j9lg4PMeR6UwUtSBsySp2Q3qSreDl8tBG7jLYnsvIfbc7Mwx0W4yNmTRtA44/LP8FUzMRjaqOGxYDsQnD3eAQq/d+4rjGxNNN7ufYyKz2Q9jH5DdbLMPHNjro3ElphNL/66tuLanEbH7wwi+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707445; c=relaxed/simple;
	bh=eBQc9PCYZrCjyx8p39U2MG6elWbeNnZFG9NajQGLrjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OfU1okL5+Ius9PxLkYgroYLV7c42twmEalRCm/EQMt+VtNGqmjmjDQ3k7VCUTVjbwdUAq4z2c6SBpynHr39dv+HejYT5bBG3pZORM1ShCXk/An7hIoR1Q9m3adQoD1OD5yT7sLWrPbKmXsuzrSxJuTtCPs5j04z+5gi+Ht4ZXl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XijhNIfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A7EC4CEE8;
	Thu,  3 Apr 2025 19:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707444;
	bh=eBQc9PCYZrCjyx8p39U2MG6elWbeNnZFG9NajQGLrjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XijhNIfYdzuW6H8O87CofRR7amBg71WtLFsjFPVu9nHDHXi5puPCw/qsiUp1Ei7FK
	 T4s2qpREUBd7BKoDCLWejhmlFvfwXrVE1c/jCNmqF9SrV5hx2jUdjuVlC/ZMCAqgje
	 zEBYiPmosxtExwfJeD45g/tK9EK6vkD13A79ux5uFYHk6rqof3BvLKUGU1Y35IQHnt
	 sdaNg+iSBvShyKBioB62xmuZR4Luvkihc/dymfRdOZ+rpNmbnG/qx0oBOixYOl4Rc8
	 cde+WxbOuTWgHIhAF1wQuNHO8tULFv+vsSRzhQWOe/6nP4D9Vqwpf5uozkr18LKK96
	 lUQsM24vCxxQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	eadavis@qq.com,
	niharchaithanya@gmail.com,
	rbrasga@uci.edu,
	aha310510@gmail.com,
	peili.dev@gmail.com,
	ghanshyam1898@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.4 02/14] fs/jfs: cast inactags to s64 to prevent potential overflow
Date: Thu,  3 Apr 2025 15:10:24 -0400
Message-Id: <20250403191036.2678799-2-sashal@kernel.org>
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
index 812945c8e3840..3bc304d4886e6 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -3728,8 +3728,8 @@ void dbFinalizeBmap(struct inode *ipbmap)
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


