Return-Path: <stable+bounces-94968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8B59D728D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67DEAB46B79
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB451E25EC;
	Sun, 24 Nov 2024 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gt/70ve0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFED1E25E9;
	Sun, 24 Nov 2024 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455445; cv=none; b=Pl2vZMpYXc63iUAobBlwyYCAzFmoTIUsCrfl8+F70PDro96TSoUeADzMk0I/0EalPL2LttIbAtRdBu60oi3Q0a/RdUSbtMEFHuUOoBM3P17Ui8wFrSb2oRIYQI2VDxJNpZjfBferDLIxUPxYO+UwchgIld8IFKsXagZBYCFy2OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455445; c=relaxed/simple;
	bh=GPWL1EoADPh4U369AvLTJZQRfBf1SjUW476Qa27QLl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzFGm3fUshvJ5TLiIvQ9HYddAvyWLUui7LoYohxIAcLu7vnmZURgZbpiPzkheIbB2kZJX57nE/xzjET9WJYYGNrR1ncZ903r/Nz8BoOo3NbtFIYCdJestXiZHkrt8+6TVSAoix9POsPVwEefOUUzKpo7ngRJ4prK5LcMFTAi8hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gt/70ve0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B92C4CECC;
	Sun, 24 Nov 2024 13:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455444;
	bh=GPWL1EoADPh4U369AvLTJZQRfBf1SjUW476Qa27QLl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gt/70ve0Xy64BlowO6DrH6oCAvM3K0QXRZ3ufaQfLWc5caIXPwWKwaY8ufc4KMjgG
	 nbu8QaCoxm2XXq1aqtsl56fxBVpq0AKwCgPfhAW0CZ3dKf7f5M4pdericViItECtZ+
	 XceApRRGns79Y1WhGrjUBlMKJ9u5vQYC+jc4McAu7nQ+rZG3JWPFEm8kbVjwd/agOf
	 OHc4MBXwFr7bdE8W70cUgxKKisBpsKMfJ5Z2QDbcPiSoTbp41HGRR1dM9LXEQ2Dzw0
	 EuGZXD0h07P0Rei9FNEVpYrM5h9N/zQh2WYAgxXq6KvkdFUlvfcHHNcjeAraAcnTkz
	 6gZYd0FtUS5pg==
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
Subject: [PATCH AUTOSEL 6.12 072/107] jfs: fix array-index-out-of-bounds in jfs_readdir
Date: Sun, 24 Nov 2024 08:29:32 -0500
Message-ID: <20241124133301.3341829-72-sashal@kernel.org>
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
index 69fd936fbdb37..8f85177f284b5 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -2891,6 +2891,14 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
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


