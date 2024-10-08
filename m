Return-Path: <stable+bounces-82783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1337994E65
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D9A1C24EA8
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E33192594;
	Tue,  8 Oct 2024 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hTEsmlkU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4931D3653;
	Tue,  8 Oct 2024 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393413; cv=none; b=Pk+GPkSio/4iI82jzlJhfqd0vO1zR4VnK2f5I1dZsnWfYjycCBzjX/XSburXNR/DKs595khBQlSXU5psm/FyBBvtJNiEDNKUldF7ziDOW1IufiojUA8/D7bYV9QqqSzNdWJFtQDtGefqxyYfwQasqgGiiqW8WojGgDRk3GsPG9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393413; c=relaxed/simple;
	bh=M5smAU+IPKkeP//UPjVTvtmMz6UaV9stjmdvmtGpBzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUG+lVqieLjz4Two2oROhn/ZCO/lgym9NtcVI6ynkvgJxVTbL64Jrq9KmyXH9GC+uLyvQ6dQfBzMP9glOvf0kIo7G9C6R7MuHjoEEYwLzUTwicR4VR/NJM/Qb428MUlmKa/ZnsZvQhG2H77K8Brvf2lq824/tQNYSYuTA3UCfPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hTEsmlkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700F2C4CECC;
	Tue,  8 Oct 2024 13:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728393412;
	bh=M5smAU+IPKkeP//UPjVTvtmMz6UaV9stjmdvmtGpBzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTEsmlkUk/I80GccAJ/kQYUJe9MGfQciCa78F5OPhmCHep19rpBMZ/TJ5nU/Xvfo9
	 WcsGsWT9G/3rWVFQP/FrJM/mXE24sfsXoNGfdloKcX6qpf6A5q8ctB/wKL5gJrU8ec
	 DIsZh3z2ZyxJLjFDNtD6cUF3M4gyEEOAK3Q4TxZI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Edward Adam Davis <eadavis@qq.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	syzbot+dca05492eff41f604890@syzkaller.appspotmail.com
Subject: [PATCH 6.6 144/386] jfs: check if leafidx greater than num leaves per dmap tree
Date: Tue,  8 Oct 2024 14:06:29 +0200
Message-ID: <20241008115635.096827980@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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




