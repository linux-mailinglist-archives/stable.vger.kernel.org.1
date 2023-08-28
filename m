Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E5F78AA3E
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjH1KUS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjH1KT7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:19:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C186126
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:19:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F061763668
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1083DC433C8;
        Mon, 28 Aug 2023 10:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217983;
        bh=h/pXnaQoBae982MUchWK4WuHKla4CHCPMjb+Eowuy/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YBhUXBgJ2KFZFPSHwBahDzRPiAdx6o+w5K33LG0y3x2/t3ekNqDqKWXXY6oelVUcK
         eduwbKkgZmqBwogNL2/3R+l3yRMkAuJgPVkSQwVbKtEXe23jIDGjnx+8XaRL5DlQxU
         jFDFaOXcb1Gnu8aCyHl0/HMxgSBwLs/2WToYsuAE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Srinivas Goud <srinivas.goud@amd.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.4 053/129] spi: spi-cadence: Fix data corruption issues in slave mode
Date:   Mon, 28 Aug 2023 12:12:12 +0200
Message-ID: <20230828101159.135174810@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivas Goud <srinivas.goud@amd.com>

commit 627d05a41ca1fbb9d390f9513af262f001f261f7 upstream.

Remove 10us delay in cdns_spi_process_fifo() (called from cdns_spi_irq())
to fix data corruption issue on Master side when this driver
configured in Slave mode, as Slave is failed to prepare the date
on time due to above delay.

Add 10us delay before processing the RX FIFO as TX empty doesn't
guarantee valid data in RX FIFO.

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/1692610216-217644-1-git-send-email-srinivas.goud@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-cadence.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -316,12 +316,6 @@ static void cdns_spi_process_fifo(struct
 	xspi->rx_bytes -= nrx;
 
 	while (ntx || nrx) {
-		/* When xspi in busy condition, bytes may send failed,
-		 * then spi control did't work thoroughly, add one byte delay
-		 */
-		if (cdns_spi_read(xspi, CDNS_SPI_ISR) & CDNS_SPI_IXR_TXFULL)
-			udelay(10);
-
 		if (ntx) {
 			if (xspi->txbuf)
 				cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi->txbuf++);
@@ -391,6 +385,11 @@ static irqreturn_t cdns_spi_irq(int irq,
 		if (xspi->tx_bytes) {
 			cdns_spi_process_fifo(xspi, trans_cnt, trans_cnt);
 		} else {
+			/* Fixed delay due to controller limitation with
+			 * RX_NEMPTY incorrect status
+			 * Xilinx AR:65885 contains more details
+			 */
+			udelay(10);
 			cdns_spi_process_fifo(xspi, 0, trans_cnt);
 			cdns_spi_write(xspi, CDNS_SPI_IDR,
 				       CDNS_SPI_IXR_DEFAULT);
@@ -438,12 +437,18 @@ static int cdns_transfer_one(struct spi_
 		cdns_spi_setup_transfer(spi, transfer);
 	} else {
 		/* Set TX empty threshold to half of FIFO depth
-		 * only if TX bytes are more than half FIFO depth.
+		 * only if TX bytes are more than FIFO depth.
 		 */
 		if (xspi->tx_bytes > xspi->tx_fifo_depth)
 			cdns_spi_write(xspi, CDNS_SPI_THLD, xspi->tx_fifo_depth >> 1);
 	}
 
+	/* When xspi in busy condition, bytes may send failed,
+	 * then spi control didn't work thoroughly, add one byte delay
+	 */
+	if (cdns_spi_read(xspi, CDNS_SPI_ISR) & CDNS_SPI_IXR_TXFULL)
+		udelay(10);
+
 	cdns_spi_process_fifo(xspi, xspi->tx_fifo_depth, 0);
 	spi_transfer_delay_exec(transfer);
 


