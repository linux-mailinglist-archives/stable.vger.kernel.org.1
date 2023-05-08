Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0D36FA56A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjEHKJO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbjEHKJM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:09:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464E23292B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:09:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDC526239B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB313C433D2;
        Mon,  8 May 2023 10:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540550;
        bh=fdXHo95mCwwARUnG7mX1iJ1J6jnHDQ7V4JIZS4SAT0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbuqpttdgdQcT2JEbu/s7O9E4jE5HNa9ygjDZ6ArmRJl2sZzffMoCibgC97Z8Do1K
         CeXly1GApcfCv5drsr7pAPFyRJqq//kB7VkPTaR3izPi6WYSN+6kdoFXSh1FlG4Ebg
         2w6Or5AqoTTkEXhagHRwde4Ivzk16l9tCvTfxY5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 407/611] serial: 8250_bcm7271: Fix arbitration handling
Date:   Mon,  8 May 2023 11:44:09 +0200
Message-Id: <20230508094435.487050021@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit 15ac1122fd6d4bf408a03e6f23c7ad4f60b22f9e ]

The arbitration of the UART DMA is mishandled for a few
exceptional cases when probing and releasing the driver.

It is possible that the DMA register spaces are not defined in
device tree for an instance of the driver, so attempts to access
the registers in brcmuart_arbitration() would use NULL pointers.

It is also possible for the probe function to return an error
while still holding the UART DMA. This would prevent the UART
DMA from being claimed by an instance that could use it.

These errors are addressed by only releasing the UART DMA if it
is held by this instance (i.e. priv->dma_enabled == 1) and
directing early error paths in probe to this common release_dma
handling.

Fixes: 41a469482de2 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Link: https://lore.kernel.org/r/20230309190224.687380-1-opendmb@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 89bfcefbea848..36e31b96ef4a5 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1016,14 +1016,16 @@ static int brcmuart_probe(struct platform_device *pdev)
 	/* See if a Baud clock has been specified */
 	baud_mux_clk = of_clk_get_by_name(np, "sw_baud");
 	if (IS_ERR(baud_mux_clk)) {
-		if (PTR_ERR(baud_mux_clk) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(baud_mux_clk) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto release_dma;
+		}
 		dev_dbg(dev, "BAUD MUX clock not specified\n");
 	} else {
 		dev_dbg(dev, "BAUD MUX clock found\n");
 		ret = clk_prepare_enable(baud_mux_clk);
 		if (ret)
-			return ret;
+			goto release_dma;
 		priv->baud_mux_clk = baud_mux_clk;
 		init_real_clk_rates(dev, priv);
 		clk_rate = priv->default_mux_rate;
@@ -1031,7 +1033,8 @@ static int brcmuart_probe(struct platform_device *pdev)
 
 	if (clk_rate == 0) {
 		dev_err(dev, "clock-frequency or clk not defined\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto release_dma;
 	}
 
 	dev_dbg(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");
@@ -1118,7 +1121,9 @@ static int brcmuart_probe(struct platform_device *pdev)
 	serial8250_unregister_port(priv->line);
 err:
 	brcmuart_free_bufs(dev, priv);
-	brcmuart_arbitration(priv, 0);
+release_dma:
+	if (priv->dma_enabled)
+		brcmuart_arbitration(priv, 0);
 	return ret;
 }
 
@@ -1130,7 +1135,8 @@ static int brcmuart_remove(struct platform_device *pdev)
 	hrtimer_cancel(&priv->hrt);
 	serial8250_unregister_port(priv->line);
 	brcmuart_free_bufs(&pdev->dev, priv);
-	brcmuart_arbitration(priv, 0);
+	if (priv->dma_enabled)
+		brcmuart_arbitration(priv, 0);
 	return 0;
 }
 
-- 
2.39.2



