Return-Path: <stable+bounces-152376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAA1AD4A26
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7238C3A5E02
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAC61F0984;
	Wed, 11 Jun 2025 05:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="iRbXWp76"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B698F5B
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618061; cv=none; b=mI+G4lNHUxikR+BmCObnQJ+lDllA1WG/+G7v2O+mDRVCPk5xsSExSYN2uue44lIVmcUfDfXTOlxlQuTwy809afdFWqU4Fw+Wil3Txlps1bWn1q3SWkqKpnHiIzlunSWVb4nEU5em5QbVb4MCzMorP0LDajqqst9x+CvM9PMQrZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618061; c=relaxed/simple;
	bh=hiOhyq6CBXQpyUWslkcCRrzPgZtbTTDaytFPkcHarZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qa3ygSapGWkbLJ49OtFXXBIFeIwm+SRSVTp++Ym58ckYRNG426Yfk6hwStVtqSvK3QJjmvkjXWfyM5pyqGA35MwoTsNcvSe78CY9y/JxPMGV0xBV/M7+8q1S+6vLb4E1BiRpz748T/Nz2iy9k/H79RYNIsv7EjIIp8X6ZDH5ekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=iRbXWp76; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a376ba6f08so3451710f8f.1
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749618057; x=1750222857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ses629eDe4YU/TJyXbFlkXH8Cod5VqNUsMhaFtcJvsw=;
        b=iRbXWp76ontVV7piW83zp5qTNRtbqgLt6rE45phE8+TPcgBrUWuVzupuQ7azSzOHRe
         hncF/QOTlqvdGP3rH6SYQ+lvEuhKACZfdMUcgtQ0xCoarCr4FErnXnRyOWHbJUxNV0xR
         9Xsp1PIHJzhPCrjBY86/rtvDy6JRAXS2sKWBqHOlUGdIQQ4Y3w6EiuZD01i7NQk+b+rC
         h7JkeiorpYKIs+X+O1s31KyGtF1nUYpD4K2rh0yfzdHADdKijz6+o3c9flk5V9veO/oj
         ESM8l/Fj+X6/l+7BwdwBn+pYXzw0D8AbKUCmgbKC3iWAavMXeVvcm+tX9BnUU5cSfdiV
         0NaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618057; x=1750222857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ses629eDe4YU/TJyXbFlkXH8Cod5VqNUsMhaFtcJvsw=;
        b=fQK7tI84RPgo4AcnUcdpcOpNIag/UnCWcmXIe8JvNHlYFEGKmlXStSkJiAATvg/gDy
         SoEWoepAJkSWvLXhgT5LXLlsdvogpemaD0PFzuaP2H+1gp30RrSlOy/ZOyAEoTgwcE9m
         y0F7nNISUpNJnFSdheOkjYKu6EqlYGsrXNbzzA4MrBREzCUqeyUnkJFIQUEQLLOOpyDo
         2X5FuGygCnk5ukFvEjTvz5ZWm5xkZqj7/wyY2CcSgmVfnu6MuA+y14unhJe2XTX71QPg
         9SyNfYkjzf5CquTvkheSj3yok/crGzjoKPsACmMiwlzK4azOL78SOaZyyUXgoYRQtfEC
         VjSQ==
X-Gm-Message-State: AOJu0YwIvbdt0GEV9g3TR+1FhKN7Dkhi4kQb4rcwS5bEIgvmUpWZV0WX
	0a1ZayQJZ7UizPrK3mkvBOKa4ME79Z6rqkdfCkkadHZoDkBYpqDSHv+gXEsDC5FJHrR+O2Ayjpc
	6SQ1w
X-Gm-Gg: ASbGnctjknwZ/f5Cq6l5eecatm4Beb2SuirvowFiymUh1Ut9QHLxGnWYJtnFl/Qs3/D
	xEtdvxV4HOZPlONVxaT48a7oQRug1MKnIuIs+7zbI17nxh2kX/IlRUGmlffgS3u/XRsm91HHV0L
	GTIw9nDmMPrh2lSFJ3kOgn8VhuGWi8MHAki76q6TFn6AZ1sP78P8uOEY+NDjrUxibMZqSHYV8G/
	TrvHbLVRiKteEuNLdzYDOk0KGh2/++k0AkG1+RRduhlhiYd1G3tvQjcLI+5Sk3rsPbGNIg2mcjC
	KjQIfPe4zQwdrJ16IhyjJLl1AxhKHpfhh3fTj8rm5A6nTGCeZg6M/i/V7Gm/5hXd9lFNgJ2shmO
	+yPTo/S7Z6UU8J6dz
X-Google-Smtp-Source: AGHT+IEbmM8lV3IT6IO9T6munVSm1DAL8xdRgIfx3hV7qdm+/26m1tVSQHYQ6W2RN/dYcT2UoEYSZg==
X-Received: by 2002:a05:6000:220c:b0:3a4:f70d:8673 with SMTP id ffacd0b85a97d-3a55881dc3cmr1076334f8f.25.1749618056682;
        Tue, 10 Jun 2025 22:00:56 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532464e3csm14252044f8f.99.2025.06.10.22.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:00:56 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH RESEND 5.10.y 1/4] serial: sh-sci: Check if TX data was written to device in .tx_empty()
Date: Wed, 11 Jun 2025 08:00:50 +0300
Message-ID: <20250611050053.454338-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611050053.454338-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250611050053.454338-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 7cc0e0a43a91052477c2921f924a37d9c3891f0c upstream.

On the Renesas RZ/G3S, when doing suspend to RAM, the uart_suspend_port()
is called. The uart_suspend_port() calls 3 times the
struct uart_port::ops::tx_empty() before shutting down the port.

According to the documentation, the struct uart_port::ops::tx_empty()
API tests whether the transmitter FIFO and shifter for the port is
empty.

The Renesas RZ/G3S SCIFA IP reports the number of data units stored in the
transmit FIFO through the FDR (FIFO Data Count Register). The data units
in the FIFOs are written in the shift register and transmitted from there.
The TEND bit in the Serial Status Register reports if the data was
transmitted from the shift register.

In the previous code, in the tx_empty() API implemented by the sh-sci
driver, it is considered that the TX is empty if the hardware reports the
TEND bit set and the number of data units in the FIFO is zero.

According to the HW manual, the TEND bit has the following meaning:

0: Transmission is in the waiting state or in progress.
1: Transmission is completed.

It has been noticed that when opening the serial device w/o using it and
then switch to a power saving mode, the tx_empty() call in the
uart_port_suspend() function fails, leading to the "Unable to drain
transmitter" message being printed on the console. This is because the
TEND=0 if nothing has been transmitted and the FIFOs are empty. As the
TEND=0 has double meaning (waiting state, in progress) we can't
determined the scenario described above.

Add a software workaround for this. This sets a variable if any data has
been sent on the serial console (when using PIO) or if the DMA callback has
been called (meaning something has been transmitted). In the tx_empty()
API the status of the DMA transaction is also checked and if it is
completed or in progress the code falls back in checking the hardware
registers instead of relying on the software variable.

Fixes: 73a19e4c0301 ("serial: sh-sci: Add DMA support.")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20241125115856.513642-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[claudiu.beznea: fixed conflict by:
 - keeping serial_port_out() instead of sci_port_out() in
   sci_transmit_chars()
 - keeping !uart_circ_empty(xmit) condition in sci_dma_tx_complete(),
   after s->tx_occurred = true; assignement]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 26c5c585c221..f598135ea75c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -157,6 +157,7 @@ struct sci_port {
 
 	bool has_rtscts;
 	bool autorts;
+	bool tx_occurred;
 };
 
 #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
@@ -806,6 +807,7 @@ static void sci_transmit_chars(struct uart_port *port)
 {
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned int stopped = uart_tx_stopped(port);
+	struct sci_port *s = to_sci_port(port);
 	unsigned short status;
 	unsigned short ctrl;
 	int count;
@@ -837,6 +839,7 @@ static void sci_transmit_chars(struct uart_port *port)
 		}
 
 		serial_port_out(port, SCxTDR, c);
+		s->tx_occurred = true;
 
 		port->icount.tx++;
 	} while (--count > 0);
@@ -1204,6 +1207,8 @@ static void sci_dma_tx_complete(void *arg)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
+	s->tx_occurred = true;
+
 	if (!uart_circ_empty(xmit)) {
 		s->cookie_tx = 0;
 		schedule_work(&s->work_tx);
@@ -1686,6 +1691,19 @@ static void sci_flush_buffer(struct uart_port *port)
 		s->cookie_tx = -EINVAL;
 	}
 }
+
+static void sci_dma_check_tx_occurred(struct sci_port *s)
+{
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	if (!s->chan_tx)
+		return;
+
+	status = dmaengine_tx_status(s->chan_tx, s->cookie_tx, &state);
+	if (status == DMA_COMPLETE || status == DMA_IN_PROGRESS)
+		s->tx_occurred = true;
+}
 #else /* !CONFIG_SERIAL_SH_SCI_DMA */
 static inline void sci_request_dma(struct uart_port *port)
 {
@@ -1695,6 +1713,10 @@ static inline void sci_free_dma(struct uart_port *port)
 {
 }
 
+static void sci_dma_check_tx_occurred(struct sci_port *s)
+{
+}
+
 #define sci_flush_buffer	NULL
 #endif /* !CONFIG_SERIAL_SH_SCI_DMA */
 
@@ -2007,6 +2029,12 @@ static unsigned int sci_tx_empty(struct uart_port *port)
 {
 	unsigned short status = serial_port_in(port, SCxSR);
 	unsigned short in_tx_fifo = sci_txfill(port);
+	struct sci_port *s = to_sci_port(port);
+
+	sci_dma_check_tx_occurred(s);
+
+	if (!s->tx_occurred)
+		return TIOCSER_TEMT;
 
 	return (status & SCxSR_TEND(port)) && !in_tx_fifo ? TIOCSER_TEMT : 0;
 }
@@ -2177,6 +2205,7 @@ static int sci_startup(struct uart_port *port)
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
+	s->tx_occurred = false;
 	sci_request_dma(port);
 
 	ret = sci_request_irq(s);
-- 
2.43.0


