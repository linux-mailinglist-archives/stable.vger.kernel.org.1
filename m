Return-Path: <stable+bounces-23457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A682C8610D9
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 12:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B841C20D69
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 11:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124EE7AE5A;
	Fri, 23 Feb 2024 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UdpfAvTs"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851EA76905
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689359; cv=none; b=cR7p1ysxkeqG+RBI6Ao+nH9yH35/T6BLPzb2iL+FotScV34ma2XWjuBgVFvIHggDh8fvxHa1GKKFsd1353hlBFhJKhXt/WgQaeJYOQcHD5v9vCLk3k7Xt0jLkBWcj5lSVsRTPQbxn6yruVHVq2gXBr8M3IDQiLKxUld7xpMw1YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689359; c=relaxed/simple;
	bh=ot7rfY//SXr54qNBjHWuWgs6Wlu/7UUOCtacgDS2B7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+Fsf9zUl0foqAyB0EcLzMV/HR5g4D9UpWzFuJ4GbHpMk3n+FIWO81yjP0OabVJGYtO9LM9cfpg0s3N1AwiX8ffJJDmp/tjsv2AU5u+adhuJ7BHQh5XDMS0+G974lQiEEZSH2tqID4uHmMGu/ZGfz5uf1Rc97qamU1divmiN9uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UdpfAvTs; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3968C000A;
	Fri, 23 Feb 2024 11:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708689350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8yrP8J9ft/GYoNxsSdLSCccwDVuNUqlEsP+2f7HuanA=;
	b=UdpfAvTsQ8T+NJXqujvznRZyQgsNEoFKSKyQy+pI3cnAdr8N/l2Z9JYCBYm39cKnE1Qrby
	H3MnBlHoTQH7MOrLOHpUPgu9b25ZEQ1wlG0wIuDzU4wlJGmXX802I/WOeohNjAqiSD/EEm
	+4v+bnh7Pr0SLMToHDP1exPtd268x0AHM8il8NSfHqtjhAswh+MLSmgYStIEcuQQ/SPg5O
	QMbHSr1/CQQRem+yRLzzLHfhaIar/LNZYm3jgAjd2XjPD5Kf2+NU+FbVmdgg25eemxp1Xm
	rr7Mkk/w9qbHEntErpjhgRL4oD6PFtLxGMyczWC0u4cuQ16eaY2RkyS2gkbqhg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Julien Su <juliensu@mxic.com.tw>,
	Jaime Liao <jaimeliao@mxic.com.tw>,
	Jaime Liao <jaimeliao.tw@gmail.com>,
	Alvin Zhou <alvinzhou@mxic.com.tw>,
	Christophe Kerello <christophe.kerello@foss.st.com>,
	eagle.alexander923@gmail.com,
	mans@mansr.com,
	martin@geanix.com,
	=?UTF-8?q?Sean=20Nyekj=C3=A6r?= <sean@geanix.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] mtd: rawnand: Fix and simplify again the continuous read derivations
Date: Fri, 23 Feb 2024 12:55:43 +0100
Message-Id: <20240223115545.354541-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223115545.354541-1-miquel.raynal@bootlin.com>
References: <20240223115545.354541-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

We need to avoid the first page if we don't read it entirely.
We need to avoid the last page if we don't read it entirely.
While rather simple, this logic has been failed in the previous
fix. This time I wrote about 30 unit tests locally to check each
possible condition, hopefully I covered them all.

Reported-by: Christophe Kerello <christophe.kerello@foss.st.com>
Closes: https://lore.kernel.org/linux-mtd/20240221175327.42f7076d@xps-13/T/#m399bacb10db8f58f6b1f0149a1df867ec086bb0a
Suggested-by: Christophe Kerello <christophe.kerello@foss.st.com>
Fixes: 828f6df1bcba ("mtd: rawnand: Clarify conditions to enable continuous reads")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 38 ++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 3b3ce2926f5d..bcfd99a1699f 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -3466,30 +3466,36 @@ static void rawnand_enable_cont_reads(struct nand_chip *chip, unsigned int page,
 				      u32 readlen, int col)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	unsigned int end_page, end_col;
+	unsigned int first_page, last_page;
 
 	chip->cont_read.ongoing = false;
 
 	if (!chip->controller->supported_op.cont_read)
 		return;
 
-	end_page = DIV_ROUND_UP(col + readlen, mtd->writesize);
-	end_col = (col + readlen) % mtd->writesize;
+	/*
+	 * Don't bother making any calculations if the length is too small.
+	 * Side effect: avoids possible integer underflows below.
+	 */
+	if (readlen < (2 * mtd->writesize))
+		return;
 
+	/* Derive the page where continuous read should start (the first full page read) */
+	first_page = page;
 	if (col)
-		page++;
-
-	if (end_col && end_page)
-		end_page--;
-
-	if (page + 1 > end_page)
-		return;
-
-	chip->cont_read.first_page = page;
-	chip->cont_read.last_page = end_page;
-	chip->cont_read.ongoing = true;
-
-	rawnand_cap_cont_reads(chip);
+		first_page++;
+
+	/* Derive the page where continuous read should stop (the last full page read) */
+	last_page = page + ((col + readlen) / mtd->writesize) - 1;
+
+	/* Configure and enable continuous read when suitable */
+	if (first_page < last_page) {
+		chip->cont_read.first_page = first_page;
+		chip->cont_read.last_page = last_page;
+		chip->cont_read.ongoing = true;
+		/* May reset the ongoing flag */
+		rawnand_cap_cont_reads(chip);
+	}
 }
 
 static void rawnand_cont_read_skip_first_page(struct nand_chip *chip, unsigned int page)
-- 
2.34.1


