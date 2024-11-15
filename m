Return-Path: <stable+bounces-93549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ADA9CE07F
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 14:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA851F24C92
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7611D47CB;
	Fri, 15 Nov 2024 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qkQRBzjs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0250B1D434F
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678259; cv=none; b=VHgyphNUpZIFkYGTpAnf86k7Q9gOXJ4QRlF8ytZB+ixNQg+M8A6fHON/br6c7laio3eLLTKr8POirvOmvz/CrE1jVgTaionBcPWx+fjrDqG2Vfw/mMxi1Moh/BBiZY3j1NMCDqaHTvaaCWaoOfpwhizFfcEQuRvNKJTq6dhE9HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678259; c=relaxed/simple;
	bh=+KsWKchUufpoPCqQG4uoP+gjV/+ev+Z95Zo8TDMS2kI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p06/hzGdHt2h0nCUul+dTr2dCmYZAYCk6Yfu8CjnWVt09DBCZbe+E6dmKugH0w+qEIEeHW8lx1RLtvxwEbybCLxXK1hIrkQlojty2qRbeATpl6sxDERurZOQ6raSTUGjc+McL6nlzZHrP4zwhn/sfKTkbtFD6ombQswTgTbJobA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=qkQRBzjs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43163667f0eso14823935e9.0
        for <stable@vger.kernel.org>; Fri, 15 Nov 2024 05:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731678254; x=1732283054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iEdUECHFmk4I0P8OuONHc3S4huRYfPCWKtdoNW9iyY=;
        b=qkQRBzjsQDBZhPyKsArYJYMTPAyDHxJbIhqRXNhHDsQhqyXAtjG6B+rXXbIJ++um3O
         8UoAiB0O8Y9SDfDK4lM0ArASN5/mB2K1AHAC8123LFSVXgGFCI6/iyhzVW2202vLc4b1
         7XsY7KXJo6pq9MSb+3+NJxuUeqCrT71FmmIv3EfxB1jmLx1shumk6JSrNAwEi1qoXq23
         g52HaR0KutETH1C5q39MfUJnLkR88YDMkQQEK1vz00SHWMxnsQ3FGqAoM3xUbHqe3pg9
         HXg6mng0vBoQ1OPEf+gCuA0ZG0SGqG7e6FTpzz6lMQJVa5E3yFtQ3FuBe27kJFq5twn0
         NocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678254; x=1732283054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iEdUECHFmk4I0P8OuONHc3S4huRYfPCWKtdoNW9iyY=;
        b=TwaY8M7gA6/dkY5JmIQ0ABEOIaMLyuz3P/DT4DPV7wbx1Gbvp3hpDcTwBi4QYX0c2Y
         3544bWkMPudnUvwSFCLsRf2ZhPPbQYhZ3byJXYZC2In4buL+ARKrjdjp60AnfHRRtThZ
         BGibsnlxMuIW2wCWgQAk6DW+Yq7jNCWVK/JC4ZVMM/YQ1duJi4XyIutxTBLB7dLALENB
         mpIZPRH5D/vikyGw1ZtgoifoKiM8xDDyxzB4VScBBSLylmkrTKRdnw9MZ6s7JLMkLyIu
         aYjQHCnp0X0A+Z/TO0iJj17yLxzq13sevbTjuY6jlN4/ZkitJvkIeGGOf71MG4HPSR4U
         hw7w==
X-Forwarded-Encrypted: i=1; AJvYcCX27ZJC2jshdYF/v2kJmVP3M5ptEepnJMdXsOGiRpBUA9vBuIJuF5eS7eCW1+YZbRxImqyuqDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgzEh1IyVeehyFWLAux8k0ELRzM5914oM19JHQVKkjy3meG95G
	mgn1Q3h24aKacEAP70I4w+ttj83K5h2s0HpLbYAIDsJz1xsnxl0Bt/N9L741O1o=
X-Google-Smtp-Source: AGHT+IHREok9BoAyXyx6cs96noJtJb7OY9pRSi5wp/pt8MiabvddgDJ+Peg3bta54bxlDckbF5XiWw==
X-Received: by 2002:a05:6000:460b:b0:37c:cc77:3e72 with SMTP id ffacd0b85a97d-38225a86684mr2136074f8f.33.1731678254355;
        Fri, 15 Nov 2024 05:44:14 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada3fc9sm4378016f8f.20.2024.11.15.05.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:44:13 -0800 (PST)
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
	g.liakhovetski@gmx.de
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/8] serial: sh-sci: Check if TX data was written to device in .tx_empty()
Date: Fri, 15 Nov 2024 15:43:55 +0200
Message-Id: <20241115134401.3893008-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241115134401.3893008-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241115134401.3893008-1-claudiu.beznea.uj@bp.renesas.com>
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
been called (meaning something has been transmitted). In the tx_empty()
API the status of the DMA transaction is also checked and if it is
completed or in progress the code falls back in checking the hardware
registers instead of relying on the software variable.

Fixes: 73a19e4c0301 ("serial: sh-sci: Add DMA support.")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- s/first_time_tx/tx_occurred/g
- checked the DMA status in sci_tx_empty() through sci_dma_check_tx_occurred()
  function; added this new function as the DMA support is conditioned by
  the CONFIG_SERIAL_SH_SCI_DMA flag
- dropped the tx_occurred initialization in sci_shutdown() as it is already
  initialized in sci_startup()
- adjusted the commit message to reflect latest changes

Changes in v2:
- use bool type instead of atomic_t

 drivers/tty/serial/sh-sci.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 136e0c257af1..ade151ff39d2 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -157,6 +157,7 @@ struct sci_port {
 
 	bool has_rtscts;
 	bool autorts;
+	bool tx_occurred;
 };
 
 #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
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
+		s->tx_occurred = true;
 
 		port->icount.tx++;
 	} while (--count > 0);
@@ -1241,6 +1244,8 @@ static void sci_dma_tx_complete(void *arg)
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
+	s->tx_occurred = true;
+
 	if (!kfifo_is_empty(&tport->xmit_fifo)) {
 		s->cookie_tx = 0;
 		schedule_work(&s->work_tx);
@@ -1731,6 +1736,16 @@ static void sci_flush_buffer(struct uart_port *port)
 		s->cookie_tx = -EINVAL;
 	}
 }
+
+static void sci_dma_check_tx_occurred(struct sci_port *s)
+{
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	status = dmaengine_tx_status(s->chan_tx, s->cookie_tx, &state);
+	if (status == DMA_COMPLETE || status == DMA_IN_PROGRESS)
+		s->tx_occurred = true;
+}
 #else /* !CONFIG_SERIAL_SH_SCI_DMA */
 static inline void sci_request_dma(struct uart_port *port)
 {
@@ -1740,6 +1755,10 @@ static inline void sci_free_dma(struct uart_port *port)
 {
 }
 
+static void sci_dma_check_tx_occurred(struct sci_port *s)
+{
+}
+
 #define sci_flush_buffer	NULL
 #endif /* !CONFIG_SERIAL_SH_SCI_DMA */
 
@@ -2076,6 +2095,12 @@ static unsigned int sci_tx_empty(struct uart_port *port)
 {
 	unsigned short status = sci_serial_in(port, SCxSR);
 	unsigned short in_tx_fifo = sci_txfill(port);
+	struct sci_port *s = to_sci_port(port);
+
+	sci_dma_check_tx_occurred(s);
+
+	if (!s->tx_occurred)
+		return TIOCSER_TEMT;
 
 	return (status & SCxSR_TEND(port)) && !in_tx_fifo ? TIOCSER_TEMT : 0;
 }
@@ -2247,6 +2272,7 @@ static int sci_startup(struct uart_port *port)
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
+	s->tx_occurred = false;
 	sci_request_dma(port);
 
 	ret = sci_request_irq(s);
-- 
2.39.2


