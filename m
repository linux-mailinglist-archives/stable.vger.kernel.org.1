Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E1777ABFD
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjHMV2B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjHMV2B (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:28:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2996A10D7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:28:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B273B62A27
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D90C433C8;
        Sun, 13 Aug 2023 21:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962082;
        bh=ZEv/HAweZuiGnvwv6eZxaATYoGfoTROek+O5VAPXFVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RggbMd6OkRqX91HvpfssEAYikuN4y1WtgleeClc3BGAtSlaqrnACc2CO1D1C7C5oQ
         tY1EdWASfRl79hvAdNZbcm6PtJE6X9kfZWEF4soPn/RDFIbZXNou6BsYyWVS9Fu1s9
         mOZH7ujdFMs6aXw+JKN/oW3pGC1yIt5KmW7EqvbA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Minjie Du <duminjie@vivo.com>,
        Michal Simek <michal.simek@amd.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.4 107/206] dmaengine: xilinx: xdma: Fix Judgment of the return value
Date:   Sun, 13 Aug 2023 23:17:57 +0200
Message-ID: <20230813211728.115845481@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Minjie Du <duminjie@vivo.com>

commit a68b48afc050a9456ed4ed19d8755e0f925b44e6 upstream.

Fix: make IS_ERR() judge the devm_ioremap_resource() function return.

Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
Signed-off-by: Minjie Du <duminjie@vivo.com>
Acked-by: Michal Simek <michal.simek@amd.com>
Link: https://lore.kernel.org/r/20230705113912.16247-1-duminjie@vivo.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/xilinx/xdma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -894,7 +894,7 @@ static int xdma_probe(struct platform_de
 	}
 
 	reg_base = devm_ioremap_resource(&pdev->dev, res);
-	if (!reg_base) {
+	if (IS_ERR(reg_base)) {
 		xdma_err(xdev, "ioremap failed");
 		goto failed;
 	}


