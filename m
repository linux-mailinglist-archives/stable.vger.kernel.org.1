Return-Path: <stable+bounces-95286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13DE9D74E8
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A33D2867EE
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6EC249AF8;
	Sun, 24 Nov 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejZHLRao"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4188249AF2;
	Sun, 24 Nov 2024 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456586; cv=none; b=Z36N+hX+5EsuhKXU3uOGCdjVdnyKfjKxh5Kv1OrLaR01XYXfM5Tzz1OPaErQHCOMAExE9Avzp6O3N3KRSqaBSy5XB+UsYCpnT8+Oo3D1XYN07Qy29UZn2Gvs08I4B66/bF2N0IekDBGkabvXHhDOuVpxgcczQSvFZ2kc/NOs8xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456586; c=relaxed/simple;
	bh=baPr/z7l3TwFkp4oKvfUVWSDQQy6pCQaNQyLhIjPFeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNX71eRQkOPcrQPCy1f5L8ih8R1u1e8VXJhLiJVLfTrHCAUmKaNBgW0UySFhIsXiet9gJYxH0+GX60je3nUQjAiYDpLnyYlSyJiE3AglVqFly0BvEd11XZmrpyEpggVSQNkaH0FD3KQNwGaUwjzL1bNbgL6yTTESBN5oMVyCTh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejZHLRao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B4AC4CECC;
	Sun, 24 Nov 2024 13:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456586;
	bh=baPr/z7l3TwFkp4oKvfUVWSDQQy6pCQaNQyLhIjPFeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ejZHLRaoghOHTl/1LbJzfY1Qw2TO9Nd7mVSzMEP/LNu8XDoy7FuKFYq7JNRfCFLUz
	 4mb8S8Ak9d5oAEP/n2RKP1TjeitzF4ze/Q2ZJ43kic6Un6A98+BX1uEGWnbqYgAhpY
	 X69FXh2ayqffwHRkItGxUr1TvRO0nIYMScKUxLuo1jY9A/DtQyGWxNRlD+DVnyG1JK
	 ombo1a4eDnWN1zbl81lV9UHnZJTKZMkD1B43Ch6A00DPl4M/L+1Srdy3KMcUoXM8Te
	 AnW/7JVNfkED3zIQ8axKypk6XuJIleWD/NLtut71w55UoUTNBHqr/5ObF+qDcIgzie
	 ClWo/7AWd5ktg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	syzbot+0315f8fe99120601ba88@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.4 18/28] jfs: fix array-index-out-of-bounds in jfs_readdir
Date: Sun, 24 Nov 2024 08:55:18 -0500
Message-ID: <20241124135549.3350700-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
Content-Transfer-Encoding: 8bit

From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>

[ Upstream commit 839f102efb168f02dfdd46717b7c6dddb26b015e ]

The stbl might contain some invalid values. Added a check to
return error code in that case.

Reported-by: syzbot+0315f8fe99120601ba88@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0315f8fe99120601ba88
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dtree.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index bd198b04c388f..4692c50d615f0 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -3187,6 +3187,14 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 		stbl = DT_GETSTBL(p);
 
 		for (i = index; i < p->header.nextindex; i++) {
+			if (stbl[i] < 0 || stbl[i] > 127) {
+				jfs_err("JFS: Invalid stbl[%d] = %d for inode %ld, block = %lld",
+					i, stbl[i], (long)ip->i_ino, (long long)bn);
+				free_page(dirent_buf);
+				DT_PUTPAGE(mp);
+				return -EIO;
+			}
+
 			d = (struct ldtentry *) & p->slot[stbl[i]];
 
 			if (((long) jfs_dirent + d->namlen + 1) >
-- 
2.43.0


