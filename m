Return-Path: <stable+bounces-209078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDDDD26A7F
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F06D030C26BF
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B9C39E199;
	Thu, 15 Jan 2026 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o6VWDmsY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861672F619D;
	Thu, 15 Jan 2026 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497673; cv=none; b=pDeKZQRpHIbRRRoF5bktWbm8yJkHHyKjQcTD8Qkg/quK5F4zeXAf2Zu5IXS4QPbzq9cxzWrXI04EayoN30XxGL9Mn9Js6rmNPjzJmCP5bzR1ivMgMjYREwb/o8taimtzbLf7vt0dtUpfZjecXHR89fnIQ7wJf3DrLv2ipLWPbmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497673; c=relaxed/simple;
	bh=zPa4rQJYBGLA6Ca9MLNYuyNtuvp7mGIF3I32KefXSKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqW61e9SSbcbiLFdT4gJSl5fNzKiqsGQRycfKpXhxm4+gMdu/HDpIHOf0wCKcKnPfRHXM5KZgnGqzGeq1Ro0vUronBIUZq7T1b/XTop1dvedDe5kebuZ9FEZ4zavvzUXJ4yeh+l9RKBB2z5t8Cp/5myWPerKZqDy8S4DgtUkGmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o6VWDmsY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12140C116D0;
	Thu, 15 Jan 2026 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768497673;
	bh=zPa4rQJYBGLA6Ca9MLNYuyNtuvp7mGIF3I32KefXSKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o6VWDmsYl1NXUoYh/PL3SX5vhzqyb8sIPI4JY1bz2teBHTTg1MKzCpurviH7eVXZv
	 UuelqFw0FOnVxZZAh6lF+muCHGVr8EpnrLYO7PBVB+Z+hv+VE/zW7FVXj83ibGKSSP
	 7qP3WNNy88LUNAu2Dq8Zjzdetn6D7MXJZFkowUSU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ivan Stepchenko <sid@itb.spb.ru>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 162/554] mtd: lpddr_cmds: fix signed shifts in lpddr_cmds
Date: Thu, 15 Jan 2026 17:43:48 +0100
Message-ID: <20260115164252.131947373@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164246.225995385@linuxfoundation.org>
References: <20260115164246.225995385@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Stepchenko <sid@itb.spb.ru>

[ Upstream commit c909fec69f84b39e63876c69b9df2c178c6b76ba ]

There are several places where a value of type 'int' is shifted by
lpddr->chipshift. lpddr->chipshift is derived from QINFO geometry and
might reach 31 when QINFO reports a 2 GiB size - the maximum supported by
LPDDR(1) compliant chips. This may cause unexpected sign-extensions when
casting the integer value to the type of 'unsigned long'.

Use '1UL << lpddr->chipshift' and cast 'j' to unsigned long before
shifting so the computation is performed at the destination width.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c68264711ca6 ("[MTD] LPDDR Command set driver")
Signed-off-by: Ivan Stepchenko <sid@itb.spb.ru>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/lpddr/lpddr_cmds.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/lpddr/lpddr_cmds.c b/drivers/mtd/lpddr/lpddr_cmds.c
index ee063baed136c..5c39c9c653233 100644
--- a/drivers/mtd/lpddr/lpddr_cmds.c
+++ b/drivers/mtd/lpddr/lpddr_cmds.c
@@ -79,7 +79,7 @@ struct mtd_info *lpddr_cmdset(struct map_info *map)
 		mutex_init(&shared[i].lock);
 		for (j = 0; j < lpddr->qinfo->HWPartsNum; j++) {
 			*chip = lpddr->chips[i];
-			chip->start += j << lpddr->chipshift;
+			chip->start += (unsigned long)j << lpddr->chipshift;
 			chip->oldstate = chip->state = FL_READY;
 			chip->priv = &shared[i];
 			/* those should be reset too since
@@ -562,7 +562,7 @@ static int lpddr_point(struct mtd_info *mtd, loff_t adr, size_t len,
 			break;
 
 		if ((len + ofs - 1) >> lpddr->chipshift)
-			thislen = (1<<lpddr->chipshift) - ofs;
+			thislen = (1UL << lpddr->chipshift) - ofs;
 		else
 			thislen = len;
 		/* get the chip */
@@ -578,7 +578,7 @@ static int lpddr_point(struct mtd_info *mtd, loff_t adr, size_t len,
 		len -= thislen;
 
 		ofs = 0;
-		last_end += 1 << lpddr->chipshift;
+		last_end += 1UL << lpddr->chipshift;
 		chipnum++;
 		chip = &lpddr->chips[chipnum];
 	}
@@ -604,7 +604,7 @@ static int lpddr_unpoint (struct mtd_info *mtd, loff_t adr, size_t len)
 			break;
 
 		if ((len + ofs - 1) >> lpddr->chipshift)
-			thislen = (1<<lpddr->chipshift) - ofs;
+			thislen = (1UL << lpddr->chipshift) - ofs;
 		else
 			thislen = len;
 
-- 
2.51.0




