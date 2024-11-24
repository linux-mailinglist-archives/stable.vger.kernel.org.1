Return-Path: <stable+bounces-95059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6669D72AA
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507AF285F31
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BEC1D5CC9;
	Sun, 24 Nov 2024 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXHRVlVk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF861D5AD9;
	Sun, 24 Nov 2024 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455849; cv=none; b=CF1+e0blK9EphcE7bzvICyHTx3+SCfxNRXeadFOi/V2pl2xbL+t7rWRivVGTQpbUjlfyCMDGvPvAiyBnRoiRh6OCqQDZc7S4mBaRNJ1Q/Fv+5kmGoISk35f/BEQ97z+d+kpM7fR368Y67fzssUQ9we4TvhkgfHwZpWXuE2qZLWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455849; c=relaxed/simple;
	bh=7SeF0gTH/JLCX/yvCisAO4zHQS3KiWhTn9A9Mtcwta8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBXlCEAuLdfc6hf6GePKVdynOicJEpzWQxj+5n2TyD4uKGjSkf1RBXmJwSpoq/y2gaT0ib1q4ezSzmYpC+10jFT7occHhViw5O+LlONJYCbcYGpcVCwn12oP5kbUAbhbRfUh5UBISftXniLQmSNe2yPkgAe3OPIScBue3sGRlv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXHRVlVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59692C4CECC;
	Sun, 24 Nov 2024 13:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455849;
	bh=7SeF0gTH/JLCX/yvCisAO4zHQS3KiWhTn9A9Mtcwta8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXHRVlVkCKNPv/A2/faRH8tx0bCPNOhFP3EHbcERy9/4vkZFtqrcdtMPajb8Q5exT
	 ULIqqcMZ1rZOY3I8gIUh0i+UQabmBpgrhuHb2BTNdEYNHaGGSXmMZooZmVsZBq53rG
	 E1hdE2B8KjryHBEnvoIc34mkproo+U3rtNEFeySm5JdAPspK6DoHLmlv1jSfvWVx70
	 wnepJUuIz2CqdiYYn47Iszi31fSXSraZIUuYgQZJatN8CJHFvpAyKKNKH8TnlCSTfL
	 U0hqWzWdx5DusZ6jKiWLNzmStfHHcjELi/0FLoEqBEUrOhds7N8+qEdYmE4Q+Hbfzz
	 F8B1U6swH4GHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	syzbot+b5ca8a249162c4b9a7d0@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	niharchaithanya@gmail.com,
	aha310510@gmail.com,
	peili.dev@gmail.com,
	rbrasga@uci.edu,
	eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.11 56/87] jfs: fix shift-out-of-bounds in dbSplit
Date: Sun, 24 Nov 2024 08:38:34 -0500
Message-ID: <20241124134102.3344326-56-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index 3ab410059dc20..39957361a7eed 100644
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


