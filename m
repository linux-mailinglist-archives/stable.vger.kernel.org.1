Return-Path: <stable+bounces-181526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB7CB96A76
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 17:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8EC47A5C31
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 15:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6B8264A92;
	Tue, 23 Sep 2025 15:47:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F01A23815C;
	Tue, 23 Sep 2025 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642473; cv=none; b=A0H6eBLxJB6Eca+K5GgcNl4AyXMEllGp5VFQUHcyeHObItW20jjNnaFvZtR3MTOYjWDb5GB0BQS5hHSP1iwVrV/bfgQ4b5WnyDOoEOYw4Qxq0nM+SqzQ7mj3jdOCKE+6CzXXVNim4LQhwulIOJXJMshTeuhi8fdJMPFEn5Fjk4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642473; c=relaxed/simple;
	bh=ExbNrBUxZz4jaMeIL7GyUCv6mgFwjLV9B32HM3yyxuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ctd9JjPiwP/2BB0ejD3XoQIOno9OCrBuG8iyIixSM4/Z6uE6RA+X4qG8pHTu8FxV4w9h/QAFI87o1LT7j5ui+6nrcTt/vQEF4UGrt2G+yquIfXKvWYNJlK4WGrEAJkDJ2NuOCtIgS1Co/PaB/WjLVnipku9m8Cleb52TFTbS9ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 9/t0SQo+QIqN5T6NqyHqMw==
X-CSE-MsgGUID: 2CycLQvbQz+ZWDfthuQXRw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Sep 2025 00:47:44 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.64])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 981DE40062C5;
	Wed, 24 Sep 2025 00:47:40 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Nam Cao <namcao@linutronix.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH] tty: serial: sh-sci: fix RSCI FIFO overrun handling
Date: Tue, 23 Sep 2025 18:47:06 +0300
Message-ID: <20250923154707.1089900-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The receive error handling code is shared between RSCI and all other
SCIF port types, but the RSCI overrun_reg is specified as a memory
offset, while for other SCIF types it is an enum value used to index
into the sci_port_params->regs array, as mentioned above the
sci_serial_in() function.

For RSCI, the overrun_reg is CSR (0x48), causing the sci_getreg() call
inside the sci_handle_fifo_overrun() function to index outside the
bounds of the regs array, which currently has a size of 20, as specified
by SCI_NR_REGS.

Because of this, we end up accessing memory outside of RSCI's
rsci_port_params structure, which, when interpreted as a plat_sci_reg,
happens to have a non-zero size, causing the following WARN when
sci_serial_in() is called, as the accidental size does not match the
supported register sizes.

The existence of the overrun_reg needs to be checked because
SCIx_SH3_SCIF_REGTYPE has overrun_reg set to SCLSR, but SCLSR is not
present in the regs array.

Avoid calling sci_getreg() for port types which don't use standard
register handling.

Use the ops->read_reg() and ops->write_reg() functions to properly read
and write registers for RSCI, and change the type of the status variable
to accommodate the 32-bit CSR register.

sci_getreg() and sci_serial_in() are also called with overrun_reg in the
sci_mpxed_interrupt() interrupt handler, but that code path is not used
for RSCI, as it does not have a muxed interrupt.

------------[ cut here ]------------
Invalid register access
WARNING: CPU: 0 PID: 0 at drivers/tty/serial/sh-sci.c:522 sci_serial_in+0x38/0xac
Modules linked in: renesas_usbhs at24 rzt2h_adc industrialio_adc sha256 cfg80211 bluetooth ecdh_generic ecc rfkill fuse drm backlight ipv6
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.17.0-rc1+ #30 PREEMPT
Hardware name: Renesas RZ/T2H EVK Board based on r9a09g077m44 (DT)
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : sci_serial_in+0x38/0xac
lr : sci_serial_in+0x38/0xac
sp : ffff800080003e80
x29: ffff800080003e80 x28: ffff800082195b80 x27: 000000000000000d
x26: ffff8000821956d0 x25: 0000000000000000 x24: ffff800082195b80
x23: ffff000180e0d800 x22: 0000000000000010 x21: 0000000000000000
x20: 0000000000000010 x19: ffff000180e72000 x18: 000000000000000a
x17: ffff8002bcee7000 x16: ffff800080000000 x15: 0720072007200720
x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
x11: 0000000000000058 x10: 0000000000000018 x9 : ffff8000821a6a48
x8 : 0000000000057fa8 x7 : 0000000000000406 x6 : ffff8000821fea48
x5 : ffff00033ef88408 x4 : ffff8002bcee7000 x3 : ffff800082195b80
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff800082195b80
Call trace:
 sci_serial_in+0x38/0xac (P)
 sci_handle_fifo_overrun.isra.0+0x70/0x134
 sci_er_interrupt+0x50/0x39c
 __handle_irq_event_percpu+0x48/0x140
 handle_irq_event+0x44/0xb0
 handle_fasteoi_irq+0xf4/0x1a0
 handle_irq_desc+0x34/0x58
 generic_handle_domain_irq+0x1c/0x28
 gic_handle_irq+0x4c/0x140
 call_on_irq_stack+0x30/0x48
 do_interrupt_handler+0x80/0x84
 el1_interrupt+0x34/0x68
 el1h_64_irq_handler+0x18/0x24
 el1h_64_irq+0x6c/0x70
 default_idle_call+0x28/0x58 (P)
 do_idle+0x1f8/0x250
 cpu_startup_entry+0x34/0x3c
 rest_init+0xd8/0xe0
 console_on_rootfs+0x0/0x6c
 __primary_switched+0x88/0x90
---[ end trace 0000000000000000 ]---

Cc: stable@vger.kernel.org
Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 538b2f991609..62bb62b82cbe 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1014,16 +1014,18 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 	struct sci_port *s = to_sci_port(port);
 	const struct plat_sci_reg *reg;
 	int copied = 0;
-	u16 status;
+	u32 status;
 
-	reg = sci_getreg(port, s->params->overrun_reg);
-	if (!reg->size)
-		return 0;
+	if (s->type != SCI_PORT_RSCI) {
+		reg = sci_getreg(port, s->params->overrun_reg);
+		if (!reg->size)
+			return 0;
+	}
 
-	status = sci_serial_in(port, s->params->overrun_reg);
+	status = s->ops->read_reg(port, s->params->overrun_reg);
 	if (status & s->params->overrun_mask) {
 		status &= ~s->params->overrun_mask;
-		sci_serial_out(port, s->params->overrun_reg, status);
+		s->ops->write_reg(port, s->params->overrun_reg, status);
 
 		port->icount.overrun++;
 
-- 
2.51.0


