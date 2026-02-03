Return-Path: <stable+bounces-213285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AZbELMtgmlFQAMAu9opvQ
	(envelope-from <stable+bounces-213285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 18:17:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB45CDCA70
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 18:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 488A9310BDCE
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 17:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB413D4121;
	Tue,  3 Feb 2026 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ID7kpV+8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BF735BDB8;
	Tue,  3 Feb 2026 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138691; cv=none; b=MZfZ88tJgeOkk9HPBIaiFOk3Vgopmk2fjs09xZ4Maf61vsr8EjEumfAhlh97YRsaX6Oykq+M8Ryi5tbmcAywopBQL/F6C2MyvjBG7+H4dX0HBvJpE4oALqUoWauYPJIfKq6WESiWUo9L+GALzFy0ff35UT0+KSFGDWfpHGn7Tpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138691; c=relaxed/simple;
	bh=KYUpUdrzugPsCtS0tUswQI3r8Uf6rPUv7lph+Wn/z4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrRQaDM3irXsZigVcNc11ibDC81HV0yDE3Y2KIHmBBM6ykzUz8gzzgOdKLj8juSS4L2XbL7enK0AeQJglpOqWGHsjOuWJ9azPAOL3iqDLWHeoH7RWk06cwrwsjuVHz9eTRYpDDDAxKQpxMJJ7DGSakYc1QGYoEPWm5CxrjqiLxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ID7kpV+8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770138690; x=1801674690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KYUpUdrzugPsCtS0tUswQI3r8Uf6rPUv7lph+Wn/z4Q=;
  b=ID7kpV+8GOhxwmegXCJ9lo8N0u+y+uZX9JvnK/XGmiAeNWciaHmPwu7B
   wbFAON2qEiKE8H+udmYwMT4fsbWRgZFpjNSxlEvNgw8SpctY+5DmoBuAr
   mJn/6g4BR9/zYe1sksxmwaPP3LmI0cKY7EZa7o59DAv9EOyy1t2td4rK3
   pH6kOc1l2BVFeqYC7XS3tWLZ8Tyy7FbeuXI2fPpVKZNmtrpuKeOPSFH35
   2sV3UHrN4x7VVdd2VtJ/xV12rgc+Y/jOU0lanU0gxLHQfXbHDs7515Nte
   bRot4eilg8/vjUsCAtYLaykkqmkJd1n4LtwnpLhC3PiP/uKG6wEuP5EJ0
   w==;
X-CSE-ConnectionGUID: nJkszj9ITJOzZqnuvuR/+Q==
X-CSE-MsgGUID: ZojpOStZQLOp5qs7cOIaRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71220863"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="71220863"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:11:27 -0800
X-CSE-ConnectionGUID: pS087PG3Tb2FkfvgMLldgA==
X-CSE-MsgGUID: 80hDDkwvR0m8Q+jkNeFisg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="240589507"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.117])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:11:23 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>,
	linux-kernel@vger.kernel.org
Cc: "Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 3/7] serial: 8250: Add serial8250_handle_irq_locked()
Date: Tue,  3 Feb 2026 19:10:45 +0200
Message-Id: <20260203171049.4353-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260203171049.4353-1-ilpo.jarvinen@linux.intel.com>
References: <20260203171049.4353-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,linux.intel.com,163.com,arista.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213285-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EB45CDCA70
X-Rspamd-Action: no action

8250_port exports serial8250_handle_irq() to HW specific 8250 drivers.
It takes port's lock within but a HW specific 8250 driver may want to
take port's lock itself, do something, and then call the generic
handler in 8250_port but to do that, the caller has to release port's
lock for no good reason.

Introduce serial8250_handle_irq_locked() which a HW specific driver can
call while already holding port's lock.

As this is new export, put it straight into a namespace (where all 8250
exports should eventually be moved).

Tested-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Murthy, Shanth" <shanth.murthy@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 24 ++++++++++++++++--------
 include/linux/serial_8250.h         |  1 +
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f7a3c5555204..bc223eb1f474 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -18,6 +18,7 @@
 #include <linux/irq.h>
 #include <linux/console.h>
 #include <linux/gpio/consumer.h>
+#include <linux/lockdep.h>
 #include <linux/sysrq.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
@@ -1782,20 +1783,16 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 }
 
 /*
- * This handles the interrupt from one port.
+ * Context: port's lock must be held by the caller.
  */
-int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
+void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct tty_port *tport = &port->state->port;
 	bool skip_rx = false;
-	unsigned long flags;
 	u16 status;
 
-	if (iir & UART_IIR_NO_INT)
-		return 0;
-
-	uart_port_lock_irqsave(port, &flags);
+	lockdep_assert_held_once(&port->lock);
 
 	status = serial_lsr_in(up);
 
@@ -1828,8 +1825,19 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 		else if (!up->dma->tx_running)
 			__stop_tx(up);
 	}
+}
+EXPORT_SYMBOL_NS_GPL(serial8250_handle_irq_locked, "SERIAL_8250");
 
-	uart_unlock_and_check_sysrq_irqrestore(port, flags);
+/*
+ * This handles the interrupt from one port.
+ */
+int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
+{
+	if (iir & UART_IIR_NO_INT)
+		return 0;
+
+	guard(uart_port_lock_irqsave)(port);
+	serial8250_handle_irq_locked(port, iir);
 
 	return 1;
 }
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 01efdce0fda0..a95b2d143d24 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -195,6 +195,7 @@ void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
 void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
 			       unsigned int quot);
 int fsl8250_handle_irq(struct uart_port *port);
+void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir);
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
 u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr);
 void serial8250_read_char(struct uart_8250_port *up, u16 lsr);
-- 
2.39.5


