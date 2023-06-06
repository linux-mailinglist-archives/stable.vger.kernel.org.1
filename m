Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53ED7242ED
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 14:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjFFMsG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 6 Jun 2023 08:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjFFMsE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Jun 2023 08:48:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CB3198A
        for <stable@vger.kernel.org>; Tue,  6 Jun 2023 05:47:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99CC163207
        for <stable@vger.kernel.org>; Tue,  6 Jun 2023 12:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7274C4339C;
        Tue,  6 Jun 2023 12:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686055565;
        bh=570QZlkwOYzEoGStBdUeJZYjgV5eYV772/o4+83JYfs=;
        h=Subject:To:From:Date:In-Reply-To:From;
        b=BrdZboSnkZ52yMfp1M5W4NkZIifxL93C+E+R4wv7PhlpBuy5PRn58KkJM9yzTHVrc
         RxDBdbgaZF7PXHr+7kUiyMb7NYPOgFdPpnSvo2wNzwrVO03WmqpXoAa43TIJB4NY/f
         SEW2X2Ps8JR2tErzQJPj86Eq+/hhah1BkOoZdlMs=
Subject: patch "serial: lantiq: add missing interrupt ack" added to tty-linus
To:     mail@bernhard-seibold.de, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com, stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 06 Jun 2023 14:46:02 +0200
In-Reply-To: <20230602133029.546-1-mail@bernhard-seibold.de>
Message-ID: <2023060602-faster-rental-2e9c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    serial: lantiq: add missing interrupt ack

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 306320034e8fbe7ee1cc4f5269c55658b4612048 Mon Sep 17 00:00:00 2001
From: Bernhard Seibold <mail@bernhard-seibold.de>
Date: Fri, 2 Jun 2023 15:30:29 +0200
Subject: serial: lantiq: add missing interrupt ack
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
index a58e9277dfad..f1387f1024db 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -250,6 +250,7 @@ lqasc_err_int(int irq, void *_port)
 	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
 
 	spin_lock_irqsave(&ltq_port->lock, flags);
+	__raw_writel(ASC_IRNCR_EIR, port->membase + LTQ_ASC_IRNCR);
 	/* clear any pending interrupts */
 	asc_update_bits(0, ASCWHBSTATE_CLRPE | ASCWHBSTATE_CLRFE |
 		ASCWHBSTATE_CLRROE, port->membase + LTQ_ASC_WHBSTATE);
-- 
2.41.0


