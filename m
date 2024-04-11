Return-Path: <stable+bounces-38150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 580768A0D3F
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13999285FB7
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1370145B08;
	Thu, 11 Apr 2024 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ep9ominL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90577145345;
	Thu, 11 Apr 2024 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829711; cv=none; b=ex4HTe86PSPhlmjTniKGJsFyCHRLA+Vo9k1UDDYApbcTajQHoYQGqEbwCDGqKqx5b/b3oGuqBZcphRTXDA43r3OHx7XjnBl648pHzSynUI6rYJA+Bij0PN0izvyBDfiQj7xBj/eajmAtJEvVqvjC0sfw8bT9wgKJKzI6Djyap4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829711; c=relaxed/simple;
	bh=Ba4e5KiZ64IHblsKq9tLYwPK0IMRcyDrGet/Ej6dyHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AVztkAFPCXYfx0DBn/sHVd+rr4kpqj26g7FzedcYHSXoPbHr9/IAxCa1cV9RXXDyvxkw5n7rJNTAXuKyznIq2cV8tx45v3BD+wyc5B5/4fw4inxPjRie7YgCV0Mfuy2LHclacavzjs5AFuxhkUWVES44rNjGxd0753V2XOLJJ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ep9ominL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E56BC433C7;
	Thu, 11 Apr 2024 10:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712829711;
	bh=Ba4e5KiZ64IHblsKq9tLYwPK0IMRcyDrGet/Ej6dyHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ep9ominLsfuRM+EXHOLRWDc5dDGzU0ghzFJrTkCiyDXY2ANNtVXQOAq/DrX0eNU0X
	 cSa74FoDH5OU4d8HnPmKiAmsw1taKBzWm8tDwKmgeC8ydKaGWd/H6C9T55yIz7L7Y2
	 vy4GRJ3Vp5FvNnBuVlu09FuCIVO/fsJmagA1TWjQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Sherry Sun <sherry.sun@nxp.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH 4.19 077/175] tty: serial: fsl_lpuart: avoid idle preamble pending if CTS is enabled
Date: Thu, 11 Apr 2024 11:55:00 +0200
Message-ID: <20240411095421.882047204@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095419.532012976@linuxfoundation.org>
References: <20240411095419.532012976@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sherry Sun <sherry.sun@nxp.com>

commit 74cb7e0355fae9641f825afa389d3fba3b617714 upstream.

If the remote uart device is not connected or not enabled after booting
up, the CTS line is high by default. At this time, if we enable the flow
control when opening the device(for example, using “stty -F /dev/ttyLP4
crtscts” command), there will be a pending idle preamble(first writing 0
and then writing 1 to UARTCTRL_TE will queue an idle preamble) that
cannot be sent out, resulting in the uart port fail to close(waiting for
TX empty), so the user space stty will have to wait for a long time or
forever.

This is an LPUART IP bug(idle preamble has higher priority than CTS),
here add a workaround patch to enable TX CTS after enabling UARTCTRL_TE,
so that the idle preamble does not get stuck due to CTS is deasserted.

Fixes: 380c966c093e ("tty: serial: fsl_lpuart: add 32-bit register interface support")
Cc: stable <stable@kernel.org>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Link: https://lore.kernel.org/r/20240305015706.1050769-1-sherry.sun@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/fsl_lpuart.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1753,9 +1753,12 @@ lpuart32_set_termios(struct uart_port *p
 		       UARTCTRL);
 
 	lpuart32_serial_setbrg(sport, baud);
-	lpuart32_write(&sport->port, modem, UARTMODIR);
-	lpuart32_write(&sport->port, ctrl, UARTCTRL);
+	/* disable CTS before enabling UARTCTRL_TE to avoid pending idle preamble */
+	lpuart32_write(&sport->port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
 	/* restore control register */
+	lpuart32_write(&sport->port, ctrl, UARTCTRL);
+	/* re-enable the CTS if needed */
+	lpuart32_write(&sport->port, modem, UARTMODIR);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 }



