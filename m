Return-Path: <stable+bounces-127541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FEEA7A56D
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 16:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8BF1791D5
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33E224EF89;
	Thu,  3 Apr 2025 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FgCAugTG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA5824EF82
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743691078; cv=none; b=JwD2a/YCiF/MW0oiYKV/Rd/aLrG5cTqQJZVZlUQQxH6gUwoyPE8uSkidixaS5pOrOcIP9kocEUT1+jfzMOotLZACMA6wA8k4xe57+L/exfCOd272Kwsg1w7EvFfkPgG6KXYk7zkV+CknNI6Z+syN2Zu0BYsHUppaO+8NCmYkDFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743691078; c=relaxed/simple;
	bh=KzdvMdJvzfoPtWfGMklgMIwB6uxI3Ui9wSPF/fcsFu8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=meMkRVkMAtG5TXQD/zMIpsJwfHMq2JFmbTylIL1ZHzDGkXd3h5FpiQRUqUUMt3uypSexRj6CuJVWHHM4PaokiWFwUUlbkl7UYflMKOEA83cdqm7AnRYW1NOgRjeLa6wU7388Z9zRQzy+BgvVdCmihwVvA+4RIyPyqPpGOW5gHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FgCAugTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D22C4CEE3;
	Thu,  3 Apr 2025 14:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743691078;
	bh=KzdvMdJvzfoPtWfGMklgMIwB6uxI3Ui9wSPF/fcsFu8=;
	h=Subject:To:Cc:From:Date:From;
	b=FgCAugTGsX+fRkAFVW9m8/YoG8Kb3CUfU6v9c/sSEZnclq21pfZWfL4DP8fsRMHsl
	 U7Zv73ksj1++92zSdFrIkfq94drU/mQZvjE3Gs3zgrjgJ3v8dYiCnQqWFXoGOAHcqk
	 wgaD6xAIiYGUdXkuPgRZSwkEMvSUtbjECcPSLHMU=
Subject: FAILED: patch "[PATCH] tty: serial: fsl_lpuart: disable transmitter before changing" failed to apply to 6.1-stable tree
To: sherry.sun@nxp.com,Frank.Li@nxp.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Apr 2025 15:36:30 +0100
Message-ID: <2025040330-immunity-crouch-2b64@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f5cb528d6441eb860250a2f085773aac4f44085e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040330-immunity-crouch-2b64@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f5cb528d6441eb860250a2f085773aac4f44085e Mon Sep 17 00:00:00 2001
From: Sherry Sun <sherry.sun@nxp.com>
Date: Wed, 12 Mar 2025 10:25:03 +0800
Subject: [PATCH] tty: serial: fsl_lpuart: disable transmitter before changing
 RS485 related registers

According to the LPUART reference manual, TXRTSE and TXRTSPOL of MODIR
register only can be changed when the transmitter is disabled.
So disable the transmitter before changing RS485 related registers and
re-enable it after the change is done.

Fixes: 67b01837861c ("tty: serial: lpuart: Add RS485 support for 32-bit uart flavour")
Cc: stable <stable@kernel.org>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20250312022503.1342990-1-sherry.sun@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 91d02c55c470..203ec3b46304 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1484,6 +1484,19 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 
 	unsigned long modem = lpuart32_read(&sport->port, UARTMODIR)
 				& ~(UARTMODIR_TXRTSPOL | UARTMODIR_TXRTSE);
+	u32 ctrl;
+
+	/* TXRTSE and TXRTSPOL only can be changed when transmitter is disabled. */
+	ctrl = lpuart32_read(&sport->port, UARTCTRL);
+	if (ctrl & UARTCTRL_TE) {
+		/* wait for the transmit engine to complete */
+		lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
+		lpuart32_write(&sport->port, ctrl & ~UARTCTRL_TE, UARTCTRL);
+
+		while (lpuart32_read(&sport->port, UARTCTRL) & UARTCTRL_TE)
+			cpu_relax();
+	}
+
 	lpuart32_write(&sport->port, modem, UARTMODIR);
 
 	if (rs485->flags & SER_RS485_ENABLED) {
@@ -1503,6 +1516,10 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 	}
 
 	lpuart32_write(&sport->port, modem, UARTMODIR);
+
+	if (ctrl & UARTCTRL_TE)
+		lpuart32_write(&sport->port, ctrl, UARTCTRL);
+
 	return 0;
 }
 


