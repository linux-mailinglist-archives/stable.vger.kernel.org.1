Return-Path: <stable+bounces-90112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970B39BE68D
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5523C282909
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A6D1DFDB3;
	Wed,  6 Nov 2024 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ap9JzklA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BA51DF98B
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894497; cv=none; b=svKFAL8rNqo5PRaA9DYMBjmRlmrtfjfFhPdUsab1zf2X0YcVl83z9IaGGeMWx7VaeI7M0Xcbnouv/f8fcBxwe6xZb0+eVUDMBgrdvC3nDB/IQHZ+gWPOh3i7RkIkqFMRFHAVhd2PPAE2KU/s1UWTCT6fk38BUww/0MDFUI6dK7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894497; c=relaxed/simple;
	bh=Lh8DevTbvanScGSPN6SnkhvaV5yCyT7xZvKsjN0ZrgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KPk//wb8T1Wt8M5CppPxHdNd5agdCKQYi/JeQZbhFc3CNi15Dz71SAshpfqbuwnKVvmkdk366rYM7b1MXeKBiNz0oUYikqxIRpwud2jQoiBlJmaffhDAL6LaHKPv90IOUyyUrZCXEuUTsx1KTZae/mN9ea3SXNEvANVOCLMkUcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ap9JzklA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so8754475a12.3
        for <stable@vger.kernel.org>; Wed, 06 Nov 2024 04:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730894493; x=1731499293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuQQ9nuz/fv1v5WB3vsq3Ar711CKbKh3RUk1VzcE0FA=;
        b=ap9JzklAFb9pgRzo803oF6Qz//6IYMmJvTmmaNz3F+adaTpP/KJaIhrlsZlkSRThXU
         DcsB04OiJxK0RHvM6ED2WxasoKhwiXIKg/sO7K8h++fc7ji9cr4thdk6ZUQq5Xwd6eYb
         IctsJiFDtB/1o7mT82Iagl2zhxFusOz7Ag7ZgEQ2M6XZBaqhqUnVItjn1BQONqh5nNN1
         HIxhJF65A1HaPCW/hkKHROAA5nHRbHi2Qg+AU9Q5rZG/LhvHaryq2PcZj3WFr8y+P7Th
         lgo9pGAa4E+F0dxQUO0jb5FTE3j4WVNvTAyrMA7Sg2rJfMFzY3kCiNSBXVZXd7bqDcfg
         Cb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730894493; x=1731499293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuQQ9nuz/fv1v5WB3vsq3Ar711CKbKh3RUk1VzcE0FA=;
        b=uonOf26aLMlFZNalqEKJa69iT5X7eXla96ddfj9TENx6RRSYP1dIxYyRlRn9ocxVPy
         d+Z/M/i7CVfof0N0T/HIIkvcyTSDUhOGlvvG0CqLJYQ2bB/SoGonqljWv/7qtzqg93m3
         XsYUwryFrRBGW4tZH3s02RVDV5OcSDKmjgXxiavqVVCn5P0jWH+cRfjOCIXIIyFGVNfm
         qvWVGcp0YXc+QatLy5mYCyw0mn6DhxY6SVEIR2rjJ/yYqVxdic4QWqeNHXDrH/aHEGIV
         siXhpUK5CTDFQSvIashyJfyBi/jb72nTYiYC2GlXIpA+8ZkIxWOZyUv4KV9FNL+lpTIv
         zQdw==
X-Forwarded-Encrypted: i=1; AJvYcCWtnSjzTfzGUdATrBzvdQ86+L0bu5vm1FBkKZsUbTdbYl2kOAHGU6wVgU0ZYkGqc+vxaKPXNLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDBVd/k2SdG4VFQJQcT5d3yjHSxO2eWVeA1xhwjhh1EUs4fErS
	ohSPqv5eYkaWKPSZVTlISs/m1SoJv7fuqVWK3RFk4nTR5hQBn190g75YQV7CYpU=
X-Google-Smtp-Source: AGHT+IHtx5Uc49jn/5rFDtZbXkQTqsz1oLlOj01V707XR4uAHqys9j21kgOR3dB2dECT7Z2GpaF6/g==
X-Received: by 2002:a05:6402:348e:b0:5ce:fa13:2630 with SMTP id 4fb4d7f45d1cf-5cefa13273fmr591343a12.33.1730894493047;
        Wed, 06 Nov 2024 04:01:33 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6afe528sm2697984a12.55.2024.11.06.04.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 04:01:32 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	p.zabel@pengutronix.de,
	lethal@linux-sh.org,
	g.liakhovetski@gmx.de,
	ysato@users.sourceforge.jp,
	ulrich.hecht+renesas@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/9] serial: sh-sci: Check if TX data was written to device in .tx_empty()
Date: Wed,  6 Nov 2024 14:01:11 +0200
Message-Id: <20241106120118.1719888-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241106120118.1719888-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241106120118.1719888-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

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
been called (meaning something has been transmitted).

Fixes: 73a19e4c0301 ("serial: sh-sci: Add DMA support.")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index df523c744423..8e2d534401fa 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -153,6 +153,7 @@ struct sci_port {
 	int				rx_trigger;
 	struct timer_list		rx_fifo_timer;
 	int				rx_fifo_timeout;
+	atomic_t			first_time_tx;
 	u16				hscif_tot;
 
 	bool has_rtscts;
@@ -850,6 +851,7 @@ static void sci_transmit_chars(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
 	unsigned int stopped = uart_tx_stopped(port);
+	struct sci_port *s = to_sci_port(port);
 	unsigned short status;
 	unsigned short ctrl;
 	int count;
@@ -885,6 +887,7 @@ static void sci_transmit_chars(struct uart_port *port)
 		}
 
 		sci_serial_out(port, SCxTDR, c);
+		atomic_set(&s->first_time_tx, 1);
 
 		port->icount.tx++;
 	} while (--count > 0);
@@ -1241,6 +1244,8 @@ static void sci_dma_tx_complete(void *arg)
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
+	atomic_set(&s->first_time_tx, 1);
+
 	if (!kfifo_is_empty(&tport->xmit_fifo)) {
 		s->cookie_tx = 0;
 		schedule_work(&s->work_tx);
@@ -2076,6 +2081,10 @@ static unsigned int sci_tx_empty(struct uart_port *port)
 {
 	unsigned short status = sci_serial_in(port, SCxSR);
 	unsigned short in_tx_fifo = sci_txfill(port);
+	struct sci_port *s = to_sci_port(port);
+
+	if (!atomic_read(&s->first_time_tx))
+		return TIOCSER_TEMT;
 
 	return (status & SCxSR_TEND(port)) && !in_tx_fifo ? TIOCSER_TEMT : 0;
 }
@@ -2247,6 +2256,7 @@ static int sci_startup(struct uart_port *port)
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
+	atomic_set(&s->first_time_tx, 0);
 	sci_request_dma(port);
 
 	ret = sci_request_irq(s);
@@ -2267,6 +2277,7 @@ static void sci_shutdown(struct uart_port *port)
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
 	s->autorts = false;
+	atomic_set(&s->first_time_tx, 0);
 	mctrl_gpio_disable_ms(to_sci_port(port)->gpios);
 
 	uart_port_lock_irqsave(port, &flags);
-- 
2.39.2


