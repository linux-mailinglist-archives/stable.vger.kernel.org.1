Return-Path: <stable+bounces-8449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD6A81DF6F
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 10:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3502811F8
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 09:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10ED3D9C;
	Mon, 25 Dec 2023 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNDhjsD1"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3C8443E
	for <stable@vger.kernel.org>; Mon, 25 Dec 2023 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-67f85d29d14so29398466d6.1
        for <stable@vger.kernel.org>; Mon, 25 Dec 2023 01:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703496123; x=1704100923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GUmVHJjZjFlMnRho+FxPh8GlLi7ACEuv/Yg7ul1J0rs=;
        b=hNDhjsD1ceswRhRSFOVhEW3/QZbOALl4UBaPoRLK2qTWMdbSSQPbIOIwccUDqB1a/N
         ecxC5APD6DUBiFc7Oy8Vprx894akl65uxhvyYCLVKCWL9OJf6lmJzeVZhRJnfG8S3zXE
         WRMpkrgePN9V5VZcfY8JGc5/TppWWjpLCNfaN5PRUduF/XTBjf+N5WmF03yb11Opc2GA
         HlSCjhf8D4JXrgfKqZU5r0kG78ra0YvCdr9xZg8tkuHMp10NGX89MmQR5kUNfWLeAN+S
         sKqqfaoXiuGm4o5D3G/phvUtoaTX7DM7yJUuFx5VNA0T682hu4/AcIP/HlXia+FsigED
         s6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703496123; x=1704100923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUmVHJjZjFlMnRho+FxPh8GlLi7ACEuv/Yg7ul1J0rs=;
        b=Ea3UW6jlMojbFfhBjUHP66N1Y3gvPeR42GTL4T8CiwkMm13ZaLLe5f6Mc/pblsav4J
         YwKxeE+5Nn83Ha45DZKT+6u+14oYovabuiUyySB42pAnCSthXGtRbAtNUR57nrTlwnJi
         EkuF/9Dgium5qo0TyQDMFc4n1/P3LMhlPY9heh31kM/65SbVYLSqe8OvgO8Kk8yas/5d
         bhAWsRt+8lLIazoDyd4lnv73/AaysXbOJt7GOlk4e2WICGnXKwxSfxVMrCAmRQMabhqV
         OYWxsFDrL+y2AdULXY+NoYIPrs98ntFCrs8ygI/ZLGkVBNosztC0WZYReoEno/FSrNPz
         s87w==
X-Gm-Message-State: AOJu0YwNgqooGkjJHV0eL4V6iam+C0owmvXauFwhDKjhtKJQXciivpbU
	QguNNOa4/o8//RhkfpiKW0w=
X-Google-Smtp-Source: AGHT+IHoDYBxKSPj+XqmZQGb7D6BMIVxaKgWLtntWuMBuROyB2Bo4ug9MKYdVXYpKcBKQuV2Tc6eMQ==
X-Received: by 2002:ad4:4e27:0:b0:67f:cec4:dea6 with SMTP id dm7-20020ad44e27000000b0067fcec4dea6mr2551273qvb.99.1703496123269;
        Mon, 25 Dec 2023 01:22:03 -0800 (PST)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a1a1c00b0028b3539cd97sm11382464pjk.20.2023.12.25.01.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 01:22:02 -0800 (PST)
Received: from hqs-appsw-appswa2.mp600.macronix.com (linux-patcher [172.17.236.35])
	by twhmp6px (Postfix) with ESMTPS id D058380527;
	Mon, 25 Dec 2023 17:26:04 +0800 (CST)
From: Jaime Liao <jaimeliao.tw@gmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	stable@vger.kernel.org
Cc: jaimeliao@mxic.com.tw
Subject: [PATCH] mtd: spinand: macronix: Correct faulty page size of MX35LF4GE4AD
Date: Mon, 25 Dec 2023 17:21:38 +0800
Message-Id: <20231225092138.114149-1-jaimeliao.tw@gmail.com>
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


