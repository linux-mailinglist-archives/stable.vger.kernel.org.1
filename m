Return-Path: <stable+bounces-159192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A70AF0BE7
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 08:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8863AF353
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 06:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777DB1FE44B;
	Wed,  2 Jul 2025 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5M6YrvA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17F92AE8E;
	Wed,  2 Jul 2025 06:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751438803; cv=none; b=YAsEQUDAMCbwsEGmf0tx2r8e/0+tH4jMRXGWd4Gz3mjMmVymDNpVKxQiv4Ph0kiP/XMa1SMLS2FGJQV9lO2Ays6sYEKxnfRqJkoLQ6PfbnaheK6R9YQc8sMVtK9iNbe64aJOfKAjIt33ddkCO49ZXvl8vh74zO4Jkyc5ThewZmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751438803; c=relaxed/simple;
	bh=zMHzm0hMduct+wHoWhsqVIpYxmo48Ijy2VBnTRILvKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AAd9E63+0N3V0aM6Dl9cc3LM5Fdv0fUcmJRDzzi6fbd/6/GijHnl3u48iYZ9BqFM98ntdHQpd+yqwB+EZ9Lkh4mcMMJZ46aWOFqLfjOZae8YRiAazNMO39g6fIFw1hN2cWuL1Vp3i0n4MWVgG1LB5f+WUl3WlBSzEc8ndDDerY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5M6YrvA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450ddb35583so8311695e9.1;
        Tue, 01 Jul 2025 23:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751438800; x=1752043600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z44fZXCKQ2rdMNWqQElWdKkxsLIoVt0uR3JUXZYJwhs=;
        b=U5M6YrvA+4/QVuCdS2Wxf3xveBCmadi9UaP4jkQDCGQwXekmpkSTgZ9tTruseLc/GY
         jFS5YDNUI4/sNH1tSbhIAZZ9OOuXta7rG+FjEbmiMMJzjNv/DsIFS4NJozElOkk76/lC
         0JaUn7S/DiFoKKHjUI7MIK8q+JGYWEHsWFmSrEXr5vJuMxKwtrxH3X/fwzcLmqE6s1f9
         AGp7F1Z1E8+A5lHBIJ0rV4+EF2aJyr7FcnmrDykFjjMeOcoXt/7tfVHKzZ/WEWf5d7TL
         b1qluDkp5EyCwnnlP0ED2wJH/uUoIFMOzNCwAKz7tiNTaiJTmMsZ1xDLP1egknzbscfm
         rNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751438800; x=1752043600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z44fZXCKQ2rdMNWqQElWdKkxsLIoVt0uR3JUXZYJwhs=;
        b=iTA5Et6o6lNhJ7WlPzUHHn5L2K1OrySNVkJfNz7pZthfbXNmki39L9r9Ro03tP1ODu
         pI6iT23R0yv5q/BHENASOMwlJu2YlC/xtVyhSqMvDazWHNo1Aja9w42XJib8r4xCRqZ4
         3jOxqrLuA5fkGl03W/AvXOATra48p+gKurFNolPyCDM10g+IBHNWHi43pOo0RlVeD6ik
         VxFmwKe7ER46er+ir1LTOldpxRhk2/UnRXv8+0DxfYjhduV6H8GtugLLp+I1WmV6LNmx
         VoYXjg9Fukt2f5REHDlLr2p648UdR9n96Okys7lrkEPbkJrvdmcqFZe3YulfbBZpcyJR
         IWtA==
X-Forwarded-Encrypted: i=1; AJvYcCVVFmIq7/15WMK8ZeJdmdxpDmLaOTdbvFp3J+u3DhMG5JyE/T0vxzzm7iXutVsi8QzP3+xiEYsB@vger.kernel.org, AJvYcCVzKr2jiwWRzBa2JC0L4YyZGG4oHvv5wiGpczAihmbkqxFwGQK4KjpA6lx4ieQeEYRQgmKL5LUA57RQc4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzat8CF23ivF6N1vRkmP4EmXlqycQMImtuwhga4vuN8bVG4hvQW
	G/9ksW5DrdPj7tvIXY1Po/BXicg6U/A9Hx23CkZMjcs64UjFAmiVeKJk
X-Gm-Gg: ASbGncuUXkorZd4urkbpiJcAXpP/PkHxRLIwaUC+aphvAjQhYb+RnK4/Kzl/lnVlQLy
	hPkR5lJXakGEZmq6dWkJS+GigcCV8NoZJn8sUlO3Cad+wegYu8QYlqGIcrdJN0rMvsgpZcIIQ+G
	3eUxm1fbhzteN5KEGXPJaBs0tUukZbEVKRCtt4jNSXsdKHeUd39qTN4cSDWFSaEOVU/3OIdJXae
	nCzymhXF28vr6uuKGt946EsfJuoMDJcYmqx3B+UvtzpXYgADo19ScZbCiZnosfVg6kZ5jOeu7h2
	KVvKTu/MUQWq29Yx2OZPETNbnRd3UvCTBYLKPUQiqYImiwBOSSk2v8afPRQyUbfe3WxVG691aB0
	0xrS+4/vVkBA8
X-Google-Smtp-Source: AGHT+IGEU3Ny06YRoZuAUkzUDN3QOXyRXaO7n1F+q8fEIPVppChrJnd6v3AlCTeUUNL0apHLFRr+KQ==
X-Received: by 2002:a05:6000:22c1:b0:3a6:d403:6429 with SMTP id ffacd0b85a97d-3b1fe8a00d6mr415529f8f.4.1751438799651;
        Tue, 01 Jul 2025 23:46:39 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:9d5:215:761c:daff])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a88c7fab7asm15156201f8f.24.2025.07.01.23.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 23:46:39 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Alexander Dahl <ada@thorsis.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: rawnand: atmel: Fix dma_mapping_error() address
Date: Wed,  2 Jul 2025 08:45:11 +0200
Message-ID: <20250702064515.18145-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems like what was intended is to test if the dma_map of the
previous line failed but the wrong dma address was passed.

Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
v1 -> v2:
- Add stable@vger.kernel.org
- Fix subject prefix

 drivers/mtd/nand/raw/atmel/nand-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index dedcca87defc..84ab4a83cbd6 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -373,7 +373,7 @@ static int atmel_nand_dma_transfer(struct atmel_nand_controller *nc,
 	dma_cookie_t cookie;
 
 	buf_dma = dma_map_single(nc->dev, buf, len, dir);
-	if (dma_mapping_error(nc->dev, dev_dma)) {
+	if (dma_mapping_error(nc->dev, buf_dma)) {
 		dev_err(nc->dev,
 			"Failed to prepare a buffer for DMA access\n");
 		goto err;
-- 
2.43.0


