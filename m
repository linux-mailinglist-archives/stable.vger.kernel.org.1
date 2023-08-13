Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A66077ABFC
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjHMV16 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjHMV16 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:27:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F97610DD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:28:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2B1562A23
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134D3C433C8;
        Sun, 13 Aug 2023 21:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962079;
        bh=0Lu6qzZ+BC+PCrDLqjYzvJejE4YoydfJKVIVVV377pI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=marC7v6Y6QJKsWJuJ9eMlFQ+kM/Fe6soSQr/cXxUSJjTKGZsMedyya7miCTIS4R2Y
         4FS7dFC9RmMkCxUifCiGSN8MViLymSre5+CQctO0K8OqftcyTUV7KzHFkAQQgocmRK
         WPmee5t/fR3MDg4iltOaDwcYXuSHifOYXZboGg+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Miquel Raynal <miquel.raynal@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.4 106/206] dmaengine: xilinx: xdma: Fix typo
Date:   Sun, 13 Aug 2023 23:17:56 +0200
Message-ID: <20230813211728.088966221@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit 422dbc66b7702ae797326d5480c3c9b6467053da upstream.

Probably a copy/paste error with the previous block, here we are
actually managing C2H IRQs.

Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20230731101442.792514-3-miquel.raynal@bootlin.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/xilinx/xdma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -717,7 +717,7 @@ static int xdma_irq_init(struct xdma_dev
 		ret = request_irq(irq, xdma_channel_isr, 0,
 				  "xdma-c2h-channel", &xdev->c2h_chans[j]);
 		if (ret) {
-			xdma_err(xdev, "H2C channel%d request irq%d failed: %d",
+			xdma_err(xdev, "C2H channel%d request irq%d failed: %d",
 				 j, irq, ret);
 			goto failed_init_c2h;
 		}


