Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24FF6FABDD
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjEHLST (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjEHLSS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:18:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F39E37847
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:18:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B87C761BD5
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3314C433D2;
        Mon,  8 May 2023 11:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544696;
        bh=2Qu7lRMkpiCSdzL9Wn0xhzrbliIZ6NffpuHSJYKR8Vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ufBaAOYFpVzI+czvaDLr4CBlig1gpKgpjGQPHFmJdc0tk8akWRljLFn3byoCeLfgR
         HQu1s2riCUGnF5gHNW1mtt+tKrq3VXmFJMEhntR7/lSeanVMquOnbDIUkUfVFZyzab
         YacUH/6hIeR0rvLwHIr3uDQj9n7J8IcXy5v9JK1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 495/694] serial: 8250_bcm7271: Fix arbitration handling
Date:   Mon,  8 May 2023 11:45:30 +0200
Message-Id: <20230508094450.076316965@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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
index ed5a947476920..f801b1f5b46c0 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1014,14 +1014,16 @@ static int brcmuart_probe(struct platform_device *pdev)
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
@@ -1029,7 +1031,8 @@ static int brcmuart_probe(struct platform_device *pdev)
 
 	if (clk_rate == 0) {
 		dev_err(dev, "clock-frequency or clk not defined\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto release_dma;
 	}
 
 	dev_dbg(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");
@@ -1116,7 +1119,9 @@ static int brcmuart_probe(struct platform_device *pdev)
 	serial8250_unregister_port(priv->line);
 err:
 	brcmuart_free_bufs(dev, priv);
-	brcmuart_arbitration(priv, 0);
+release_dma:
+	if (priv->dma_enabled)
+		brcmuart_arbitration(priv, 0);
 	return ret;
 }
 
@@ -1128,7 +1133,8 @@ static int brcmuart_remove(struct platform_device *pdev)
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



