Return-Path: <stable+bounces-62803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1275494129D
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC2AEB28063
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E451AB535;
	Tue, 30 Jul 2024 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIuhhnT2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B091AB51E;
	Tue, 30 Jul 2024 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343621; cv=none; b=PZbu1F8XGbdexRClKVG3GciYfo2Zg0vRbIn4HMVYgmDtoZC1g2JnjwTapsGn9AH4LNiT1eTX5B/mZ4SS0LgttRNlikpPwTOlNT8wpVaF9lytmvTW9eDt5bAoXlXKKxbvgHVcu0d4PGmbbFUuymmvFFFLSDfudm8Mm1nuv+fJROQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343621; c=relaxed/simple;
	bh=GlDTIuYKGseGG6MqlXOaqNu21boebpySbXeK6ZRVROY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjioFvxO+6SxOaZ3opHa8n284WnnDsddOEk4zTITSMiNQz+5ccqQ5uqRLWbXOkOUtYA/sX31sUyaRHaJynEnMJw/3oQJe7YC1+8opZBBKKbGx1mNTcg5MFwxpwIToD2HBxtNbYWPGwUdxmlMPMFB+OXY81cuio/8o0clOG49M8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIuhhnT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAEFC4AF09;
	Tue, 30 Jul 2024 12:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343620;
	bh=GlDTIuYKGseGG6MqlXOaqNu21boebpySbXeK6ZRVROY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CIuhhnT2BQJhFA4OiDpARkyxo1m6kvrHK8+uohy/UrsQ7QavdZgC4VcIDiY5F7rVs
	 K8ggXjanScXlouYHUTJBVAE3AksjiGrHMWq1bigxrkMz1PPIgdMqMFknOpySKLoFo6
	 d+6tTUEWSFXY9JYle0A+Mj0BV+bKiALUizMpS/+IugVy5MH10l8nzSKeCyKU1oE32W
	 2toWkW+xgKpBKSL3etI89z31oS+1V7GUZX0mRVKHh3+AfxwOo/dzma3i8Ki8Gs/w9l
	 zzCgNIaA7OkI2LrQLKRw8rPU50t61s8mdd5duCMct2Y2LYp5pbxUH83QqbUaTeZVSn
	 J0kGHDS2SheRw==
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
Subject: [PATCH AUTOSEL 4.19 2/2] jfs: Fix shift-out-of-bounds in dbDiscardAG
Date: Tue, 30 Jul 2024 08:46:49 -0400
Message-ID: <20240730124654.3100568-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730124654.3100568-1-sashal@kernel.org>
References: <20240730124654.3100568-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
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
index 893bc59658dad..672471f4e72c8 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1707,6 +1707,8 @@ s64 dbDiscardAG(struct inode *ip, int agno, s64 minlen)
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


