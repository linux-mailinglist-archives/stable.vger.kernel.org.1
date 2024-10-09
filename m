Return-Path: <stable+bounces-83204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 485BB996AC4
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 14:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063301F24CF7
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 12:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664651957E7;
	Wed,  9 Oct 2024 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PiuXCtPJ"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C88D1E4AE
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478209; cv=none; b=V+i9kUQrcPpMU0wdbI94632IqirO7rUJW0EHkCgKvYA9/Wll/HtFz7XC/m6GQ9Jbvk5h94v0ChF3b0H8kZMfi513gndrjK9MetSpmB/9cpir08667jSwQe3huCYQ/87fPdW6Vm+akhFEY5r+V4zTaAxw3OsNAnsKdBZRm0CjfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478209; c=relaxed/simple;
	bh=hgbLU0Ummc0aA6rkIYf4KcpcoSxbFLGZNiD3RW7DNE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrzpdtV6+E1ET4nyhZbU7DFhWqh2ww/LA4C4wmLiSx/8IzGf1X9KCJK1RWOAjGGJYAI7RGkh+y55cE5lEi91JZ08J5K2ccY9XvUaz+PTIFte9m08a7MOnKHIRaFDYA2XdBJ+zqYZo7TAV2sm5X9RqRAsonAmjh8UDiHHap7wr+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PiuXCtPJ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1ABE1C000D;
	Wed,  9 Oct 2024 12:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728478205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=99CvSVKc2OGj1mXYyz7kU4sOpawQLKPY7h3Y3IqJTVw=;
	b=PiuXCtPJnSsCSd6xtydD7+f4MX3fBCaKeCfZ06Rhr7K6DAQJFU4nL5fOGKIBHak0d7SguS
	hkh6uzBglrUDxws/uTTSAV9hX2ymQoTXe6ha0+8ez07Q177soXQypcWri96MBlOaPptmT1
	lbBShV7mleeZjUssXhBlylkZRY9HEAWpdtNmGCdZ/Rapt4oONsBPX9Ctd0qzX2mKiUqt2f
	c3iUqIZfh0IMiAYc6/jHwFZ8wWKVf21+bQTDtd6zRfFcvn4Tzfht3f40ayPvPws28kmE0R
	vBiu9hFyhxJsahaU/7jR22o37TFEQr/m0GibTtwvSpJSARLFI/GD/FnF31LxSQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Steam Lin <stlin2@winbond.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Sridharan S N <quic_sridsn@quicinc.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] mtd: spi-nand: winbond: Fix 512GW, 01GW, 01JW and 02JW ECC information
Date: Wed,  9 Oct 2024 14:50:00 +0200
Message-ID: <20241009125002.191109-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009125002.191109-1-miquel.raynal@bootlin.com>
References: <20241009125002.191109-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

These four chips:
* W25N512GW
* W25N01GW
* W25N01JW
* W25N02JW
all require a single bit of ECC strength and thus feature an on-die
Hamming-like ECC engine. There is no point in filling a ->get_status()
callback for them because the main ECC status bytes are located in
standard places, and retrieving the number of bitflips in case of
corrected chunk is both useless and unsupported (if there are bitflips,
then there is 1 at most, so no need to query the chip for that).

Without this change, a kernel warning triggers every time a bit flips.

Fixes: 6a804fb72de5 ("mtd: spinand: winbond: add support for serial NAND flash")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 4e765cec0a3b..9b611bf7e8f0 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -175,30 +175,30 @@ static const struct spinand_info winbond_spinand_table[] = {
 	SPINAND_INFO("W25N01JW",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbc, 0x21),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
-		     NAND_ECCREQ(4, 512),
+		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&w25m02gv_ooblayout, w25n02kv_ecc_get_status)),
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
 	SPINAND_INFO("W25N02JWZEIF",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbf, 0x22),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 2, 1),
-		     NAND_ECCREQ(4, 512),
+		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&w25m02gv_ooblayout, w25n02kv_ecc_get_status)),
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
 	SPINAND_INFO("W25N512GW",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x20),
 		     NAND_MEMORG(1, 2048, 64, 64, 512, 10, 1, 1, 1),
-		     NAND_ECCREQ(4, 512),
+		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&w25m02gv_ooblayout, w25n02kv_ecc_get_status)),
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
 	SPINAND_INFO("W25N02KWZEIR",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x22),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -220,12 +220,12 @@ static const struct spinand_info winbond_spinand_table[] = {
 	SPINAND_INFO("W25N01GWZEIG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x21),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
-		     NAND_ECCREQ(4, 512),
+		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&w25m02gv_ooblayout, w25n02kv_ecc_get_status)),
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
 	SPINAND_INFO("W25N04KV",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x23),
 		     NAND_MEMORG(1, 2048, 128, 64, 4096, 40, 2, 1, 1),
-- 
2.43.0


