Return-Path: <stable+bounces-77482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5330A985DAB
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075FD1F25ECA
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF2C21018C;
	Wed, 25 Sep 2024 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8Im67Ip"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F59210186;
	Wed, 25 Sep 2024 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265983; cv=none; b=Xhzigbz+8K4b1YbmrvyA7YsIM4rONwBmK3VORj/h3MNBibRjTyU9KopnzDxKtSGAluVabIKlnEgIYIoWRoX31zTYGrODJq1OdsO9DaJmV3gE9Q36Sgc6Zzq9Fzck0oCM9nboAgbO21aRdBDXoeJbKG+ceL/Ic0wloRZTIV5y7Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265983; c=relaxed/simple;
	bh=po9f51uDucsvgf7M2G/usUCoT5pvByTwmJt47R8DjF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bukoUBcqr7bFYRMZgiOIW6HrBpFGU226l8BBozw9f5+uViGetAJv3dSKy2L+UXBBW38EVWWJGi7QF0Vq36+K1aBrcmyU+QVVQWug7U0uZAW9LY3gaewkLW/PtCAsYZHQWQKn5l3liSph/O1e3Zlj6SbgQzgmNNHl9TzNmOer6q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8Im67Ip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5812DC4CEC3;
	Wed, 25 Sep 2024 12:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265982;
	bh=po9f51uDucsvgf7M2G/usUCoT5pvByTwmJt47R8DjF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f8Im67IpF8vrJX1EwjPvmFp/vucw3PYKrL6Sd5fCgdPKKRgPuYptd/D4Ys8JwMSe6
	 EY1HpAp/18iue54DVKYFOXE7BH5IHx/ASSTK65zb7Zqun3hhmFaOrSJVa4C2G5/mF9
	 dqP7GGllwYauc6pFRmJy/lk/79emy0N7bW1gNs5A1RmWX4hdNz+aM5DPEDXLCJwjGF
	 WzPGd7M3wd5L8WcPH1cHoHqYAKp+WEWXOOcEmMgw+GAeDJc5QYUQTg3JDS7FArpABM
	 md7llhsNF4d3ziqFCLr9iRaPQAaH0DK7rKBWBUTZq+2IJbeO2sW4rk62y9PcDNKWk4
	 ZG8dYaU2r/NCg==
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
	rbrasga@uci.edu,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.10 137/197] jfs: check if leafidx greater than num leaves per dmap tree
Date: Wed, 25 Sep 2024 07:52:36 -0400
Message-ID: <20240925115823.1303019-137-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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


