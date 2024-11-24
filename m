Return-Path: <stable+bounces-95256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2409D760D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0A13B81AC1
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2021FC438;
	Sun, 24 Nov 2024 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+ib+PWW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DBB1E5000;
	Sun, 24 Nov 2024 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456493; cv=none; b=O/nG4gCA7Hn5NoJ5jYkaZNKIN1ySzPaVrMLQo3hAvK7Dka+tLVvi+NfP85TnY3A2JKtxsFmFuflEa8DVvAL2fhvviYoZch5R4FhuUEEgcrM04eO/P10qKDFaQNw/23ewWigvhTPYlKpMnhtvZGP/3ZSyULuQMnT2Ctsmu8l7uf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456493; c=relaxed/simple;
	bh=Dqq0JZ9ULS9e/X8QVR1bmE9vISRIh37PAurSsgMYg2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMiaFeBoKf+k8dJn+N55uVSdiGxnd7ee3voy5ZAoo9W8hNQ+IQDGk33aibOHPTg7v7L+nw/LzbkLyoKpg9sUnI1L26ALVYrOailuz9n1m4LNXsHG4s8pSOW6io4Xd0GG4D5lymHAIhgKyVVcZXqOLoVjIEQywgFEoKIKqb4RAuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+ib+PWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE7EC4CECC;
	Sun, 24 Nov 2024 13:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456493;
	bh=Dqq0JZ9ULS9e/X8QVR1bmE9vISRIh37PAurSsgMYg2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q+ib+PWWS902qyKXBrluWG/CuTsnCW19XMJXUhliPFpbDyWUW+5tTSn+ZphnKnGnN
	 1PP60DdiLzegboZZ8U4yAUsI2XmaRMPug9B2rL6H//IoOMiNadADs3GjNMIgsdMJSk
	 runJUSXYe26BTuePQE3ZwbamMwOoGtfLFnoetjC15AkADg79OiybFmvj3sd+k1lr7q
	 HjwGNzfbB9ukwzyFYq3qTl2dNk7o2/T5kj5e1RtjqQJb271KUYxBj91aOe4MlBgjmO
	 IN5wsde9Z1E+R/4uPkeO4j11x/MjpjGc+CgRB11sL0mtmEfXttHXnhgRwhrN0s/71/
	 A0gY6M0wklPVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	syzbot+b5ca8a249162c4b9a7d0@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	peili.dev@gmail.com,
	niharchaithanya@gmail.com,
	rbrasga@uci.edu,
	eadavis@qq.com,
	aha310510@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.10 21/33] jfs: fix shift-out-of-bounds in dbSplit
Date: Sun, 24 Nov 2024 08:53:33 -0500
Message-ID: <20241124135410.3349976-21-sashal@kernel.org>
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
index 559f6ebebfc0c..c61fcf0e88d29 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1886,6 +1886,9 @@ dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno, s64 * results)
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


