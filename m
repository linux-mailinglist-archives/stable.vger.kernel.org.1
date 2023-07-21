Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3DF75D318
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjGUTHD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjGUTHC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:07:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B87930D7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:07:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4D3E61D76
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03335C433C8;
        Fri, 21 Jul 2023 19:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966420;
        bh=2s7RTo3VNv6TmVXLN6GEj8GSY4RWSlqZJQSydBtaFVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2TR+5vo/tIhVnzKLHKMVJi6ClX7jqFMd4XpFc+wUXQtgHT9P2Wry62kOv6Zuv1eMa
         HZxWfPbrZYZtf0QY7cWyH82oOsVEmWKux2wyZP+vGjpclaVWLWZnYyQG83LUyFHxpM
         3tWoFlIsJkUeRpKjr6mSJkOxDNMKsVdFLabZhvug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Artur Rojek <contact@artur-rojek.eu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 337/532] sh: dma: Fix DMA channel offset calculation
Date:   Fri, 21 Jul 2023 18:04:01 +0200
Message-ID: <20230721160632.704406335@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Artur Rojek <contact@artur-rojek.eu>

[ Upstream commit e82e47584847129a20b8c9f4a1dcde09374fb0e0 ]

Various SoCs of the SH3, SH4 and SH4A family, which use this driver,
feature a differing number of DMA channels, which can be distributed
between up to two DMAC modules. The existing implementation fails to
correctly accommodate for all those variations, resulting in wrong
channel offset calculations and leading to kernel panics.

Rewrite dma_base_addr() in order to properly calculate channel offsets
in a DMAC module. Fix dmaor_read_reg() and dmaor_write_reg(), so that
the correct DMAC module base is selected for the DMAOR register.

Fixes: 7f47c7189b3e8f19 ("sh: dma: More legacy cpu dma chainsawing.")
Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Link: https://lore.kernel.org/r/20230527164452.64797-2-contact@artur-rojek.eu
Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sh/drivers/dma/dma-sh.c | 37 +++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
index 96c626c2cd0a4..306fba1564e5e 100644
--- a/arch/sh/drivers/dma/dma-sh.c
+++ b/arch/sh/drivers/dma/dma-sh.c
@@ -18,6 +18,18 @@
 #include <cpu/dma-register.h>
 #include <cpu/dma.h>
 
+/*
+ * Some of the SoCs feature two DMAC modules. In such a case, the channels are
+ * distributed equally among them.
+ */
+#ifdef	SH_DMAC_BASE1
+#define	SH_DMAC_NR_MD_CH	(CONFIG_NR_ONCHIP_DMA_CHANNELS / 2)
+#else
+#define	SH_DMAC_NR_MD_CH	CONFIG_NR_ONCHIP_DMA_CHANNELS
+#endif
+
+#define	SH_DMAC_CH_SZ		0x10
+
 /*
  * Define the default configuration for dual address memory-memory transfer.
  * The 0x400 value represents auto-request, external->external.
@@ -29,7 +41,7 @@ static unsigned long dma_find_base(unsigned int chan)
 	unsigned long base = SH_DMAC_BASE0;
 
 #ifdef SH_DMAC_BASE1
-	if (chan >= 6)
+	if (chan >= SH_DMAC_NR_MD_CH)
 		base = SH_DMAC_BASE1;
 #endif
 
@@ -40,13 +52,13 @@ static unsigned long dma_base_addr(unsigned int chan)
 {
 	unsigned long base = dma_find_base(chan);
 
-	/* Normalize offset calculation */
-	if (chan >= 9)
-		chan -= 6;
-	if (chan >= 4)
-		base += 0x10;
+	chan = (chan % SH_DMAC_NR_MD_CH) * SH_DMAC_CH_SZ;
+
+	/* DMAOR is placed inside the channel register space. Step over it. */
+	if (chan >= DMAOR)
+		base += SH_DMAC_CH_SZ;
 
-	return base + (chan * 0x10);
+	return base + chan;
 }
 
 #ifdef CONFIG_SH_DMA_IRQ_MULTI
@@ -250,12 +262,11 @@ static int sh_dmac_get_dma_residue(struct dma_channel *chan)
 #define NR_DMAOR	1
 #endif
 
-/*
- * DMAOR bases are broken out amongst channel groups. DMAOR0 manages
- * channels 0 - 5, DMAOR1 6 - 11 (optional).
- */
-#define dmaor_read_reg(n)		__raw_readw(dma_find_base((n)*6))
-#define dmaor_write_reg(n, data)	__raw_writew(data, dma_find_base(n)*6)
+#define dmaor_read_reg(n)		__raw_readw(dma_find_base((n) * \
+						    SH_DMAC_NR_MD_CH) + DMAOR)
+#define dmaor_write_reg(n, data)	__raw_writew(data, \
+						     dma_find_base((n) * \
+						     SH_DMAC_NR_MD_CH) + DMAOR)
 
 static inline int dmaor_reset(int no)
 {
-- 
2.39.2



