Return-Path: <stable+bounces-58698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEED92B83C
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78197282192
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC60154C07;
	Tue,  9 Jul 2024 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZUAej/F9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85C314038F;
	Tue,  9 Jul 2024 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524724; cv=none; b=PZbBY6XEWQyqMR69UsoY4gr04rl9dFLYny6jknOIHcfKHM6nJWAnBmDUm18AB1QxG5LN3sa2hwbvtfAlCoOgBVP6/swi8LSHgHftad0IOCXQ/4PYIctwBgdIJSvbnFM2hGolwMO4wdBXguadbspASwuTtiS3Myvb/Yaztoik0ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524724; c=relaxed/simple;
	bh=j3dZrrkJCO8ZxAoU0zQRGeu7O67W/psbq6bkY7CKyUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqIBm0wKBbkLI9B0H9oTyhIsW17AP+hzR+i8TOsbbgl4o7SbzFYqRtE5SJxhlKFs2ADmfgOFz7e18rkb2XdtrbQp1Dx4GViUfQjzEiDP34KJbYKrDD5gI6E3NDYC7rWHU4/+AHc1DN0uVdNbWG+twpjkJcyTqoe/TTFOOmg3tic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZUAej/F9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607CDC3277B;
	Tue,  9 Jul 2024 11:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524723;
	bh=j3dZrrkJCO8ZxAoU0zQRGeu7O67W/psbq6bkY7CKyUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZUAej/F9lKq325GXYKPOVvSBAjUeVQbx57UHZMuDwnT26UM5RdBuLK40CHgHy13ob
	 E3mP6A9Jz9kiwj8CRnww1ubcMdlD/n3Pl0m3701lu+DYbFcRe8V6SihL5kgJajEHsG
	 TtuE3xom/x11xFO2TD+fGqrl5+xUfQbXQifjs9MQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Dahl <ada@thorsis.com>,
	Steven Seeger <steven.seeger@flightsystems.net>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 6.1 079/102] mtd: rawnand: Bypass a couple of sanity checks during NAND identification
Date: Tue,  9 Jul 2024 13:10:42 +0200
Message-ID: <20240709110654.450678821@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110651.353707001@linuxfoundation.org>
References: <20240709110651.353707001@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit 8754d9835683e8fab9a8305acdb38a3aeb9d20bd upstream.

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
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Link: https://lore.kernel.org/linux-mtd/20240516131320.579822-3-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/nand_base.c |   57 +++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1090,28 +1090,32 @@ static int nand_fill_column_cycles(struc
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
@@ -1120,7 +1124,7 @@ static int nand_fill_column_cycles(struc
 	 * Small page NANDs use 1 cycle for the columns, while large page NANDs
 	 * need 2
 	 */
-	if (mtd->writesize <= 512)
+	if (!ident_stage && mtd->writesize <= 512)
 		return 1;
 
 	addrs[1] = offset_in_page >> 8;
@@ -1316,16 +1320,19 @@ int nand_change_read_column_op(struct na
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



