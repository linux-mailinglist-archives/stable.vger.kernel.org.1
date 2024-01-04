Return-Path: <stable+bounces-9707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994E9824512
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 16:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991101C22407
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 15:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D650024207;
	Thu,  4 Jan 2024 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O6kayq5W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7D7241F7
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 15:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247C4C433C7;
	Thu,  4 Jan 2024 15:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704382461;
	bh=+RW6GnsFhj4CjWQVDCep1whyPPDwRpnP30UMSWUjWF8=;
	h=Subject:To:From:Date:From;
	b=O6kayq5WRI/2O5qS7wfyO8v9weU7QdRpqjGcnkls+inXAagquhDHHdwYGLwy2F6iG
	 Q74Wv7tasuVJtuzh28y+P+18NQxy9ywq2XQWXYdG5PxBO9qewroXMwowX5qaqeAFEv
	 2j/Omqpd5tV1NeHTzZG3JqRdoVzdmxSNdNeN3KFI=
Subject: patch "serial: sc16is7xx: remove obsolete loop in sc16is7xx_port_irq()" added to tty-testing
To: hvilleneuve@dimonoff.com,andy.shevchenko@gmail.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jan 2024 16:33:57 +0100
Message-ID: <2024010456-undergrad-conjuror-c8e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    serial: sc16is7xx: remove obsolete loop in sc16is7xx_port_irq()

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the tty-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From ed647256e8f226241ecff7baaecdb8632ffc7ec1 Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu, 21 Dec 2023 18:18:11 -0500
Subject: serial: sc16is7xx: remove obsolete loop in sc16is7xx_port_irq()

Commit 834449872105 ("sc16is7xx: Fix for multi-channel stall") changed
sc16is7xx_port_irq() from looping multiple times when there was still
interrupts to serve. It simply changed the do {} while(1) loop to a
do {} while(0) loop, which makes the loop itself now obsolete.

Clean the code by removing this obsolete do {} while(0) loop.

Fixes: 834449872105 ("sc16is7xx: Fix for multi-channel stall")
Cc:  <stable@vger.kernel.org>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20231221231823.2327894-5-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sc16is7xx.c | 81 ++++++++++++++++------------------
 1 file changed, 39 insertions(+), 42 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index ced2446909a2..44a11c89c949 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -725,58 +725,55 @@ static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 {
 	bool rc = true;
+	unsigned int iir, rxlen;
 	struct uart_port *port = &s->p[portno].port;
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
 	mutex_lock(&one->efr_lock);
 
-	do {
-		unsigned int iir, rxlen;
+	iir = sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
+	if (iir & SC16IS7XX_IIR_NO_INT_BIT) {
+		rc = false;
+		goto out_port_irq;
+	}
 
-		iir = sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
-		if (iir & SC16IS7XX_IIR_NO_INT_BIT) {
-			rc = false;
-			goto out_port_irq;
-		}
+	iir &= SC16IS7XX_IIR_ID_MASK;
 
-		iir &= SC16IS7XX_IIR_ID_MASK;
+	switch (iir) {
+	case SC16IS7XX_IIR_RDI_SRC:
+	case SC16IS7XX_IIR_RLSE_SRC:
+	case SC16IS7XX_IIR_RTOI_SRC:
+	case SC16IS7XX_IIR_XOFFI_SRC:
+		rxlen = sc16is7xx_port_read(port, SC16IS7XX_RXLVL_REG);
 
-		switch (iir) {
-		case SC16IS7XX_IIR_RDI_SRC:
-		case SC16IS7XX_IIR_RLSE_SRC:
-		case SC16IS7XX_IIR_RTOI_SRC:
-		case SC16IS7XX_IIR_XOFFI_SRC:
-			rxlen = sc16is7xx_port_read(port, SC16IS7XX_RXLVL_REG);
+		/*
+		 * There is a silicon bug that makes the chip report a
+		 * time-out interrupt but no data in the FIFO. This is
+		 * described in errata section 18.1.4.
+		 *
+		 * When this happens, read one byte from the FIFO to
+		 * clear the interrupt.
+		 */
+		if (iir == SC16IS7XX_IIR_RTOI_SRC && !rxlen)
+			rxlen = 1;
 
-			/*
-			 * There is a silicon bug that makes the chip report a
-			 * time-out interrupt but no data in the FIFO. This is
-			 * described in errata section 18.1.4.
-			 *
-			 * When this happens, read one byte from the FIFO to
-			 * clear the interrupt.
-			 */
-			if (iir == SC16IS7XX_IIR_RTOI_SRC && !rxlen)
-				rxlen = 1;
-
-			if (rxlen)
-				sc16is7xx_handle_rx(port, rxlen, iir);
-			break;
+		if (rxlen)
+			sc16is7xx_handle_rx(port, rxlen, iir);
+		break;
 		/* CTSRTS interrupt comes only when CTS goes inactive */
-		case SC16IS7XX_IIR_CTSRTS_SRC:
-		case SC16IS7XX_IIR_MSI_SRC:
-			sc16is7xx_update_mlines(one);
-			break;
-		case SC16IS7XX_IIR_THRI_SRC:
-			sc16is7xx_handle_tx(port);
-			break;
-		default:
-			dev_err_ratelimited(port->dev,
-					    "ttySC%i: Unexpected interrupt: %x",
-					    port->line, iir);
-			break;
-		}
-	} while (0);
+	case SC16IS7XX_IIR_CTSRTS_SRC:
+	case SC16IS7XX_IIR_MSI_SRC:
+		sc16is7xx_update_mlines(one);
+		break;
+	case SC16IS7XX_IIR_THRI_SRC:
+		sc16is7xx_handle_tx(port);
+		break;
+	default:
+		dev_err_ratelimited(port->dev,
+				    "ttySC%i: Unexpected interrupt: %x",
+				    port->line, iir);
+		break;
+	}
 
 out_port_irq:
 	mutex_unlock(&one->efr_lock);
-- 
2.43.0



