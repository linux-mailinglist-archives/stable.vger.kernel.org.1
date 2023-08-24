Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B1478727A
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241856AbjHXOyI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241933AbjHXOx6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:53:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CF21BE9
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:53:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7762F66ECA
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88708C433C8;
        Thu, 24 Aug 2023 14:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888829;
        bh=ItA0T4AmZ9Hcg321ILjZdBhshLGhV2FrSz5xCHWQdi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C8NiIxfrupnKB/YW8J+rObSaie36YPGzIF5+JKrAfS6HqD6NjAAuxlxvHnAs5hsFU
         xzaFs2LAVcUMpCoJhA1kzuv7j/oi+42s2Jr1Vr+hdGxSMJLUbKPJ6a00M8upMuwbp0
         KnKKNcE+QLpPOBfviIxiZfYZc1+9v3GUCRkwC1tg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sherry Sun <sherry.sun@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 057/139] tty: serial: fsl_lpuart: make rx_watermark configurable for different platforms
Date:   Thu, 24 Aug 2023 16:49:40 +0200
Message-ID: <20230824145026.110834983@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sherry Sun <sherry.sun@nxp.com>

[ Upstream commit 34ebb26f12a84b744f43c5c4869516f122a2dfaa ]

Add rx_watermark parameter for struct lpuart_port to make the receive
watermark configurable for different platforms.
No function changed.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Link: https://lore.kernel.org/r/20230130064449.9564-2-sherry.sun@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: a82c3df955f8 ("tty: serial: fsl_lpuart: reduce RX watermark to 0 on LS1028A")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/fsl_lpuart.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index bf709ea93ec97..380d9237989b2 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -257,6 +257,7 @@ struct lpuart_port {
 	unsigned int		txfifo_size;
 	unsigned int		rxfifo_size;
 
+	u8			rx_watermark;
 	bool			lpuart_dma_tx_use;
 	bool			lpuart_dma_rx_use;
 	struct dma_chan		*dma_tx_chan;
@@ -281,38 +282,45 @@ struct lpuart_soc_data {
 	enum lpuart_type devtype;
 	char iotype;
 	u8 reg_off;
+	u8 rx_watermark;
 };
 
 static const struct lpuart_soc_data vf_data = {
 	.devtype = VF610_LPUART,
 	.iotype = UPIO_MEM,
+	.rx_watermark = 1,
 };
 
 static const struct lpuart_soc_data ls1021a_data = {
 	.devtype = LS1021A_LPUART,
 	.iotype = UPIO_MEM32BE,
+	.rx_watermark = 1,
 };
 
 static const struct lpuart_soc_data ls1028a_data = {
 	.devtype = LS1028A_LPUART,
 	.iotype = UPIO_MEM32,
+	.rx_watermark = 1,
 };
 
 static struct lpuart_soc_data imx7ulp_data = {
 	.devtype = IMX7ULP_LPUART,
 	.iotype = UPIO_MEM32,
 	.reg_off = IMX_REG_OFF,
+	.rx_watermark = 1,
 };
 
 static struct lpuart_soc_data imx8qxp_data = {
 	.devtype = IMX8QXP_LPUART,
 	.iotype = UPIO_MEM32,
 	.reg_off = IMX_REG_OFF,
+	.rx_watermark = 1,
 };
 static struct lpuart_soc_data imxrt1050_data = {
 	.devtype = IMXRT1050_LPUART,
 	.iotype = UPIO_MEM32,
 	.reg_off = IMX_REG_OFF,
+	.rx_watermark = 1,
 };
 
 static const struct of_device_id lpuart_dt_ids[] = {
@@ -1556,7 +1564,7 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
 	}
 
 	writeb(0, sport->port.membase + UARTTWFIFO);
-	writeb(1, sport->port.membase + UARTRWFIFO);
+	writeb(sport->rx_watermark, sport->port.membase + UARTRWFIFO);
 
 	/* Restore cr2 */
 	writeb(cr2_saved, sport->port.membase + UARTCR2);
@@ -1591,7 +1599,8 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
 	lpuart32_write(&sport->port, val, UARTFIFO);
 
 	/* set the watermark */
-	val = (0x1 << UARTWATER_RXWATER_OFF) | (0x0 << UARTWATER_TXWATER_OFF);
+	val = (sport->rx_watermark << UARTWATER_RXWATER_OFF) |
+	      (0x0 << UARTWATER_TXWATER_OFF);
 	lpuart32_write(&sport->port, val, UARTWATER);
 
 	/* Restore cr2 */
@@ -2736,6 +2745,7 @@ static int lpuart_probe(struct platform_device *pdev)
 	sport->port.dev = &pdev->dev;
 	sport->port.type = PORT_LPUART;
 	sport->devtype = sdata->devtype;
+	sport->rx_watermark = sdata->rx_watermark;
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
 		return ret;
-- 
2.40.1



