Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC65789B54
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 06:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjH0EOO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 00:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjH0EN7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 00:13:59 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBA91AD;
        Sat, 26 Aug 2023 21:13:55 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5733789a44cso1482935eaf.2;
        Sat, 26 Aug 2023 21:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693109635; x=1693714435;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AIl1b0PkLEfFH4MOGYeCC8mCbNP8ENQSFlp2p49bKJI=;
        b=jqE/6cQ0xa/TO+YNkEKejmoU+mMYy91nOeqqWzXnwijbS/6CyAV09LX2kn2Zv1Zyfq
         VpK2cA03TLcXs84PtDTPGpZxQdzVonQiNcMU78cdmvCyM7j70HYwszKassSt32QNx3yy
         Djza6PNKkKNNXtbijWTXgn4LLojI5T+NTPah+4IQPzsdlqhHUjOlZZyiEVbNtQMHFkeT
         RkxbP4oahAxbIjY6SCidw6ohMnuUqipdo6rqFptOB6g6JWVH7h2tz+0MSWEK/Ct64/tD
         6c1/4wzbzB3jzM9Qt5B9nBTOjpo8GLv6ADapWGXsL/nFNbI8w2MvjDZUhydQik6W4N/9
         n+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693109635; x=1693714435;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIl1b0PkLEfFH4MOGYeCC8mCbNP8ENQSFlp2p49bKJI=;
        b=hRvJFDDXpNZtKl0p+c2yseUfTjYjsJx6w45NKeey95lqUDkmleQUymwq1TJC4NGr9Y
         xbC+LnTgSfWjDHyD1QQgnBXTAD5GJNK1ZQmf2vrI+5pgPGoMoa7P6oEeoGlNVHUUqguR
         hpz/bTnGPSAKDJXnL8KDh8EgHIaOsJalTv28YDTsVRrJ1it1aIaq9k/11mhTLsIYAHUr
         BBJNX0/U4ax2B5ZJJcaB55wuePMaihSEExC7EfBpfccDjqEhjT9un1Rj3fWxEpq/Hv5a
         UVZuAOKSkA2W27r6fp4erD/aRPerNuqWTIkGb5lguBNxicmezkq0hnNTRQi9fDFZfJbX
         5qcQ==
X-Gm-Message-State: AOJu0YxNdQsPJM2o9emBw2GfziRgHutXoVcb9lj4TObfkqZAkl4zqWPT
        NMYLwUjExkRBdrWV0vo8Vl8=
X-Google-Smtp-Source: AGHT+IHMR88Wjl6mrPo3yoEkdBuxSBcmzN2yqs+3fEhsYUsZ5aLcat3S+kgXRbtRQHaqUadHXuiDmw==
X-Received: by 2002:a05:6358:9217:b0:135:24ed:5108 with SMTP id d23-20020a056358921700b0013524ed5108mr24212851rwb.10.1693109634881;
        Sat, 26 Aug 2023 21:13:54 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id c6-20020a62e806000000b00682c1db7551sm4059758pfi.49.2023.08.26.21.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 21:13:54 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id E290636043C; Sun, 27 Aug 2023 16:13:50 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     s.shtylyov@omp.ru, dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>, stable@vger.kernel.org,
        Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v6 1/2] ata: pata_falcon: fix IO base selection for Q40
Date:   Sun, 27 Aug 2023 16:13:47 +1200
Message-Id: <20230827041348.18887-2-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230827041348.18887-1-schmitzmic@gmail.com>
References: <20230827041348.18887-1-schmitzmic@gmail.com>
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

