Return-Path: <stable+bounces-211951-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHuUBQvseWkF1AEAu9opvQ
	(envelope-from <stable+bounces-211951-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 11:59:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8859FD73
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 11:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B646E309AB21
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 10:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4543E33B6C7;
	Wed, 28 Jan 2026 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQ82Agas"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80EB33A01B;
	Wed, 28 Jan 2026 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597649; cv=none; b=dwL3US3CCFzXqJVW4UmtD7N9LuJVtBMyDWM0Cajpy8kCGoLz6oaNEpi2CQWFcfIe6cL2Ypxw3sgHFBVK37A6ykXtaGdwmxiVbRJy8n/VYQsuceNFiNN8uzemWSWW1INpJUUGqvTY2z9hNecr+Cm3hXPlUaJDmw4vItsE1uZ+YTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597649; c=relaxed/simple;
	bh=B843BIjDmM6+7b2O2RW8TrN+hegMpPSgt0H4J0YgJq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rnJn/g1kwa9XUvDVI4apVJtHenYUCyDgknjQb9weQOZe/3pCYAhZz+A0yMuAnataJZxMNwV1VYGlefYCkP2/XzYJuyrFENL4eKCYCnrVeZ4495J7mvJDCfvDi+CvZ7gk8L42lHRr38+AhyRN2m8GtmekkEO+osPQ0UHBbQ50j6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQ82Agas; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769597648; x=1801133648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B843BIjDmM6+7b2O2RW8TrN+hegMpPSgt0H4J0YgJq0=;
  b=AQ82AgastBaEr3XQq65EI+cbr1JOvDZiXtU+NKN7ca/ZrBeJwBtEqL98
   ykNCmjUTSaCoOR+NHszi1xR5P+Bkqb4bEPwEg+Bu5gebWA6tdAjpzB/yC
   Q/9N5WP5bZ2xCTvQ8r9UxOduUcWdcMpX4itVWXZ/Kq4FNAsDHfKnsEHHl
   A/AM6wnlF2FUvh0yQZ/BHideEZo/OG4eS1uhzfo1h6oxGT06rw6j+BYHk
   QSh7YOS37/IHzXyPPed7LGzyQtozKMs74DdQAsqmt92jkVsoHeQ5fO8FA
   rhad9fRvifLVkUhhJyqtAfBkG+TGcXH2X+shc4M17ZbE9cKo+IT9NGJji
   g==;
X-CSE-ConnectionGUID: naEuDEVLS1+/EyBPz/TRbA==
X-CSE-MsgGUID: n1TbmFMAR9yYwVTe8ySfqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70848834"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70848834"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 02:54:07 -0800
X-CSE-ConnectionGUID: 9YKcn0ylRO2H9XyYrheoIQ==
X-CSE-MsgGUID: LbG3T3AgSqO98afKuBt7gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="212788259"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.14])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 02:54:03 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>,
	Jamie Iles <jamie@jamieiles.com>,
	linux-kernel@vger.kernel.org
Cc: "Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 6/7] serial: 8250: Add late synchronize_irq() to shutdown to handle DW UART BUSY
Date: Wed, 28 Jan 2026 12:53:00 +0200
Message-Id: <20260128105301.1869-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260128105301.1869-1-ilpo.jarvinen@linux.intel.com>
References: <20260128105301.1869-1-ilpo.jarvinen@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211951-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,linux.intel.com,163.com,arista.com,jamieiles.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 6A8859FD73
X-Rspamd-Action: no action

When DW UART is !uart_16550_compatible, it can indicate BUSY at any
point (when under constant Rx pressure) unless a complex sequence of
steps is performed. Any LCR write can run a foul with the condition
that prevents writing LCR while the UART is BUSY, which triggers
BUSY_DETECT interrupt that seems unmaskable using IER bits.

Normal flow is that dw8250_handle_irq() handles BUSY_DETECT condition
by reading USR register. This BUSY feature, however, breaks the
assumptions made in serial8250_do_shutdown(), which runs
synchronize_irq() after clearing IER and assumes no interrupts can
occur after that point but then proceeds to update LCR, which on DW
UART can trigger an interrupt.

If serial8250_do_shutdown() releases the interrupt handler before the
handler has run and processed the BUSY_DETECT condition by read the USR
register, the IRQ is not deasserted resulting in interrupt storm that
triggers "irq x: nobody cared" warning leading to disabling the IRQ.

Add late synchronize_irq() into serial8250_do_shutdown() to ensure
BUSY_DETECT from DW UART is handled before port's interrupt handler is
released. Alternative would be to add DW UART specific shutdown
function but it would mostly duplicate the generic code and the extra
synchronize_irq() seems pretty harmless in serial8250_do_shutdown().

Fixes: 7d4008ebb1c9 ("tty: add a DesignWare 8250 driver")
Cc: stable@vger.kernel.org
Reported-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Murthy, Shanth" <shanth.murthy@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index bc223eb1f474..fb0b8397cd4b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2401,6 +2401,12 @@ void serial8250_do_shutdown(struct uart_port *port)
 	 * the IRQ chain.
 	 */
 	serial_port_in(port, UART_RX);
+	/*
+	 * LCR writes on DW UART can trigger late (unmaskable) IRQs.
+	 * Handle them before releasing the handler.
+	 */
+	synchronize_irq(port->irq);
+
 	serial8250_rpm_put(up);
 
 	up->ops->release_irq(up);
-- 
2.39.5


