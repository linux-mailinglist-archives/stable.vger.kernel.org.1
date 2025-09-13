Return-Path: <stable+bounces-179511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4078B56239
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 18:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308F3189CF30
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BDA1E5B9E;
	Sat, 13 Sep 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQlTb93M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808511DD0D4
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757780368; cv=none; b=TZpfoJvool3oUPsx+7dL13HL35+zhpluFmlEM4illRZzDVsbfM3qASIMxg7OKGKZmdrY0RQxTG/vwwDcpddogd+V6OcDfmAfhL8/f2YulxPIi7Vn8j2TYBRFuUMlFEvotWi3G1sNxHSoT8mDtZSndl0vCsgP2io81wpuCov+OBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757780368; c=relaxed/simple;
	bh=Nj+J5K8BVYVeDw/CL8GSojjKCJulqQBMGV7+StxmcSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UB67gnS3XBcjZUE9CH7v64amOLjHEb1D/nHI2ywoA8DMSxh2YS6+1Tr+OJUBJaMCuA/EQp1XuscRFfF6M5jpZz/oIrTWotvG2tfkXG6m0Zxr0j6rXahB3JctWq9fE3acx2R5POOAN3LGBvsC8daQTpwamMroFqjhNJuL92vaJ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQlTb93M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D9AC4CEEB;
	Sat, 13 Sep 2025 16:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757780368;
	bh=Nj+J5K8BVYVeDw/CL8GSojjKCJulqQBMGV7+StxmcSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qQlTb93MKtESsNh7sIZud2AN0CgrUNy+y87FsFYlIbNZQqeHX3PK+hrMZPvcYhHpt
	 0LyBDJI5mlFSjI2UCkzQ71AppmJC5XuXNBdc2jiTdnKak2KmomWOafePZ2JH/QjioI
	 efnwz4tlbJlDFeCJF2CqxhzovzaTuD+pcj0RKNaIfFAzLRjD5mSYaqKjTEjHtLlXId
	 eNGnkLCEkXeH1nVbtN/PymAOIoxV5s8Fxo3M6Zaq3TskqIwvw5Obik0DaMXaV27GOv
	 NTdK1MeWVoa/kUbS/PSVpOnrd02b1/fBq+hDMT/j9RWKXwjKP9YwINh4+bZXRX+YaL
	 HyewhyDd8b7yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Santhosh Kumar K <s-k6@ti.com>,
	Sridharan S N <quic_sridsn@quicinc.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mtd: spinand: winbond: Fix oob_layout for W25N01JW
Date: Sat, 13 Sep 2025 12:19:24 -0400
Message-ID: <20250913161924.1449549-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091343-refund-bullseye-601a@gregkh>
References: <2025091343-refund-bullseye-601a@gregkh>
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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/spi/winbond.c | 37 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index a33ad04e99cc8..d1666b3151817 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -122,6 +122,41 @@ static const struct mtd_ooblayout_ops w25n02kv_ooblayout = {
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
+static const struct mtd_ooblayout_ops w25n01jw_ooblayout = {
+	.ecc = w25n01jw_ooblayout_ecc,
+	.free = w25n01jw_ooblayout_free,
+};
+
 static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 				   u8 status)
 {
@@ -206,7 +241,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&w25n01jw_ooblayout, NULL)),
 	SPINAND_INFO("W25N02JWZEIF",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbf, 0x22),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 2, 1),
-- 
2.51.0


