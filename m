Return-Path: <stable+bounces-159150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918C0AEFBB2
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 16:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83F04A031F
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 14:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41662276036;
	Tue,  1 Jul 2025 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDb1gITG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE43527585C;
	Tue,  1 Jul 2025 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378672; cv=none; b=WkNYdxg0bKGkK1GELDq2F2PE9pyJ5Dz03P7ng974Tl27zn6dyKorS2ay44fjcbEjUdQ7F7hOXrucEKXumJr2ZVSGZiOQFXDgq/XQ7WrzLJ3NDXyBMr2Vdu3O9seYYrdJpwcYNq5dzsh/FjRE/p4GdJVbWlUlGZRf/Kq9Z1alFEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378672; c=relaxed/simple;
	bh=/MBHO/HqDaUBfzBgNGZeYC4UQPMQnREgL2F3m4ayADY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IQgoclEXI+czsU12fdtLRxp5E+2vpoJQWiuZ7v9zDo1qc7CGULnutIRReBxB/5v1cGrHX2t8EEXgdHWPT6Dnkg1d1uTJnoInpjTYUz1ntVJAMhB17x5brlKn/FEZFCpF4qu6tpJzuEs9c0/rQIzwPfKW5hacZ6lrTHLkGhpdPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDb1gITG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BE6C4CEEB;
	Tue,  1 Jul 2025 14:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751378671;
	bh=/MBHO/HqDaUBfzBgNGZeYC4UQPMQnREgL2F3m4ayADY=;
	h=From:To:Cc:Subject:Date:From;
	b=BDb1gITGKIO6DCGeNfIDtTY3aHfaO9vINFNOBkMJJ+rTmWSAbobkDnC0tSb7FjsOQ
	 PqIqe1g6Jpv5iHlaDsLAIiDGd1cBWwGJVJctOuQ0ooMWRB/0xBlvK3+oYeETKbsbEZ
	 JfXb9yJomsLbsqZQAnKkuzUxRi1e7fppRexivtCRSvBVMcutFaXucS8uuNT+RrM9O3
	 AcD0CRvi0qKDBCCxXcAWZPQZTcgDyvZPILEkHNw1UdvFiN/zE1YaSn6Wmnhr3LngOV
	 1t4UyA3czdAQ1cd+wk46KBMHfkkoMM8GLaV1XxWKO/smBH8FYhhl3RwRKR4r2CZuhM
	 QmK4C6ApXV9/g==
From: Michael Walle <mwalle@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jean-Marc Ranger <jmranger@hotmail.com>
Subject: [PATCH] mtd: spi-nor: Fix spi_nor_try_unlock_all()
Date: Tue,  1 Jul 2025 16:04:26 +0200
Message-Id: <20250701140426.2355182-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ff67592cbdfc ("mtd: spi-nor: Introduce spi_nor_set_mtd_info()")
moved all initialization of the mtd fields at the end of spi_nor_scan().
Normally, the mtd info is only needed for the mtd ops on the device,
with one exception: spi_nor_try_unlock_all(), which will also make use
of the mtd->size parameter. With that commit, the size will always be
zero because it is not initialized. Fix that by not using the size of
the mtd_info struct, but use the size from struct spi_nor_flash_parameter.

Fixes: ff67592cbdfc ("mtd: spi-nor: Introduce spi_nor_set_mtd_info()")
Cc: stable@vger.kernel.org
Reported-by: Jean-Marc Ranger <jmranger@hotmail.com>
Closes: https://lore.kernel.org/all/DM6PR06MB561177323DC5207E34AF2A06C547A@DM6PR06MB5611.namprd06.prod.outlook.com/
Tested-by: Jean-Marc Ranger <jmranger@hotmail.com>
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/swp.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
index 9c9328478d8a..9b07f83aeac7 100644
--- a/drivers/mtd/spi-nor/swp.c
+++ b/drivers/mtd/spi-nor/swp.c
@@ -56,7 +56,6 @@ static u64 spi_nor_get_min_prot_length_sr(struct spi_nor *nor)
 static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
 					u64 *len)
 {
-	struct mtd_info *mtd = &nor->mtd;
 	u64 min_prot_len;
 	u8 mask = spi_nor_get_sr_bp_mask(nor);
 	u8 tb_mask = spi_nor_get_sr_tb_mask(nor);
@@ -77,13 +76,13 @@ static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
 	min_prot_len = spi_nor_get_min_prot_length_sr(nor);
 	*len = min_prot_len << (bp - 1);
 
-	if (*len > mtd->size)
-		*len = mtd->size;
+	if (*len > nor->params->size)
+		*len = nor->params->size;
 
 	if (nor->flags & SNOR_F_HAS_SR_TB && sr & tb_mask)
 		*ofs = 0;
 	else
-		*ofs = mtd->size - *len;
+		*ofs = nor->params->size - *len;
 }
 
 /*
@@ -158,7 +157,6 @@ static bool spi_nor_is_unlocked_sr(struct spi_nor *nor, loff_t ofs, u64 len,
  */
 static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, u64 len)
 {
-	struct mtd_info *mtd = &nor->mtd;
 	u64 min_prot_len;
 	int ret, status_old, status_new;
 	u8 mask = spi_nor_get_sr_bp_mask(nor);
@@ -183,7 +181,7 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, u64 len)
 		can_be_bottom = false;
 
 	/* If anything above us is unlocked, we can't use 'top' protection */
-	if (!spi_nor_is_locked_sr(nor, ofs + len, mtd->size - (ofs + len),
+	if (!spi_nor_is_locked_sr(nor, ofs + len, nor->params->size - (ofs + len),
 				  status_old))
 		can_be_top = false;
 
@@ -195,11 +193,11 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, u64 len)
 
 	/* lock_len: length of region that should end up locked */
 	if (use_top)
-		lock_len = mtd->size - ofs;
+		lock_len = nor->params->size - ofs;
 	else
 		lock_len = ofs + len;
 
-	if (lock_len == mtd->size) {
+	if (lock_len == nor->params->size) {
 		val = mask;
 	} else {
 		min_prot_len = spi_nor_get_min_prot_length_sr(nor);
@@ -248,7 +246,6 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, u64 len)
  */
 static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, u64 len)
 {
-	struct mtd_info *mtd = &nor->mtd;
 	u64 min_prot_len;
 	int ret, status_old, status_new;
 	u8 mask = spi_nor_get_sr_bp_mask(nor);
@@ -273,7 +270,7 @@ static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, u64 len)
 		can_be_top = false;
 
 	/* If anything above us is locked, we can't use 'bottom' protection */
-	if (!spi_nor_is_unlocked_sr(nor, ofs + len, mtd->size - (ofs + len),
+	if (!spi_nor_is_unlocked_sr(nor, ofs + len, nor->params->size - (ofs + len),
 				    status_old))
 		can_be_bottom = false;
 
@@ -285,7 +282,7 @@ static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, u64 len)
 
 	/* lock_len: length of region that should remain locked */
 	if (use_top)
-		lock_len = mtd->size - (ofs + len);
+		lock_len = nor->params->size - (ofs + len);
 	else
 		lock_len = ofs;
 
-- 
2.39.5


