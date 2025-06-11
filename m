Return-Path: <stable+bounces-152391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA1EAD4A3B
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53015189D197
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E5C42AB4;
	Wed, 11 Jun 2025 05:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BMtWLQyp"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5980F8F5B
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618359; cv=none; b=oNURNUdWmf4nAv4Y0zQA3OiAOsIE2C6uD7XF1FDgVnI9AdCEnmijXNySQIDHZ0g38GYbe21MkZ5QwAPjYJpoSMLKWV4qr+NuEBKqPcvRMVqafqg/byWEHMG/Y/PNl3bYYUhBIHXLn2Ohb8cb2WiwwnLKGsxQuI0/G1zko6GvPIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618359; c=relaxed/simple;
	bh=PRbA6ABNk4mhnYVpjllzYL5T3Y8J07yIaUQYYsMnWVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blXDjtqYv3byedT6zqxaN+lXB5KWYrUpDX7lzgpIZEiGq8igFn+zQM1BSQXnV/ve0tVR/qbawFFiF+iVeIf+ZeOASFnynHEZ5ME3wTbB3PPzL5CULjzF1YdoxOTpwIHuU1UR+WNSLBQ3MTbPXkwn3MUZTOsIDhb70Mc/ECowCIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=BMtWLQyp; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad89333d603so1082530566b.2
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749618355; x=1750223155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wogNdthOOaAjVuT3Np0mFeo0ZfE9egaMgN4kDzzmDH8=;
        b=BMtWLQyp0AQeC+osXJxLz+6+l/re2D/lCriE1aJXdR6me6amtYVFg1ZiwoorHZoizA
         6TuND2fu2I0qjBPvLyoLCOPUB0R0PlgobFbQEuJXWlyiZerCdYI2j0hLQLEhO4/xwGb+
         o3YhKDPhhbP79N+6fJWJD5uTQvAlsCakqTdeL1HQyRCC+azVUGfacxQUNRx5rHTGIiiN
         rhSseaT2Th6wlit097sIso37ud/BHm8CuXLE44N86YQeb8EXYNBPsdm7T4/o6C5QOCKG
         gB6Z3ZMQVJWj2pSgHif1SSGhrFqjh7etbP6n9fYPFi48WN9v9YT4PzchAyDlfg7rcyeh
         RLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618355; x=1750223155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wogNdthOOaAjVuT3Np0mFeo0ZfE9egaMgN4kDzzmDH8=;
        b=CUj9jgOYfq1fcb/0WehmtYB61NH5imduvaN75KDbtP25adLRYUZKJrDuGdRvG0Vt95
         04xalkIXvTiZLS4ECh0o8/6AQ+6Rfu8WAke6Jj4J8KEanTvFXyG/WmCfKMJi7Tnxpw/A
         Wf4hefPOQElrjst/BRqyrTS2XOgrkqhTDy+Nl6ZtfHjWJWkGXWEU/8GMlluZTSd3bDqU
         OaqkM4ec7k5Gl7GqUEXysg1PahhAApyM/0mvjOJPwUlVGc/9eafC9VOKTBraeAojl7Or
         TET3Yei5drM7wqZKCyQ1tHEhY0irAyX4Q0EdcA+Ogv/RK8yuPDtqmzMxneL35ZTG4JQ9
         n7ow==
X-Gm-Message-State: AOJu0YyAmVI1ZOfHh+v6U4zgRKLs3ppxLlIO3yJP6w3BpH+EFWozAX4b
	aNaDFwfyMexcbZMO1Xp3chCV3A1B1KQdqq09bJo8cBlVdUaVnpA7bph0K5+BF7N3xoeJ50tJQDb
	z/jRB
X-Gm-Gg: ASbGncu73+30mzGpeuxhpp0tFXixQdyLUIweWZJ900DTbsuvkA0lyjE/VMh/drqL/SB
	KJop90FBPy9siT8IqJc3JvgI5JJ2GlQ0QcJKq9pQJJLxwaVJqkQWyhHIwpLT3TNxA3Ezl8TdK63
	i4AluGB9W9EqPcjR/eIGU/sJsEe4k/og+Osq7i08cFc98hOzKHL9fYQnd4ojXAxEOsZLRORdoIR
	Yi5O1c0ImRB6Ei09swMle5zuxpBZruzqgXNw2OLzvsn69ea8Iq7LZ4qw9RvtCqaPO0vW2z0oDhY
	ylzQWHxaiQVe1MG8m9yVSflhETZG1sJzGkVyk4i2K/AxpDEkdYIK2rf0KmXwUV7gYhxa06s27g8
	B35P+kPXycGoOg698
X-Google-Smtp-Source: AGHT+IHYi1To3oed03Ymu8ICTA1tlON0KgfcOz0hWZMdYlWD4ASkPPtBpIKbJ1M0yzK2H6VbHAEmvw==
X-Received: by 2002:a17:907:3d4e:b0:ad8:9b5d:2c1c with SMTP id a640c23a62f3a-ade894b77edmr178980266b.19.1749618355358;
        Tue, 10 Jun 2025 22:05:55 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade3c427cafsm675513866b.75.2025.06.10.22.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:05:54 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 6.6.y 1/4] serial: sh-sci: Check if TX data was written to device in .tx_empty()
Date: Wed, 11 Jun 2025 08:05:49 +0300
Message-ID: <20250611050552.597806-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611050552.597806-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250611050552.597806-1-claudiu.beznea.uj@bp.renesas.com>
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
index 4350a69d97d7..bf77bf8f5a26 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -157,6 +157,7 @@ struct sci_port {
 
 	bool has_rtscts;
 	bool autorts;
+	bool tx_occurred;
 };
 
 #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
@@ -821,6 +822,7 @@ static void sci_transmit_chars(struct uart_port *port)
 {
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned int stopped = uart_tx_stopped(port);
+	struct sci_port *s = to_sci_port(port);
 	unsigned short status;
 	unsigned short ctrl;
 	int count;
@@ -857,6 +859,7 @@ static void sci_transmit_chars(struct uart_port *port)
 		}
 
 		serial_port_out(port, SCxTDR, c);
+		s->tx_occurred = true;
 
 		port->icount.tx++;
 	} while (--count > 0);
@@ -1213,6 +1216,8 @@ static void sci_dma_tx_complete(void *arg)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
+	s->tx_occurred = true;
+
 	if (!uart_circ_empty(xmit)) {
 		s->cookie_tx = 0;
 		schedule_work(&s->work_tx);
@@ -1702,6 +1707,19 @@ static void sci_flush_buffer(struct uart_port *port)
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
@@ -1711,6 +1729,10 @@ static inline void sci_free_dma(struct uart_port *port)
 {
 }
 
+static void sci_dma_check_tx_occurred(struct sci_port *s)
+{
+}
+
 #define sci_flush_buffer	NULL
 #endif /* !CONFIG_SERIAL_SH_SCI_DMA */
 
@@ -2047,6 +2069,12 @@ static unsigned int sci_tx_empty(struct uart_port *port)
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
@@ -2217,6 +2245,7 @@ static int sci_startup(struct uart_port *port)
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
+	s->tx_occurred = false;
 	sci_request_dma(port);
 
 	ret = sci_request_irq(s);
-- 
2.43.0


