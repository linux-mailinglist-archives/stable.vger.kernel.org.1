Return-Path: <stable+bounces-95310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3997E9D764D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 18:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04A37C00186
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805521EB9F3;
	Sun, 24 Nov 2024 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E57U2SZ7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBAA24E589;
	Sun, 24 Nov 2024 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456659; cv=none; b=BRch56iW94R7D3T6Ol2mdo2REGjmDqZVVERzHvylVn1SRFnFp3gC2IK6Bd9jwiza2SjoGB5ELsROqqWIPuMi8Vk3Yc4EuGfqEoCaHGVrtOtfYgORJnPxB1/iORtxwgGfRTHEz2OX2xEgSQuXSXyRuEh8B7JDnXLnsHqKh0TZ02g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456659; c=relaxed/simple;
	bh=9Od5JDeAk14YjcF+ZGPXHt4neugAoQwO7pAs5NXydnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+Gnr95PaxjujGOHMnP7+y28AcyvTt2axwhlX650203R991gZghPfpd0154nLXw5XttZ1ygeHRwFp+Ok/Y/N+rDlfUN8Lo+uhNLViM+iS5H8hgWVkI/H2aWRLsNAwHIS/TacED90EJHzC4LudE2ix4wRPb7VJWjPp1F+AdwPVcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E57U2SZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBBAC4CED1;
	Sun, 24 Nov 2024 13:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456658;
	bh=9Od5JDeAk14YjcF+ZGPXHt4neugAoQwO7pAs5NXydnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E57U2SZ7K6PS1viro1KPAQ9RogdBjoxxGZgjT7P/NAD62CDJ0uz++JzBr+xCJaYio
	 TdNDswm2AohqzYomU+kvke9JiJ45BFAUK0Ev5JIWy7opskfFXSpdNFqNyiYiNolvpm
	 iwMLOzeVsUq03MFPZD027M6RWmz0ixXTlaoL8Se2yTOEbJxpJzhlpfNt1/ib2RJvPJ
	 wP+fh1UIq4ZFBsE0FxoSClz0DNiQpjtBuj3YAndJYSWm/HHDDffkMbqRopglnp9WAS
	 OYlY/5bPCvnCKwT9y6mcnt94A6DXK5GB/TMoxkHYhOh/v3MQTVCOHGQGugTo7LczhT
	 Ovz7g42FgpgUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	syzbot+b5ca8a249162c4b9a7d0@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	rbrasga@uci.edu,
	niharchaithanya@gmail.com,
	aha310510@gmail.com,
	peili.dev@gmail.com,
	eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 14/21] jfs: fix shift-out-of-bounds in dbSplit
Date: Sun, 24 Nov 2024 08:56:47 -0500
Message-ID: <20241124135709.3351371-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135709.3351371-1-sashal@kernel.org>
References: <20241124135709.3351371-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
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
index b6c698fe7301d..7bb2d0212c90a 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1899,6 +1899,9 @@ dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno, s64 * results)
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


