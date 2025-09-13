Return-Path: <stable+bounces-179507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091BEB561D0
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 17:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D5F1B24D59
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 15:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8193D2F0C7C;
	Sat, 13 Sep 2025 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmDnEEyR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4170F2BE05F
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757777455; cv=none; b=lB0TaDzj/MWZqNo0U/MoBHu2T/xc/Avo0Z2bImmU0BDXITxK6nRhTw1+RFDh3VAHjgOH3veqVnoVo6UToC5VR4I20V+uiUEsfj+3wM1RS7GK1436NnKhDAC9fWbm52R9RX9j0tD9kjRY6sBRl7VTFJkUa5FF514DQQaQkWFkPac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757777455; c=relaxed/simple;
	bh=zBzhQUBejJV9uO6sXnH9jwadxlm+As40Ct3xjkGog3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4g1Ef8YPA4EO5XU83A7ocqEy8psUuB3JSJqrxAZ5NNgldpgz4UVoBLXuuz1ctnhIHPhxhN6vgbBZ4F42udNIlmKgSBvt3yiiLWCmI8ZQKGT+tOqI7dCljH/R/wDxoobXSRAuNgR6XIszWdYBrwZ4VuWhSOjmBSlxDJYy0tzDkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmDnEEyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F409BC4CEEB;
	Sat, 13 Sep 2025 15:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757777455;
	bh=zBzhQUBejJV9uO6sXnH9jwadxlm+As40Ct3xjkGog3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmDnEEyRtFR8uiVzS5p6J5n3NOcB8njz5ZLNDNTeUii76cmzgyByWYtm9b2djZ6a0
	 V6OGSIPvUAvNPR98USrNQKqbskRhweNvxqXD0deNnCc6EgvzoSryw6FUdLnI6K5Nrf
	 PnIT4dGPTtwRNeZr1GzvLbM7DUUJZDp2JZAWTJIeHnHEM1t5EwjU4fiV5gm8taw908
	 Gahz1wwcLgfFe0P274x7sVoGTtL20HME/y6o7JYYmfHFy8GbT5ZFKIfGQtkph+taqu
	 iBZcsJ4k+j+op55p2IdnTyVf6AGP2plmGTr+AzIfnRyyifefq6kUKiJkJJ74D5zMzL
	 GHwC46YUGt0zQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Santhosh Kumar K <s-k6@ti.com>,
	Sridharan S N <quic_sridsn@quicinc.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 3/3] mtd: spinand: winbond: Fix oob_layout for W25N01JW
Date: Sat, 13 Sep 2025 11:30:49 -0400
Message-ID: <20250913153049.1419819-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913153049.1419819-1-sashal@kernel.org>
References: <2025091343-unmade-clapped-31e9@gregkh>
 <20250913153049.1419819-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Santhosh Kumar K <s-k6@ti.com>

[ Upstream commit 4550d33e18112a11a740424c4eec063cd58e918c ]

Fix the W25N01JW's oob_layout according to the datasheet [1]

[1] https://www.winbond.com/hq/product/code-storage-flash-memory/qspinand-flash/?__locale=en&partNo=W25N01JW

Fixes: 6a804fb72de5 ("mtd: spinand: winbond: add support for serial NAND flash")
Cc: Sridharan S N <quic_sridsn@quicinc.com>
Cc: stable@vger.kernel.org
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/spi/winbond.c | 37 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 9af6675affc9c..116ac17591a86 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -162,6 +162,36 @@ static const struct mtd_ooblayout_ops w25n02kv_ooblayout = {
 	.free = w25n02kv_ooblayout_free,
 };
 
+static int w25n01jw_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = (16 * section) + 12;
+	region->length = 4;
+
+	return 0;
+}
+
+static int w25n01jw_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = (16 * section);
+	region->length = 12;
+
+	/* Extract BBM */
+	if (!section) {
+		region->offset += 2;
+		region->length -= 2;
+	}
+
+	return 0;
+}
+
 static int w35n01jw_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
 {
@@ -192,6 +222,11 @@ static int w35n01jw_ooblayout_free(struct mtd_info *mtd, int section,
 	return 0;
 }
 
+static const struct mtd_ooblayout_ops w25n01jw_ooblayout = {
+	.ecc = w25n01jw_ooblayout_ecc,
+	.free = w25n01jw_ooblayout_free,
+};
+
 static const struct mtd_ooblayout_ops w35n01jw_ooblayout = {
 	.ecc = w35n01jw_ooblayout_ecc,
 	.free = w35n01jw_ooblayout_free,
@@ -307,7 +342,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
+		     SPINAND_ECCINFO(&w25n01jw_ooblayout, NULL),
 		     SPINAND_CONFIGURE_CHIP(w25n0xjw_hs_cfg)),
 	SPINAND_INFO("W25N01KV", /* 3.3V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xae, 0x21),
-- 
2.51.0


