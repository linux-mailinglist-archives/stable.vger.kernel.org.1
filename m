Return-Path: <stable+bounces-77644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB42F985F71
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA691C25A14
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EF4224EDC;
	Wed, 25 Sep 2024 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAB9aEQI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3091A224ED2;
	Wed, 25 Sep 2024 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266566; cv=none; b=FTpgbcfA23w7nZIGeYo3vQ3h6PctxBSETw+5lP4FU/6ArUNH69rSjdyuJAjVeSoSVrIxYFfx/pbBX7OXJuPAXvUaUp2wPSyzRwHBeBl98Q03aaWJaTZJgD+JgTGsbLyOPJUbwApEAa9J82oMEsD+or5mclllDNApmFFCilbyMeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266566; c=relaxed/simple;
	bh=po9f51uDucsvgf7M2G/usUCoT5pvByTwmJt47R8DjF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxrfnKgshY6zRuhe0dnNBEppGXVdx5nj1BB2BCQ9xpkDu29N0aGsa3sHYX2Ern7q6KWNiryKs1aU4yQ7M/W6udIRVm5sNwTdTgzGHrl/iZ21z1sYawL2adRd0b1bc/kUe11VyYJ1z/4YZdB5WWaKCenl2YhiJ+QEDRNMYnyZF5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAB9aEQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7AAC4CEC3;
	Wed, 25 Sep 2024 12:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266566;
	bh=po9f51uDucsvgf7M2G/usUCoT5pvByTwmJt47R8DjF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RAB9aEQInZ/qpF9FXgKtXfFvcJLju4z8aN4RntkPwhiWQPQVvz+B7nQX6ccGBr+vL
	 7zAEahWa3njgnWf7uklWbZLECln+ezYj/bW3unIJaPmMHnfJVGp6wbJ4DPdXhI46m1
	 Kz3axh+q7Tpdh85C6XH0IiKxwbA7ZbsFKBWpV4dGq6158Ueh0MNO6D/wdnxOJsiwld
	 4pgMSMDxyOC8w7VaY4eG7vubwPthsnSdpfWR9JYxH2Y/iP4TdoB/oyqSeUNAm7vKzk
	 l7PNBFghxI9j2TbyzCbY/pL4oT7NqDk/qziekhqHZfEO0XVcvromvgcs+lqhypGa6q
	 PXjyznYySwPQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+dca05492eff41f604890@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	ghandatmanas@gmail.com,
	juntong.deng@outlook.com,
	peili.dev@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 097/139] jfs: check if leafidx greater than num leaves per dmap tree
Date: Wed, 25 Sep 2024 08:08:37 -0400
Message-ID: <20240925121137.1307574-97-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit d64ff0d2306713ff084d4b09f84ed1a8c75ecc32 ]

syzbot report a out of bounds in dbSplit, it because dmt_leafidx greater
than num leaves per dmap tree, add a checking for dmt_leafidx in dbFindLeaf.

Shaggy:
Modified sanity check to apply to control pages as well as leaf pages.

Reported-and-tested-by: syzbot+dca05492eff41f604890@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=dca05492eff41f604890
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index ccdfa38d7a682..53904e06d843b 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2944,9 +2944,10 @@ static void dbAdjTree(dmtree_t *tp, int leafno, int newval, bool is_ctl)
 static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, bool is_ctl)
 {
 	int ti, n = 0, k, x = 0;
-	int max_size;
+	int max_size, max_idx;
 
 	max_size = is_ctl ? CTLTREESIZE : TREESIZE;
+	max_idx = is_ctl ? LPERCTL : LPERDMAP;
 
 	/* first check the root of the tree to see if there is
 	 * sufficient free space.
@@ -2978,6 +2979,8 @@ static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, bool is_ctl)
 		 */
 		assert(n < 4);
 	}
+	if (le32_to_cpu(tp->dmt_leafidx) >= max_idx)
+		return -ENOSPC;
 
 	/* set the return to the leftmost leaf describing sufficient
 	 * free space.
-- 
2.43.0


