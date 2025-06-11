Return-Path: <stable+bounces-152386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC95AD4A32
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A92D17AAEA
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBD514B945;
	Wed, 11 Jun 2025 05:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="q5160NVd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4B2224B02
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618324; cv=none; b=blqNUlC5U3ahMA2pDwHEljTLUrS8P9ZjYO9rhSorpWhyG/H9fH/F9BOxvez+UXZUJcx5vH3u3LHNtDfQs+y5XXFD+es0Xxf7k56+PF1/Z24k7rwBoua2vupIfreJBJ2JWQg0ZtkDdP9QIZZHxyJEXRaqVYXUT20XFZBnodRc0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618324; c=relaxed/simple;
	bh=DlzdcA+s1Ip6Wv/t76Wzr7pk6xqKKAQF/eg3G+c0HP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlQWUf+0TDrhXsFjAe1tTZMry1v8SGYv4WohjQiBH0fK7ZTmHx3uufQzJ1tuSFHmynTah9lOxKQivXwQXG3jbiKyhwd75yTu6nmNbNd+cZCPJ6NuEFVUWzu0zbZTuNUikp2qBtndExe2KsORTZ1ekoRJE/w3AoYyEFxFpOrs/H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=q5160NVd; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60702d77c60so12206562a12.3
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749618321; x=1750223121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6p4wUI922406CuHIPAxnqh0B4wedlAevyXD6wryZHVA=;
        b=q5160NVdp2SwoBFJMZNo3yu9LaCpKnrr06I9qqmsV31fq8dUo93SX1hrk/ieETFCGP
         ejetDgCbeSNCnyYPfqro+ufhT+ajTGmgp62xVfaFkmQyM7tJ8xTw6TYY1lrONLdVQ50E
         fI8VkUA2ivbdvJaX9ZQTgb9oguwbGRwkaEkANiGJgl6/i7CVq9AHJdNRIuVanQXmfuAV
         WUeCsHx4lbKSOQle7yTuh+H3qiTGnebOngMTj8+/Jhz8jKZ7uWvshMuQ+6Ih8/emXHQ0
         YInGF5vQc6hfzj+y8J4z8f/qt/UBJXwOXPJpXjhoLEJJSLjYi2ZF6cyg9kGq3i2K5O9y
         aZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618321; x=1750223121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6p4wUI922406CuHIPAxnqh0B4wedlAevyXD6wryZHVA=;
        b=kcJguWO6tS8uHXoiQzl/asnCDJaNYK7yAc6NyLLdG/83emTRfisalNLz9xwQFmWked
         KF4HtQ7rYr3yGI4e5jfnoF53QAs5ai2/gZYGo2nPmaDLzEzLtu1nFMm9kRpWvuz0mvRL
         9J7U8eRny80I3mwNezlvBFwYtncdcWH8Q0LJ+0PEtRsWTR1w62OoH5Tn7jWpzbDhMDwf
         JTNY3iHqe9lPE814u3v/T8l4ZJLtATCalqOw7tYF/SCIKY/xqFpLCOpE35AszYt1gVEh
         8rmmo27j+bWy7AaK94MVCz6a6qTLtq/1GKrMfCT13NMGCtXVdPQAmLH2CX0Jdlw3j9DW
         Oxyg==
X-Gm-Message-State: AOJu0Yy7IBU1V/niKDYNjiX8fx0KuxbLe+cQKvWaI8ESJOrS0o1SWJAx
	P09q279AlsSylv8fUDOg8jnx89CbzPQeyS9b5ajjQjXaY8vzVgk+g/uzQl0/FFzJUkE3u5ge8yp
	YFXAl
X-Gm-Gg: ASbGncscGQTsnx/fJ19srLoCkltBIGAhnGC09Anf5K+pGV5jvkSE6wjf2oWIFVfXS+j
	yFnUtydG7l4F5bblDvvQLS+OQyR09ZrUOmW91zgGTMqKddHVjnY+9dKZUqR/I+a2g7qNcw8IBgB
	vNmnB1L+ZdWWiCfM4PgL/FTKWBICfUuo4zhqc0WNXL/Nrvb0GUYPUqZXLYbJoMWjjYJVs50KXh+
	ADfkZTyJzGeZ3ITdie/BXD3AWIjx+yWbpJ6zMpMOg/spSwypTrt77uLON2JaV8+NEhKKEtC6wow
	ittibRa26T0ryqJj1Ks+rSYJSiVdI9pLPUgDk8DzePuxdYb5XL/2lffGutZCcZXIxUcdIZt1TaC
	DlJ+0nF5eARCOu4kP
X-Google-Smtp-Source: AGHT+IEy+LxcPW+pROuzZFaTxW2C0axalT4pear1X2K+mZxDaD8m7Px1Ti3QlYruMxmdZeht1RjJaQ==
X-Received: by 2002:a05:6402:354d:b0:601:f4ff:c637 with SMTP id 4fb4d7f45d1cf-60846c0af8dmr1542646a12.16.1749618320820;
        Tue, 10 Jun 2025 22:05:20 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783c04f9sm6961577a12.52.2025.06.10.22.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:05:20 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 6.1.y 1/4] serial: sh-sci: Check if TX data was written to device in .tx_empty()
Date: Wed, 11 Jun 2025 08:05:14 +0300
Message-ID: <20250611050517.582880-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611050517.582880-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250611050517.582880-1-claudiu.beznea.uj@bp.renesas.com>
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
index 6182ae5f6fa1..4e00dad52593 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -158,6 +158,7 @@ struct sci_port {
 
 	bool has_rtscts;
 	bool autorts;
+	bool tx_occurred;
 };
 
 #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
@@ -808,6 +809,7 @@ static void sci_transmit_chars(struct uart_port *port)
 {
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned int stopped = uart_tx_stopped(port);
+	struct sci_port *s = to_sci_port(port);
 	unsigned short status;
 	unsigned short ctrl;
 	int count;
@@ -839,6 +841,7 @@ static void sci_transmit_chars(struct uart_port *port)
 		}
 
 		serial_port_out(port, SCxTDR, c);
+		s->tx_occurred = true;
 
 		port->icount.tx++;
 	} while (--count > 0);
@@ -1191,6 +1194,8 @@ static void sci_dma_tx_complete(void *arg)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
+	s->tx_occurred = true;
+
 	if (!uart_circ_empty(xmit)) {
 		s->cookie_tx = 0;
 		schedule_work(&s->work_tx);
@@ -1671,6 +1676,19 @@ static void sci_flush_buffer(struct uart_port *port)
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
@@ -1680,6 +1698,10 @@ static inline void sci_free_dma(struct uart_port *port)
 {
 }
 
+static void sci_dma_check_tx_occurred(struct sci_port *s)
+{
+}
+
 #define sci_flush_buffer	NULL
 #endif /* !CONFIG_SERIAL_SH_SCI_DMA */
 
@@ -1992,6 +2014,12 @@ static unsigned int sci_tx_empty(struct uart_port *port)
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
@@ -2162,6 +2190,7 @@ static int sci_startup(struct uart_port *port)
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
+	s->tx_occurred = false;
 	sci_request_dma(port);
 
 	ret = sci_request_irq(s);
-- 
2.43.0


