Return-Path: <stable+bounces-131279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA2AA8093B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622BC4C4869
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42492276040;
	Tue,  8 Apr 2025 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kU83Yjtp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0677270ECB;
	Tue,  8 Apr 2025 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115968; cv=none; b=mHemvua3IOMljfQHGVHHWRQvOY8iQmatbnEQbTdg+tOTF63vwwAzGcfiHLRpc2JlouEtNjHEq3mgdnnvEnhNZ+NRoXg0AOWpP4KBtF0HR1Cr3+ptIDFg+0sHZOiyI4gjNtTb/Gk+uzPqliqZIYmURpdjYxNDtaE9kzPDxXlBjeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115968; c=relaxed/simple;
	bh=uSgovpjzsgwy/d4UzCE9SkrEcqhKcXdwUFrjl81/WXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QViY6m7avWQ1NuIFrI4w9Or08v+825HAjxFHFQNISGsqJsETrz7mh4yEzUv82k32M2Z5ews9LiWEQPBMF2QNNXhPFagkniL3w1PtUrECEGGBT3xvBrTByf13L7AhEUpFlBrMjtQoLGI5v7PXyPKSg/VttorJOSy9fvdX2KkAERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kU83Yjtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81788C4CEE5;
	Tue,  8 Apr 2025 12:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115967;
	bh=uSgovpjzsgwy/d4UzCE9SkrEcqhKcXdwUFrjl81/WXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kU83Yjtp3Tkpv0NPm34PPJ6Fe3N8awUwrpG60DOmIsao11/xSmH4hNC/2Kl8bif+R
	 /vMW+fGsz8o98HOAT56rZOy2p33uz7oiJP01YyToSvQIoH7z3z07DlSkX4ab8Q/HAP
	 Wqoks3ciA8foLQsObEG4A5q675LwfnU7wkgXTrvY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Sherry Sun <sherry.sun@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 172/204] tty: serial: fsl_lpuart: disable transmitter before changing RS485 related registers
Date: Tue,  8 Apr 2025 12:51:42 +0200
Message-ID: <20250408104825.364006188@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
References: <20250408104820.266892317@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sherry Sun <sherry.sun@nxp.com>

[ Upstream commit f5cb528d6441eb860250a2f085773aac4f44085e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/fsl_lpuart.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index e96354edff6e9..011f175936132 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1395,6 +1395,19 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 
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
@@ -1414,6 +1427,10 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 	}
 
 	lpuart32_write(&sport->port, modem, UARTMODIR);
+
+	if (ctrl & UARTCTRL_TE)
+		lpuart32_write(&sport->port, ctrl, UARTCTRL);
+
 	return 0;
 }
 
-- 
2.39.5




