Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6B67B8A11
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244342AbjJDSb7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244353AbjJDSb6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:31:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAB1FF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:31:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FAAC433C7;
        Wed,  4 Oct 2023 18:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444312;
        bh=esN8fUUbC54lkQPgLbr4o42r6UR05R32m+4o9vJ98ZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtAU6bkEJjadYtDz1ayajWFZXnat9fNditfqhf6WFbDvH15sfq82dCwfYo30Q2JuL
         UN0klQxGKGAOkP9hWUwiHtrnqeBYtlapVm9TIMhm2Oe7r4CdRmKx/jzKILWMM3Pwr2
         H5KmbSmxQ+tcJ2j840BOYUB6S1V9C9sETcAFGLrM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Valentin Caron <valentin.caron@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 205/321] spi: stm32: add a delay before SPI disable
Date:   Wed,  4 Oct 2023 19:55:50 +0200
Message-ID: <20231004175238.747534651@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Valentin Caron <valentin.caron@foss.st.com>

[ Upstream commit 6de8a70c84ee0586fdde4e671626b9caca6aed74 ]

As explained in errata sheet, in section "2.14.5 Truncation of SPI output
signals after EOT event":
On STM32MP1x, EOT interrupt can be thrown before the true end of
communication.

So we add a delay of a half period to wait the real end of the
transmission.

Link: https://www.st.com/resource/en/errata_sheet/es0539-stm32mp131x3x5x-device-errata-stmicroelectronics.pdf
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
Link: https://lore.kernel.org/r/20230906132735.748174-1-valentin.caron@foss.st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-stm32.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 7ddf9db776b06..4737a36e5d4e9 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -275,6 +275,7 @@ struct stm32_spi_cfg {
  * @fifo_size: size of the embedded fifo in bytes
  * @cur_midi: master inter-data idleness in ns
  * @cur_speed: speed configured in Hz
+ * @cur_half_period: time of a half bit in us
  * @cur_bpw: number of bits in a single SPI data frame
  * @cur_fthlv: fifo threshold level (data frames in a single data packet)
  * @cur_comm: SPI communication mode
@@ -302,6 +303,7 @@ struct stm32_spi {
 
 	unsigned int cur_midi;
 	unsigned int cur_speed;
+	unsigned int cur_half_period;
 	unsigned int cur_bpw;
 	unsigned int cur_fthlv;
 	unsigned int cur_comm;
@@ -466,6 +468,8 @@ static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz,
 
 	spi->cur_speed = spi->clk_rate / (1 << mbrdiv);
 
+	spi->cur_half_period = DIV_ROUND_CLOSEST(USEC_PER_SEC, 2 * spi->cur_speed);
+
 	return mbrdiv - 1;
 }
 
@@ -707,6 +711,10 @@ static void stm32h7_spi_disable(struct stm32_spi *spi)
 		return;
 	}
 
+	/* Add a delay to make sure that transmission is ended. */
+	if (spi->cur_half_period)
+		udelay(spi->cur_half_period);
+
 	if (spi->cur_usedma && spi->dma_tx)
 		dmaengine_terminate_async(spi->dma_tx);
 	if (spi->cur_usedma && spi->dma_rx)
-- 
2.40.1



