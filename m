Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A882C735212
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjFSKaL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjFSKaK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:30:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE01B3
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:30:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACE1C60B5E
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17DBC433C8;
        Mon, 19 Jun 2023 10:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170608;
        bh=r7jCTs05P1TocNEkA/9VDItcaXinkn85dCGSKyL0hD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g56QHqfl4OH6Y/PiW7IVttdyDccTyTxBh2Lh2BhSN+LSbOFURlXjmIXNqoRPtzuRz
         Gj8I9NYyv4ctM25FeFGR3rdiHkfSWoRCk7Srt7mWJzzfgiQh8EJFVf1Z+6ZNFXNUG/
         0lfdoK6nor8/IQ07+7VpEXTLFIyLuHH15nexonPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 07/32] MIPS: Alchemy: fix dbdma2
Date:   Mon, 19 Jun 2023 12:28:55 +0200
Message-ID: <20230619102127.882423018@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102127.461443957@linuxfoundation.org>
References: <20230619102127.461443957@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Manuel Lauss <manuel.lauss@gmail.com>

[ Upstream commit 2d645604f69f3a772d58ead702f9a8e84ab2b342 ]

Various fixes for the Au1200/Au1550/Au1300 DBDMA2 code:

- skip cache invalidation if chip has working coherency circuitry.
- invalidate KSEG0-portion of the (physical) data address.
- force the dma channel doorbell write out to bus immediately with
  a sync.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/alchemy/common/dbdma.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index fc482d900dddb..122f8c0d258ef 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -30,6 +30,7 @@
  *
  */
 
+#include <linux/dma-map-ops.h> /* for dma_default_coherent */
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -623,17 +624,18 @@ u32 au1xxx_dbdma_put_source(u32 chanid, dma_addr_t buf, int nbytes, u32 flags)
 		dp->dscr_cmd0 &= ~DSCR_CMD0_IE;
 
 	/*
-	 * There is an errata on the Au1200/Au1550 parts that could result
-	 * in "stale" data being DMA'ed. It has to do with the snoop logic on
-	 * the cache eviction buffer.  DMA_NONCOHERENT is on by default for
-	 * these parts. If it is fixed in the future, these dma_cache_inv will
-	 * just be nothing more than empty macros. See io.h.
+	 * There is an erratum on certain Au1200/Au1550 revisions that could
+	 * result in "stale" data being DMA'ed. It has to do with the snoop
+	 * logic on the cache eviction buffer.  dma_default_coherent is set
+	 * to false on these parts.
 	 */
-	dma_cache_wback_inv((unsigned long)buf, nbytes);
+	if (!dma_default_coherent)
+		dma_cache_wback_inv(KSEG0ADDR(buf), nbytes);
 	dp->dscr_cmd0 |= DSCR_CMD0_V;	/* Let it rip */
 	wmb(); /* drain writebuffer */
 	dma_cache_wback_inv((unsigned long)dp, sizeof(*dp));
 	ctp->chan_ptr->ddma_dbell = 0;
+	wmb(); /* force doorbell write out to dma engine */
 
 	/* Get next descriptor pointer. */
 	ctp->put_ptr = phys_to_virt(DSCR_GET_NXTPTR(dp->dscr_nxtptr));
@@ -685,17 +687,18 @@ u32 au1xxx_dbdma_put_dest(u32 chanid, dma_addr_t buf, int nbytes, u32 flags)
 			  dp->dscr_source1, dp->dscr_dest0, dp->dscr_dest1);
 #endif
 	/*
-	 * There is an errata on the Au1200/Au1550 parts that could result in
-	 * "stale" data being DMA'ed. It has to do with the snoop logic on the
-	 * cache eviction buffer.  DMA_NONCOHERENT is on by default for these
-	 * parts. If it is fixed in the future, these dma_cache_inv will just
-	 * be nothing more than empty macros. See io.h.
+	 * There is an erratum on certain Au1200/Au1550 revisions that could
+	 * result in "stale" data being DMA'ed. It has to do with the snoop
+	 * logic on the cache eviction buffer.  dma_default_coherent is set
+	 * to false on these parts.
 	 */
-	dma_cache_inv((unsigned long)buf, nbytes);
+	if (!dma_default_coherent)
+		dma_cache_inv(KSEG0ADDR(buf), nbytes);
 	dp->dscr_cmd0 |= DSCR_CMD0_V;	/* Let it rip */
 	wmb(); /* drain writebuffer */
 	dma_cache_wback_inv((unsigned long)dp, sizeof(*dp));
 	ctp->chan_ptr->ddma_dbell = 0;
+	wmb(); /* force doorbell write out to dma engine */
 
 	/* Get next descriptor pointer. */
 	ctp->put_ptr = phys_to_virt(DSCR_GET_NXTPTR(dp->dscr_nxtptr));
-- 
2.39.2



