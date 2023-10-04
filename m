Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033717B89D6
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244293AbjJDS34 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244294AbjJDS3z (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:29:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553DFBF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:29:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DDFC433C7;
        Wed,  4 Oct 2023 18:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444191;
        bh=qR4OsNt9A+rVmVibH4kxQCzdAvZEyxh6K3eOK3zjt3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A04EGlUX3FGd7/dlWBSgyxuNSi8GY0chS2GNkdqg6x8SGsD4rUkBm0rxkG87H+Vuw
         lv0E2GfuPwNflzy4PXQsUPoWreWKY7tfIJVaSyCriXKH7iXYDEYbUnwGBLHGxHFqmQ
         ylyf1iiKyyHLsBZ3CCRxmdmr/SIAaHiBSD38qj9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tobias Schramm <t.schramm@manjaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 163/321] spi: sun6i: reduce DMA RX transfer width to single byte
Date:   Wed,  4 Oct 2023 19:55:08 +0200
Message-ID: <20231004175236.813551525@linuxfoundation.org>
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

From: Tobias Schramm <t.schramm@manjaro.org>

[ Upstream commit 171f8a49f212e87a8b04087568e1b3d132e36a18 ]

Through empirical testing it has been determined that sometimes RX SPI
transfers with DMA enabled return corrupted data. This is down to single
or even multiple bytes lost during DMA transfer from SPI peripheral to
memory. It seems the RX FIFO within the SPI peripheral can become
confused when performing bus read accesses wider than a single byte to it
during an active SPI transfer.

This patch reduces the width of individual DMA read accesses to the
RX FIFO to a single byte to mitigate that issue.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
Link: https://lore.kernel.org/r/20230827152558.5368-2-t.schramm@manjaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sun6i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index cec2747235abf..bc9c88dce067a 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -211,7 +211,7 @@ static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
 		struct dma_slave_config rxconf = {
 			.direction = DMA_DEV_TO_MEM,
 			.src_addr = sspi->dma_addr_rx,
-			.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+			.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
 			.src_maxburst = 8,
 		};
 
-- 
2.40.1



