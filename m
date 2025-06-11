Return-Path: <stable+bounces-152381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C6DAD4A2B
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1C417ADA2
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F9219F487;
	Wed, 11 Jun 2025 05:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="adJSX//1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC752AE66
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618098; cv=none; b=KFoceFMIDAUVZtlGUlJP+yOlU6EEpHXKwM5BymZoFuqFCNKeIXw+45/+/dA/JIsbciBGtXtmTDB6VvBGRj4gqbuFGKaIrYG83OkXxlGuTT4zqNVbHJaLy5BwKL5gwJ0EybtPMLENMxhh+1aweaMRea+dwT9o6OzmJ296OayyByQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618098; c=relaxed/simple;
	bh=NOdfB4WyFiDzhcwPmB+KflbMihmPtidy7hS+dC1Hl/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjIaLIJ7KwXQ58er07NrNIbdvEKroh9ykGBLW0+ZlDfp/6N+P33dmDu2jwiohGN5GeHpTbUeSFzrrFm42Yxtm8/yWrKjWqRyNqXxxrtK0ZV1uvGsJB0i3/ZdiZ8rQMm/pMK/T9kl8ib8rpcskykiVXlacDrdo0T2tR4lFjYu78E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=adJSX//1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a522224582so3795498f8f.3
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749618094; x=1750222894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8BkbNuRaErS9yLCOQrHmWkYgWizIIz9kKzhLu1y9Yw=;
        b=adJSX//1fawWSRDrtIY0bzYJ84Vj4uQIvhq1uJNWu3jGiJF/bNPDSwQSSSZZ53gyaN
         A+FbUvoxHkITtMp2OufmylAyfeODCBQyZUCIwX2xyUY5xU+/sg0EBqsdSjLIaNyUTqO0
         kpnZBvKlUi6o+FpWFSLRSeWWtUdi00CP37eX9TB70vD2AeFWJRlSKha294K7ciw0CdQj
         2QwAeETS7xX5EQ0JzG2d8wSY2ygOlwh+8TbKJ2H6LNwE2atHYMwl1zmrqVnDJmMVyZrP
         WgFzt+fS576JeZsKxts9DJb6xsgJhhh0MDbweRnIQ08uQjj+9+NvwbUUR9ETs7fe95HQ
         2J/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618094; x=1750222894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8BkbNuRaErS9yLCOQrHmWkYgWizIIz9kKzhLu1y9Yw=;
        b=gJD5ylU3nrlbvrLUWfuef0BnkvbATszriEX7pJ5dkUy1Od1uCo86Tj/wdqMx450UAz
         /iN7xkXQM9cCS8MpGCrgQWecuBQWOW1I72YninKJTgxN0d93JlVDML5XD3VqFTVX87Px
         PKsfTvdKc4JcyNCD6vOyZ9RcjJdglukWx2glnO/VMwPM3fHFgFmKL3vB9i8iJAOKFGIa
         LOImqRviqcsZN478VVHY6cDKRLcVBkOqp73KR941NhTLvgvRyPpHo635RRWv6zdyNjBt
         B0x+085yuXn5Z5x441mtrAnRt/N1zHKSA70IjtutWxkh9aRuhVfJrM+v7qZ60gWMwUAa
         tUgA==
X-Gm-Message-State: AOJu0YwMrxezyhe2FgV1iJ7CF8X3vCZzUAVDYO6LRtmMnYMzeaWrxj6v
	Ui8PRIU+SskzhetlkiwH8Tz7eK+6dPKmWzfy4XY949dxDGf4klx8vxk1svSUKIkyDsDGCmo4YqK
	hGfon
X-Gm-Gg: ASbGncuy9dgUutr8mV+sDcAI81gZy57mkGKIXn+qDztHr+lXqPMu7ToFYDoZdeOOvXM
	nI4EjssbPLjRE5wKjLqEQZ8ahbkdmw+zx2StWAZaWTizQdXLqXbtzZ0i1DkhSDeDY402CLc+8v2
	qpiZT4wB+kTQjvBPz6qLnhGoIsXLXkZZDkzE5PSvh35ApSBqUqrqMiSg6sQJd3/USDUn8B7hpyF
	nc9GHvKBVyd63on9C+z8jw4HIghGiFACUvMSnwaii08nZdlR0h6rU3IRDJ+Cn8XdJCVOiAux0kx
	4forlFkzUNO98uyDfyzUYMoVBQWqz4f1urDnlwPOiJdplox6sR9QCTiHBfWXPgREazBaJoWZLU3
	KtoGGjRN4ne9e1dQg
X-Google-Smtp-Source: AGHT+IGfDACXj0MvOIN3navdOHSKaxFbHg6Ier3QQk1bGxDOYVrdHAmRgoaoTvwGgFbVxNuQuGAFfg==
X-Received: by 2002:a05:6000:4014:b0:3a4:f7dc:8a62 with SMTP id ffacd0b85a97d-3a558629ba3mr1200316f8f.0.1749618094147;
        Tue, 10 Jun 2025 22:01:34 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532468360sm13885875f8f.100.2025.06.10.22.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:01:33 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 5.15.y 1/4] serial: sh-sci: Check if TX data was written to device in .tx_empty()
Date: Wed, 11 Jun 2025 08:01:28 +0300
Message-ID: <20250611050131.471315-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611050131.471315-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250611050131.471315-1-claudiu.beznea.uj@bp.renesas.com>
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
index eb9c1e991024..a276efa10319 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -157,6 +157,7 @@ struct sci_port {
 
 	bool has_rtscts;
 	bool autorts;
+	bool tx_occurred;
 };
 
 #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
@@ -807,6 +808,7 @@ static void sci_transmit_chars(struct uart_port *port)
 {
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned int stopped = uart_tx_stopped(port);
+	struct sci_port *s = to_sci_port(port);
 	unsigned short status;
 	unsigned short ctrl;
 	int count;
@@ -838,6 +840,7 @@ static void sci_transmit_chars(struct uart_port *port)
 		}
 
 		serial_port_out(port, SCxTDR, c);
+		s->tx_occurred = true;
 
 		port->icount.tx++;
 	} while (--count > 0);
@@ -1202,6 +1205,8 @@ static void sci_dma_tx_complete(void *arg)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
+	s->tx_occurred = true;
+
 	if (!uart_circ_empty(xmit)) {
 		s->cookie_tx = 0;
 		schedule_work(&s->work_tx);
@@ -1684,6 +1689,19 @@ static void sci_flush_buffer(struct uart_port *port)
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
@@ -1693,6 +1711,10 @@ static inline void sci_free_dma(struct uart_port *port)
 {
 }
 
+static void sci_dma_check_tx_occurred(struct sci_port *s)
+{
+}
+
 #define sci_flush_buffer	NULL
 #endif /* !CONFIG_SERIAL_SH_SCI_DMA */
 
@@ -2005,6 +2027,12 @@ static unsigned int sci_tx_empty(struct uart_port *port)
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
@@ -2175,6 +2203,7 @@ static int sci_startup(struct uart_port *port)
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
+	s->tx_occurred = false;
 	sci_request_dma(port);
 
 	ret = sci_request_irq(s);
-- 
2.43.0


