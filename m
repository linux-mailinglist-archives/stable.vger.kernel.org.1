Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878BA6FAE34
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbjEHLm0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbjEHLmE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:42:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF2D4268D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:41:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BA90634E2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF17C433D2;
        Mon,  8 May 2023 11:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546060;
        bh=gfob5RVvO+8vSjUDiVXTpdkeqvV1sKG00uQz5ESath4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFKc3dWLFSUCYnPugVhy7WjDiqEZct/slNQKmcBoD2J1H3nSpsrNhCN51KpWjgVG9
         4G6/Fso2VqGXOHqbgYK93ZsptJn5pvCLYTVZAILzDM2v/mUP8I8KxE3/NC8YBBhqYJ
         x4EuLRvkTx6N4aKlz6XElw5O0kMQGEJ/B6biB8Jg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 243/371] serial: stm32: Re-assert RTS/DE GPIO in RS485 mode only if more data are transmitted
Date:   Mon,  8 May 2023 11:47:24 +0200
Message-Id: <20230508094821.711066016@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Marek Vasut <marex@denx.de>

[ Upstream commit c47527cbcc3c50800f34b8c684f29721f75de246 ]

The stm32_usart_transmit_chars() may be called with empty or stopped
transmit queue, and no XON/OFF character pending. This can happen at
the end of transmission, where this last call is used to either handle
the XON/XOFF x_char, or disable TX interrupt if queue is empty or
stopped.

If that occurs, do not assert the RS485 RTS/DE GPIO anymore, as the
GPIO would remain asserted past the end of transmission and that would
block the RS485 bus after the transmission.

Only assert the RS485 RTS/DE GPIO if there is either pending XON/XOFF
x_char, or at least one character in running transmit queue.

Fixes: d7c76716169d ("serial: stm32: Use TC interrupt to deassert GPIO RTS in RS485 mode")
Signed-off-by: Marek Vasut <marex@denx.de>
Link: https://lore.kernel.org/r/20230223042252.95480-2-marex@denx.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/stm32-usart.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 0e8158cfaf0f9..3b7d4481edbea 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -502,8 +502,9 @@ static void stm32_usart_transmit_chars(struct uart_port *port)
 	int ret;
 
 	if (!stm32_port->hw_flow_control &&
-	    port->rs485.flags & SER_RS485_ENABLED) {
-		stm32_port->txdone = false;
+	    port->rs485.flags & SER_RS485_ENABLED &&
+	    (port->x_char ||
+	     !(uart_circ_empty(xmit) || uart_tx_stopped(port)))) {
 		stm32_usart_tc_interrupt_disable(port);
 		stm32_usart_rs485_rts_enable(port);
 	}
-- 
2.39.2



