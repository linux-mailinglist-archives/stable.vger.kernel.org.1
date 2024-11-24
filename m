Return-Path: <stable+bounces-95224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E279D7758
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 19:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB51B399C0
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD5B23EA9E;
	Sun, 24 Nov 2024 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uL0SZ/Lx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3950923EA98;
	Sun, 24 Nov 2024 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456394; cv=none; b=tDJknXNsmco5ggYH8CNRSOAHzztL/gl6QUW1vRJ8fx5vndqStTz/e2BIQ0zJGjCWIsYWfFCZ4dOvEPKz0j1CF5DNIM1a9hRc8W0gt09U+WhJms1a+uQn0LhS7BG4GGOb7Rr+yCj0ftdGo260JcBzigsb+hIeGMpoNP2qBHVkXPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456394; c=relaxed/simple;
	bh=57UBQmnW7OuFyYta6vvxjU5mrQGRwbCXRqrBczkBK4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSYlQJZuprwoQuJrTokrhSvrKSCshP4eSWAhSuRpHBgyQsqEzyGG7bbjBDOmZwdr/19lesBp7RFWkth6Nas5Gj/ABAb6JXg7rHvO+K/rA8ae+SMb3yAh4hsQvRGYcCRYwqe9YUUgcbG4Qf5/H7od6igCu8T4Wm88ugkMmIpYNvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uL0SZ/Lx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AF3C4CECC;
	Sun, 24 Nov 2024 13:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456394;
	bh=57UBQmnW7OuFyYta6vvxjU5mrQGRwbCXRqrBczkBK4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uL0SZ/LxvHVsuTzGbjDPCi8jwOKXPUa2jID3d2EISufVV9v5xeB6oOFfif/v5gLLm
	 KIFJBo+dqrCc2mkyM8MNGmM4GvxyGf6PvqS4ejM0Ecu68g0pqvbF9RobWJqPrVvnjb
	 IqHDL5ZpthYKAVhgGmF2QX415TNHiZ8l10JtMgmkpw6hPPsZoR66FCaIjJoGtLAhKK
	 w3ipT9DOA/Q/sXkN+6RMXZXD4FAh6KCMyhxYI9CTOk0YsHM+vcAu4J42q9fl6tWoQS
	 mUMCNRcjCM6RhVb51uYDy+nbNcg5GFtRm7nou7JM/AWGUpDBnAzafhBzmaWAYOmeZE
	 7O9FcHYGCOMdg==
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
Subject: [PATCH AUTOSEL 5.15 25/36] jfs: fix array-index-out-of-bounds in jfs_readdir
Date: Sun, 24 Nov 2024 08:51:39 -0500
Message-ID: <20241124135219.3349183-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135219.3349183-1-sashal@kernel.org>
References: <20241124135219.3349183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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


