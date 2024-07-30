Return-Path: <stable+bounces-62799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DE6941275
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30121C23450
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7E31A4F1A;
	Tue, 30 Jul 2024 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l98OK3u1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090E01A4F3D;
	Tue, 30 Jul 2024 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343598; cv=none; b=geXoFF0xBdJZxhjim32sO4oqgAtaR/odaQ24e1ZnznNWYPt8GfccXwDw4SW3IJf23OWcdGrOMk+Gd+FMgJoaCzNsIfHmmu6Rgjh8XJXDg5sY9F9cEnn8f3OLXZm5Xd6qIvzcPaQoowyYVpykbB/mLGlinWFLOKeWK864UpqD7Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343598; c=relaxed/simple;
	bh=dwrRDKD/T9ZYtlcZgiYiXiflk63vQUyVGllK9EDxPVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIqQqga1Pvr0EPo5UtJLDRvwkwuPH6/F6dNwoR7l0JQV6T4dPLId5FgSpJP/UUVr+w9wC/HiDjXV/t9Xwcsu8Ah7hcr8ChrhV6eMiLXlwqcpADg73pva73KJF/O+kzVWzIbpNkTkaFYXQ7m7V0C/51onPaliU9R6q7YuTFtEsJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l98OK3u1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E63EC32782;
	Tue, 30 Jul 2024 12:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343597;
	bh=dwrRDKD/T9ZYtlcZgiYiXiflk63vQUyVGllK9EDxPVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l98OK3u1mj8vO52SZSK1Yc/7R7g/EptpHL2SuwX89wlnJQ+g1ObI35ysKuZJEQHvS
	 umRtpwiiRgMsULVE7d1Oo69zi2FGlTYUqwRYdEsRA8OxqecR9DcQ0RAoioOlp7p5dI
	 6I7WBCDy3G6p4NfnmUWa7sUzb0ij+tPLJeKImK5dXFKvcDvcgPbIPymTTB3KUhlwYv
	 Ha2Z1QF2DFrLWVFvsq09Xttjp2TgeKi0+Vm3KzaOP4tbf74Fofl4j4I14oyoWmU8P2
	 iGITlK2p6OyRjhgZqftb5M2ogRoBWwdDsvg4J3tuVik+nZbQ08Ueyp3/7KhzPO4Kub
	 LlAYRO3vcUHQA==
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
Subject: [PATCH AUTOSEL 5.10 3/3] jfs: Fix shift-out-of-bounds in dbDiscardAG
Date: Tue, 30 Jul 2024 08:46:25 -0400
Message-ID: <20240730124629.3098598-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730124629.3098598-1-sashal@kernel.org>
References: <20240730124629.3098598-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index 9b6849b9bfdb9..acfe13f368562 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1694,6 +1694,8 @@ s64 dbDiscardAG(struct inode *ip, int agno, s64 minlen)
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


