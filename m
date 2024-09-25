Return-Path: <stable+bounces-77263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D91985B3B
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF321C240AC
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FCE1BAEDE;
	Wed, 25 Sep 2024 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3wMusr8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60CE1925B7;
	Wed, 25 Sep 2024 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264868; cv=none; b=MjJz/lvXD2lW2zeonTDGEHJxSy39T49BMR5FhkMIrUKWiDSwsqRLRWLKkHvbjqX9MD0b/200uaNuvMLuL9SnfPiBtqDIKFvgfygWR5W1tFplYHQpQGFZUKqm3F0IX8WJJFZG2m+LoEDESDz3gOi/7Ho4GzQZwuRmoVKWHygy9BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264868; c=relaxed/simple;
	bh=po9f51uDucsvgf7M2G/usUCoT5pvByTwmJt47R8DjF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1469tIK1+ahKpn0Hx3tlHT9p0kzh3dDJaH15y3uik2b0v6OigyQp5ou22WuThMIMo8SFRsHObOKuRbiDfQy9GwopqcmbK++uWpg314BAEaWSVSfTD0XWJh6mr57+zVz5pJlOzUp7qnLIFKw2aZPBDkbHkalEDSqagIXHUdEGdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3wMusr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271E1C4CEC7;
	Wed, 25 Sep 2024 11:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264868;
	bh=po9f51uDucsvgf7M2G/usUCoT5pvByTwmJt47R8DjF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R3wMusr8qJqfe0vf/VVLspI8QYtRMI/Sogfxf7LsQSLBNFJpnrvLRXBHcA/PcPRn5
	 mLMQ7m/k8o/9ZvFwK4PKp/XFTYviScepBcJ841BzbNYzQH6CXESmUFDfwDspf/BPgx
	 Iev95yTz4fehzr6qlvOUKEWNqCzIzW7sMBte4ZVIlIxAbTkRbTtBDgrmxE4Dd5qlCX
	 p9Qf/zEYWB7FsagUQUpmXL3yp5l3dXmyq65/yifyDooy2ZwnRGzHTUswViO2c1lqRR
	 onsIZRbNLnxQ0I19XiRirQxNcpA6XkdMI3u8ImnvEM+NXRahSuxExosvNmiw8aUGbw
	 UmYknwo91SxyA==
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
Subject: [PATCH AUTOSEL 6.11 165/244] jfs: check if leafidx greater than num leaves per dmap tree
Date: Wed, 25 Sep 2024 07:26:26 -0400
Message-ID: <20240925113641.1297102-165-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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


