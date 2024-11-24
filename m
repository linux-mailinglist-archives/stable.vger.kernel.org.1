Return-Path: <stable+bounces-95183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFF39D73F9
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55C028B58E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068BD1E1C2E;
	Sun, 24 Nov 2024 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8LuKRRB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EFB1F8729;
	Sun, 24 Nov 2024 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456261; cv=none; b=S2Zr7RtkrdCgezIxfR1/EKYrJ2jLXgw5in0OYoPoywM1NJlvN//cCAWkRFCr0gm9PJgV/JavUOZh7QQYJUhgc3qG37tPbKbUyr7WNZO4hMnvqsMmRDuTPqnI4tWalBlGH8uTDWMk+DqIueKikG1SqUi4qoJliICfO2z1WBU09gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456261; c=relaxed/simple;
	bh=VP0taqpeoaeCL5uOvCJOIqfJ5CCdeNL8ReskrgAZ3Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBtZGh2I3kGeuKyjlt2ehzxLVt8f1tn2boYe+3IEQ4v0AHR3o0MUoVGwG4FbUfvalSJ0CGchATupNnoFN+01Tpnze7n/LS7oFO02aX82jGmXgJ+6LPVmCK0Wz9rY7cMxhdt+mhZMbENCf6kHCDy1nJNthl+l7s5SSGimR1K9Z5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8LuKRRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9693C4CECC;
	Sun, 24 Nov 2024 13:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456261;
	bh=VP0taqpeoaeCL5uOvCJOIqfJ5CCdeNL8ReskrgAZ3Zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z8LuKRRBQv1meQmG2Vc5ynCdDCcP0ENVGyeJh+Jlyv5I3ABBhWGs8kYbBYT2KTxUf
	 ojc3G+SmmGIJDOM0u1yMgE0wt9vgY3Ykfx1a3G44so/B6HbwZXqxDx9vintuzybABE
	 N4AbhAQK7pT813UyzkZzjbE9dRyAAThXqEAhvKAtE2n9K6v5QzMK0142JqP1O0S/F0
	 bVEhm68yS/X3ZHWFn0+Ucm44bqaSu6vPI28NCfukQp4VkGgrD9hLi8zu87FfT7Y8LK
	 xeO2pi7u95k3V7Im62wGhd9NbzZSta3llV1VyNcqPRPTIj/O6il7UnVYEzIBnnqOG4
	 4UjWBO55jTSZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	syzbot+b5ca8a249162c4b9a7d0@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	rbrasga@uci.edu,
	aha310510@gmail.com,
	peili.dev@gmail.com,
	niharchaithanya@gmail.com,
	eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.1 32/48] jfs: fix shift-out-of-bounds in dbSplit
Date: Sun, 24 Nov 2024 08:48:55 -0500
Message-ID: <20241124134950.3348099-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
Content-Transfer-Encoding: 8bit

From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>

[ Upstream commit a5f5e4698f8abbb25fe4959814093fb5bfa1aa9d ]

When dmt_budmin is less than zero, it causes errors
in the later stages. Added a check to return an error beforehand
in dbAllocCtl itself.

Reported-by: syzbot+b5ca8a249162c4b9a7d0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b5ca8a249162c4b9a7d0
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index a6b1d748df16b..30a56c37d9ecf 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1820,6 +1820,9 @@ dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno, s64 * results)
 			return -EIO;
 		dp = (struct dmap *) mp->data;
 
+		if (dp->tree.budmin < 0)
+			return -EIO;
+
 		/* try to allocate the blocks.
 		 */
 		rc = dbAllocDmapLev(bmp, dp, (int) nblocks, l2nb, results);
-- 
2.43.0


