Return-Path: <stable+bounces-62789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF2E941256
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF101C22C79
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D0E1A257D;
	Tue, 30 Jul 2024 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPJ4QUMQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F331A00E2;
	Tue, 30 Jul 2024 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343557; cv=none; b=lbtpdkEDiGZapfqORnIMOjNmURFbZeR/Yr1/eie6IHkd4oITeZQ4OWLe1IJjIR8fe2JH5NrwXkX/2aTWPOvvNAUH5678iADXXvrQJo4/gsrHnVfhfSkyk3RNNe/F7AeE1ijznoEQPddayusG3R+YCCiDXIf05t+sVxuvEc28mWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343557; c=relaxed/simple;
	bh=dj3ZUdCBqrSs5hApOQfY89TE70ROrZ696r/pf9VlDAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6c2oc5MZX8aR44fb2xVQifMobYtkaGkD+Bhomg/I7oi1er7+xSeLK0EPA3rP4RkbGnZkIK6Am0Sy4r7ctO3aQz6tk50MrB180/IPMfiYCmrMMk3b3+ZIfFG5MbA7IHuBlPnZCq4+GzmZVvbLBf965Ox12WwTR5609DtSodhbYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPJ4QUMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55674C4AF09;
	Tue, 30 Jul 2024 12:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343556;
	bh=dj3ZUdCBqrSs5hApOQfY89TE70ROrZ696r/pf9VlDAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uPJ4QUMQKrfj5ZNog0mrg6NOR+6leupIyA4Pmj6JotkR1zmDdTd/Ws8DhCkYsvxLZ
	 DzP5Kb3NMf16Ko8D606QD0uYGEedrJk5SmPW4j4K46lTq4tFT8UgDdUwIsRbPPVVCo
	 ZWuAAgdLCNSIRbtyHlh+7AmvoxbwakzM1lCZ0cOw+H/h3EeWnz50bqrpMoJFlVeSzK
	 onbA0cRlrz4JoH0xpCevhXuvpobfBu5lpXEefHzGFpblfucV0cCzNQONjO5Q823UWi
	 BJWQPoBnWoNtdsqRauaA24KvJCWEyIesi2WTwt5sCqHRJXKwnw814WO8hduKVQlTjw
	 0hfRVwPveNRvg==
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
Subject: [PATCH AUTOSEL 6.6 6/7] jfs: Fix shift-out-of-bounds in dbDiscardAG
Date: Tue, 30 Jul 2024 08:45:36 -0400
Message-ID: <20240730124542.3095044-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730124542.3095044-1-sashal@kernel.org>
References: <20240730124542.3095044-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index cb3cda1390adb..5713994328cbc 100644
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


