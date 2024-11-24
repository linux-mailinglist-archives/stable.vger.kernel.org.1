Return-Path: <stable+bounces-94967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 405EC9D72B6
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C19B29C26
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767EC1AF0A8;
	Sun, 24 Nov 2024 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksguemwa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4F41E230B;
	Sun, 24 Nov 2024 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455442; cv=none; b=KbpCzRoZTnv3SLh2R2fI0i4gLVvFEp8JpCAu8Fb5gGHJTNLx2k6yh+qPhO1GlOualJ3e1/9yJ46D9N3jCJj3iINTtcWHTw5S30qV7DOCI2aeyPsquKZH1mmLSrQKXXVqaY5+JJw2LmpkCrROlMJN5BwivCf0HeHWkO4ift00iKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455442; c=relaxed/simple;
	bh=7SeF0gTH/JLCX/yvCisAO4zHQS3KiWhTn9A9Mtcwta8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnlmvshUhVeU+ebGVNVPBEn+/Re/JRq7dH1tiKe2tgjhhxNaTELsxyVO04r4Rggu1P0UiJ2PwbsyUwx8l9b9azKqNVr6QVU28hCb6MhmaxRXJjzgYAKaDTuPwFtjoFj4xZ3TVZ6tYEmXBouogEJggW65xgLN88h4z+YNWfGJYA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksguemwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A38C4CECC;
	Sun, 24 Nov 2024 13:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455442;
	bh=7SeF0gTH/JLCX/yvCisAO4zHQS3KiWhTn9A9Mtcwta8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ksguemwagzjILW0X3+l2fqowqtwQ6AfJUD7Wzll/ImzQWaLiSUZyrCHgUubVYII9x
	 k0ultHRYwzZPFdvcLu3jiCwp6/TZp+IxCoxSyJ/6vc5crc3RYl4P1YHkIWhoVgkNkk
	 9gYyVtvAQ8W0s7u6ztBNawzMocj/fb/VkIX54gmpRwrLdFI2hrqZT8E23wiSu1hzDV
	 4B7ko4d9LrXXm1RUxofSScmfJ+Pplb3O7U8Htne27i7IPlQyviv5MO280BE1+9LWZ3
	 DQIDmzkeHxNhCl5xvmWKe1PCZlwnknvh6b8ILxSM8VpWM/ByrQ9WXgvqSGg4r84SII
	 LclD3s3jpPpTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	syzbot+b5ca8a249162c4b9a7d0@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	eadavis@qq.com,
	rbrasga@uci.edu,
	peili.dev@gmail.com,
	niharchaithanya@gmail.com,
	aha310510@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.12 071/107] jfs: fix shift-out-of-bounds in dbSplit
Date: Sun, 24 Nov 2024 08:29:31 -0500
Message-ID: <20241124133301.3341829-71-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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


