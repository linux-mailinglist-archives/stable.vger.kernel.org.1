Return-Path: <stable+bounces-45296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61028C7757
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 15:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E99B281899
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 13:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E1E146D51;
	Thu, 16 May 2024 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MCXIKfcR"
X-Original-To: stable@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BFC145FE8
	for <stable@vger.kernel.org>; Thu, 16 May 2024 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865206; cv=none; b=YPvjgHsKGAGAWlI0zPAsS7Fxubf81fBy2oZyawy8SavZJlIgnNEAPGgxOsAXI8rcpvkeZtu+O6CE0QP6/inGpQjZylUOfj8sSTQSd5OamGHS/W78ZdqzP31s7h5vNS5tBktLGojHi/huHbdC9Cyd769dRlXETSUvSMtW4e5A0t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865206; c=relaxed/simple;
	bh=/aIH5lv1ykkSsOoOdTBeMSjQ/AYjRWRo/L5DVy9ZGtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZFHBrmTwSbQa0pCr3oY0FNud2wYZqlvWHKIQaSYnPdzhmaB79gh5OJDpYDW1eCF84H7BX1+XkddE4dgkzdVsF6ESNhKL5NdCvWdgdOrIx0aNcApAwFvd+e8UC6dRhXsW2YGvvomGD34kTauM0FIwFmGdSbllzoD4jGMuUQsE8Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MCXIKfcR; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6DFF14000D;
	Thu, 16 May 2024 13:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715865203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=niIhrWEjM3sU/kw98OzBrAKu9bIx/RRyEgWePiM1sso=;
	b=MCXIKfcRLCTetH7bJGUTLsLR5IhXYK7Tx7jmubQgWxBdELgB/TeKRPUc9lk5wryuqSbBsj
	9T+YfnamFcGGcnQeDki0AtcDCC6hH3BS8xvcZXANkpz2XhWI7nMdhXeWwj3ipFJDI2h4nx
	iNnYSmQoNKbqNsbwJUIK8mVoH5psvW/eVxF2cw5M4sD+7HyiJqKus99wAwWKybuxtog9LS
	RD/f46Q7VF1ZCE8Frlvaq+0a6HCCOCsJKtaip9Nb8ZX6mBWIJi5yDVp/n3DGo6tHWRWCd6
	jAcQQ1KoNJ19gcNxa+wBY+B4zVA0skY7YIGjz710wLlIkOpvJVsKgi1MIXjpnQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Alexander Dahl <ada@thorsis.com>,
	Steven Seeger <steven.seeger@flightsystems.net>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] mtd: rawnand: Bypass a couple of sanity checks during NAND identification
Date: Thu, 16 May 2024 15:13:20 +0200
Message-Id: <20240516131320.579822-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240516131320.579822-1-miquel.raynal@bootlin.com>
References: <20240516131320.579822-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

Early during NAND identification, mtd_info fields have not yet been
initialized (namely, writesize and oobsize) and thus cannot be used for
sanity checks yet. Of course if there is a misuse of
nand_change_read_column_op() so early we won't be warned, but there is
anyway no actual check to perform at this stage as we do not yet know
the NAND geometry.

So, if the fields are empty, especially mtd->writesize which is *always*
set quite rapidly after identification, let's skip the sanity checks.

nand_change_read_column_op() is subject to be used early for ONFI/JEDEC
identification in the very unlikely case of:
- bitflips appearing in the parameter page,
- the controller driver not supporting simple DATA_IN cycles.

As nand_change_read_column_op() uses nand_fill_column_cycles() the logic
explaind above also applies in this secondary helper.

Fixes: c27842e7e11f ("mtd: rawnand: onfi: Adapt the parameter page read to constraint controllers")
Fixes: daca31765e8b ("mtd: rawnand: jedec: Adapt the parameter page read to constraint controllers")
Cc: stable@vger.kernel.org
Reported-by: Alexander Dahl <ada@thorsis.com>
Closes: https://lore.kernel.org/linux-mtd/20240306-shaky-bunion-d28b65ea97d7@thorsis.com/
Reported-by: Steven Seeger <steven.seeger@flightsystems.net>
Closes: https://lore.kernel.org/linux-mtd/DM6PR05MB4506554457CF95191A670BDEF7062@DM6PR05MB4506.namprd05.prod.outlook.com/
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Changes in v2:
* Dropped the double (( ))
* Fixed nand_fill_column_cycles() as well.
---
 drivers/mtd/nand/raw/nand_base.c | 57 ++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 248e654ecefd..53e16d39af4b 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1093,28 +1093,32 @@ static int nand_fill_column_cycles(struct nand_chip *chip, u8 *addrs,
 				   unsigned int offset_in_page)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
+	bool ident_stage = !mtd->writesize;
 
-	/* Make sure the offset is less than the actual page size. */
-	if (offset_in_page > mtd->writesize + mtd->oobsize)
-		return -EINVAL;
-
-	/*
-	 * On small page NANDs, there's a dedicated command to access the OOB
-	 * area, and the column address is relative to the start of the OOB
-	 * area, not the start of the page. Asjust the address accordingly.
-	 */
-	if (mtd->writesize <= 512 && offset_in_page >= mtd->writesize)
-		offset_in_page -= mtd->writesize;
-
-	/*
-	 * The offset in page is expressed in bytes, if the NAND bus is 16-bit
-	 * wide, then it must be divided by 2.
-	 */
-	if (chip->options & NAND_BUSWIDTH_16) {
-		if (WARN_ON(offset_in_page % 2))
+	/* Bypass all checks during NAND identification */
+	if (likely(!ident_stage)) {
+		/* Make sure the offset is less than the actual page size. */
+		if (offset_in_page > mtd->writesize + mtd->oobsize)
 			return -EINVAL;
 
-		offset_in_page /= 2;
+		/*
+		 * On small page NANDs, there's a dedicated command to access the OOB
+		 * area, and the column address is relative to the start of the OOB
+		 * area, not the start of the page. Asjust the address accordingly.
+		 */
+		if (mtd->writesize <= 512 && offset_in_page >= mtd->writesize)
+			offset_in_page -= mtd->writesize;
+
+		/*
+		 * The offset in page is expressed in bytes, if the NAND bus is 16-bit
+		 * wide, then it must be divided by 2.
+		 */
+		if (chip->options & NAND_BUSWIDTH_16) {
+			if (WARN_ON(offset_in_page % 2))
+				return -EINVAL;
+
+			offset_in_page /= 2;
+		}
 	}
 
 	addrs[0] = offset_in_page;
@@ -1123,7 +1127,7 @@ static int nand_fill_column_cycles(struct nand_chip *chip, u8 *addrs,
 	 * Small page NANDs use 1 cycle for the columns, while large page NANDs
 	 * need 2
 	 */
-	if (mtd->writesize <= 512)
+	if (!ident_stage && mtd->writesize <= 512)
 		return 1;
 
 	addrs[1] = offset_in_page >> 8;
@@ -1436,16 +1440,19 @@ int nand_change_read_column_op(struct nand_chip *chip,
 			       unsigned int len, bool force_8bit)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
+	bool ident_stage = !mtd->writesize;
 
 	if (len && !buf)
 		return -EINVAL;
 
-	if (offset_in_page + len > mtd->writesize + mtd->oobsize)
-		return -EINVAL;
+	if (!ident_stage) {
+		if (offset_in_page + len > mtd->writesize + mtd->oobsize)
+			return -EINVAL;
 
-	/* Small page NANDs do not support column change. */
-	if (mtd->writesize <= 512)
-		return -ENOTSUPP;
+		/* Small page NANDs do not support column change. */
+		if (mtd->writesize <= 512)
+			return -ENOTSUPP;
+	}
 
 	if (nand_has_exec_op(chip)) {
 		const struct nand_interface_config *conf =
-- 
2.40.1


