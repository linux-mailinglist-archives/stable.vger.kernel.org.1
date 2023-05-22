Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BF270C795
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbjEVTbZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbjEVTbY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:31:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1689C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:31:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F121662919
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147B9C433EF;
        Mon, 22 May 2023 19:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783882;
        bh=VLEATu1x539o1+vwaElZ7izbKFwZ+xJDmw3HMOEdpdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y1Qjljfgbqry0e1JwguuntSU1oLLJRRh1qvZeBnJutVYF+H4FBEKysJGaXgfLw0Se
         pkBaeaU5bsPGtmNIFIAnJhZjBJH4oZ3wI+OXBychlhqpQkdLkzSCrodqgHKsz6WNO6
         oowQce1wMuK785/XhI2/DSETSu6WF8hjpONaIP8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, XuDong Liu <m202071377@hust.edu.cn>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 175/292] serial: 8250_bcm7271: balance clk_enable calls
Date:   Mon, 22 May 2023 20:08:52 +0100
Message-Id: <20230522190410.336623610@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

[ Upstream commit 8a3b5477256a54ae4a470dcebbcf8cdc18e4696d ]

The sw_baud clock must be disabled when the device driver is not
connected to the device. This now occurs when probe fails and
upon remove.

Fixes: 41a469482de2 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
Reported-by: XuDong Liu <m202071377@hust.edu.cn>
Link: https://lore.kernel.org/lkml/20230424125100.4783-1-m202071377@hust.edu.cn/
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Link: https://lore.kernel.org/r/20230427181916.2983697-2-opendmb@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 36e31b96ef4a5..1f0095cf57a7e 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1034,7 +1034,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 	if (clk_rate == 0) {
 		dev_err(dev, "clock-frequency or clk not defined\n");
 		ret = -EINVAL;
-		goto release_dma;
+		goto err_clk_disable;
 	}
 
 	dev_dbg(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");
@@ -1121,6 +1121,8 @@ static int brcmuart_probe(struct platform_device *pdev)
 	serial8250_unregister_port(priv->line);
 err:
 	brcmuart_free_bufs(dev, priv);
+err_clk_disable:
+	clk_disable_unprepare(baud_mux_clk);
 release_dma:
 	if (priv->dma_enabled)
 		brcmuart_arbitration(priv, 0);
@@ -1135,6 +1137,7 @@ static int brcmuart_remove(struct platform_device *pdev)
 	hrtimer_cancel(&priv->hrt);
 	serial8250_unregister_port(priv->line);
 	brcmuart_free_bufs(&pdev->dev, priv);
+	clk_disable_unprepare(priv->baud_mux_clk);
 	if (priv->dma_enabled)
 		brcmuart_arbitration(priv, 0);
 	return 0;
-- 
2.39.2



