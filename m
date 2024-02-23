Return-Path: <stable+bounces-23458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD788610DA
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 12:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C015284E9E
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 11:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EDF7AE7E;
	Fri, 23 Feb 2024 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UFx60bkB"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80015627FC
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689360; cv=none; b=dfLJSOPoKaF7+3lPRcFX84jowAG08EWcAcauLRetBg84e+jNYnite2+9uQJ9+vDVszOcc7wMHcZM91wPUB14P0cteLz2jLg2KMcPWzg+0thKpSplWbL/sHGHm5U3nwBBm5TXArhLdWABMewC0nA04+k09C5IPRDqKIxXBOXciOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689360; c=relaxed/simple;
	bh=fQf+6zFBphoqJ4/cUTV4V1rmyBl0akohoo7TJ7AYlbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u1W+HM8j+RBgLnLzyWPnbXgZWPyP65FG0B95NrIroCJ1MYDmHgP949FvRh5HwlEoSkq8GRRSXOzjGUkN/B8FrqFW7/M1gkWA8cYP1X18t/Hq9B2C0nlC4hKBHmPQHbFmcUAGg+1s6xG43oRwi7+9fnAfy4rs3DNhn8zn8a31/JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UFx60bkB; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4346C000F;
	Fri, 23 Feb 2024 11:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708689351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4210C3c5/SylTjU8kMcKJ8rayKT+noKE9Ryn/irxAf4=;
	b=UFx60bkBHZlF+wkEHc5QTPSi2NpXroDmzbuuIXrzKVe354ejrZBovIMSPZRo6tBE40iDNO
	Y6Llgyj0XbyKGukMznIskWUIvlwo7Y5nIMGj8Bgc31qAWBcVwTPXQEzmcXh5NvhTQUpDwF
	NAT4PCkdel0TIhKqwjnYU7zeAJFqaU7Q6mLg2S7T7q08zhFlNmCUZHdY/8fJLitMjMDevf
	AAw1x8hyySlvU78yzROME+P2GRHXNBXpAU03gqromS7k1Vse0Scs1hXcLd3jGUX1jDD+R0
	WFgz9a3Rs5qM6uFPp6DD6pRnP/v9/0zWlCS0yv/XkPnk9KZ4Mj5gRgjhNSiOyA==
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
Subject: [PATCH 2/3] mtd: rawnand: Add a helper for calculating a page index
Date: Fri, 23 Feb 2024 12:55:44 +0100
Message-Id: <20240223115545.354541-3-miquel.raynal@bootlin.com>
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

For LUN crossing boundaries, it is handy to know what is the index of
the last page in a LUN. This helper will soon be reused. At the same
time I rename page_per_lun to ppl in the calling function to clarify the
lines.

Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
This is a dependency for the next patch, so I Cc'd stable on it as well.
---
 drivers/mtd/nand/raw/nand_base.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index bcfd99a1699f..d6a27e08b112 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1211,19 +1211,25 @@ static int nand_lp_exec_read_page_op(struct nand_chip *chip, unsigned int page,
 	return nand_exec_op(chip, &op);
 }
 
+static unsigned int rawnand_last_page_of_lun(unsigned int pages_per_lun, unsigned int lun)
+{
+	/* lun is expected to be very small */
+	return (lun * pages_per_lun) + pages_per_lun - 1;
+}
+
 static void rawnand_cap_cont_reads(struct nand_chip *chip)
 {
 	struct nand_memory_organization *memorg;
-	unsigned int pages_per_lun, first_lun, last_lun;
+	unsigned int ppl, first_lun, last_lun;
 
 	memorg = nanddev_get_memorg(&chip->base);
-	pages_per_lun = memorg->pages_per_eraseblock * memorg->eraseblocks_per_lun;
-	first_lun = chip->cont_read.first_page / pages_per_lun;
-	last_lun = chip->cont_read.last_page / pages_per_lun;
+	ppl = memorg->pages_per_eraseblock * memorg->eraseblocks_per_lun;
+	first_lun = chip->cont_read.first_page / ppl;
+	last_lun = chip->cont_read.last_page / ppl;
 
 	/* Prevent sequential cache reads across LUN boundaries */
 	if (first_lun != last_lun)
-		chip->cont_read.pause_page = first_lun * pages_per_lun + pages_per_lun - 1;
+		chip->cont_read.pause_page = rawnand_last_page_of_lun(ppl, first_lun);
 	else
 		chip->cont_read.pause_page = chip->cont_read.last_page;
 }
-- 
2.34.1


