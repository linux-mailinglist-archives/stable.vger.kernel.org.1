Return-Path: <stable+bounces-47853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470758D7C9C
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 09:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7071C21925
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 07:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A791F481A7;
	Mon,  3 Jun 2024 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPaW8jAg"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABF047A4C;
	Mon,  3 Jun 2024 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717400413; cv=none; b=mYkLEA9CV7H0TZrpexURzAmFYhTkHwU6/XAW0XFhzswIneKm5MCQSg7f+RDwJJjrIGp5JwERi3m2kgQ/dbpdCXw/GwlUdZ0dN6LwhPDDNYrA5mAs2qbT5xcAkYc5FzbMx/iph31oPbVzLSIzc0wJxOvmVUpyc1hqM22fT2aHWGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717400413; c=relaxed/simple;
	bh=Y0TmL0BXrE37/+np5aA/hDi1fG033tdMSsomY2CBrCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JBPC+K2kG9Z5HaHeoaBeowke7GINyRjlE37qt3B30XJ7C6LZm/a9KJ1PE4Xvu/Vcqlk7VZELLCiNMyVgHcnpmyR0iOJqvnJOL0yimN7AHs24KOlhOlzuo7iWPvm3fJHHVjC4mEDR8zbebJPs+o5cOCZzbywNeviVQ2RD61xuWso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPaW8jAg; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-24c9f297524so2141073fac.0;
        Mon, 03 Jun 2024 00:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717400411; x=1718005211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2FWb75cH+3iCprEXqTnOlMXbH+prg3pAb1WVvaGmF9A=;
        b=NPaW8jAgn0bAeuVRNIZrSoycEllrR4eVfEcGrCkJSGAq1w0nSMTGXZ3DXcPXtPUW0i
         kSDDKKPM5i/wgOiER4RH9z4k/NCDFxvNigb1GIxiwSfVzcUUzCn3FdUtglfslIr5qOq+
         hno7pwj8OUH2D2w1w+BUTk1yqfEQrcfS0LYEM0B3uzDrjF27aBwq0RVgmvSPdLsg/NWR
         VYhd36JBF4OCw+Ak6j1GPL2aUxeQ7kBlKdErrjlXt7jT2WX8zRU2N1ruBJRdPp5r91Gq
         MFdauejkWlhbYmKb4yN6qHoDU/OQ4301FGYakHfIIRVSceO8OcmHKikXJqcisNpivGFI
         K0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717400411; x=1718005211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2FWb75cH+3iCprEXqTnOlMXbH+prg3pAb1WVvaGmF9A=;
        b=MyY1LLXLbGTrk1mLpiR93nb6nGg1zbgw9iQBoJS8W/hUesqdvPkHBOsBQj1OO8om6o
         9+1cARBcx5zKJf3MOsJFC2ElPJH5R4NJigShn+aA/hl24jpLtaOkaaQXg+TTcOGx6zaH
         3G8CDTluqmOT9WlpoTskIvy/OrySJM0P6zQyf3qlxbp00CKyZzYAzbLBhe7GYpfhmcsT
         c97a0s1HqBAUJ50prwyHy5jLcWoq/J6k9tc9lhiPMYBntoq8fldyjxy7oClSMoxwimzL
         vYZ3kk5SiO4wcYM3+E9MKaUH4WO1ZXGJimiGnf5V6JYRmAS8Shmwky0BeGevYZsCsvdW
         Y+zg==
X-Forwarded-Encrypted: i=1; AJvYcCXffMpAvXoDFUcY+cVECL1P6iFbO4FpAuohJJ/4hyVsg5Qdv1nlY1Z98KIOInlZEoPWvK6WkZvmtRZO56ApbcbIiFJRlf2xKN201TkytOrZpkyIzkWKKlsEOmsLIDaDUdMFYjnc
X-Gm-Message-State: AOJu0YzD9M8DJEwD5xZCZliz9+T0YDHiNZe9vX0hzAehBEo5r99HnSYz
	FXZ/d0/GznHPCzYhy49jBlC3HPcQbkoQfpBXajkS3BlsFrnWzl2y
X-Google-Smtp-Source: AGHT+IF5/ByL3b/SC1mcU5unJApgzzwn4Zx24MkG74MKNAPQfKKM9gMvAoT31/rXitQaS4tx8uULRQ==
X-Received: by 2002:a05:6870:a714:b0:24f:f413:3039 with SMTP id 586e51a60fabf-2508b9b8415mr9956592fac.2.1717400410647;
        Mon, 03 Jun 2024 00:40:10 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423cb705sm4904998b3a.4.2024.06.03.00.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 00:40:10 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 117BE8095A;
	Mon,  3 Jun 2024 15:43:08 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	dwmw2@infradead.org,
	computersforpeace@gmail.com,
	marek.vasut@gmail.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH] Documentation: mtd: spinand: macronix: Add support for serial NAND flash
Date: Mon,  3 Jun 2024 15:39:53 +0800
Message-Id: <20240603073953.16399-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

MX35UF{1,2,4}GE4AD and MX35UF{1,2}GE4AC have been merge into 
Linux kernel mainline. 
Commit ID: "c374839f9b4475173e536d1eaddff45cb481dbdf".

For SPI-NAND flash support on Linux kernel LTS v5.4.y,
add SPI-NAND flash MX35UF{1,2,4}GE4AD and MX35UF{1,2}GE4AC in id tables.

Those five flashes have been validate on Xilinx zynq-picozed board and
Linux kernel LTS v5.4.y.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/macronix.c | 45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index f18c6cfe8ff5..e1446798bfb3 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -132,6 +132,51 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+	SPINAND_INFO("MX35UF4GE4AD", 0xb7,
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
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


