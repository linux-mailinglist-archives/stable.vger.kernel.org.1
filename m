Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C551570C6B3
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjEVTVW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjEVTVV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:21:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FAAA3
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:21:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C11226282E
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD9DC433EF;
        Mon, 22 May 2023 19:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783279;
        bh=g63N/8IHgm2wznptnbX0o8k72ZjzpAYpVXhLBN+UQ40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JmTAvUv7Bp+TjkpCxk45VB6zK3qtpJpnnv7DEO9oaDcuc4T6VAQACAv8MOnffEdja
         g6GIS6gt93neH0/vnOuOXctzdFF/mlGan7OBr0S/D2+T0Cy43IfteGlceQe8IFsJGu
         2DnOsA89dcEih0oVQcpsu25BlbQ60/M71FcJWLiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jimmy Assarsson <extja@kvaser.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.15 179/203] can: kvaser_pciefd: Empty SRB buffer in probe
Date:   Mon, 22 May 2023 20:10:03 +0100
Message-Id: <20230522190359.956718723@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

commit c589557dd1426f5adf90c7a919d4fde5a3e4ef64 upstream.

Empty the "Shared receive buffer" (SRB) in probe, to assure we start in a
known state, and don't process any irrelevant packets.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://lore.kernel.org/r/20230516134318.104279-5-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/kvaser_pciefd.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -70,10 +70,12 @@ MODULE_DESCRIPTION("CAN driver for Kvase
 #define KVASER_PCIEFD_SYSID_BUILD_REG (KVASER_PCIEFD_SYSID_BASE + 0x14)
 /* Shared receive buffer registers */
 #define KVASER_PCIEFD_SRB_BASE 0x1f200
+#define KVASER_PCIEFD_SRB_FIFO_LAST_REG (KVASER_PCIEFD_SRB_BASE + 0x1f4)
 #define KVASER_PCIEFD_SRB_CMD_REG (KVASER_PCIEFD_SRB_BASE + 0x200)
 #define KVASER_PCIEFD_SRB_IEN_REG (KVASER_PCIEFD_SRB_BASE + 0x204)
 #define KVASER_PCIEFD_SRB_IRQ_REG (KVASER_PCIEFD_SRB_BASE + 0x20c)
 #define KVASER_PCIEFD_SRB_STAT_REG (KVASER_PCIEFD_SRB_BASE + 0x210)
+#define KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG (KVASER_PCIEFD_SRB_BASE + 0x214)
 #define KVASER_PCIEFD_SRB_CTRL_REG (KVASER_PCIEFD_SRB_BASE + 0x218)
 /* EPCS flash controller registers */
 #define KVASER_PCIEFD_SPI_BASE 0x1fc00
@@ -110,6 +112,9 @@ MODULE_DESCRIPTION("CAN driver for Kvase
 /* DMA support */
 #define KVASER_PCIEFD_SRB_STAT_DMA BIT(24)
 
+/* SRB current packet level */
+#define KVASER_PCIEFD_SRB_RX_NR_PACKETS_MASK 0xff
+
 /* DMA Enable */
 #define KVASER_PCIEFD_SRB_CTRL_DMA_ENABLE BIT(0)
 
@@ -1055,6 +1060,7 @@ static int kvaser_pciefd_setup_dma(struc
 {
 	int i;
 	u32 srb_status;
+	u32 srb_packet_count;
 	dma_addr_t dma_addr[KVASER_PCIEFD_DMA_COUNT];
 
 	/* Disable the DMA */
@@ -1082,6 +1088,15 @@ static int kvaser_pciefd_setup_dma(struc
 		  KVASER_PCIEFD_SRB_CMD_RDB1,
 		  pcie->reg_base + KVASER_PCIEFD_SRB_CMD_REG);
 
+	/* Empty Rx FIFO */
+	srb_packet_count = ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG) &
+			   KVASER_PCIEFD_SRB_RX_NR_PACKETS_MASK;
+	while (srb_packet_count) {
+		/* Drop current packet in FIFO */
+		ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_FIFO_LAST_REG);
+		srb_packet_count--;
+	}
+
 	srb_status = ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_STAT_REG);
 	if (!(srb_status & KVASER_PCIEFD_SRB_STAT_DI)) {
 		dev_err(&pcie->pci->dev, "DMA not idle before enabling\n");


