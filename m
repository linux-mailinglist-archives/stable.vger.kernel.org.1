Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC33B7A7AAC
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbjITLo7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbjITLo6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:44:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F30EF0
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:44:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EA6C433C7;
        Wed, 20 Sep 2023 11:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210290;
        bh=LmrYutY7fbdfmSy5hGpZfYmPKAYUdg5rW0P7QuJh5Ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXfFgOpiOkn3+QZ9IARv9whPXwGxc+lrd/NSQKRMBxlx9sqnE9InHTvHlmJ+tk8Ea
         bx+tjDijnKoWRyHlVqQaJHepnPAXkkMDUG58gL7iGifZxL/r7fdtfS9wqc8xlae3dG
         Yz99OUGzbZjiRXjM3bLZ66uIcXSmeNU7Bbxf5KqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maksim Kiselev <bigunclemax@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 022/211] spi: sun6i: add quirk for dual and quad SPI modes support
Date:   Wed, 20 Sep 2023 13:27:46 +0200
Message-ID: <20230920112846.490787190@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maksim Kiselev <bigunclemax@gmail.com>

[ Upstream commit 0605d9fb411f3337482976842a3901d6c125d298 ]

New Allwinner's SPI controllers can support dual and quad SPI modes.
To enable one of these modes, we should set the corresponding bit in
the SUN6I_BURST_CTL_CNT_REG register. DRM (28 bits) for dual mode and
Quad_EN (29 bits) for quad transmission.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
Link: https://lore.kernel.org/r/20230624131632.2972546-2-bigunclemax@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sun6i.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 30d541612253e..cec2747235abf 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -83,6 +83,9 @@
 #define SUN6I_XMIT_CNT_REG		0x34
 
 #define SUN6I_BURST_CTL_CNT_REG		0x38
+#define SUN6I_BURST_CTL_CNT_STC_MASK		GENMASK(23, 0)
+#define SUN6I_BURST_CTL_CNT_DRM			BIT(28)
+#define SUN6I_BURST_CTL_CNT_QUAD_EN		BIT(29)
 
 #define SUN6I_TXDATA_REG		0x200
 #define SUN6I_RXDATA_REG		0x300
@@ -90,6 +93,7 @@
 struct sun6i_spi_cfg {
 	unsigned long		fifo_depth;
 	bool			has_clk_ctl;
+	u32			mode_bits;
 };
 
 struct sun6i_spi {
@@ -266,7 +270,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	unsigned int div, div_cdr1, div_cdr2, timeout;
 	unsigned int start, end, tx_time;
 	unsigned int trig_level;
-	unsigned int tx_len = 0, rx_len = 0;
+	unsigned int tx_len = 0, rx_len = 0, nbits = 0;
 	bool use_dma;
 	int ret = 0;
 	u32 reg;
@@ -418,13 +422,29 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sun6i_spi_write(sspi, SUN6I_GBL_CTL_REG, reg);
 
 	/* Setup the transfer now... */
-	if (sspi->tx_buf)
+	if (sspi->tx_buf) {
 		tx_len = tfr->len;
+		nbits = tfr->tx_nbits;
+	} else if (tfr->rx_buf) {
+		nbits = tfr->rx_nbits;
+	}
+
+	switch (nbits) {
+	case SPI_NBITS_DUAL:
+		reg = SUN6I_BURST_CTL_CNT_DRM;
+		break;
+	case SPI_NBITS_QUAD:
+		reg = SUN6I_BURST_CTL_CNT_QUAD_EN;
+		break;
+	case SPI_NBITS_SINGLE:
+	default:
+		reg = FIELD_PREP(SUN6I_BURST_CTL_CNT_STC_MASK, tx_len);
+	}
 
 	/* Setup the counters */
+	sun6i_spi_write(sspi, SUN6I_BURST_CTL_CNT_REG, reg);
 	sun6i_spi_write(sspi, SUN6I_BURST_CNT_REG, tfr->len);
 	sun6i_spi_write(sspi, SUN6I_XMIT_CNT_REG, tx_len);
-	sun6i_spi_write(sspi, SUN6I_BURST_CTL_CNT_REG, tx_len);
 
 	if (!use_dma) {
 		/* Fill the TX FIFO */
@@ -623,7 +643,8 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	master->set_cs = sun6i_spi_set_cs;
 	master->transfer_one = sun6i_spi_transfer_one;
 	master->num_chipselect = 4;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
+			    sspi->cfg->mode_bits;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->dev.of_node = pdev->dev.of_node;
 	master->auto_runtime_pm = true;
-- 
2.40.1



