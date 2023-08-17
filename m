Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709D07800E8
	for <lists+stable@lfdr.de>; Fri, 18 Aug 2023 00:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbjHQWNc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 18:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355692AbjHQWNG (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 18:13:06 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747FC35B5;
        Thu, 17 Aug 2023 15:12:41 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5656a5c6721so265043a12.1;
        Thu, 17 Aug 2023 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692310361; x=1692915161;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=350+Yr4pUsoYLbgryjPyHNFc7BOKfJLnct3uHCEqK6Q=;
        b=Os8cW5mjxuPiKUCLQQeMklRvmgF4ZSChK1relXTWQEEi50TQVPqw8W2Mlq8IaQE8Bu
         Gs9zIBjC/mCuSCTrLzbEhYhY3G45Dgrxk1J3Krk+rP2E6RYHvYf6YhbrglCKaBElXKKS
         7DnrVcEIqwXHMaOaAmlbFPoKlYK7OfAAXrgql8aLiwah43KCWL3uleWbrBvNdkPbtB2f
         HsRutGyHE+zX4sXMQ+tbrslAiPKXgg6PM4NxCN1Sbx5LhUd379BNWgesxHqWuJWUIG/Y
         5OHuAT8wCeURdGNhw6Hn3p4L5/kN9N0eYI68U3aXCoFGJAxHcx+Broq9OOa6XzRjDWeF
         IpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692310361; x=1692915161;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=350+Yr4pUsoYLbgryjPyHNFc7BOKfJLnct3uHCEqK6Q=;
        b=lJEjb3+ygm730Ol2I1WVOne9TxSXF4RqlMu/ibCuJgL+mjy7zwCro+/e8v6ZlAgS4k
         8E+f2VPdXh6xcqmoFcS6+iZLs1Z5SAI2NoHdTvv2vpTlRsi2ymjwck3mTNihhF0lPg5w
         agDPL/aA4+JDlcqGDilQQlbKYHj9DVoRP1vBOknHnHAAPmql7ke9zOFT7yZT7gqiuUVH
         V4dBbqTcmDl/l62hFOk4jSDh156ZaoZgTN3UHleTxqBCKTTVmxcxHcr/ByN+sr1Y3iGO
         nmC8N1BHJu4hgBCT2+Tb5q2RS2YetqprUOzieppZG2x0Ctfs/1KoINo9pKDajsyKBCvg
         Wo6g==
X-Gm-Message-State: AOJu0YwcB49aVibPWrXR0jaubiQPCaYS9f9zvJ+uHNsCjVYqq/S8h9hs
        9Gt+I1fVYWHLUEQv2ETvaVU=
X-Google-Smtp-Source: AGHT+IHRlafKM6qKSEbveuFEqNK5vhvbbHqQ/uPa3EAtoF/6KD+5Uocj0tiz/ONJX0bBTC8GjfGs5Q==
X-Received: by 2002:a05:6a20:4420:b0:131:f504:a631 with SMTP id ce32-20020a056a20442000b00131f504a631mr1334482pzb.51.1692310360909;
        Thu, 17 Aug 2023 15:12:40 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-62-141-252-fibre.sparkbb.co.nz. [122.62.141.252])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78705000000b0068746ab9aebsm253230pfo.14.2023.08.17.15.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 15:12:40 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id B56DB360370; Fri, 18 Aug 2023 10:12:36 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     s.shtylyov@omp.ru, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>, stable@vger.kernel.org,
        Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 1/3] m68k/q40: fix IO base selection for Q40 in pata_falcon.c
Date:   Fri, 18 Aug 2023 10:12:30 +1200
Message-Id: <20230817221232.22035-2-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230817221232.22035-1-schmitzmic@gmail.com>
References: <20230817221232.22035-1-schmitzmic@gmail.com>
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
Cc: <stable@vger.kernel.org> # 5.14
Cc: Finn Thain <fthain@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

---

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

