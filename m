Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8589726FE0
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbjFGVDC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbjFGVCs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:02:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B55B26AF
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:02:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F4BF63991
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 21:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52823C433EF;
        Wed,  7 Jun 2023 21:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171720;
        bh=+e3f2umMcMCnawlupSfzFmkG7XIn5sp26HBUPFUrLAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S30WK4IHJampoQpzjaEAjqwnGFeTQS7fFhtb0X61nvqfGJVHDU3G7+FSpkq5YdoGp
         lSfWQQepxpiVkIJ2xB09tRyvDRfBtkAiLrKqZy79VQgPifawBemK1pZarpnpQFvkUW
         e8Hgl2j2xQLQEKrpvrAQzM/08tYXjI0SsJ0LHhfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Sherry Sun <sherry.sun@nxp.com>
Subject: [PATCH 5.15 124/159] tty: serial: fsl_lpuart: use UARTCTRL_TXINV to send break instead of UARTCTRL_SBK
Date:   Wed,  7 Jun 2023 22:17:07 +0200
Message-ID: <20230607200907.735550311@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Sherry Sun <sherry.sun@nxp.com>

commit 2474e05467c00f7d51af3039b664de6886325257 upstream.

LPUART IP now has two known bugs, one is that CTS has higher priority
than the break signal, which causes the break signal sending through
UARTCTRL_SBK may impacted by the CTS input if the HW flow control is
enabled. It exists on all platforms we support in this driver.
So we add a workaround patch for this issue: commit c4c81db5cf8b
("tty: serial: fsl_lpuart: disable the CTS when send break signal").

Another IP bug is i.MX8QM LPUART may have an additional break character
being sent after SBK was cleared. It may need to add some delay between
clearing SBK and re-enabling CTS to ensure that the SBK latch are
completely cleared.

But we found that during the delay period before CTS is enabled, there
is still a risk that Bluetooth data in TX FIFO may be sent out during
this period because of break off and CTS disabled(even if BT sets CTS
line deasserted, data is still sent to BT).

Due to this risk, we have to drop the CTS-disabling workaround for SBK
bugs, use TXINV seems to be a better way to replace SBK feature and
avoid above risk. Also need to disable the transmitter to prevent any
data from being sent out during break, then invert the TX line to send
break. Then disable the TXINV when turn off break and re-enable
transmitter.

Fixes: c4c81db5cf8b ("tty: serial: fsl_lpuart: disable the CTS when send break signal")
Cc: stable <stable@kernel.org>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Link: https://lore.kernel.org/r/20230519094751.28948-1-sherry.sun@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/fsl_lpuart.c |   44 ++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1491,34 +1491,36 @@ static void lpuart_break_ctl(struct uart
 
 static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 {
-	unsigned long temp, modem;
-	struct tty_struct *tty;
-	unsigned int cflag = 0;
+	unsigned long temp;
 
-	tty = tty_port_tty_get(&port->state->port);
-	if (tty) {
-		cflag = tty->termios.c_cflag;
-		tty_kref_put(tty);
-	}
-
-	temp = lpuart32_read(port, UARTCTRL) & ~UARTCTRL_SBK;
-	modem = lpuart32_read(port, UARTMODIR);
+	temp = lpuart32_read(port, UARTCTRL);
 
+	/*
+	 * LPUART IP now has two known bugs, one is CTS has higher priority than the
+	 * break signal, which causes the break signal sending through UARTCTRL_SBK
+	 * may impacted by the CTS input if the HW flow control is enabled. It
+	 * exists on all platforms we support in this driver.
+	 * Another bug is i.MX8QM LPUART may have an additional break character
+	 * being sent after SBK was cleared.
+	 * To avoid above two bugs, we use Transmit Data Inversion function to send
+	 * the break signal instead of UARTCTRL_SBK.
+	 */
 	if (break_state != 0) {
-		temp |= UARTCTRL_SBK;
 		/*
-		 * LPUART CTS has higher priority than SBK, need to disable CTS before
-		 * asserting SBK to avoid any interference if flow control is enabled.
+		 * Disable the transmitter to prevent any data from being sent out
+		 * during break, then invert the TX line to send break.
 		 */
-		if (cflag & CRTSCTS && modem & UARTMODIR_TXCTSE)
-			lpuart32_write(port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
+		temp &= ~UARTCTRL_TE;
+		lpuart32_write(port, temp, UARTCTRL);
+		temp |= UARTCTRL_TXINV;
+		lpuart32_write(port, temp, UARTCTRL);
 	} else {
-		/* Re-enable the CTS when break off. */
-		if (cflag & CRTSCTS && !(modem & UARTMODIR_TXCTSE))
-			lpuart32_write(port, modem | UARTMODIR_TXCTSE, UARTMODIR);
+		/* Disable the TXINV to turn off break and re-enable transmitter. */
+		temp &= ~UARTCTRL_TXINV;
+		lpuart32_write(port, temp, UARTCTRL);
+		temp |= UARTCTRL_TE;
+		lpuart32_write(port, temp, UARTCTRL);
 	}
-
-	lpuart32_write(port, temp, UARTCTRL);
 }
 
 static void lpuart_setup_watermark(struct lpuart_port *sport)


