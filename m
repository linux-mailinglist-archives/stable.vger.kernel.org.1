Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02444735EC4
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 23:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjFSVAd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 17:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSVAb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 17:00:31 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F77128
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 14:00:29 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QlMbq4TV9z9sW2;
        Mon, 19 Jun 2023 23:00:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bernhard-seibold.de;
        s=MBO0001; t=1687208423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fStXnJ7H0ML2K4HdlShUnZFAEYzo2xVKmLR5Q1QOQh4=;
        b=gk4/lqlPpiqaxBza6mnvUlxI+ZgdZ+vrzdqZpzEcqNirIf0VrfeJm9YnPeQIW3EP1X6M21
        SICsnQpxsnrY9eLSxivTm1fCj9PwLQVMeemiNS5xFCRU64JoanyXcYA2JsBdRhIXm0/kAK
        3tEU1dA7xCAdT73YN1P24XxkUajykJ8uR0C5KDw9RGfiUDmSjxpUipjzWt7Fntbh1Rgwrl
        WYwP6UxcFNkeq0IF41oMp5UvAUHG1aI5T1Hs8B1nvnmTlQ2/NgMXPpPP9WK3oIAysj2uvY
        x4T/dMz5o8vl1cRnaDcKzW42+J5V0ArA1QCbnXZiOcJDtQUevb2xXt3z83ynsQ==
From:   Bernhard Seibold <mail@bernhard-seibold.de>
To:     stable@vger.kernel.org
Cc:     Bernhard Seibold <mail@bernhard-seibold.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.19.y] serial: lantiq: add missing interrupt ack
Date:   Mon, 19 Jun 2023 23:00:17 +0200
Message-ID: <20230619210017.8894-1-mail@bernhard-seibold.de>
In-Reply-To: <2023061831-detention-overtime-783b@gregkh>
References: <2023061831-detention-overtime-783b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 306320034e8fbe7ee1cc4f5269c55658b4612048 upstream.

Currently, the error interrupt is never acknowledged, so once active it
will stay active indefinitely, causing the handler to be called in an
infinite loop.

Fixes: 2f0fc4159a6a ("SERIAL: Lantiq: Add driver for MIPS Lantiq SOCs.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Message-ID: <20230602133029.546-1-mail@bernhard-seibold.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/lantiq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 044128277248..d0b81dad2970 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -251,6 +251,7 @@ lqasc_err_int(int irq, void *_port)
 	unsigned long flags;
 	struct uart_port *port = (struct uart_port *)_port;
 	spin_lock_irqsave(&ltq_asc_lock, flags);
+	__raw_writel(ASC_IRNCR_EIR, port->membase + LTQ_ASC_IRNCR);
 	/* clear any pending interrupts */
 	ltq_w32_mask(0, ASCWHBSTATE_CLRPE | ASCWHBSTATE_CLRFE |
 		ASCWHBSTATE_CLRROE, port->membase + LTQ_ASC_WHBSTATE);
-- 
2.41.0

