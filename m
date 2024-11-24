Return-Path: <stable+bounces-94966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F4C9D7327
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2FD9B28D29
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7AF1B218D;
	Sun, 24 Nov 2024 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvlwYeud"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2481E22F7;
	Sun, 24 Nov 2024 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455439; cv=none; b=CtI1BcSvcBR0d0xaFHr4en5Xd4JqkJWdvR9j2Kgq90SzrMlVKx2ZPq5oUdVAhL3NLREvmgnsNRhp3LxdlyaXSe47+NlgkCVhOuDhYlDTjFjbO1jtZiSbSUEorx8YGPvgAPB795Cn2y0ZXl3OHiysPReGu+A9kaZwzII2w137588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455439; c=relaxed/simple;
	bh=Cm48ydr7HuUmpf8NLPZ0xlI3ymdHuP7sWgbwamctBOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZnPEjzhkEl4bjD9SVE0gJuXbJfvuxpguY1wZj0ieRdRAhu4RImBVgTErpJgs22RyWHxer46LWlfYl1/74FrYkZ0+nm0Jykzzda939SeAxc/GfhMPNzMZlZmTGKcf0wgP5eobhI6OFrgNkZFI3bgCpcFlnNJrhpLktdC+nfbJOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvlwYeud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E668FC4CED1;
	Sun, 24 Nov 2024 13:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455439;
	bh=Cm48ydr7HuUmpf8NLPZ0xlI3ymdHuP7sWgbwamctBOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KvlwYeudmg9EfwB+UgYycUExatdR0rHRLQmeyPmoTdHhDrdsfn2hSA30n4yBTDMhB
	 +OFMO3wtW6uL3zsoy85eLEAgJedngY5/rpnaBKlGKoULCJB92Crk0nOYCGuT9qaqj5
	 Zcf7LMNwUYuJD4kRjuE8/yvjcegKw10VKycqVZvbZGiIuHheeGx4r8EnQRRWcJs7Q0
	 M/HawW4qu7Xv+A6EGpzYqIkGxW2ldxRO5VBvl7n8ouz8KqMG2ugv7T99+2GqEsNy0m
	 ixBZbyhdM0Or+e5g7qanNb3M6TCHXXDEgOa5ibP7+uW+3lZ91d2rjMSUDzwWGRsKV7
	 0Ie5EvSIftSmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	syzbot+65fa06e29859e41a83f3@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.12 070/107] jfs: array-index-out-of-bounds fix in dtReadFirst
Date: Sun, 24 Nov 2024 08:29:30 -0500
Message-ID: <20241124133301.3341829-70-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>

[ Upstream commit ca84a2c9be482836b86d780244f0357e5a778c46 ]

The value of stbl can be sometimes out of bounds due
to a bad filesystem. Added a check with appopriate return
of error code in that case.

Reported-by: syzbot+65fa06e29859e41a83f3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=65fa06e29859e41a83f3
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dtree.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 5d3127ca68a42..69fd936fbdb37 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -3086,6 +3086,13 @@ static int dtReadFirst(struct inode *ip, struct btstack * btstack)
 
 		/* get the leftmost entry */
 		stbl = DT_GETSTBL(p);
+
+		if (stbl[0] < 0 || stbl[0] > 127) {
+			DT_PUTPAGE(mp);
+			jfs_error(ip->i_sb, "stbl[0] out of bound\n");
+			return -EIO;
+		}
+
 		xd = (pxd_t *) & p->slot[stbl[0]];
 
 		/* get the child page block address */
-- 
2.43.0


