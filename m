Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7BA7556A3
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjGPUwb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjGPUwa (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:52:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712BEE9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:52:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FD7660EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A07C433C8;
        Sun, 16 Jul 2023 20:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540748;
        bh=wIhVIxw9S833HrnfEukz1tQG3b6q0/sNhMaUJ5ePRFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mG5qcI19bmzmS0ta+WY/g/8xu2JRXZRP8c4a9fuj7HpfJ/xAFyeFT4nrhrIax74vZ
         gt3nbAQ5f+VuA72RsJDTwRvYe3c2PHgdBgHWu/8OBkf9RDDk32/gcmQgaKozi5JtgF
         U06smUM9AUae0sv0KJAQfBvlTSsqIHwRLBtstZpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 474/591] spi: spi-geni-qcom: enable SPI_CONTROLLER_MUST_TX for GPI DMA mode
Date:   Sun, 16 Jul 2023 21:50:13 +0200
Message-ID: <20230716194936.169022249@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit d10005837be83906bbd2078c3b4f9dfcbd6c95b6 ]

The GPI DMA mode requires for TX DMA to be prepared. Force SPI core to
provide TX buffer even if the caller didn't provide one by setting the
SPI_CONTROLLER_MUST_TX flag.

Fixes: b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230629095847.3648597-1-dmitry.baryshkov@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 689b94fc5570a..7b76dcd11e2bb 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -979,6 +979,12 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (mas->cur_xfer_mode == GENI_SE_FIFO)
 		spi->set_cs = spi_geni_set_cs;
 
+	/*
+	 * TX is required per GSI spec, see setup_gsi_xfer().
+	 */
+	if (mas->cur_xfer_mode == GENI_GPI_DMA)
+		spi->flags = SPI_CONTROLLER_MUST_TX;
+
 	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
 	if (ret)
 		goto spi_geni_release_dma;
-- 
2.39.2



