Return-Path: <stable+bounces-212875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMYtGEiyfGmbOQIAu9opvQ
	(envelope-from <stable+bounces-212875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 14:29:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D170ABB049
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 14:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02E593029602
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 13:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2602E092E;
	Fri, 30 Jan 2026 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kzBQ9nD5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD9E2D7395;
	Fri, 30 Jan 2026 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779763; cv=none; b=qsjztNtwr+uqtu2q+gOdK9+3tUywZCHEO8AeeOPzetHsHjQ2kmSirrzvZDZwGeSpdgu+1W4G6IHyoMTh+WhKaWRcFvggol6fLRVBIeTPRHP+4YEde3vdjlf2Kxk8TRahW5gTYp0kGWc2Ainb3uofo0ShA9mozu1AJp4SGNLIbKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779763; c=relaxed/simple;
	bh=v9MIggMZQHwM4Mc3G2t1gkLl/CS706f7qBG7EVvk9Cc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LyGjLMPSQl+POb2K9A1GUl6CbMkceAO4bOgc3WL8yv/l/TWphFb5tLA3NU96+e777qR38KPEb12ep4MkqNgPJyviQ/ckjDXsQk8O9SBMv+EPJcwLOuZBdEQrCcWb9zIWohNRjAYaxPItOoL/5EONNryosOqIoREqkVF/1SCfBpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kzBQ9nD5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769779762; x=1801315762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v9MIggMZQHwM4Mc3G2t1gkLl/CS706f7qBG7EVvk9Cc=;
  b=kzBQ9nD51XnMxgJkvXcDMR/Ck9n6ib2HAO9vvD1i7uegvzaSFE2v+FZi
   RlEcoOEq1oAieWJqfur78VbOmfgTw2p9ALvpirlOrXADgF1RtL2lUADgw
   5jcieEvZ122A1V7qkORp7tolIVC3928byuliq0h8z1MtENKohQinEt5oo
   wtRyGTn1sn6madSCMK4h+dLTy/ZWvS6hojg+J4uBp56dYce4/upVndv56
   M+jcqFhiZlNa8Pmsl6tpLgx8gh+qYT9mkYGXUkiLsqgWvNiwj7TpKqaki
   IiZWwH3MyaW7M0yw5lBnx03De7Lbnwe/vFg1aZnVPbCDdMvhjwcSKhw+F
   g==;
X-CSE-ConnectionGUID: iCBJZyRmQqSWJMqQFN/JJg==
X-CSE-MsgGUID: 5XYsoIwzTcWrRv2C3SUfvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="74882370"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="74882370"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 05:29:22 -0800
X-CSE-ConnectionGUID: 0nNuhRVFSTmpL29B2MboCQ==
X-CSE-MsgGUID: 063ooe+VROiEE0Ia1o+DOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="209103784"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 05:29:18 -0800
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
Subject: [PATCH v3 1/7] serial: 8250: Protect LCR write in shutdown
Date: Fri, 30 Jan 2026 15:28:51 +0200
Message-Id: <20260130132857.13124-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260130132857.13124-1-ilpo.jarvinen@linux.intel.com>
References: <20260130132857.13124-1-ilpo.jarvinen@linux.intel.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212875-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,linux.intel.com,163.com,arista.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D170ABB049
X-Rspamd-Action: no action

The 8250_dw driver needs to potentially perform very complex operations
during LCR writes because its BUSY handling prevents updates to LCR
while UART is BUSY (which is not fully under our control without those
complex operations). Thus, LCR writes should occur under port's lock.

Move LCR write under port's lock in serial8250_do_shutdown(). Also
split the LCR RMW so that the logic is on a separate line for clarity.

Reported-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Murthy, Shanth" <shanth.murthy@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 719faf92aa8a..f7a3c5555204 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2350,6 +2350,7 @@ static int serial8250_startup(struct uart_port *port)
 void serial8250_do_shutdown(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
+	u32 lcr;
 
 	serial8250_rpm_get(up);
 	/*
@@ -2376,13 +2377,13 @@ void serial8250_do_shutdown(struct uart_port *port)
 			port->mctrl &= ~TIOCM_OUT2;
 
 		serial8250_set_mctrl(port, port->mctrl);
+
+		/* Disable break condition */
+		lcr = serial_port_in(port, UART_LCR);
+		lcr &= ~UART_LCR_SBC;
+		serial_port_out(port, UART_LCR, lcr);
 	}
 
-	/*
-	 * Disable break condition and FIFOs
-	 */
-	serial_port_out(port, UART_LCR,
-			serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
 	serial8250_clear_fifos(up);
 
 	rsa_disable(up);
-- 
2.39.5


