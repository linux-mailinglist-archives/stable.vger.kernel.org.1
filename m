Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1455775A2A
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjHILFy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjHILFx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:05:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C675F10F3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:05:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6551063142
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77179C433C8;
        Wed,  9 Aug 2023 11:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579151;
        bh=0CafBrQiEEReLNP/c8SyftyzBtjMt5sk4PgL7lbirJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ozsGniPwhl28VC+N43LUCm4RyN7RJ8xL4SLlxvlNr8TbJtj/RrsmfKLKvlgadUrR+
         RSTXN42/1sZdhznaMxAEq4Yt1CZp7FzZezNPtMBBPZrQvsv0I1u5ZTsDPBdAJZE0Jm
         VTWildaUmqIIDGLFSG168/iaU37xuJxjLMHH+sEU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Artur Rojek <contact@artur-rojek.eu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 076/204] sh: dma: Fix DMA channel offset calculation
Date:   Wed,  9 Aug 2023 12:40:14 +0200
Message-ID: <20230809103645.198861451@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index afde2a7d3eb35..e0679d8a9b34b 100644
--- a/arch/sh/drivers/dma/dma-sh.c
+++ b/arch/sh/drivers/dma/dma-sh.c
@@ -21,6 +21,18 @@
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
@@ -32,7 +44,7 @@ static unsigned long dma_find_base(unsigned int chan)
 	unsigned long base = SH_DMAC_BASE0;
 
 #ifdef SH_DMAC_BASE1
-	if (chan >= 6)
+	if (chan >= SH_DMAC_NR_MD_CH)
 		base = SH_DMAC_BASE1;
 #endif
 
@@ -43,13 +55,13 @@ static unsigned long dma_base_addr(unsigned int chan)
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
@@ -253,12 +265,11 @@ static int sh_dmac_get_dma_residue(struct dma_channel *chan)
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



