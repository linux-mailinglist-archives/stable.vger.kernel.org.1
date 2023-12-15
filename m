Return-Path: <stable+bounces-6817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7B3814840
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 13:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54AD41F23AFA
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 12:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD1A2D052;
	Fri, 15 Dec 2023 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bctRou4Q"
X-Original-To: stable@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE422C6B6
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay8-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::228])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 90C93C28B5
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 12:32:27 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7CC9A1BF210;
	Fri, 15 Dec 2023 12:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702643540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1qNhSGk24Wd3KqDZvArgww3F1dD6EeCxn1qNbuBtcZ4=;
	b=bctRou4QxDYwafAq2TANfW7HNjJ53mbp+9zBTGyEymQrHyZopHLDPHrixl6yHkPG+h1Xqy
	irKqAyqQNbiZyqrF35z3MtYCz/s6Ux8w1iOXYhfKjjRx2L8K4nSx+mQnIZ+3HWpyXiRKnO
	/F0lW+VKy7v4egpTwA0iBK2LSqZAPcSa7J3fHGYW7YBsXG/t8eX3JqgDYaGm9/4CtolHMY
	EW2jjrFHBknY4Tw1nf/SEwM7lNeQGkIO6I6NH2MnF9etxtbGBgWdVdcOHqQHW6ZKFfeWkS
	r1tFjVv/aVERPWB2XCiHzhDkFgiS+5avOlSbNEsj7CqdCZl4kKTAKlrfNlPw1w==
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
	eagle.alexander923@gmail.com,
	mans@mansr.com,
	martin@geanix.com,
	=?UTF-8?q?Sean=20Nyekj=C3=A6r?= <sean@geanix.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] mtd: rawnand: Clarify conditions to enable continuous reads
Date: Fri, 15 Dec 2023 13:32:08 +0100
Message-Id: <20231215123208.516590-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215123208.516590-1-miquel.raynal@bootlin.com>
References: <20231215123208.516590-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

The current logic is probably fine but is a bit convoluted. Plus, we
don't want partial pages to be part of the sequential operation just in
case the core would optimize the page read with a subpage read (which
would break the sequence). This may happen on the first and last page
only, so if the start offset or the end offset is not aligned with a
page boundary, better avoid them to prevent any risk.

Cc: stable@vger.kernel.org
Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache reads")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 139fdf3e58c0..bbdcfbe643f3 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -3460,21 +3460,29 @@ static void rawnand_enable_cont_reads(struct nand_chip *chip, unsigned int page,
 				      u32 readlen, int col)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
+	unsigned int end_page, end_col;
+
+	chip->cont_read.ongoing = false;
 
 	if (!chip->controller->supported_op.cont_read)
 		return;
 
-	if ((col && col + readlen < (3 * mtd->writesize)) ||
-	    (!col && readlen < (2 * mtd->writesize))) {
-		chip->cont_read.ongoing = false;
-		return;
-	}
+	end_page = DIV_ROUND_UP(col + readlen, mtd->writesize);
+	end_col = (col + readlen) % mtd->writesize;
 
-	chip->cont_read.ongoing = true;
-	chip->cont_read.first_page = page;
 	if (col)
-		chip->cont_read.first_page++;
-	chip->cont_read.last_page = page + ((readlen >> chip->page_shift) & chip->pagemask);
+		page++;
+
+	if (end_col && end_page)
+		end_page--;
+
+	if (page + 1 > end_page)
+		return;
+
+	chip->cont_read.first_page = page;
+	chip->cont_read.last_page = end_page;
+	chip->cont_read.ongoing = true;
+
 	rawnand_cap_cont_reads(chip);
 }
 
-- 
2.34.1


