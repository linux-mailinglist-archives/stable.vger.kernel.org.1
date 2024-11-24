Return-Path: <stable+bounces-95257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3B29D74A5
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F08288399
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE1724481B;
	Sun, 24 Nov 2024 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaOhPwxG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9E7244815;
	Sun, 24 Nov 2024 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456496; cv=none; b=sdBR8pPVbZWoYmRnDLOh+rQHtTR4R00xFkAjoweomoUv2cgg/YwNTmicag1mw+mxublQH4+1SiKOIGyC5qr27Xnjw9om8xN4+Gvbdoyj8bKtZhfsoLqKJC6qZ43D/WNV8Ihd8tPUrFz1fZ9i6rydI/yiY+o6wSrl0NYTj1uC+WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456496; c=relaxed/simple;
	bh=57UBQmnW7OuFyYta6vvxjU5mrQGRwbCXRqrBczkBK4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjlNyzN/RHlRWhkWqwj4AyHNJoh5Zh4sFEBx76SL1Df53AWkWokXuzdvl2G434DZt+ebDXsST9P8OttbSAsmRmDXl0blnBeKjfdrF85vPMtHSB/GbuTlW0QR5OjUCHcOfSs/qgx6kQ1QbFd48ECyHPARx1vNes/5r53YgxoHxtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaOhPwxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461F4C4CECC;
	Sun, 24 Nov 2024 13:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456496;
	bh=57UBQmnW7OuFyYta6vvxjU5mrQGRwbCXRqrBczkBK4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HaOhPwxGZpNbmJEgXcHM2betfZiTWSvWzWglHKCUpA7I7Zaq501DVLNZ7LbnI7cek
	 bjLc+h4g9nhrRONiLKihxUhtj/oni1zGF7UxHKmiZen/cOXVLiTsZGQJKBNMaDhkRk
	 2zRREUlNwOqR0/h9kOOBFbLfVHCDkHz3Dcwv+lmATxKpz8j2GMEZf8mGjasWjIe5B5
	 1d0Yh1H8Kz8WCukGVuEasFVMx12G7kzTeG0NuWw82loOVqyFcyiE3cScB0Fc/yMo2V
	 CP/+/RVJ0PT+g5PjFeCmdCJQzCqXy2OXpx9HVk1UlLe7frwoVl1Sg5xkcV5zmDqsT9
	 JCTBRuMjqDWNA==
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
Subject: [PATCH AUTOSEL 5.10 22/33] jfs: fix array-index-out-of-bounds in jfs_readdir
Date: Sun, 24 Nov 2024 08:53:34 -0500
Message-ID: <20241124135410.3349976-22-sashal@kernel.org>
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
index 8f7ce1bea44c5..a3d1d560f4c86 100644
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


