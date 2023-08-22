Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33B2784CBC
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 00:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjHVWOJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 18:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjHVWOI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 18:14:08 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEECACD0;
        Tue, 22 Aug 2023 15:14:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bee82fad0fso32537825ad.2;
        Tue, 22 Aug 2023 15:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692742446; x=1693347246;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AUC9eoO5UIo46oFX1a6+lAn1zuPwqHuYWfvH8tGdhi8=;
        b=GaLfBs1I36f+HHrYGOisKuHtm3CDyZhSwuB4VY680WmQL75KJop8NDDaCwGhnM8dKZ
         zDcswSMUWkTFQMqLbHldmKje+9dfUZr0GM4FFpBXzn7Wu+IFXKzM2bhkMSV8goswU5zB
         A1hjkrNNyfkz/E6WIbU5TCJtAxxx8VPyj1QTvYVKdtiM8cni7yDYoyVg5uvZ23sRaSXm
         +nz+D0j4rANiy5FbDpgOWxeknqlYXoerSgikUKicZ9j7lLTGvjKT+9+w+MLmjZugOqmN
         KqIbiWQss7cd+3qdjydIRFmtLLNlSnBQMXLNCh0iLhjAe2ZutY9NT4ar05j+rzoBAcgA
         t5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692742446; x=1693347246;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUC9eoO5UIo46oFX1a6+lAn1zuPwqHuYWfvH8tGdhi8=;
        b=IaenhR16OW+Ujs530vkTVJesEllrqBHbeTKTLS3e5Hy9w3x9pQeLMj9jZ5v6BpeokF
         ZCqwtEXYoD8ydHsnwu2OfodlVP0Eqd2CjMtThHb4TIibxMcZGhNoT6LtGPCrsKVOpvQ8
         HOYusLpen5IT5cBaz0fYHOG3TmD+TeNdhj//M5ofgxq+vQ55yAN4/hKb0uu9CVPG464M
         RV8hwVGgSeAFockMrv1TBUhGI/Uu8AiQyUTA6CBL5Cg0EE5CGwJsiZQCT7QeBWn+YxTe
         r8KHTAieUQvN4vluP9yK4h7ZUUhHSkNf4xeMfsHOLI8BqxSGWQIFhnrbK2Spzzq+Yden
         gLFg==
X-Gm-Message-State: AOJu0Yy6DTnpsg4CyvOJGMshz/ngn9aTNyIe9pQw3iV5L9I1WT9MlB3H
        xEj3oUt7fwOxGtte3Tmhk7Q=
X-Google-Smtp-Source: AGHT+IF6Cm7CnJgHT+j9s7B01elvFwccNEtEgEKoIPZT929hMukEg43eA6M8SwhaW9dk6E2OBJjV2A==
X-Received: by 2002:a17:902:6b48:b0:1bf:7d3b:4405 with SMTP id g8-20020a1709026b4800b001bf7d3b4405mr6065901plt.14.1692742446184;
        Tue, 22 Aug 2023 15:14:06 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902bc4700b001beef2c9bffsm9450990plz.85.2023.08.22.15.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 15:14:05 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 1F822360446; Wed, 23 Aug 2023 10:14:02 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     sergei.shtylyov@gmail.com, dlemoal@kernel.org,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>, stable@vger.kernel.org,
        Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v4 1/2] ata: pata_falcon: fix IO base selection for Q40
Date:   Wed, 23 Aug 2023 10:13:58 +1200
Message-Id: <20230822221359.31024-2-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230822221359.31024-1-schmitzmic@gmail.com>
References: <20230822221359.31024-1-schmitzmic@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

---

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
index 996516e64f13..3841ea200bcb 100644
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
+	ata_port_desc(ap, "cmd %px ctl %px data %pa",
+		      base, ctl_base, &ap->ioaddr.data_addr);
 
 	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (irq_res && irq_res->start > 0) {
-- 
2.17.1

