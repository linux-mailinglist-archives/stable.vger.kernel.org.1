Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A5C6F8EED
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 07:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjEFF50 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 01:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjEFF5Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 01:57:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23C559F1
        for <stable@vger.kernel.org>; Fri,  5 May 2023 22:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4676D61647
        for <stable@vger.kernel.org>; Sat,  6 May 2023 05:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE5DC433D2;
        Sat,  6 May 2023 05:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683352643;
        bh=nJRt/tBDRBh2gf/U2morkFcIUEaqONCmFuLelL65OnQ=;
        h=Subject:To:Cc:From:Date:From;
        b=q/z2c+C30jvOGup0DPlSTO09V6KzNCvWF15olHI8ZrNLBTJXgy5boq6kzBx7X6sgL
         lk07Sq5ZZWtdUj+70m7G0Kgt1tr33eYgN0yRLx4Lx9pVLoEwYR5ztd/3IINXXJaL5O
         S4wutOrvzkJsYQLQ2LlfKL9Z5d6l6ISY6v5r26+E=
Subject: FAILED: patch "[PATCH] serial: 8250: Fix serial8250_tx_empty() race with DMA Tx" failed to apply to 4.19-stable tree
To:     ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 06 May 2023 11:12:29 +0900
Message-ID: <2023050629-nastily-commodity-a7ad@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 146a37e05d620cef4ad430e5d1c9c077fe6fa76f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050629-nastily-commodity-a7ad@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 146a37e05d620cef4ad430e5d1c9c077fe6fa76f Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 17 Mar 2023 13:33:18 +0200
Subject: [PATCH] serial: 8250: Fix serial8250_tx_empty() race with DMA Tx
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There's a potential race before THRE/TEMT deasserts when DMA Tx is
starting up (or the next batch of continuous Tx is being submitted).
This can lead to misdetecting Tx empty condition.

It is entirely normal for THRE/TEMT to be set for some time after the
DMA Tx had been setup in serial8250_tx_dma(). As Tx side is definitely
not empty at that point, it seems incorrect for serial8250_tx_empty()
claim Tx is empty.

Fix the race by also checking in serial8250_tx_empty() whether there's
DMA Tx active.

Note: This fix only addresses in-kernel race mainly to make using
TCSADRAIN/FLUSH robust. Userspace can still cause other races but they
seem userspace concurrency control problems.

Fixes: 9ee4b83e51f74 ("serial: 8250: Add support for dmaengine")
Cc: stable@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20230317113318.31327-3-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 287153d32536..1e8fe44a7099 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -365,6 +365,13 @@ static inline void serial8250_do_prepare_rx_dma(struct uart_8250_port *p)
 	if (dma->prepare_rx_dma)
 		dma->prepare_rx_dma(p);
 }
+
+static inline bool serial8250_tx_dma_running(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	return dma && dma->tx_running;
+}
 #else
 static inline int serial8250_tx_dma(struct uart_8250_port *p)
 {
@@ -380,6 +387,11 @@ static inline int serial8250_request_dma(struct uart_8250_port *p)
 	return -1;
 }
 static inline void serial8250_release_dma(struct uart_8250_port *p) { }
+
+static inline bool serial8250_tx_dma_running(struct uart_8250_port *p)
+{
+	return false;
+}
 #endif
 
 static inline int ns16550a_goto_highspeed(struct uart_8250_port *up)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index fa43df05342b..107bcdfb119c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2005,18 +2005,19 @@ static int serial8250_tx_threshold_handle_irq(struct uart_port *port)
 static unsigned int serial8250_tx_empty(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned int result = 0;
 	unsigned long flags;
-	u16 lsr;
 
 	serial8250_rpm_get(up);
 
 	spin_lock_irqsave(&port->lock, flags);
-	lsr = serial_lsr_in(up);
+	if (!serial8250_tx_dma_running(up) && uart_lsr_tx_empty(serial_lsr_in(up)))
+		result = TIOCSER_TEMT;
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	serial8250_rpm_put(up);
 
-	return uart_lsr_tx_empty(lsr) ? TIOCSER_TEMT : 0;
+	return result;
 }
 
 unsigned int serial8250_do_get_mctrl(struct uart_port *port)

