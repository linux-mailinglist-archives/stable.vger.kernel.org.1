Return-Path: <stable+bounces-179742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4903B59D1F
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 18:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5F41BC0FF1
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 16:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7660C2BE62C;
	Tue, 16 Sep 2025 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWFCg3JR"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D391328585
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038871; cv=none; b=Wo2Tb7nhujUrXjyrW1AL1oo+69mtF42krWuU4QWqownYnR+yb5JltOw+c0/Xfw0+hoxtp4m/1cnHJ0kV0eZt6EClSRv6+yjfbhuQX5fwQ5fxDewJ8uauRy3ujK7KQPc2OBtRhw4d8eVbEW6CtxtddLKqRDJ4dL37b806wcSKT/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038871; c=relaxed/simple;
	bh=2oyx3fguYqISTGd7HbY+g2/plEKbV2lTIDCk1OtyjQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sz7/Zbap4dJbyGiyGQhYd/KdIX62vI7OUl4Et9gVb0YbZvx3f9sKNkLhnj7L5D11Z6wYiL6K+6ZZdOURe3T2gw4wP/gs3Ff7SLDPwBN3HNma8cZIe87PlHrKfKOEcPltAAE99/2VKNl8PhGl7IJt0vqDPs/iG6Eyw9O6O4lvg1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PWFCg3JR; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-353dece5805so27759991fa.1
        for <stable@vger.kernel.org>; Tue, 16 Sep 2025 09:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758038867; x=1758643667; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d/0W2L9OlAywXpF0HxvS+gWrdQm+yMEFpV/GktPNazQ=;
        b=PWFCg3JRdt0egEkL6haWZg2OKocL8zPWZ8M1aAijwo4tW6cvxPY/CKJXyxjoS0G4+B
         Gi5sXX6MYmx13AbvzrN5+AhcVpsKZqiMqbRRgWhoYJzwTglENtP6Ri8c0RhFIku2FXVM
         fHfE8q+Gn8TOM2tVHcaotvgbEHouYT2QZFkMj4OR8E4s80Gi5TVltRVn+AlXMZc0KguQ
         UZXsqXevTaptiYmGbO45nV8PZxzk2C0papmXJ2bzcIwipjopqzy89VNBr+hPDMtS+L25
         zYPtSXBj6BgzqBj6lxdRkMXeqXQ5DrDObE7uBoYs6XSqeBUEgxkI/vaQikmoUuSiDzke
         GxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038867; x=1758643667;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/0W2L9OlAywXpF0HxvS+gWrdQm+yMEFpV/GktPNazQ=;
        b=X8R/ANTJliwwmKIJDH8pMKm69GEbI5hdWa6wHak0onqv4Rni03edV7jTGFMqJcmw4a
         ShLPxqh4fYQtzIN//NE93TeUH55QaVDSx5zfN3bJ+CKaLYoDLu9m8InVmZu+Shuz8Xsw
         2DEvR0BjejdFX0nHYiIyxcNbJaiKoaQ4jYnNXD5HYGSX39Ka87THehaeJ3KrTgOqiEu8
         +to7kFaKJXmxStNcy8jukZYeIwVSON8uihSXxY5gvoBY9cnRgBnqjCb5gn5VodFkLpsQ
         wL3qarC3Y9MIS8nUxkq/Vf4wB2HmB1uge0VaM4oSvMqK92vTNWfu6XB6pFh4p3y8zrYd
         lS9g==
X-Forwarded-Encrypted: i=1; AJvYcCWX+B2nsm4CxOzuNVQ493Ij2rlv+uniswbJh79jSh+5qkwDmqRp7iDF/7AkZDYt/mWUL/FlO44=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXVXuIe70HhJ9UyhfEDeW302Et0kcIjoWcEeF+XhZez6WWDOj4
	t6Yy6IV4gEF0MYR7HI+pXoSWVFNW6nyeJduYsNVizOuJmRWVV33IW7pIZReKHCS1ue0=
X-Gm-Gg: ASbGncs8f8n8xCtjNhj5pLlQ6ljuBWXrqIn506PdE/wUpMzHwZ8h0+BXuXYriRQW20y
	OFMoQw8RGl91sZxSVLkrPZVgcQbmHXq/h3FWaxrfFI0Dj4tOa+Q9lr76aF6FMLsP4VMN3SurKlB
	McBy+8yI6cvw1aDTDrJcAWbj/nh4CHvhOpdZw2Q5SKILJ7Vpo3C8aeefOS4E5VI//coNaGQcs7W
	DimmlRjrp+fCI7pUSWrp/udmGWxvyTjkdI975GX+UxHUUpSWbMPDq3F15Fi46X73Fr8jopTSq8K
	WlPwjDjPnTNRwH5sc+qNqJenHYHm2182MvYQ42gAswL62qpfRECPKlGyjTgqBzDzoSN/QKCoOwq
	Ml9Pdxej4p3iGOMYyrmIM+3j41sFjzq6QsTVIyFgCU7FYthopl1lgr0IWViTKgShtV0A=
X-Google-Smtp-Source: AGHT+IGhvr8U/FqO72QNvVOlNymqj+FPYnXU6PzK71FX6MNafUcnCAiOiJDfXKt2I3Er1bgMXYwDWQ==
X-Received: by 2002:a2e:b893:0:b0:355:2a10:f45f with SMTP id 38308e7fff4ca-3552a10f5d4mr37991311fa.12.1758038867171;
        Tue, 16 Sep 2025 09:07:47 -0700 (PDT)
Received: from [192.168.1.2] (c-92-34-217-190.bbcust.telenor.se. [92.34.217.190])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1a82065asm33455861fa.34.2025.09.16.09.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 09:07:46 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 16 Sep 2025 18:07:37 +0200
Subject: [PATCH v2] mtd: rawnand: fsmc: Default to autodetect buswidth
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-fsmc-v2-1-fd6c86c919ee@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEiLyWgC/12MQQrCMBBFr1JmbaQT2hJdeY/SRdpM2gFNZCJBK
 bm7sUvhb97n8XZIJEwJrs0OQpkTx1BBnxpYNhtWUuwqg251316wUz49FjU7NITWIA4eqvoU8vw
 +MuNUeeP0ivI5qhl/718go0I1OFM3d6bv9e3OwUo8R1lhKqV8AY2PyZOZAAAA
X-Change-ID: 20250914-fsmc-bd18e1a8116f
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, stable@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

If you don't specify buswidth 2 (16 bits) in the device
tree, FSMC doesn't even probe anymore:

fsmc-nand 10100000.flash: FSMC device partno 090,
  manufacturer 80, revision 00, config 00
nand: device found, Manufacturer ID: 0x20, Chip ID: 0xb1
nand: ST Micro 10100000.flash
nand: bus width 8 instead of 16 bits
nand: No NAND device found
fsmc-nand 10100000.flash: probe with driver fsmc-nand failed
  with error -22

With this patch to use autodetection unless buswidth is
specified, the device is properly detected again:

fsmc-nand 10100000.flash: FSMC device partno 090,
  manufacturer 80, revision 00, config 00
nand: device found, Manufacturer ID: 0x20, Chip ID: 0xb1
nand: ST Micro NAND 128MiB 1,8V 16-bit
nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
fsmc-nand 10100000.flash: Using 1-bit HW ECC scheme
Scanning device for bad blocks

I don't know where or how this happened, I think some change
in the nand core.

Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Drop surplus semicolon.
- Also add NAND_BUSWIDTH_AUTO if 8bit buswidth is specified.
- Link to v1: https://lore.kernel.org/r/20250914-fsmc-v1-1-6d86d8b48552@linaro.org
---
 drivers/mtd/nand/raw/fsmc_nand.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index df61db8ce466593d533e617c141a8d2498b3a180..b13b2b0c3f300c7a611a36a402f1587d28166fab 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -876,10 +876,14 @@ static int fsmc_nand_probe_config_dt(struct platform_device *pdev,
 	if (!of_property_read_u32(np, "bank-width", &val)) {
 		if (val == 2) {
 			nand->options |= NAND_BUSWIDTH_16;
-		} else if (val != 1) {
+		} else if (val == 1) {
+			nand->options |= NAND_BUSWIDTH_AUTO;
+		} else {
 			dev_err(&pdev->dev, "invalid bank-width %u\n", val);
 			return -EINVAL;
 		}
+	} else {
+		nand->options |= NAND_BUSWIDTH_AUTO;
 	}
 
 	if (of_property_read_bool(np, "nand-skip-bbtscan"))

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250914-fsmc-bd18e1a8116f

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


