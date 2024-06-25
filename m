Return-Path: <stable+bounces-55146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A631915F40
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C954B2306B
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 07:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F60114659E;
	Tue, 25 Jun 2024 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEydQj02"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA9A146593;
	Tue, 25 Jun 2024 07:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719298946; cv=none; b=iiju8+f9rYZniEceh3qFFrWY7p4Qxp4EauMQsRQLFgP7bFMtvI74m7MUyPUf8cpMjjU1/9Daa2Sf9EHizCOFeLsAfcPQHaFWJiHoMYq9omMqUhPOmmak7/mQHpy6HKdNvVKCD23xO+28vEOMX64W2JZZ+7+SOCpF3AAVig4F9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719298946; c=relaxed/simple;
	bh=XlxkV5B5tKXN7agg1gK5hUup3+lJMnoQSSsBrRi9eFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LPla5dWp5LPqJFgsE6yls2SRSRcwhIKyM60vmLX3mmNw5HSYdDeOf+IwN1KyBLowWUTnsh7JQbbnC3Nh1uq/dNCWn5GFnrG6zNA6GcieRy162hl6HQocjtmfCd3vBhOyY6HWXXETr8eJUqzFc70OzlfFH0CkYQePrSfFw6XDcZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEydQj02; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70661cd46d2so2602687b3a.3;
        Tue, 25 Jun 2024 00:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719298944; x=1719903744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mvA5mzE/+nHLQ/xPEP+Y/yB74SbWB8VJOLGQGw2nUCg=;
        b=UEydQj02v6kfcCHd/WXXvk8gDfvncyP1DctWs9xP+1wTDGObeAYeDpOAF6Lpq7FAbP
         xa+MfKNCbI64vP5AYiNggqbI/ZLQDLqAMDBZ2UqJY34RqfHkPTHS5CQL5G20fWyr5GIm
         gBJy3WBHk/+S2ZXsZbKuYbydQd7r9d2rqPon5QS1sUV1/1Z95UbSAkSxpHqWnkhUVZrO
         jWkVbfqvr0dHKfYBJyWxdsl6VEv5Gp1y5k3g0yQcrLP9La0Pgy2OKLbeArRoe0NsIJ0d
         1vOP6U1ov8iA7azBySL3O1ihQ/ECqt3oJvtLEnBjGxCZPdl/m711N8AvUtPlSK6ROqwT
         FXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719298944; x=1719903744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mvA5mzE/+nHLQ/xPEP+Y/yB74SbWB8VJOLGQGw2nUCg=;
        b=nO01ZjPxI7E5FVE4z2jMKmugW6zcdnOjNgqJgJVLjOsAQTqm7kiNgWNYB6Vx9/VTbm
         /PuKrnp/5lQNaveD5inkBFVwpaJ4x3zaAjFv63/k8hAdjU++1ZMW1PaYBLLC/Yob0iTl
         yQpOeao/bNJX5gJqcF+4HChQnxE5vSD13hwAJc9IcWzKGuLfChFudB40gGwcvB+7Op8h
         f5KRp3mMp+LMhzm7Omfnkgy0fUnyXyi4Nk0XfT1qqPomOG7AEScFx8bgtIZkAicRgCe7
         4iUaP4I5RurdEyw6zL+QBoN7Aezwp1AbNmGtEFKsOXtdF5caVVblFU9H5fxB/bhBWw3P
         EArQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGjMEl6EzJ34jlm32RjlZvnzc0y4lx+TZoxLEgD49YB9krhPPsG6XdhNqgaXvLsIvjKTGUtDc4Z0v8ALnQKwwoHoJ0e98lrIv9ly98zUwD3iodPrGWn1F6nMUP8NqeIXbOciez
X-Gm-Message-State: AOJu0Yylyr8um7+9NyIHpGi0vl603HAXyoSMZ236zu4gP2t+wTA+S/uh
	Dlc+wGeKSkwvqXdWo7IYioWc9Ze8Asmgd2xPd8UAUzCW28MkUDCx
X-Google-Smtp-Source: AGHT+IHyXqn+MHBdaLTe/TgEpMINUt8YDQTQlDh9NmxJoiVz8r0KZYhpo1Sq3pmY2xVwKalIv08U+Q==
X-Received: by 2002:a05:6a00:2b8:b0:6ec:da6c:fc2d with SMTP id d2e1a72fcca58-70670fd4341mr5360419b3a.23.1719298943562;
        Tue, 25 Jun 2024 00:02:23 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7068a63c8bfsm2551976b3a.27.2024.06.25.00.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:02:23 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 46A2B800F4;
	Tue, 25 Jun 2024 15:04:44 +0800 (CST)
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
Subject: [PATCH v5.4.y v3] mtd: spinand: macronix: Add support for serial NAND flash
Date: Tue, 25 Jun 2024 15:01:42 +0800
Message-Id: <20240625070142.61782-1-linchengming884@gmail.com>
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


