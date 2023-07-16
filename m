Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C6F7551DF
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjGPUBK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjGPUBJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:01:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7A0EE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:01:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF68B60EBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2D8C433C8;
        Sun, 16 Jul 2023 20:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537664;
        bh=nFEGZ5+2DFaaUlC1wPd3QXgv9jAuD//KLcWqW9MwZZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BqqnGe5OIr8+WB6kDWjyAhnX2tH+wfkZ0ZK19XXb5tsVhJX0cqnb+Phf1GeKWpQOH
         r9zY+iPk+lqk3+QV3QLpXgjgIuzK+VCZd/5CKNPAFOokFkRdFumvvd2zEYu/JQA6/k
         nDLspiKVumwu5DOohXhV1HWIS1dLYuQp1CkN9GcI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 149/800] soc: qcom: geni-se: Add interfaces geni_se_tx_init_dma() and geni_se_rx_init_dma()
Date:   Sun, 16 Jul 2023 21:40:02 +0200
Message-ID: <20230716194952.555732298@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>

[ Upstream commit 6d6e57594957ee9131bc3802dfc8657ca6f78fee ]

The geni_se_xx_dma_prep() interfaces necessarily do DMA mapping before
initiating DMA transfers. This is not suitable for spi where framework
is expected to handle map/unmap.

Expose new interfaces geni_se_xx_init_dma() which do only DMA transfer.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/1684325894-30252-2-git-send-email-quic_vnivarth@quicinc.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 3a76c7ca9e77 ("spi: spi-geni-qcom: Do not do DMA map/unmap inside driver, use framework instead")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/qcom-geni-se.c  | 67 +++++++++++++++++++++++---------
 include/linux/soc/qcom/geni-se.h |  4 ++
 2 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 795a2e1d59b3a..dd50a255fa6cb 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -682,6 +682,30 @@ EXPORT_SYMBOL(geni_se_clk_freq_match);
 #define GENI_SE_DMA_EOT_EN BIT(1)
 #define GENI_SE_DMA_AHB_ERR_EN BIT(2)
 #define GENI_SE_DMA_EOT_BUF BIT(0)
+
+/**
+ * geni_se_tx_init_dma() - Initiate TX DMA transfer on the serial engine
+ * @se:			Pointer to the concerned serial engine.
+ * @iova:		Mapped DMA address.
+ * @len:		Length of the TX buffer.
+ *
+ * This function is used to initiate DMA TX transfer.
+ */
+void geni_se_tx_init_dma(struct geni_se *se, dma_addr_t iova, size_t len)
+{
+	u32 val;
+
+	val = GENI_SE_DMA_DONE_EN;
+	val |= GENI_SE_DMA_EOT_EN;
+	val |= GENI_SE_DMA_AHB_ERR_EN;
+	writel_relaxed(val, se->base + SE_DMA_TX_IRQ_EN_SET);
+	writel_relaxed(lower_32_bits(iova), se->base + SE_DMA_TX_PTR_L);
+	writel_relaxed(upper_32_bits(iova), se->base + SE_DMA_TX_PTR_H);
+	writel_relaxed(GENI_SE_DMA_EOT_BUF, se->base + SE_DMA_TX_ATTR);
+	writel(len, se->base + SE_DMA_TX_LEN);
+}
+EXPORT_SYMBOL(geni_se_tx_init_dma);
+
 /**
  * geni_se_tx_dma_prep() - Prepare the serial engine for TX DMA transfer
  * @se:			Pointer to the concerned serial engine.
@@ -697,7 +721,6 @@ int geni_se_tx_dma_prep(struct geni_se *se, void *buf, size_t len,
 			dma_addr_t *iova)
 {
 	struct geni_wrapper *wrapper = se->wrapper;
-	u32 val;
 
 	if (!wrapper)
 		return -EINVAL;
@@ -706,17 +729,34 @@ int geni_se_tx_dma_prep(struct geni_se *se, void *buf, size_t len,
 	if (dma_mapping_error(wrapper->dev, *iova))
 		return -EIO;
 
+	geni_se_tx_init_dma(se, *iova, len);
+	return 0;
+}
+EXPORT_SYMBOL(geni_se_tx_dma_prep);
+
+/**
+ * geni_se_rx_init_dma() - Initiate RX DMA transfer on the serial engine
+ * @se:			Pointer to the concerned serial engine.
+ * @iova:		Mapped DMA address.
+ * @len:		Length of the RX buffer.
+ *
+ * This function is used to initiate DMA RX transfer.
+ */
+void geni_se_rx_init_dma(struct geni_se *se, dma_addr_t iova, size_t len)
+{
+	u32 val;
+
 	val = GENI_SE_DMA_DONE_EN;
 	val |= GENI_SE_DMA_EOT_EN;
 	val |= GENI_SE_DMA_AHB_ERR_EN;
-	writel_relaxed(val, se->base + SE_DMA_TX_IRQ_EN_SET);
-	writel_relaxed(lower_32_bits(*iova), se->base + SE_DMA_TX_PTR_L);
-	writel_relaxed(upper_32_bits(*iova), se->base + SE_DMA_TX_PTR_H);
-	writel_relaxed(GENI_SE_DMA_EOT_BUF, se->base + SE_DMA_TX_ATTR);
-	writel(len, se->base + SE_DMA_TX_LEN);
-	return 0;
+	writel_relaxed(val, se->base + SE_DMA_RX_IRQ_EN_SET);
+	writel_relaxed(lower_32_bits(iova), se->base + SE_DMA_RX_PTR_L);
+	writel_relaxed(upper_32_bits(iova), se->base + SE_DMA_RX_PTR_H);
+	/* RX does not have EOT buffer type bit. So just reset RX_ATTR */
+	writel_relaxed(0, se->base + SE_DMA_RX_ATTR);
+	writel(len, se->base + SE_DMA_RX_LEN);
 }
-EXPORT_SYMBOL(geni_se_tx_dma_prep);
+EXPORT_SYMBOL(geni_se_rx_init_dma);
 
 /**
  * geni_se_rx_dma_prep() - Prepare the serial engine for RX DMA transfer
@@ -733,7 +773,6 @@ int geni_se_rx_dma_prep(struct geni_se *se, void *buf, size_t len,
 			dma_addr_t *iova)
 {
 	struct geni_wrapper *wrapper = se->wrapper;
-	u32 val;
 
 	if (!wrapper)
 		return -EINVAL;
@@ -742,15 +781,7 @@ int geni_se_rx_dma_prep(struct geni_se *se, void *buf, size_t len,
 	if (dma_mapping_error(wrapper->dev, *iova))
 		return -EIO;
 
-	val = GENI_SE_DMA_DONE_EN;
-	val |= GENI_SE_DMA_EOT_EN;
-	val |= GENI_SE_DMA_AHB_ERR_EN;
-	writel_relaxed(val, se->base + SE_DMA_RX_IRQ_EN_SET);
-	writel_relaxed(lower_32_bits(*iova), se->base + SE_DMA_RX_PTR_L);
-	writel_relaxed(upper_32_bits(*iova), se->base + SE_DMA_RX_PTR_H);
-	/* RX does not have EOT buffer type bit. So just reset RX_ATTR */
-	writel_relaxed(0, se->base + SE_DMA_RX_ATTR);
-	writel(len, se->base + SE_DMA_RX_LEN);
+	geni_se_rx_init_dma(se, *iova, len);
 	return 0;
 }
 EXPORT_SYMBOL(geni_se_rx_dma_prep);
diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index c55a0bc8cb0e9..821a19135bb66 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -490,9 +490,13 @@ int geni_se_clk_freq_match(struct geni_se *se, unsigned long req_freq,
 			   unsigned int *index, unsigned long *res_freq,
 			   bool exact);
 
+void geni_se_tx_init_dma(struct geni_se *se, dma_addr_t iova, size_t len);
+
 int geni_se_tx_dma_prep(struct geni_se *se, void *buf, size_t len,
 			dma_addr_t *iova);
 
+void geni_se_rx_init_dma(struct geni_se *se, dma_addr_t iova, size_t len);
+
 int geni_se_rx_dma_prep(struct geni_se *se, void *buf, size_t len,
 			dma_addr_t *iova);
 
-- 
2.39.2



