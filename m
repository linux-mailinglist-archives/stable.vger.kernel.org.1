Return-Path: <stable+bounces-81785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25981994960
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579D81C2298E
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1381DE89D;
	Tue,  8 Oct 2024 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KgTS0wA/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA0C1DEFE3;
	Tue,  8 Oct 2024 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390122; cv=none; b=SxkhfySgodVcD8ICjvsGNFlma3RC0fZzpGYsWk5QgrtjmboEj/H8xEaPcDVzuPiZRAo7sIMVNOux6JWeyhxfgTaidBP6mloTW8AkCwb3h20hYQTlfhT5uQe1ATeSZeGC2niZz4HNmKwOrMi2GqliIwcJUg0lzfu8OGo4ZKQa8LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390122; c=relaxed/simple;
	bh=S1Ec91FFJJ5Xo6nwNywuBHUJSAR7yLHaLO/EDIuGTMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8mpcqYAlHkzvAOPRHLYKHLtWUKTowC2PbRLssuudvPPYN+b3x3jVHG8aAvHfP926lgYClaIQGRcxPLQetT2939s9G0XD3Zu26xSjkglj4Zr75BAdvtXzbTUQGqe34rXDm0Whip8C51oxXa/gkAG/7kkL/K24UJPwQnVic08kL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KgTS0wA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4072DC4CEC7;
	Tue,  8 Oct 2024 12:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728390122;
	bh=S1Ec91FFJJ5Xo6nwNywuBHUJSAR7yLHaLO/EDIuGTMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KgTS0wA/E60P0ORsoPTxMH6CN6RChlwKHWvAHLPOhfIJ6rClso5qZqiPC8/Zy/xMD
	 1uwQUopJSZtp8I4HZC//pH8aCulIwp59PHHmUDpwYjh9V2CeyuIuRYZ72pkL0hMj+A
	 z7iqbrNQTdl4bUTl91RbGhwBhFbTHdM3p3p6ZKGQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Edward Adam Davis <eadavis@qq.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	syzbot+dca05492eff41f604890@syzkaller.appspotmail.com
Subject: [PATCH 6.10 198/482] jfs: check if leafidx greater than num leaves per dmap tree
Date: Tue,  8 Oct 2024 14:04:21 +0200
Message-ID: <20241008115656.100652248@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 8847e8c5d5b45..974ecf5e0d952 100644
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




