Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1CB775BBC
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjHILUc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbjHILUb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:20:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0A9FA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:20:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1EDA631D6
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D304DC433CA;
        Wed,  9 Aug 2023 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580030;
        bh=5ELQ0BDJ9SjiJguy0eiDz3rrVkV8UAGxL3v3HC38j14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Dh3RwyvSu6Ps0aytVHEo/WN2kF7UBpnP1l+PYMVrGARvbsINXQ7dNV0UZ7FARkN1
         7YGjCtr1zs26imi46h02mdRE0MPY3YEQi17vOwMiqF0R9reNvV5w44JQc6yYnDY+ez
         AX9tHlhVk5gvGq4/inKbqsWeuArZtgRNY+yyKWKo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        stable <stable@kernel.org>
Subject: [PATCH 4.19 172/323] serial: atmel: dont enable IRQs prematurely
Date:   Wed,  9 Aug 2023 12:40:10 +0200
Message-ID: <20230809103706.028176713@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 27a826837ec9a3e94cc44bd9328b8289b0fcecd7 upstream.

The atmel_complete_tx_dma() function disables IRQs at the start
of the function by calling spin_lock_irqsave(&port->lock, flags);
There is no need to disable them a second time using the
spin_lock_irq() function and, in fact, doing so is a bug because
it will enable IRQs prematurely when we call spin_unlock_irq().

Just use spin_lock/unlock() instead without disabling or enabling
IRQs.

Fixes: 08f738be88bb ("serial: at91: add tx dma support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Acked-by: Richard Genoud <richard.genoud@gmail.com>
Link: https://lore.kernel.org/r/cb7c39a9-c004-4673-92e1-be4e34b85368@moroto.mountain
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/atmel_serial.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -791,11 +791,11 @@ static void atmel_complete_tx_dma(void *
 
 	port->icount.tx += atmel_port->tx_len;
 
-	spin_lock_irq(&atmel_port->lock_tx);
+	spin_lock(&atmel_port->lock_tx);
 	async_tx_ack(atmel_port->desc_tx);
 	atmel_port->cookie_tx = -EINVAL;
 	atmel_port->desc_tx = NULL;
-	spin_unlock_irq(&atmel_port->lock_tx);
+	spin_unlock(&atmel_port->lock_tx);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);


