Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D25B7A7FFA
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbjITMb5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbjITMb4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:31:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108A492
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:31:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B72AC433C7;
        Wed, 20 Sep 2023 12:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213110;
        bh=HWRB8Z4WnpiSEAVCi1Tz03yCWHA2QrVJu08CjQh/iOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YB5Yyd3d/Q7NXufdrxDCEZHxC+tbff7Cee92GvNTlbKVCcDHWXlBidyU1tkwZE3kT
         E+ZX+DLKcLBKBffWv8jXyTDd2kwIiWWds74josneasLBP3k4uU36m7pSqq14IczeUT
         eYU67BuUKSXhiZS84Aegg8iYBYTW4JnpwflcZJx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 165/367] serial: sprd: Fix DMA buffer leak issue
Date:   Wed, 20 Sep 2023 13:29:02 +0200
Message-ID: <20230920112902.917822447@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

[ Upstream commit cd119fdc3ee1450fbf7f78862b5de44c42b6e47f ]

Release DMA buffer when _probe() returns failure to avoid memory leak.

Fixes: f4487db58eb7 ("serial: sprd: Add DMA mode support")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230725064053.235448-2-chunyan.zhang@unisoc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sprd_serial.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 18f5a7f438329..8b45b3ab63416 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -371,7 +371,7 @@ static void sprd_rx_free_buf(struct sprd_uart_port *sp)
 	if (sp->rx_dma.virt)
 		dma_free_coherent(sp->port.dev, SPRD_UART_RX_SIZE,
 				  sp->rx_dma.virt, sp->rx_dma.phys_addr);
-
+	sp->rx_dma.virt = NULL;
 }
 
 static int sprd_rx_dma_config(struct uart_port *port, u32 burst)
@@ -1199,7 +1199,7 @@ static int sprd_probe(struct platform_device *pdev)
 		ret = uart_register_driver(&sprd_uart_driver);
 		if (ret < 0) {
 			pr_err("Failed to register SPRD-UART driver\n");
-			return ret;
+			goto free_rx_buf;
 		}
 	}
 
@@ -1218,6 +1218,7 @@ static int sprd_probe(struct platform_device *pdev)
 	sprd_port[index] = NULL;
 	if (--sprd_ports_num == 0)
 		uart_unregister_driver(&sprd_uart_driver);
+free_rx_buf:
 	sprd_rx_free_buf(sport);
 	return ret;
 }
-- 
2.40.1



