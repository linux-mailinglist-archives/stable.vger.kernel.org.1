Return-Path: <stable+bounces-127551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6AFA7A573
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 16:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F347C18977AF
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 14:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2A324EF6F;
	Thu,  3 Apr 2025 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h2l/pMVt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF95024EA96
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743691112; cv=none; b=QGeuiQhTAomPhivWFh1biKdsIwW2zPPq54YvWVcW3AFWNFINhxj7U8fVkpS47Fhl5YWyyIkSvmPAIxneP/8RvDqRiUofTULjfc5dXeYvnP3LXZCR7Xrz4YyxMqkK30Z9Z7bM2aKVA88hQHXc0ggRf6LEYE8FPlnxjxtZ33TKs0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743691112; c=relaxed/simple;
	bh=hLV10IguTLtVqvI9uCZBQ12sEi19mZAWOvMGQHxBYhk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rueYMVzzAT/dIva3kv/CBPRU2n8hbzbb1IPwJHq/AScskM8RmtikT+3Y07HT5x4eXBCRCfU2Zb0XEBN19B+zseqhsSKy5LdGXe5rO0Nu+tbAaigIANIuRV71/g5lLbGj6qX827sNuw504bTPKfaygkNwAd4roC6WtITrGdzhWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h2l/pMVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F3FC4CEE3;
	Thu,  3 Apr 2025 14:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743691111;
	bh=hLV10IguTLtVqvI9uCZBQ12sEi19mZAWOvMGQHxBYhk=;
	h=Subject:To:Cc:From:Date:From;
	b=h2l/pMVtRmhh8TFA333teO3fgUu/1Z9gqQ9/tDysLRpahNyGpMJ0MIbCas9pGs24f
	 l85kfofi0Vc/7j00qr7fFyf1rhl6z9pXUMWdUTSFBm4hSfCe9BGZShHYpQJyYpP5vM
	 YlrwqmopET5xaLrkDYmeBo5E9RY7vcOtlX+f9Agw=
Subject: FAILED: patch "[PATCH] tty: serial: lpuart: only disable CTS instead of overwriting" failed to apply to 5.4-stable tree
To: sherry.sun@nxp.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Apr 2025 15:36:52 +0100
Message-ID: <2025040352-makeover-hardening-da0e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x e98ab45ec5182605d2e00114cba3bbf46b0ea27f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040352-makeover-hardening-da0e@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e98ab45ec5182605d2e00114cba3bbf46b0ea27f Mon Sep 17 00:00:00 2001
From: Sherry Sun <sherry.sun@nxp.com>
Date: Fri, 7 Mar 2025 14:54:46 +0800
Subject: [PATCH] tty: serial: lpuart: only disable CTS instead of overwriting
 the whole UARTMODIR register

No need to overwrite the whole UARTMODIR register before waiting the
transmit engine complete, actually our target here is only to disable
CTS flow control to avoid the dirty data in TX FIFO may block the
transmit engine complete.
Also delete the following duplicate CTS disable configuration.

Fixes: d5a2e0834364 ("tty: serial: lpuart: disable flow control while waiting for the transmit engine to complete")
Cc: stable <stable@kernel.org>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Link: https://lore.kernel.org/r/20250307065446.1122482-1-sherry.sun@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c8cc0a241fba..33eeefa6fa8f 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2349,15 +2349,19 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	/* update the per-port timeout */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
+	/*
+	 * disable CTS to ensure the transmit engine is not blocked by the flow
+	 * control when there is dirty data in TX FIFO
+	 */
+	lpuart32_write(port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
+
 	/*
 	 * LPUART Transmission Complete Flag may never be set while queuing a break
 	 * character, so skip waiting for transmission complete when UARTCTRL_SBK is
 	 * asserted.
 	 */
-	if (!(old_ctrl & UARTCTRL_SBK)) {
-		lpuart32_write(port, 0, UARTMODIR);
+	if (!(old_ctrl & UARTCTRL_SBK))
 		lpuart32_wait_bit_set(port, UARTSTAT, UARTSTAT_TC);
-	}
 
 	/* disable transmit and receive */
 	lpuart32_write(port, old_ctrl & ~(UARTCTRL_TE | UARTCTRL_RE),
@@ -2365,8 +2369,6 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	lpuart32_write(port, bd, UARTBAUD);
 	lpuart32_serial_setbrg(sport, baud);
-	/* disable CTS before enabling UARTCTRL_TE to avoid pending idle preamble */
-	lpuart32_write(port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
 	/* restore control register */
 	lpuart32_write(port, ctrl, UARTCTRL);
 	/* re-enable the CTS if needed */


