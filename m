Return-Path: <stable+bounces-179506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0028AB561CF
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 17:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7FA1B25234
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 15:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DB02E719D;
	Sat, 13 Sep 2025 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1tvt0+p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170E2BE05F
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757777454; cv=none; b=YXYlHy/Yj6zHt1IOQkNK7zgvFpFF2TQb/wukU+7rQ4cA0AQG+2JxKGfo01PxTkfqaQvQlcvqiPjkEa/7W7hUrh3qVmB0kPLChQF6431xYkOgqg9536uZfCVCXbje9NU2g/IWRZZVIE25bWxZZcwI5SsscgR103gjfmS+FO//c8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757777454; c=relaxed/simple;
	bh=CLFDgDrtByMTPXj7284SAwT4LydEZ85YZc/xFZI5tVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoXxERQkKXJUYakPTa085Fm+rjvZg7mXhnIaeEWRTIFqFjExoi29Yecyk4Dzng073ywL4i4kcbwkNi7tXtCneRrFHf5NUHVm8RfSae8+MSZZXw670KKZwyjppYNLseD70wHXWBRy26g4u+j+1OAcImXFbUxWTl1An9cINBUDbsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1tvt0+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EB5C4CEF8;
	Sat, 13 Sep 2025 15:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757777453;
	bh=CLFDgDrtByMTPXj7284SAwT4LydEZ85YZc/xFZI5tVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o1tvt0+puC5KDxNYnOL2gancpDJkBlUG9zdyjZDbEuqnFFtFvMgJzjxno/HRK8dlh
	 sYQE+Puc7vcKPuU3D2t4IBAiddrvo9oIe71rp2hp9D3tuylfJK/XzDxID5zAH5olQL
	 7rILVw6hegGpf/qCmnsrsLY9S7Fe7vCLajQir6WTih9YImE2Bzj63WzSkSnZF1q+5Y
	 CFK9SFIkVVVcSJ+4U6Vr6KrAYqJMoLCLjlhrK3dKAtacUbXcr4QS/EsSJQnzA6LbSr
	 BQcHL7mlzRbhfK7Fbezv7YehJxDumrU9cuf5AKFURL7IMgr8ekIFGJel0AcTYm0pLs
	 W7IFZ0Htt/MxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 2/3] mtd: spinand: winbond: Enable high-speed modes on w25n0xjw
Date: Sat, 13 Sep 2025 11:30:48 -0400
Message-ID: <20250913153049.1419819-2-sashal@kernel.org>
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit f1a91175faaab02a45d1ceb313a315a5bfeb5416 ]

w25n0xjw chips have a high-speed capability hidden in a configuration
register. Once enabled, dual/quad SDR reads may be performed at a much
higher frequency.

Implement the new ->configure_chip() hook for this purpose and configure
the SR4 register accordingly.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Stable-dep-of: 4550d33e1811 ("mtd: spinand: winbond: Fix oob_layout for W25N01JW")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/spi/core.c    |  2 +-
 drivers/mtd/nand/spi/winbond.c | 45 ++++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h    |  1 +
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 83e5e79e2f0db..aa6fb862451aa 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -20,7 +20,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 
-static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
+int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 {
 	struct spi_mem_op op = SPINAND_GET_FEATURE_1S_1S_1S_OP(reg,
 						      spinand->scratchbuf);
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index b7a28f001a387..9af6675affc9c 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -18,6 +18,9 @@
 
 #define W25N04KV_STATUS_ECC_5_8_BITFLIPS	(3 << 4)
 
+#define W25N0XJW_SR4			0xD0
+#define W25N0XJW_SR4_HS			BIT(2)
+
 /*
  * "X2" in the core is equivalent to "dual output" in the datasheets,
  * "X4" in the core is equivalent to "quad output" in the datasheets.
@@ -42,10 +45,12 @@ static SPINAND_OP_VARIANTS(update_cache_octal_variants,
 static SPINAND_OP_VARIANTS(read_cache_dual_quad_dtr_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_4D_4D_OP(0, 8, NULL, 0, 80 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_4D_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 4, NULL, 0, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0, 104 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2D_2D_OP(0, 4, NULL, 0, 80 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_2D_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 2, NULL, 0, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 104 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_1D_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
@@ -230,6 +235,40 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 	return -EINVAL;
 }
 
+static int w25n0xjw_hs_cfg(struct spinand_device *spinand)
+{
+	const struct spi_mem_op *op;
+	bool hs;
+	u8 sr4;
+	int ret;
+
+	op = spinand->op_templates.read_cache;
+	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
+		hs = false;
+	else if (op->cmd.buswidth == 1 && op->addr.buswidth == 1 &&
+		 op->dummy.buswidth == 1 && op->data.buswidth == 1)
+		hs = false;
+	else if (!op->max_freq)
+		hs = true;
+	else
+		hs = false;
+
+	ret = spinand_read_reg_op(spinand, W25N0XJW_SR4, &sr4);
+	if (ret)
+		return ret;
+
+	if (hs)
+		sr4 |= W25N0XJW_SR4_HS;
+	else
+		sr4 &= ~W25N0XJW_SR4_HS;
+
+	ret = spinand_write_reg_op(spinand, W25N0XJW_SR4, sr4);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static const struct spinand_info winbond_spinand_table[] = {
 	/* 512M-bit densities */
 	SPINAND_INFO("W25N512GW", /* 1.8V */
@@ -268,7 +307,8 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
+		     SPINAND_CONFIGURE_CHIP(w25n0xjw_hs_cfg)),
 	SPINAND_INFO("W25N01KV", /* 3.3V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xae, 0x21),
 		     NAND_MEMORG(1, 2048, 96, 64, 1024, 20, 1, 1, 1),
@@ -324,7 +364,8 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
+		     SPINAND_CONFIGURE_CHIP(w25n0xjw_hs_cfg)),
 	SPINAND_INFO("W25N02KV", /* 3.3V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x22),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index c13b088ef75f1..d668b6266c34a 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -730,6 +730,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 			   enum spinand_readid_method rdid_method);
 
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
+int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val);
 int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val);
 int spinand_select_target(struct spinand_device *spinand, unsigned int target);
 
-- 
2.51.0


