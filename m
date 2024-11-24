Return-Path: <stable+bounces-95223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 548259D7451
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19392286C4B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F0123EA80;
	Sun, 24 Nov 2024 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMyWNQ4Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9869F1E376E;
	Sun, 24 Nov 2024 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456391; cv=none; b=BlTiqeJ/h/7br3TO+U+Tj+ku5r7EHCJQBf2/5UK+PEIs3sSdo556QZlG9dBi2S/LuHzjebDJuPvrsapYiFzqzzyYmNPJmV96VgTcHYjpmbO3AFB+6y5NKzDEOoKj8sMcMtBbLTFnRFfbEIuNo1P4asWhwrAI9lnFnPRdTfSqFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456391; c=relaxed/simple;
	bh=i6gCwX7wAsD6EU5NjmdgnsLJ81ZMiDUlltSxCIZ6Kfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvFLrj1ZNFfXJuqgm5p3OnQKUCQ8Mz+1iPa7eWCnDYVs+bSNxouc1CFoaGhKwHtYBXp22NI/1aGGz5aoH4+MSlQRSYqaXPIuONusS3POnJ52YxuqE+ULcJJbFcqNkSEIwNgcMPHRndztUB0QDg4ZPPtc3U2Mc9xmB38v981OZLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMyWNQ4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209AAC4CECC;
	Sun, 24 Nov 2024 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456391;
	bh=i6gCwX7wAsD6EU5NjmdgnsLJ81ZMiDUlltSxCIZ6Kfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jMyWNQ4QQ7p1sQQbfwS4hcFZQjheu7+UFiyH/xwhCWqMXEm7a4RHsfIFEvNXbGI0f
	 /Z9LtiB8QIwh1cbgE2+C/5Mnx7ti7HVrbgNZHiOs8FatZM5jhVYVrN2bkdpE5q8Fh6
	 E19an+CMV5kDuSiII5nDavC0G2TkMvoMIAL0Gof0YnZtiUBQR/Kk1lCxkDhANzNBtY
	 gB5ytAiUZ0za/zZhfL3AARTCyHTVudXgRxDxtZTRJUkZ1BtKfZ0QnEXMqU//9tosOE
	 lFyrgqBin1p9eoLtF4oY0pVIWROzzzXwjyY7kJbQ/wM9bU5WpoDzK06p1CcJY21QMO
	 ygbFQmMi5CpEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	syzbot+b5ca8a249162c4b9a7d0@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	aha310510@gmail.com,
	peili.dev@gmail.com,
	rbrasga@uci.edu,
	eadavis@qq.com,
	niharchaithanya@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.15 24/36] jfs: fix shift-out-of-bounds in dbSplit
Date: Sun, 24 Nov 2024 08:51:38 -0500
Message-ID: <20241124135219.3349183-24-sashal@kernel.org>
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
index 3fa78e5f9b21e..7486c79a5058b 100644
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


