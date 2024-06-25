Return-Path: <stable+bounces-55145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B9C915F33
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526581F21F44
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 07:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41F1145FE4;
	Tue, 25 Jun 2024 07:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2F0XvhR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F716802;
	Tue, 25 Jun 2024 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719298865; cv=none; b=YwiWKgpFJC/sU2jfJMSFcbF9zcNAzRanoZ08XEJReLtxuRiKLjTImom1F1q6ZTTTJjL4h4omfGBjwlN/APK3nuhQJyk4/IlSXQRrGA+ySRN9pnuJRufl4LxCfvzY/GsDWnTxBru4a6zNU5qfJqUOgVQawBZl0joFUS99BpR01NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719298865; c=relaxed/simple;
	bh=YfpNamCGEIqA3p+BjNWW/DM+EOx9/u0jS7PSy40wbS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DvlS0Vanxge1daKgBbhyG5cbfv2oI+USShuM1iN9stV7zlk82Oyyl/YOBAnBMet3pOVa75DfKH0AZ1SIiF8A6GzX2xuSDZxAMs/x5vAW3wr/r9nncm9TD3VkgJWZ/u4DN+zbfsbt6vfr2FH+4p9oAhWDLBLzGnblkZ2l7nYUpWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2F0XvhR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70661cd46d2so2601457b3a.3;
        Tue, 25 Jun 2024 00:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719298863; x=1719903663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gXcQPhcXH3H/AQCZ56LsG9u+BEpWEhFcB2t8sFrXXoU=;
        b=T2F0XvhR/zyrqME8CKZc1KLT7Iu5PNWw5mnkZUnXQdoVWGW3yDFume98GEoWEvphnn
         03o9xhjEvxGC8xxHcnTBfqY4l9SALbmt18T9WrfXI7Eu+RSeonI5AGY5jehxjWMYwnSx
         uCuSsQFHcwUkKH42tg1tORc4orJY2JaxdptA5uCZ3UrrY+3jXlbzFx+3hCnAjOTAP7pl
         GcgtecBfXQH2+IWsvGf3EX6es6aTe675Khz60tC47pDjr4DeTHHfOMQ90sJnR+dIAIqn
         aAUPt/usMicY2dh53a4gKagsI7DNpBgNGlijBEBh73UnDzzVsA3Bra4fAWdO+UYw1h9N
         YXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719298863; x=1719903663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXcQPhcXH3H/AQCZ56LsG9u+BEpWEhFcB2t8sFrXXoU=;
        b=nQn9ps0fKJPH/MVNiuk0mD1r8b1CL+OykxZ61VxlvH2y/BDGJJMa98/vszbKXG1ZOx
         KHifE6Z5jKkUqeV1yx6iFPhfagqH5Ev22slitOxCEHKw/zaFGltZA3ZDG50yE5C3ckZS
         6jCWupnRa7iDp84t49M3mytrFb6X4F0WRXIr25YG8+b6hM/TJ5L5kmEoPG5VtoI8KqmE
         xw0Aoisr98TONeR+oq3o2LkgEriAwq4IAMAvAj8IRhgCo+rjlmIld7xbJIKEsCZAP880
         l2d9Q/SK6NPMdfyEevzXshiBA0q0Fjeg3qB1HvNT/pRuwj1tO/XYm6ptSrimClGmAdTc
         ddGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/eJAQyCkDQzOTHGrA2nwhCrjhJgDPIDha/UmidrvwqYisg6s8m+vOaup2VzwIRq7oaoKrf1NbegkILJ0mEKSVLDnEbrdGDl98xPqx6Of8Deqm4vxJBIrhzs82YlsWkbNnO/qJ
X-Gm-Message-State: AOJu0YyIf1IrAA4yhM4ZDsP++P24aJ372O0SRqw+OWMsb2f1g7W1wcGC
	m8YJco4S4UGaIAnl9miud2pdX1DMOxV20oxuETOW1hrNsArWXfAZ
X-Google-Smtp-Source: AGHT+IG90LT1DSP7K7q1tS/Kf1SuSUoQvgMMaxAEJuH8XWsCUbRBSEpcvcqyo12Vt4gHiXSJh/EMOQ==
X-Received: by 2002:a05:6a00:2284:b0:706:700c:7864 with SMTP id d2e1a72fcca58-70670e7a74bmr9584210b3a.4.1719298863393;
        Tue, 25 Jun 2024 00:01:03 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70675684c35sm4126262b3a.130.2024.06.25.00.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:01:03 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 3F0A0800F4;
	Tue, 25 Jun 2024 15:03:23 +0800 (CST)
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
Subject: [PATCH v5.10.y] mtd: spinand: macronix: Add support for serial NAND flash
Date: Tue, 25 Jun 2024 15:00:29 +0800
Message-Id: <20240625070029.61703-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

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

Cc: stable@vger.kernel.org # 5.10.y
Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
Signed-off-by: Jaime Liao <jaimeliao@mxic.com.tw>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/1621475108-22523-1-git-send-email-jaimeliao@mxic.com.tw
---
 drivers/mtd/nand/spi/macronix.c | 110 ++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 8bd3f6bf9b10..e42524687b5c 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -139,6 +139,116 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35LF2G14AC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x20),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF4G24AD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb5),
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF4GE4AD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb7),
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF2G14AC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa0),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF2G24AD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa4),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF2GE4AD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa6),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF2GE4AC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa2),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF1G14AC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x90),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF1G24AD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x94),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF1GE4AD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x96),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF1GE4AC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x92),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
 	SPINAND_INFO("MX31LF1GE4BC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x1e),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
-- 
2.25.1


