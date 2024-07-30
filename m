Return-Path: <stable+bounces-62793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE7894125E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1971528365B
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04B11A38F1;
	Tue, 30 Jul 2024 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiFeQPZl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B90319FA91;
	Tue, 30 Jul 2024 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343572; cv=none; b=aT7d4f1QJhw1dPfHqe4WDUMYStJqS3/irYGL6cQi1lm6IFnujxdbm9kZmJEyZ2VTQSwTA2uYqhDuuuGCHT04A9BzQ+O5gyezETDAcE8AtUq9/ys8pxaaZUYR5EpS+cfhdlZ8RhBg6+ZvJs3cEr/lH/tjGRQqW4zd086q2i+3L90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343572; c=relaxed/simple;
	bh=Xb9B4pTT9qg/8OnwkFxVmu+bZAyNW9sCPXmRiZn4DKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMkuOkPFlUzTYxRClhjPqZH8if9HV+8fIvs3CQKzs5OJAs6svlUrHNIqZ1is3/348zq1+R/qKi0E30uld6uTwSNhHJKZbPhV1MtCt0CJnBGAmomOyl8KnPtyDq7wOcqV1ZbxozTe7E65reCgL7L4cr7bNgHTBik8HpwsbrwZDNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiFeQPZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F60C4AF0A;
	Tue, 30 Jul 2024 12:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343572;
	bh=Xb9B4pTT9qg/8OnwkFxVmu+bZAyNW9sCPXmRiZn4DKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eiFeQPZlaqtxC3FHvhhf0QWs7foBG8KFf/WYkUhi4y2URywkr4glZ+w33UJCDPsfI
	 yPuxmbWwf8LKMX377qBw4ixuOPINo/7NU+IwVmly/lbjKVq246QGgsPMooEeIG0avp
	 0gSmcH/AhzOOGMS0ctApdch4aLIW0nByljtMS+Ph2L+lP6iOUKKv3dxpIZ5bV54elf
	 4Px+JvqPJ5NeNdGMYyRb1Bj4KWesJkJi0Ad9T4J5pa4Aal3WHaGNnBV4FGZIb75EYg
	 PHzknlrju8xjsBRpQEEPGKBkQFHu5r3PDhClLE49Vl6Gwg6MxAZ3t44OY5WywAqG4H
	 UvMzKifw65znQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pei Li <peili.dev@gmail.com>,
	syzbot+61be3359d2ee3467e7e4@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	ghandatmanas@gmail.com,
	juntong.deng@outlook.com,
	osmtendev@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.1 3/3] jfs: Fix shift-out-of-bounds in dbDiscardAG
Date: Tue, 30 Jul 2024 08:45:59 -0400
Message-ID: <20240730124603.3096510-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730124603.3096510-1-sashal@kernel.org>
References: <20240730124603.3096510-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Pei Li <peili.dev@gmail.com>

[ Upstream commit 7063b80268e2593e58bee8a8d709c2f3ff93e2f2 ]

When searching for the next smaller log2 block, BLKSTOL2() returned 0,
causing shift exponent -1 to be negative.

This patch fixes the issue by exiting the loop directly when negative
shift is found.

Reported-by: syzbot+61be3359d2ee3467e7e4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=61be3359d2ee3467e7e4
Signed-off-by: Pei Li <peili.dev@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 4462274e325ac..d2df00676292d 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1626,6 +1626,8 @@ s64 dbDiscardAG(struct inode *ip, int agno, s64 minlen)
 		} else if (rc == -ENOSPC) {
 			/* search for next smaller log2 block */
 			l2nb = BLKSTOL2(nblocks) - 1;
+			if (unlikely(l2nb < 0))
+				break;
 			nblocks = 1LL << l2nb;
 		} else {
 			/* Trim any already allocated blocks */
-- 
2.43.0


