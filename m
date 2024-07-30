Return-Path: <stable+bounces-62782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E174F94124B
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 535CDB29EB3
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262D71A0720;
	Tue, 30 Jul 2024 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crcuVciV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59EC19F47A;
	Tue, 30 Jul 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343534; cv=none; b=p1GwWAwnqPmkuMpisruKyAIIWZXjUFfcyoxkI4XFJTvxLRWF7ozEgW7fBrU7y5FzTAnBcOB7QHgLadi9wgZ//GleRf3lfhcrlETsaF4W9TtEHFLC7tDAXje0ZtBXwHIho+yxxAyq7bPxk/cK4bizMUoXeoV/4En6WbPIAGtWhLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343534; c=relaxed/simple;
	bh=dj3ZUdCBqrSs5hApOQfY89TE70ROrZ696r/pf9VlDAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqunODFsNtqgZW+yDBemLr2bRRQsV/xtJEGOVWxz9hz18gvVydKgdTcNfyYA7zGAwxStFK2S5rVFHv6buKoGeeCgOp5MoRHzJDGlTgUNmMBc/ddDNqfHROgvykfNa12cgDwhcis3Aff2mCS7tOW8rsSexidAtk0v7Sh4ez2cR6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crcuVciV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB7AC4AF09;
	Tue, 30 Jul 2024 12:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343534;
	bh=dj3ZUdCBqrSs5hApOQfY89TE70ROrZ696r/pf9VlDAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=crcuVciVHq5ToUAF6rseBBn0DKLrnqpVniSsUCDq2vYt4VECYWFp+L37c3SdsUNvL
	 wUthBQvIFuGM2X7ShFi1ypiD8ZwXd32M4Ha/tDJF67E7V4BrfUVnwce4XJ53vBTmrI
	 lvda12X/fXnMRVpkx2Ze+WA5VjeJRkjfLEUdIRTYxZZtEtccibYt0eKLoBRwmsQWWk
	 tHgBfSjuk3kFxFYm7dl+jJD9gmBbv5QIJrW8wIgds/Yk7O0p25ohdmdxtYyGd40QQk
	 qUD4BLYrhcPIyP/iuoLeWNpz2D8xcmA/APsp9tmp58BoOH745S2mdKCShwfz+c1Nfz
	 uiSk8XWeEtejg==
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
Subject: [PATCH AUTOSEL 6.10 6/7] jfs: Fix shift-out-of-bounds in dbDiscardAG
Date: Tue, 30 Jul 2024 08:45:12 -0400
Message-ID: <20240730124519.3093607-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730124519.3093607-1-sashal@kernel.org>
References: <20240730124519.3093607-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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


