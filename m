Return-Path: <stable+bounces-141564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70ECAAB452
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B8837ACBD1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AF747BBE8;
	Tue,  6 May 2025 00:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJ8/ViQj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57D38668A;
	Mon,  5 May 2025 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486715; cv=none; b=df2R5P3F/NMOZFjv7cTYMhw8XXkdTv36s/jJ81RmboE5KLZDmJbxxaFiDvxZk8TRJ1BpNc9wVd3IHL89K55PRbYg2jGXLgLLdsybCnfAsK0Devh685GldHN4svoJQ3FGmQdiRg4y/9ohfXe0ihAlLowU1cHacVSycxu1u2UPLiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486715; c=relaxed/simple;
	bh=1znkFGi3Z99swP4p+XKrV6PMB22FhHydVUbdtJFLRJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q+DRIr9nWvtKQL/UvRnKNXLPwM/66eVCDpG7iLeKnHzFAGa+ZwZEjrfZLyJURkhXHzCG/11CMBgNSvm34A/b3gFgtwX/Bf2DpXP35KY8rFyR/+6XOLsxuv+saDaqtAsrEHKZzOX5eROZ3343UNp5IxAgHSraGWbr0ETWDIW/lkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJ8/ViQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0BEC4CEED;
	Mon,  5 May 2025 23:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486714;
	bh=1znkFGi3Z99swP4p+XKrV6PMB22FhHydVUbdtJFLRJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fJ8/ViQj31mylK0IIAcgFpIVwkbNPg837DuBJDTMxTKK898W+g/+ILZzoPN8umphg
	 vYHcnfhWB1v9GYQbmAM2TiBQjcGrDD7XMpRIvXyL6sj87WydHAbviyFtq/oPOQjupA
	 BB1LJhRf68RqZGd1xm5s7N3Bfa3Jp4AzTRCD9nrtydNzlQ32tDIfouvBzpzqzDz+2I
	 3KWfkTyBcT4MGOgBRLqIjvU81cml+vbH6CMsjuLFpkfK2hElFF5deQakcVL6AcA5H6
	 P6P3n1Qrlzuajh+SnGICM2ET6zm/PpBsAaystih69evaETD77if6r1fQDJI3ylO0Xz
	 j/GC9Hv0/U8eA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	jirislaby@kernel.org,
	p.zabel@pengutronix.de,
	wsa+renesas@sang-engineering.com,
	zack.rusin@broadcom.com,
	namcao@linutronix.de,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 168/212] serial: sh-sci: Update the suspend/resume support
Date: Mon,  5 May 2025 19:05:40 -0400
Message-Id: <20250505230624.2692522-168-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit 22a6984c5b5df8eab864d7f3e8b94d5a554d31ab ]

The Renesas RZ/G3S supports a power saving mode where power to most of the
SoC components is turned off. When returning from this power saving mode,
SoC components need to be re-configured.

The SCIFs on the Renesas RZ/G3S need to be re-configured as well when
returning from this power saving mode. The sh-sci code already configures
the SCIF clocks, power domain and registers by calling uart_resume_port()
in sci_resume(). On suspend path the SCIF UART ports are suspended
accordingly (by calling uart_suspend_port() in sci_suspend()). The only
missing setting is the reset signal. For this assert/de-assert the reset
signal on driver suspend/resume.

In case the no_console_suspend is specified by the user, the registers need
to be saved on suspend path and restore on resume path. To do this the
sci_console_save()/sci_console_restore() functions were added. There is no
need to cache/restore the status or FIFO registers. Only the control
registers. The registers that will be saved/restored on suspend/resume are
specified by the struct sci_suspend_regs data structure.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250207113313.545432-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sh-sci.c | 71 +++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e2dfca4c2eff8..191136dcb94d0 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -105,6 +105,15 @@ struct plat_sci_reg {
 	u8 offset, size;
 };
 
+struct sci_suspend_regs {
+	u16 scsmr;
+	u16 scscr;
+	u16 scfcr;
+	u16 scsptr;
+	u8 scbrr;
+	u8 semr;
+};
+
 struct sci_port_params {
 	const struct plat_sci_reg regs[SCIx_NR_REGS];
 	unsigned int fifosize;
@@ -135,6 +144,8 @@ struct sci_port {
 	struct dma_chan			*chan_tx;
 	struct dma_chan			*chan_rx;
 
+	struct reset_control		*rstc;
+
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	struct dma_chan			*chan_tx_saved;
 	struct dma_chan			*chan_rx_saved;
@@ -154,6 +165,7 @@ struct sci_port {
 	int				rx_trigger;
 	struct timer_list		rx_fifo_timer;
 	int				rx_fifo_timeout;
+	struct sci_suspend_regs		suspend_regs;
 	u16				hscif_tot;
 
 	bool has_rtscts;
@@ -3252,6 +3264,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	}
 
 	sp = &sci_ports[id];
+	sp->rstc = rstc;
 	*dev_id = id;
 
 	p->type = SCI_OF_TYPE(data);
@@ -3400,13 +3413,57 @@ static int sci_probe(struct platform_device *dev)
 	return 0;
 }
 
+static void sci_console_save(struct sci_port *s)
+{
+	struct sci_suspend_regs *regs = &s->suspend_regs;
+	struct uart_port *port = &s->port;
+
+	if (sci_getreg(port, SCSMR)->size)
+		regs->scsmr = sci_serial_in(port, SCSMR);
+	if (sci_getreg(port, SCSCR)->size)
+		regs->scscr = sci_serial_in(port, SCSCR);
+	if (sci_getreg(port, SCFCR)->size)
+		regs->scfcr = sci_serial_in(port, SCFCR);
+	if (sci_getreg(port, SCSPTR)->size)
+		regs->scsptr = sci_serial_in(port, SCSPTR);
+	if (sci_getreg(port, SCBRR)->size)
+		regs->scbrr = sci_serial_in(port, SCBRR);
+	if (sci_getreg(port, SEMR)->size)
+		regs->semr = sci_serial_in(port, SEMR);
+}
+
+static void sci_console_restore(struct sci_port *s)
+{
+	struct sci_suspend_regs *regs = &s->suspend_regs;
+	struct uart_port *port = &s->port;
+
+	if (sci_getreg(port, SCSMR)->size)
+		sci_serial_out(port, SCSMR, regs->scsmr);
+	if (sci_getreg(port, SCSCR)->size)
+		sci_serial_out(port, SCSCR, regs->scscr);
+	if (sci_getreg(port, SCFCR)->size)
+		sci_serial_out(port, SCFCR, regs->scfcr);
+	if (sci_getreg(port, SCSPTR)->size)
+		sci_serial_out(port, SCSPTR, regs->scsptr);
+	if (sci_getreg(port, SCBRR)->size)
+		sci_serial_out(port, SCBRR, regs->scbrr);
+	if (sci_getreg(port, SEMR)->size)
+		sci_serial_out(port, SEMR, regs->semr);
+}
+
 static __maybe_unused int sci_suspend(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
-	if (sport)
+	if (sport) {
 		uart_suspend_port(&sci_uart_driver, &sport->port);
 
+		if (!console_suspend_enabled && uart_console(&sport->port))
+			sci_console_save(sport);
+		else
+			return reset_control_assert(sport->rstc);
+	}
+
 	return 0;
 }
 
@@ -3414,8 +3471,18 @@ static __maybe_unused int sci_resume(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
-	if (sport)
+	if (sport) {
+		if (!console_suspend_enabled && uart_console(&sport->port)) {
+			sci_console_restore(sport);
+		} else {
+			int ret = reset_control_deassert(sport->rstc);
+
+			if (ret)
+				return ret;
+		}
+
 		uart_resume_port(&sci_uart_driver, &sport->port);
+	}
 
 	return 0;
 }
-- 
2.39.5


