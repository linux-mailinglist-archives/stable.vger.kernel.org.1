Return-Path: <stable+bounces-95258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFE89D74A7
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6894A167D85
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3965244839;
	Sun, 24 Nov 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUAAaaVR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDDB244837;
	Sun, 24 Nov 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456499; cv=none; b=qOwJA90iqqDWuEbYmxfupi4PoARXUgW0iocNfOoNFOEiBa+OeyK2arVjnyjPiSFH/FvaBJb13MdcfFPSnLxD9I2G5oBrzfBdizf9lEWvzfE81vKfXyw1VQktPPfHhUUxeoCiMWuBtSe43Iq+u0TLclwYLvYMtYG4CFupYx2Iqco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456499; c=relaxed/simple;
	bh=XCbhBMU/JI1zM9eN8vKJngvuYK2k7hNwSGMKwfth/4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdR6q9UDXbakXlSlVCfuInIBoXNOd9UjykP90f49LKfwK+cKQFEojrbEM0uzsPRYR2yrq92FG3K7lLztOXU0YafvFqmYBPBB7hL3t+ol+zVmulAyqUZiLZSt/QXt901J/ybSfEAUQJE90jbEa1Fo/NoRDY51N+RgBSWwruPEMqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUAAaaVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3754DC4CECC;
	Sun, 24 Nov 2024 13:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456499;
	bh=XCbhBMU/JI1zM9eN8vKJngvuYK2k7hNwSGMKwfth/4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GUAAaaVRem+TkLfLFLwIy0c9xUn9OZlYoHCqijmqmcXL/LaqRI4cKJsDf3N+tnICy
	 cLCjyl6eLf096ApPYIw+NE613X3en9n3Z+QQY3czaruNZE8rkg/H69GVxLihuuBZ2Q
	 wse5aIVQVcdtEQi/r3NU9H/ORcZxzfafzT7IzFiKqUboEoSdk8Qg2xfWD0ApBH1aZz
	 4PPzxitqZnH9VbHbCSMdx5sZ67Ye97bCIBKr5MWLtjN9FnkNHiSEwmmmB+JWxq3xOU
	 EJT+f2yTfUR69C0vrGCqCpkceJ6y+9hN4h9+c5WcMZLJbi8KrSWsdthWFNDHhCX5l4
	 Q9c3vp/BGyGYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nihar Chaithanya <niharchaithanya@gmail.com>,
	syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	ghanshyam1898@gmail.com,
	aha310510@gmail.com,
	eadavis@qq.com,
	rbrasga@uci.edu,
	peili.dev@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.10 23/33] jfs: add a check to prevent array-index-out-of-bounds in dbAdjTree
Date: Sun, 24 Nov 2024 08:53:35 -0500
Message-ID: <20241124135410.3349976-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135410.3349976-1-sashal@kernel.org>
References: <20241124135410.3349976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
Content-Transfer-Encoding: 8bit

From: Nihar Chaithanya <niharchaithanya@gmail.com>

[ Upstream commit a174706ba4dad895c40b1d2277bade16dfacdcd9 ]

When the value of lp is 0 at the beginning of the for loop, it will
become negative in the next assignment and we should bail out.

Reported-by: syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=412dea214d8baa3f7483
Tested-by: syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com
Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index c61fcf0e88d29..ef220709c7f51 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2953,6 +2953,9 @@ static void dbAdjTree(dmtree_t *tp, int leafno, int newval, bool is_ctl)
 	/* bubble the new value up the tree as required.
 	 */
 	for (k = 0; k < le32_to_cpu(tp->dmt_height); k++) {
+		if (lp == 0)
+			break;
+
 		/* get the index of the first leaf of the 4 leaf
 		 * group containing the specified leaf (leafno).
 		 */
-- 
2.43.0


