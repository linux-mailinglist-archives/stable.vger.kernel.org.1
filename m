Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FBF7815EA
	for <lists+stable@lfdr.de>; Sat, 19 Aug 2023 01:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242269AbjHRXtc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 18 Aug 2023 19:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242318AbjHRXtL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 Aug 2023 19:49:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D443A9F;
        Fri, 18 Aug 2023 16:49:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf3a2f44ffso9697295ad.1;
        Fri, 18 Aug 2023 16:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692402549; x=1693007349;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=91d4Npc/ynEpF6lULPt7AhHYRfLPE+Vx3JagSv/mUwQ=;
        b=nXzMZ/RqjrS+Se1hJHCf6aVMj8dXaVO0xoKFESXMC7i23EkbCB5tjmf6G394wDfezA
         SNiYAjUEPobqwBn43hollY/v/4fTadQDVvNELpV6So2fgJE8tv8/TpvEueKEFlCA358M
         c4i+i6etynZH5WD+OCM7JZgJK6vxbgF1vg1UUhHUpFE2DF8p29vHREUa7WciFqm1Qsok
         OdRYYEV585BeXvrauPBOaM1p8TKmwcpL6pHWuhIZvc9B5VyBrXxLX+ZSCctCN4e2Nof0
         icPIBbpMH5DlO615BZlzAm8+mKsrn3LntkKSmtGAPR9TeAdXydEwK2NBVADNsvjBK12c
         /seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692402549; x=1693007349;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91d4Npc/ynEpF6lULPt7AhHYRfLPE+Vx3JagSv/mUwQ=;
        b=YG10oTKv2vJhTfRy4+qry4036gvEVZXxHyH81LFdEoT3Vn39v/hWRo+3MmUFItP8A7
         jDBBkCmD14JjjomxKFWpKzu6+KPaeFNUYlidv3hWcQhb9TA87AtNIFXGtpwrzGuYO4Zv
         4qP5Ly42OTTXDcN/3ZX8B3nAmExcFUk+HJLn++YqyYS8Ei2LdDQI9KmIA5k5GUA1/ujO
         k4JFO0ibrIBqn4Gy3lGeP3IWcHb3ykMbmyWZV56yvxPn1t8TybN6E5OF5hgGCpaN76p/
         6pRv8yuaU1c9yMsav0Urik/m+uNxJz5P61C+WTd6CQ632a+TT4MRTeMQ1AOfM7IFgoUj
         I4Sg==
X-Gm-Message-State: AOJu0Yz3LyPc4D1BKAS/8LneGemSGUkNLZy0elcTB3SLIzY/Q4/PzQLw
        ZqrnAf7edJSzxM504jWt9lI=
X-Google-Smtp-Source: AGHT+IFrCwUztl3KLVyu9yyg3eXM1UHM4C3/oCvZur5W1KyM1tJ9YF6c/t/DymYQAHsSdv+TrAPlUQ==
X-Received: by 2002:a17:903:1248:b0:1b8:66f6:87a3 with SMTP id u8-20020a170903124800b001b866f687a3mr794943plh.52.1692402549450;
        Fri, 18 Aug 2023 16:49:09 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-62-141-252-fibre.sparkbb.co.nz. [122.62.141.252])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902ea0200b001bc9bfaba3esm2299466plg.126.2023.08.18.16.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 16:49:09 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id A5FE43603D9; Sat, 19 Aug 2023 11:49:05 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>, stable@vger.kernel.org,
        Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 1/2] ata: pata_falcon: fix IO base selection for Q40
Date:   Sat, 19 Aug 2023 11:49:02 +1200
Message-Id: <20230818234903.9226-2-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230818234903.9226-1-schmitzmic@gmail.com>
References: <20230818234903.9226-1-schmitzmic@gmail.com>
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
resources and in including register scale and byte vs. word
offset in the address.

This was correct for the Falcon case, which does not apply
any address translation to the register addresses. In the
Q40 case, all of device base address, byte access offset
and register scaling is included in the platform specific
ISA access translation (in asm/mm_io.h).

As a consequence, such address translation gets applied
twice, and register addresses are mangled.

Use the device base address from the platform IO resource,
and use standard register offsets from that base in order
to calculate register addresses (the IO address translation
will then apply the correct ISA window base and scaling).

Encode PIO_OFFSET into IO port addresses for all registers
except the data transfer register. Encode the MMIO offset
there (pata_falcon_data_xfer() directly uses raw IO with
no address translation).

Reported-by: William R Sowerbutts <will@sowerbutts.com>
Closes: https://lore.kernel.org/r/CAMuHMdUU62jjunJh9cqSqHT87B0H0A4udOOPs=WN7WZKpcagVA@mail.gmail.com
Link: https://lore.kernel.org/r/CAMuHMdUU62jjunJh9cqSqHT87B0H0A4udOOPs=WN7WZKpcagVA@mail.gmail.com
Fixes: 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver with pata_falcon and falconide")
Cc: stable@vger.kernel.org
Cc: Finn Thain <fthain@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: William R Sowerbutts <will@sowerbutts.com>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

---

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
 drivers/ata/pata_falcon.c | 55 ++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
index 996516e64f13..346259e3bbc8 100644
--- a/drivers/ata/pata_falcon.c
+++ b/drivers/ata/pata_falcon.c
@@ -123,8 +123,8 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
 	struct resource *base_res, *ctl_res, *irq_res;
 	struct ata_host *host;
 	struct ata_port *ap;
-	void __iomem *base;
-	int irq = 0;
+	void __iomem *base, *ctl_base;
+	int irq = 0, io_offset = 1, reg_scale = 4;
 
 	dev_info(&pdev->dev, "Atari Falcon and Q40/Q60 PATA controller\n");
 
@@ -165,26 +165,39 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
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
+		reg_scale = 1;
+		base = (void __iomem *)base_res->start;
+		ctl_base = (void __iomem *)ctl_res->start;
+
+		ata_port_desc(ap, "cmd %pa ctl %pa",
+			      &base_res->start,
+			      &ctl_res->start);
+	} else {
+		base = (void __iomem *)base_mem_res->start;
+		ctl_base = (void __iomem *)ctl_mem_res->start;
+
+		ata_port_desc(ap, "cmd %pa ctl %pa",
+			      &base_mem_res->start,
+			      &ctl_mem_res->start);
+	}
+
+	ap->ioaddr.error_addr	= base + io_offset + 1 * reg_scale;
+	ap->ioaddr.feature_addr	= base + io_offset + 1 * reg_scale;
+	ap->ioaddr.nsect_addr	= base + io_offset + 2 * reg_scale;
+	ap->ioaddr.lbal_addr	= base + io_offset + 3 * reg_scale;
+	ap->ioaddr.lbam_addr	= base + io_offset + 4 * reg_scale;
+	ap->ioaddr.lbah_addr	= base + io_offset + 5 * reg_scale;
+	ap->ioaddr.device_addr	= base + io_offset + 6 * reg_scale;
+	ap->ioaddr.status_addr	= base + io_offset + 7 * reg_scale;
+	ap->ioaddr.command_addr	= base + io_offset + 7 * reg_scale;
+
+	ap->ioaddr.altstatus_addr	= ctl_base + io_offset;
+	ap->ioaddr.ctl_addr		= ctl_base + io_offset;
 
 	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (irq_res && irq_res->start > 0) {
-- 
2.17.1

