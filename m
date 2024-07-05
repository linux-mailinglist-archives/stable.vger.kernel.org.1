Return-Path: <stable+bounces-58133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D74292883B
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 13:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01121F24EDC
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 11:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4525B14A09C;
	Fri,  5 Jul 2024 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="trWeqCj9"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BCC149C42
	for <stable@vger.kernel.org>; Fri,  5 Jul 2024 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720180312; cv=none; b=cQYo0zhSZHrpWdYKf4pTRX0gSKdUO6rRazt/dGxm4bDN9Rt40Aogu6Yn3aDhMaZ4yasqrwc3qqbfLEnpbTBWISqrwWIUUuAgK4Ul9EwlpDzhNFgRkOYc7ffswC8UR7m7FDevxBR/7a0dN1BuMEdpi0nDzK0LZqwu92ONk0VhhIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720180312; c=relaxed/simple;
	bh=87QADRvjWpwITWkhJ6ZCRxkd06/1fowLe9WbEwgHq+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lQYfT2uqis9wafZHDNmqC0PyRJxClehGydYFz87FeHcQvtE3SIyRHgOC7KvGYs4YqNPUrffFIDnuuNOrgu0oRbArx0ZJpHyhBvrdmw8R6c3R5IWsWQCECYsGdhorZ54Txsm0j1IUW5c4AxHE2C45D+SrJocpHbVsRyz6TVYF0lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=trWeqCj9; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5854ac817afso1936909a12.2
        for <stable@vger.kernel.org>; Fri, 05 Jul 2024 04:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1720180306; x=1720785106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+QojLwX8k68lmn9KlieWzohao5qbJAQQ4QJADw03ISo=;
        b=trWeqCj9K7y5dEAnrYDLyNztiU8Soo8sF0P3U/aGaXrHzYLs7smY+HwYtIrgvlifzs
         2MooXhSNWElAK81uJCSoCwEswq8RD/LUiK+t0/oW5Us9cV4ivFLdpS/zZeZSoXFGNdMM
         mB7dhXamkaDcUMLVoqm6xNyj2pt3jPxVB3+xKyqrlbayu7rKJboeNB8MOZTHYrQduuh4
         YuZktNt5yZZNCaISS/SOXkC0lUi4kPdIO+qC/fDBCVBGVd9Tv5v9cpqjO9bOQZeM+nlk
         7nt2JlnRouQmWaXiP619ZiKKa2C8/0Md+Q+E+ejaGkjLaSTLKg8GI1/ishgYbdwctzqN
         JpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720180306; x=1720785106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QojLwX8k68lmn9KlieWzohao5qbJAQQ4QJADw03ISo=;
        b=gmiX9QVk/nl90/RW86ITYXynPR1zAcZkpNp8XzmhlFcIonZP8J6GDW6Xg4JuQX765h
         E0HyAOJ+L6EtWhbNipYpHhIU8GrAPKS96JZi+uOGuxdlOMP2I3cojL9l03/fO3fZHvbU
         RWXJ5sB94oC1Qwz1rgQYjtt0kCr++5VkHO4frQkwED08s8MZ+CE1w6YgIp+ol2Fg/SQN
         FeEXQOXBFwhw0JBBAwgIeYX145Ti2C786ahnCfdFy8wvHKgNxqirGAPuDBSXX+yz5zZn
         Un6+p8lrNdaZUh0K6vMajbQIZP+48U2kk80CE2IENpHMCgGsdyi3y9UVobM4tkoZ59Zv
         WXBg==
X-Forwarded-Encrypted: i=1; AJvYcCW8ehdRWAxw03wxyC8WeXZEDRijkCDYXkdlcAZ36cvQf4QVsl/5NkgifDjd+DoUmeKYW+yepdjdviSEEsJ5XZLd73vBzffk
X-Gm-Message-State: AOJu0Ywp6C3sGXpY0dVrcilZw6bD3ozCPveH9g1jNfAPZUaZRKHSZg7I
	T6th4IjFiQTCuPxIRSvZ5KFDta0OJxhP4z4oBspH7PZINm3QbVfqVN4yYPGxKoM=
X-Google-Smtp-Source: AGHT+IFHA1gnQKRQ18iPmWbS0NPjG9TbNdQHs95PiwC+5AeAhU74MhAe3PLIFlm88Q5NStc5UX6U7A==
X-Received: by 2002:a17:906:4751:b0:a74:e717:4259 with SMTP id a640c23a62f3a-a77ba48db88mr281324166b.41.1720180306439;
        Fri, 05 Jul 2024 04:51:46 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab06531fsm674762866b.100.2024.07.05.04.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:51:46 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: miquel.raynal@bootlin.com
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	stable@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Yangtao Li <frank.li@vivo.com>,
	Li Zetao <lizetao1@huawei.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [Patch v2] mtd: rawnand: lpx32xx: Fix dma_request_chan() error checks
Date: Fri,  5 Jul 2024 13:51:35 +0200
Message-Id: <20240705115139.126522-1-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dma_request_chan() returns error pointer in case of error, while
dma_request_channel() returns NULL in case of error therefore different
error checks are needed for the two.

Fixes: 7326d3fb1ee3 ("mtd: rawnand: lpx32xx: Request DMA channels using DT entries")
Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: stable@vger.kernel.org
---
Changes v2:
 - Corrected 'Fixes' tag
 - add Cc: stable 

 drivers/mtd/nand/raw/lpc32xx_mlc.c | 2 +-
 drivers/mtd/nand/raw/lpc32xx_slc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 92cebe871bb4..b9c3adc54c01 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -575,7 +575,7 @@ static int lpc32xx_dma_setup(struct lpc32xx_nand_host *host)
 	dma_cap_mask_t mask;
 
 	host->dma_chan = dma_request_chan(mtd->dev.parent, "rx-tx");
-	if (!host->dma_chan) {
+	if (IS_ERR(host->dma_chan)) {
 		/* fallback to request using platform data */
 		if (!host->pdata || !host->pdata->dma_filter) {
 			dev_err(mtd->dev.parent, "no DMA platform data\n");
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 3b7e3d259785..ade971e4cc3b 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -722,7 +722,7 @@ static int lpc32xx_nand_dma_setup(struct lpc32xx_nand_host *host)
 	dma_cap_mask_t mask;
 
 	host->dma_chan = dma_request_chan(mtd->dev.parent, "rx-tx");
-	if (!host->dma_chan) {
+	if (IS_ERR(host->dma_chan)) {
 		/* fallback to request using platform data */
 		if (!host->pdata || !host->pdata->dma_filter) {
 			dev_err(mtd->dev.parent, "no DMA platform data\n");
-- 
2.25.1


