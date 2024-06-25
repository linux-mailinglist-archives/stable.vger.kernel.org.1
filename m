Return-Path: <stable+bounces-55148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD207915FBE
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3584B22FC7
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 07:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914111474CB;
	Tue, 25 Jun 2024 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffzzuXD8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA75873463;
	Tue, 25 Jun 2024 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299602; cv=none; b=nA7JIn9YOn/j7Vdjo6g9w96u/GLA9R0OgrcWUzX1ZRWN5dFi4Z+OB9Q+nuxLAiAQDuGVldVVEqrcl9oBGE1ttlA4725y+B6zWmuQ7oJZ+arj+BS1VML0QsFoOvA8XIJxBOmpgNTM+hVYQrU1qjxouU/zLnSTxAlGENA9JWY6uQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299602; c=relaxed/simple;
	bh=eeHPwgkpAFO71TVTQMuDmcgFPFM0V9lv/vHn3xfW8PY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vdcj/2S7XGi47kkb9uRD6Ba0JwpbTi8pz41jUHonvypabGW+SVmrgbNY/ICGeRBOybP4euWwhScD1LSIy17QjqURrfLNV7t0bFeGDATx/OUrQIHBCAIxKTnIg/zIt2gFwtx37zeVrLdWVSEd9PmdVi8yGGG8mF346jk9JnLBtGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffzzuXD8; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c70c08d98fso4092111a91.0;
        Tue, 25 Jun 2024 00:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719299600; x=1719904400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QqS5qkvxYIguDPc+6nwFBzR1BGeFxAODD+Dwe8rZa64=;
        b=ffzzuXD8dbrZu+vV0vdWZTEpiw6fheI+yO2kgfyeTUBuDnJzlX2HuHTbiL3eKx/XF7
         7Zk0bTj6zf84et0BKCMIUPp8ZWkVPlDcRoRFr7CQUAHrXKFtvPsUI1ATfTJ4jq+fkePI
         MGJivUQeJpg/4loiJ2d/KkLC09Db6FSukDfWxtlWylvQSdCs+I80F0PBMbcJHUUoSWKc
         wiBCJ+ehHDUctVY9riSWfuQkoXXel2oFR6pEG0Qe4wH0AtJVCT0SHdQzPkcia0MAa4DX
         Zvyhwi53ZomYyduDIdyrqxzdoDtbXcY6eYlmrZwJEVgWXuh/A0sG0U6z5F1GppHkTi9F
         Kbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299600; x=1719904400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqS5qkvxYIguDPc+6nwFBzR1BGeFxAODD+Dwe8rZa64=;
        b=YVE1KtVFI4z3Q1mnZ2IJd8mazbieQlhrOfO6zViNVkC4stT0lvWBgivvCmdUeNK5oB
         uzycviUWd+KC7x3QYj9iS8zZsgLW1k2zTuWRodcYaQEQfFRb3u7f2Yx9LCuR48naQVA5
         FSZEK5APY99efM7nHHGxb2j0r4csBL3WxyYbncC00aNvIsOpAOr/OPcswXnArhx+CqI6
         EHhuVdZDm5L4+q562Obq5US3XjgedgCQQU5tHJXjN427+MGLBDp9BO2Xx4urfu55/h+Z
         6dNxuUouJ2cUc5qcyB/9arQCalGdVlH88zVMT4DNdFW3mf5ldjlfjwa1u8WiqwlmBrUi
         PSnw==
X-Forwarded-Encrypted: i=1; AJvYcCVBpM5uBnUi1UYbRSsHfcbvOUbab0CTEnY9Zr4qqaVwBEVreNSF8gOhvrRXSeD+xyd3n+qSKEc8gRlIEI4ECSSIrH6Q2doSM0kmJztrf0w978cMzOtYVQ8e5Nm846Kw1x7G76h0
X-Gm-Message-State: AOJu0YwgUryn2XwAxHonitG9lhDs6qrqOHvkssT6w7NgLhb+wOSi+pLT
	MLCT+SYJFhhyuD8E0oL4cm4W7RGs2uZTDI6rZyZucL+r0JTrF8qM
X-Google-Smtp-Source: AGHT+IHwy8BVEfsToz9CtNaX3E5F7pOK9zAZozi3JW/gRbDDAmNqkArpx5hpW2LXxCI9HnkVh1L1ww==
X-Received: by 2002:a17:90a:a40b:b0:2c8:87e:c4cf with SMTP id 98e67ed59e1d1-2c85819841bmr6033897a91.4.1719299600018;
        Tue, 25 Jun 2024 00:13:20 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819a8e466sm7941932a91.32.2024.06.25.00.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:13:19 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 24EFF800F4;
	Tue, 25 Jun 2024 15:15:40 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	dwmw2@infradead.org,
	computersforpeace@gmail.com,
	marek.vasut@gmail.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	stable@vger.kernel.org,
	Jaime Liao <jaimeliao@mxic.com.tw>
Subject: [PATCH v5.4.y v4] mtd: spinand: macronix: Add support for serial NAND flash
Date: Tue, 25 Jun 2024 15:12:51 +0800
Message-Id: <20240625071251.62100-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

commit c374839f9b4475173e536d1eaddff45cb481dbdf upstream.

Macronix NAND Flash devices are available in different configurations
and densities.

MX"35" means SPI NAND
MX35"LF"/"UF" , LF means 3V and UF meands 1.8V
MX35LF"2G" , 2G means 2Gbits
MX35LF2G"E4"/"24"/"14",
E4 means internal ECC and Quad I/O(x4)
24 means 8-bit ecc requirement and Quad I/O(x4)
14 means 4-bit ecc requirement and Quad I/O(x4)

MX35LF2G14AC is 3V 2Gbit serial NAND flash device
(without on-die ECC)
https://www.mxic.com.tw/Lists/Datasheet/Attachments/7926/MX35LF2G14AC,%203V,%202Gb,%20v1.1.pdf

MX35UF4G24AD/MX35UF2G24AD/MX35UF1G24AD is 1.8V 4Gbit serial NAND flash device
(without on-die ECC)
https://www.mxic.com.tw/Lists/Datasheet/Attachments/7980/MX35UF4G24AD,%201.8V,%204Gb,%20v0.00.pdf

MX35UF4GE4AD/MX35UF2GE4AD/MX35UF1GE4AD are 1.8V 4G/2Gbit serial
NAND flash device with 8-bit on-die ECC
https://www.mxic.com.tw/Lists/Datasheet/Attachments/7983/MX35UF4GE4AD,%201.8V,%204Gb,%20v0.00.pdf

MX35UF2GE4AC/MX35UF1GE4AC are 1.8V 2G/1Gbit serial
NAND flash device with 8-bit on-die ECC
https://www.mxic.com.tw/Lists/Datasheet/Attachments/7974/MX35UF2GE4AC,%201.8V,%202Gb,%20v1.0.pdf

MX35UF2G14AC/MX35UF1G14AC are 1.8V 2G/1Gbit serial
NAND flash device (without on-die ECC)
https://www.mxic.com.tw/Lists/Datasheet/Attachments/7931/MX35UF2G14AC,%201.8V,%202Gb,%20v1.1.pdf

Validated via normal(default) and QUAD mode by read, erase, read back,
on Xilinx Zynq PicoZed FPGA board which included Macronix
SPI Host(drivers/spi/spi-mxic.c).

Cc: stable@vger.kernel.org # 5.4.y
Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
Signed-off-by: Jaime Liao <jaimeliao@mxic.com.tw>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/1621475108-22523-1-git-send-email-jaimeliao@mxic.com.tw
---
 drivers/mtd/nand/spi/macronix.c | 99 +++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index f18c6cfe8ff5..a38d0de5f765 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -132,6 +132,105 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+	SPINAND_INFO("MX35LF2G14AC", 0x20,
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF4G24AD", 0xb5,
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF4GE4AD", 0xb7,
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF2G14AC", 0xa0,
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF2G24AD", 0xa4,
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF2GE4AD", 0xa6,
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF2GE4AC", 0xa2,
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF1G14AC", 0x90,
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF1G24AD", 0x94,
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF1GE4AD", 0x96,
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF1GE4AC", 0x92,
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
 };
 
 static int macronix_spinand_detect(struct spinand_device *spinand)
-- 
2.25.1


