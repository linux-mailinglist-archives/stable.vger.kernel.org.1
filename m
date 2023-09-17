Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C397A3B34
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240606AbjIQUO1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240647AbjIQUOK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:14:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9718BF1
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:14:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DADC433C8;
        Sun, 17 Sep 2023 20:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981644;
        bh=xfS1fajin8YFvcTHNkJ7WYSUR96wHn9RFpzySxRIVE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y7ymCdAzqUD7hy31wnd/yQ09cR2nkan0jiXK0rbhjHKMvAkEIjS2oVdA9XR+dy/oD
         XMD549djeFPYE012dl57E5xp3O6zkIdnGSe6jtoyfNfHTPgn7LwqImusxkVCx+FG99
         5wx5JFPWHe4wcCwtAbWqVIFHvD83NZFrOYfA1pvA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        William R Sowerbutts <will@sowerbutts.com>,
        Finn Thain <fthain@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 6.1 151/219] ata: pata_falcon: fix IO base selection for Q40
Date:   Sun, 17 Sep 2023 21:14:38 +0200
Message-ID: <20230917191046.474722539@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Schmitz <schmitzmic@gmail.com>

commit 8a1f00b753ecfdb117dc1a07e68c46d80e7923ea upstream.

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
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/pata_falcon.c |   50 ++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

--- a/drivers/ata/pata_falcon.c
+++ b/drivers/ata/pata_falcon.c
@@ -123,8 +123,8 @@ static int __init pata_falcon_init_one(s
 	struct resource *base_res, *ctl_res, *irq_res;
 	struct ata_host *host;
 	struct ata_port *ap;
-	void __iomem *base;
-	int irq = 0;
+	void __iomem *base, *ctl_base;
+	int irq = 0, io_offset = 1, reg_shift = 2; /* Falcon defaults */
 
 	dev_info(&pdev->dev, "Atari Falcon and Q40/Q60 PATA controller\n");
 
@@ -165,26 +165,34 @@ static int __init pata_falcon_init_one(s
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


