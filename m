Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72587735438
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjFSKx5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjFSKxV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:53:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36C41FC9
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:51:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D2DA60B42
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D52C433D9;
        Mon, 19 Jun 2023 10:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171915;
        bh=LoC3srpFFpmnp4vhLAhfjdr0Jrn5pae3QDISMP9kKNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1TDPdaJrfO1HL02Zdl4UVQfX/S5XEEaSSms80U47GJV8CPNDu7fMet5L85XnmHz51
         dKPG1EBjPGMrgBNgJ0ZsjLX1baG7Z2K9IM5gvPCsZkrFB4v1t8c3nxJGGsi8TDt6Jq
         YR/4mXallzxDUv+96itwL7aeAs+0E4+aanXA/5DY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 36/64] spi: spi-fsl-dspi: Remove unused chip->void_write_data
Date:   Mon, 19 Jun 2023 12:30:32 +0200
Message-ID: <20230619102134.803783557@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
References: <20230619102132.808972458@linuxfoundation.org>
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

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 6d6af5796e5d9a88ae83c9c753023bba61deb18b ]

This variable has been present since the initial submission of the
driver, and held, for some reason, the value of zero, to be sent on the
wire in the case there wasn't any TX buffer for the current transfer.

Since quite a while now, however, it isn't doing anything at all.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/r/20200304220044.11193-3-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: c5c31fb71f16 ("spi: fsl-dspi: avoid SCK glitches with continuous transfers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 3e0200618af30..51e17f0828646 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -121,7 +121,6 @@
 
 struct chip_data {
 	u32			ctar_val;
-	u16			void_write_data;
 };
 
 enum dspi_trans_mode {
@@ -190,7 +189,6 @@ struct fsl_dspi {
 	const void				*tx;
 	void					*rx;
 	void					*rx_end;
-	u16					void_write_data;
 	u16					tx_cmd;
 	u8					bits_per_word;
 	u8					bytes_per_word;
@@ -748,8 +746,6 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				dspi->tx_cmd |= SPI_PUSHR_CMD_CONT;
 		}
 
-		dspi->void_write_data = dspi->cur_chip->void_write_data;
-
 		dspi->tx = transfer->tx_buf;
 		dspi->rx = transfer->rx_buf;
 		dspi->rx_end = dspi->rx + transfer->len;
@@ -848,8 +844,6 @@ static int dspi_setup(struct spi_device *spi)
 		sck_cs_delay = pdata->sck_cs_delay;
 	}
 
-	chip->void_write_data = 0;
-
 	clkrate = clk_get_rate(dspi->clk);
 	hz_to_spi_baud(&pbr, &br, spi->max_speed_hz, clkrate);
 
-- 
2.39.2



