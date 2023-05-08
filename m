Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E7A6FABD8
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbjEHLSN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjEHLSI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:18:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A504037877
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85BD86157F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBD6C433EF;
        Mon,  8 May 2023 11:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544681;
        bh=wDgUYp7LEj6p/a2NTC3JBRUa1YjnfN901tVoPe3FbZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yJ4AqGjymtIX8JmmBPk0Nvvry1YjMF8ZcF5B7IW91YtSu+JOvRVxMs2FkPh3zrYye
         bVVARqA/pSt5sXjAUweVz90wdC4QM9yWLHqz/Dc6nti7YfXdba2QIJD32VZP3RaUVO
         ADahYWtfvho6aloVEI7Vf2hcwFAvse461cmtWOms=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 490/694] serial: stm32: Re-assert RTS/DE GPIO in RS485 mode only if more data are transmitted
Date:   Mon,  8 May 2023 11:45:25 +0200
Message-Id: <20230508094449.879929638@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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
index 767ff9fdb2e58..84700016932d6 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -693,8 +693,9 @@ static void stm32_usart_transmit_chars(struct uart_port *port)
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



