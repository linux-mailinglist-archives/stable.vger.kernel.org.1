Return-Path: <stable+bounces-150673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4FFACC341
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7103A5916
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 09:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2472820A7;
	Tue,  3 Jun 2025 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="W3B9Lcq5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87422698BC
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748943428; cv=none; b=XYefEQCDyzVhPx0yVlaRxO6ER+fKR9+YSLaOXbSnaclKMS1G3O3bEf9CGLVpq+KtG6a6oafcOTERMu/OSgvHiYpFKFJ4gxr8+lwnBWpKGrCGqPGeqBU+Vhp3PXyBKgDUJNWj2BvTO7GMWzMDKLOR/KS4cweoY14DO3hc/+u171s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748943428; c=relaxed/simple;
	bh=yLCVdh/VNjIohEH8eeKodoO94S4S9X7bjIRhiaGCmrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rd9uNINEZSE4Ejz2Z7Av43S2rO2qqjvn4h///qG9Wb0vRaWn8l2mty6DIAtLnOLU4NlFcfeXXtJ5Po1mAPCYEVsz8m/3vpsT5XGvY8DCBElld8+go77XuuFDiqsR7gAzMb7V7xicUpEYSPTE7/Rka5oEUEIbVtQ6TDKV/AoVMLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=W3B9Lcq5; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6049431b0e9so8734759a12.0
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 02:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748943424; x=1749548224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+mUSFz8pGFj3DcCHlpX/L5pP3F0tiLGbqoZpS4VKVs=;
        b=W3B9Lcq5OywcSWREoISY6MXDaJ0cKyHNc64m//HtRp1CJSPmCQFv+LrANatUhfJKZ2
         zqLQbsL8oE/cqFNa8ZIvQQieKnFweRiCDoXrZDHzwFxvhB00/HMLO9ZaGT5w92PQe71w
         RotvoWur5Fj6To+W3nfliO22NZVHnlGIEzzdwcP8p9/OpB/D5oN9XqnKoIQW9Q/Yjl1i
         IFf88i4eppBkhTgC8hg0PbbxU+bQDuOxLI7jzj0yCjDeBQmzuNkhrNhPSfH4QbsDH6yd
         fsleugI1TODeIu8TR30I2VNWHhkHcvovGCZ1zplkRkSCSKFMV3O1evyCZ0HkGs5Z2e10
         wsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748943424; x=1749548224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+mUSFz8pGFj3DcCHlpX/L5pP3F0tiLGbqoZpS4VKVs=;
        b=kX+GgWFMAXf+G0QGEQnN1GjUIRd7M1yMry9SW/kkXcPVdcgUXTnDRVj/4s1EPedf2d
         lcqO9kk++lTqkiIv39BywtK+XD3zSguKKpt+vV0N93ZpQa15AojqH/ZGPxwk74rjA5+a
         mbPS9ItoXeXbP3S80zcH5eDXywbT2aQq/72hWpEhWDps9DAUS3IcDAisYJHK5pW8P+tW
         OZnqJu99WMNS+yoTeMEeYL760dIS0Sc4Yg6QXV12lW8mcUYHgWxMzujvEjBcj/OgXBHc
         iTwYBh0t4GWv7e5VwoL0T/xi+eniZkDSGWPvCeE9LOFhqeWv5JC+5jpCi7r4NH6R9s5c
         WvYw==
X-Gm-Message-State: AOJu0YyQVqMSNLzwrQbhLgE/cRuEihdfWuM32ElZ+JTmHrRiyyFdRuBC
	LZHAHndNKWHe10WAv/j25kt4flRaEHsODbTRvLz6fMogHA9YKIfRlmWG6i5pLKrmJzjPs7QAXTk
	JaQGY
X-Gm-Gg: ASbGncuxEbfZzqkNET7ovrOn6L6sCPEcB+f9iC/KjTKdTeQlFIIUnOF6JKImDNEP870
	q13df+LUYX8JuPHTK1j/pxse7+XPwaAZPKfqt0Wa262kTphm7wd4Wg1hY69pn0LGnTgwa0k2igA
	8JAkPqYNbC+NjG400oCmWswkOa5lV/dnifpvjb/RfaMroBHndUtPbEhPlmN2hj013N0Oi7gguRr
	8DYIBhtmifTvZI4hVD7wYbmImPRJ9cqa6Twa9IWO46vUQbw53FY0bI73SuyvWnUkGzzNxUGuLTi
	hsvKSrrAk0MBy79JiMgDfztVyygXY0DDJaI7eeOnj5olEo1YAiRy8AFN7trjB0PRInUh/61VCTY
	MSm+L3w==
X-Google-Smtp-Source: AGHT+IEYhzPlGyQ+IFczPmQgiTR/PlWArBMyzqYiDPkLLDDVuyZfrB3yK9GF5sqoXWxK3L1EoZi3qg==
X-Received: by 2002:a50:f69c:0:b0:600:2af6:d942 with SMTP id 4fb4d7f45d1cf-6057c3c1cbcmr10573624a12.15.1748943423760;
        Tue, 03 Jun 2025 02:37:03 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-606af7bafedsm779334a12.57.2025.06.03.02.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:37:03 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y 1/4] serial: sh-sci: Check if TX data was written to device in .tx_empty()
Date: Tue,  3 Jun 2025 12:36:58 +0300
Message-ID: <20250603093701.3928327-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603093701.3928327-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603093701.3928327-1-claudiu.beznea.uj@bp.renesas.com>
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
index 19738d8a05e1..bdb156d4ac4d 100644
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


