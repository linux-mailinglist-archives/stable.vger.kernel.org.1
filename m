Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7D4787CD8
	for <lists+stable@lfdr.de>; Fri, 25 Aug 2023 03:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbjHYBN7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 21:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbjHYBNn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 21:13:43 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C9A1BF1;
        Thu, 24 Aug 2023 18:13:41 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a3b66f350so404742b3a.3;
        Thu, 24 Aug 2023 18:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692926021; x=1693530821;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AIl1b0PkLEfFH4MOGYeCC8mCbNP8ENQSFlp2p49bKJI=;
        b=CBADhGDm9T3A1HJfy4H9u4PjDEKVmnPFF65AhnJvO5XiteTtCjj84dAYdq0WZp3M7v
         8zHjpOZciYAbHEn9apiIY8pKsI4StwQFoEKllQH/2CFudmvzipq2c83j1i/I8EkYfaBk
         QEkSdlxLc5XdkPoe++S6cKeXjvwGcWpwxOO++zg7sA0iUY2J8TtTwYVfJ6dA+ax+lj7K
         F8c09/LjeleTO4SDxCqBZhsaU2gzwvvonNeG+50+Tn8FjsbBMOGg5m+fxegBriaygtjb
         CHOUv0t6nfEMj1N1xXWxIABEOKOa1obyWxBAUpG4yzqElI8jFT8vCVTMXz9Ay4vYxpTQ
         qHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692926021; x=1693530821;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIl1b0PkLEfFH4MOGYeCC8mCbNP8ENQSFlp2p49bKJI=;
        b=PZfQa3rqt+DDoJhp1FMLXpl5C6oU7ONTr8RRvlDOvzIzZQROSCR6svShL/TF2nf0C1
         Wd2eRlz3t6jF9AMppIduPuKO4tUGS5bDbfxXEqkKXMzeRSmWCo7b2hlbPFTGoJOw/ZVC
         1RS11l89EXvVzOWRmcQA03DkkkFB0CFnxyLGqaTbozDstKJs7QGpgsjr7y2Fk1d5QI5G
         eSwneA+lP7TJnJ+vgvTYUdFVqS+IOMQA01c0dx+AqkIgDCWbn6FSZX7MWttsCB/syGQ7
         isoB/M2AqezJdY0H2GpzZg/rDQ0mipTT3W/iKuVvXGT84m+JAxiSwVjT8s8z8fY1rkRr
         6znA==
X-Gm-Message-State: AOJu0Yy67xbDsz1Gq1Q6dGO5rE4nwyKDZtrebUZixW5Cpgdt9BHaVMsa
        vS5BY9DuYTJZjswXds78kQw=
X-Google-Smtp-Source: AGHT+IHFObaa9xySIu0dbyOas+UXR0VEQEHVnpTUb75GzWel58564U0y34/7nDlCMKK/JPqziLvYUA==
X-Received: by 2002:a05:6a00:2284:b0:68b:f524:b8fa with SMTP id f4-20020a056a00228400b0068bf524b8famr3488304pfe.28.1692926021239;
        Thu, 24 Aug 2023 18:13:41 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id ff19-20020a056a002f5300b0068783a2dfdasm347878pfb.104.2023.08.24.18.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 18:13:40 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 4D132360439; Fri, 25 Aug 2023 13:13:37 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     s.shtylyov@omp.ru, dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>, stable@vger.kernel.org,
        Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v5 1/2] ata: pata_falcon: fix IO base selection for Q40
Date:   Fri, 25 Aug 2023 13:13:34 +1200
Message-Id: <20230825011335.25808-2-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825011335.25808-1-schmitzmic@gmail.com>
References: <20230825011335.25808-1-schmitzmic@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

With commit 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver
with pata_falcon and falconide"), the Q40 IDE driver was
replaced by pata_falcon.c.

Both IO and memory resources were defined for the Q40 IDE
platform device, but definition of the IDE register addresses
was modeled after the Falcon case, both in use of the memory
resources and in including register shift and byte vs. word
offset in the address.

This was correct for the Falcon case, which does not apply
any address translation to the register addresses. In the
Q40 case, all of device base address, byte access offset
and register shift is included in the platform specific
ISA access translation (in asm/mm_io.h).

As a consequence, such address translation gets applied
twice, and register addresses are mangled.

Use the device base address from the platform IO resource
for Q40 (the IO address translation will then add the correct
ISA window base address and byte access offset), with register
shift 1. Use MMIO base address and register shift 2 as before
for Falcon.

Encode PIO_OFFSET into IO port addresses for all registers
for Q40 except the data transfer register. Encode the MMIO
offset there (pata_falcon_data_xfer() directly uses raw IO
with no address translation).

Reported-by: William R Sowerbutts <will@sowerbutts.com>
Closes: https://lore.kernel.org/r/CAMuHMdUU62jjunJh9cqSqHT87B0H0A4udOOPs=WN7WZKpcagVA@mail.gmail.com
Link: https://lore.kernel.org/r/CAMuHMdUU62jjunJh9cqSqHT87B0H0A4udOOPs=WN7WZKpcagVA@mail.gmail.com
Fixes: 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver with pata_falcon and falconide")
Cc: stable@vger.kernel.org
Cc: Finn Thain <fthain@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: William R Sowerbutts <will@sowerbutts.com>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

---

Changes from v4:

Geert Uytterhoeven:
- use %px for ap->ioaddr.data_addr

Changes from v3:

Sergey Shtylyov:
- change use of reg_scale to reg_shift

Geert Uytterhoeven:
- factor out ata_port_desc() from platform specific code

Changes from v2:

Finn Thain:
- add back stable Cc:

Changes from v1:

Damien Le Moal:
- change patch title
- drop stable backport tag

Changes from RFC v3:

- split off byte swap option into separate patch

Geert Uytterhoeven:
- review comments

Changes from RFC v2:
- add driver parameter 'data_swap' as bit mask for drives to swap

Changes from RFC v1:

Finn Thain:
- take care to supply IO address suitable for ioread8/iowrite8
- use MMIO address for data transfer
---
 drivers/ata/pata_falcon.c | 50 +++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
index 996516e64f13..616064b02de6 100644
--- a/drivers/ata/pata_falcon.c
+++ b/drivers/ata/pata_falcon.c
@@ -123,8 +123,8 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
 	struct resource *base_res, *ctl_res, *irq_res;
 	struct ata_host *host;
 	struct ata_port *ap;
-	void __iomem *base;
-	int irq = 0;
+	void __iomem *base, *ctl_base;
+	int irq = 0, io_offset = 1, reg_shift = 2; /* Falcon defaults */
 
 	dev_info(&pdev->dev, "Atari Falcon and Q40/Q60 PATA controller\n");
 
@@ -165,26 +165,34 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
 	ap->pio_mask = ATA_PIO4;
 	ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
 
-	base = (void __iomem *)base_mem_res->start;
 	/* N.B. this assumes data_addr will be used for word-sized I/O only */
-	ap->ioaddr.data_addr		= base + 0 + 0 * 4;
-	ap->ioaddr.error_addr		= base + 1 + 1 * 4;
-	ap->ioaddr.feature_addr		= base + 1 + 1 * 4;
-	ap->ioaddr.nsect_addr		= base + 1 + 2 * 4;
-	ap->ioaddr.lbal_addr		= base + 1 + 3 * 4;
-	ap->ioaddr.lbam_addr		= base + 1 + 4 * 4;
-	ap->ioaddr.lbah_addr		= base + 1 + 5 * 4;
-	ap->ioaddr.device_addr		= base + 1 + 6 * 4;
-	ap->ioaddr.status_addr		= base + 1 + 7 * 4;
-	ap->ioaddr.command_addr		= base + 1 + 7 * 4;
-
-	base = (void __iomem *)ctl_mem_res->start;
-	ap->ioaddr.altstatus_addr	= base + 1;
-	ap->ioaddr.ctl_addr		= base + 1;
-
-	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
-		      (unsigned long)base_mem_res->start,
-		      (unsigned long)ctl_mem_res->start);
+	ap->ioaddr.data_addr = (void __iomem *)base_mem_res->start;
+
+	if (base_res) {		/* only Q40 has IO resources */
+		io_offset = 0x10000;
+		reg_shift = 0;
+		base = (void __iomem *)base_res->start;
+		ctl_base = (void __iomem *)ctl_res->start;
+	} else {
+		base = (void __iomem *)base_mem_res->start;
+		ctl_base = (void __iomem *)ctl_mem_res->start;
+	}
+
+	ap->ioaddr.error_addr	= base + io_offset + (1 << reg_shift);
+	ap->ioaddr.feature_addr	= base + io_offset + (1 << reg_shift);
+	ap->ioaddr.nsect_addr	= base + io_offset + (2 << reg_shift);
+	ap->ioaddr.lbal_addr	= base + io_offset + (3 << reg_shift);
+	ap->ioaddr.lbam_addr	= base + io_offset + (4 << reg_shift);
+	ap->ioaddr.lbah_addr	= base + io_offset + (5 << reg_shift);
+	ap->ioaddr.device_addr	= base + io_offset + (6 << reg_shift);
+	ap->ioaddr.status_addr	= base + io_offset + (7 << reg_shift);
+	ap->ioaddr.command_addr	= base + io_offset + (7 << reg_shift);
+
+	ap->ioaddr.altstatus_addr	= ctl_base + io_offset;
+	ap->ioaddr.ctl_addr		= ctl_base + io_offset;
+
+	ata_port_desc(ap, "cmd %px ctl %px data %px",
+		      base, ctl_base, ap->ioaddr.data_addr);
 
 	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (irq_res && irq_res->start > 0) {
-- 
2.17.1

