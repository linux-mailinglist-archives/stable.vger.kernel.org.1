Return-Path: <stable+bounces-10414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4474282928B
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 03:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B16D1C241B9
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 02:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDDB1870;
	Wed, 10 Jan 2024 02:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmI2oJG/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9FC320C
	for <stable@vger.kernel.org>; Wed, 10 Jan 2024 02:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d4414ec9c7so17507835ad.0
        for <stable@vger.kernel.org>; Tue, 09 Jan 2024 18:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704855359; x=1705460159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GUmVHJjZjFlMnRho+FxPh8GlLi7ACEuv/Yg7ul1J0rs=;
        b=lmI2oJG/mJFLEj2ocn6sQODbIuFenh/JcTEXhA7tA3lLuGz1PcPEQQVEF9SMjROHzD
         ioU8e0GcoEolwiXoX0hBblYfxbDvy94FRq6M5TS+I9HlWa4+UuOJnO48Gclazh8vGACc
         MGy1wjEfw1MS4UqK/novMNTwbpz7KmiH8BeYLVA0f+o//G2EyJ2lE36dxW9y6O6v3m5n
         oMbqmBSYBb6fstbHzISEl5XyB7edWZasP6LK48wxekkCsFvjHRK8fT9tbN+YnRO+oHi3
         k48stO+DdALe/uy1NFFGX5gLKSbHfcDEuJQ9zMbLU1q+b9Afa6LiNrLPrIdLQfZNf8Yh
         S+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704855359; x=1705460159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUmVHJjZjFlMnRho+FxPh8GlLi7ACEuv/Yg7ul1J0rs=;
        b=b+JhBZe6AfwE6xHYppszwRiLLp10QO4SzFMfMmo5RXmr2MUch3UwhY0av56OHLJuKK
         cw5n8CzivTCG7RqYNwMfGuaaV2FdZWOzFUSaA/s2+IcNHF6e65qdZKnNnzEfPrJosC3v
         RGmphMgGJ2KPOCbUHG9uCLD81R+IFhTLsoXdBgRsIEfU69KzLJAWM54bPeHZg0dnQi3I
         ln2KlZS1SgctUPv12iXd7Ym282x5CuNi3HKLLLWhYX4W094Ylzox+RSibkPbwDMYjYDl
         cGPhPcG2kB1dMFR0CXUSlP4jVp7uo5p6hi4FAU+z8iZcegKdMRUUjtST3Q+AP5BctDCf
         Zv6g==
X-Gm-Message-State: AOJu0YzycdwSqcN0x6M7KvNJvL+y0aK8W/nwcm9v8Cd42GQQ+eogXdtN
	BT9P2lnhQNZNmYbB6rJkloM=
X-Google-Smtp-Source: AGHT+IGRymKI53hpY/v59IOKdjN94ApqZ2zwM+j/cc1tkfAqj0QSDhueCGNrIY4PcebB3dMjCbXwTg==
X-Received: by 2002:a17:903:244a:b0:1d4:4a66:dad3 with SMTP id l10-20020a170903244a00b001d44a66dad3mr325471pls.42.1704855359216;
        Tue, 09 Jan 2024 18:55:59 -0800 (PST)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902c1cc00b001d55fa244afsm1752277plc.207.2024.01.09.18.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 18:55:01 -0800 (PST)
Received: from hqs-appsw-appswa2.mp600.macronix.com (linux-patcher [172.17.236.35])
	by twhmp6px (Postfix) with ESMTPS id 151318050D;
	Wed, 10 Jan 2024 10:58:40 +0800 (CST)
From: Jaime Liao <jaimeliao.tw@gmail.com>
To: stable@vger.kernel.org,
	miquel.raynal@bootlin.com
Cc: jaimeliao@mxic.com.tw,
	jaimeliao.tw@gmail.com
Subject: [PATCH] mtd: spinand: macronix: Correct faulty page size of MX35LF4GE4AD
Date: Wed, 10 Jan 2024 10:54:28 +0800
Message-Id: <20240110025428.158812-1-jaimeliao.tw@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: JaimeLiao <jaimeliao@mxic.com.tw>

Correct page size of MX35LF4GE4AD to 4096.

Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
---
 drivers/mtd/nand/spi/macronix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index bbb1d68bce4a..f18c6cfe8ff5 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -125,7 +125,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 	SPINAND_INFO("MX35LF4GE4AD", 0x37,
-		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_MEMORG(1, 4096, 128, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
-- 
2.25.1


