Return-Path: <stable+bounces-246861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGQ/LBCDBGrVKwIAu9opvQ
	(envelope-from <stable+bounces-246861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:56:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E7B5347C1
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7F76340854D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08378425CF6;
	Wed, 13 May 2026 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="A8Mjidyb"
X-Original-To: stable@vger.kernel.org
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A2734677F;
	Wed, 13 May 2026 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778679061; cv=none; b=EknmkAzbjuq8WdMEz63XSkEO1C3Z8Wa1VKe7rxhIEoy0jGwgMbxz0hQzJl/ugD4RE+D3X0z2HFbUfi5MFrfZKjGo444YZx1YCulFeQ+ZUWUvx3nlz+BgulICLA/V9jEs3csBLgzgmDn6v0se654qFJ2ME2UpWWHKKqK3VUMtf00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778679061; c=relaxed/simple;
	bh=rFSZzmaNHh3nnM1+XFRMC3hCaekKxH0gbrQyq/EosdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X62mfyc3r2l4B6GKAkqt2ldp/esVyEtoTBVpw9URTnYCxrl+VueQSilOcq8pHnh1t1b0521Y3qRKQ425MMqXAEp5w9hQ38hQaB0kEp1cR4CaX30Qn4O+hdJBxwpRttjAw4muzMElq0wfJIH+OleC/h2peUZlBIFId1o1dN6Q5fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=A8Mjidyb; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from Gigabyte.tail209581.ts.net (unknown [IPv6:2a02:8428:7df0:ac01:62d2:7d04:a603:94c1])
	(Authenticated sender: jnilo@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id ED4D1780505;
	Wed, 13 May 2026 15:30:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1778679058;
	bh=rFSZzmaNHh3nnM1+XFRMC3hCaekKxH0gbrQyq/EosdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A8MjidybtcHZEf3dBGt2zBqZ0b48v5NkUqa5lmCfqNToGFRWs4ImA7b2ifTHlGkQt
	 gkEPJvOasUuv12rzozBEXrwK7dW9WwxUTvD/+O+6nHrl9SZT7H5xVmrzvv8sPi49f3
	 +0MMVJeM3/00C7ZCvkhkjjNDFIabg56wgP3Z2oUWkyHoDoy7J/m8kcrQjbMAXEoYV9
	 RzuspDm4igOF7tRMQNaEG2ObGM3lp3H3OpSZx3JZs3TKG3RTzwYnW8yiJgujvC5Qvg
	 MGMaw0PhpWj7wqgt62JMt3mBOGWUCoHzw9ZTzlWLs5Q2GcjhT24gwql32NdjY+Brqy
	 3jKQO0eJsr06w==
From: Jacques Nilo <jnilo@free.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jacques Nilo <jnilo@free.fr>
Subject: [PATCH v2 2/3] serial: 8250: dispatch SysRq character in serial8250_handle_irq()
Date: Wed, 13 May 2026 15:30:24 +0200
Message-ID: <52692ae6c3501f7940347cef364ad7fcacaab7e5.1778675349.git.jnilo@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778675349.git.jnilo@free.fr>
References: <cover.1778592805.git.jnilo@free.fr> <cover.1778675349.git.jnilo@free.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 17E7B5347C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[free.fr,quarantine];
	R_DKIM_ALLOW(-0.20)[free.fr:s=smtp-20201208];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,vger.kernel.org,free.fr];
	TAGGED_FROM(0.00)[bounces-246861-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[free.fr];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jnilo@free.fr,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[free.fr:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

serial8250_handle_irq() captures a SysRq character into port->sysrq_ch
inside serial8250_handle_irq_locked() via uart_prepare_sysrq_char()
(reached from serial8250_read_char()). Dispatch of that captured
character to handle_sysrq() is expected to happen at port-unlock time,
through uart_unlock_and_check_sysrq[_irqrestore]().

After commit 8324a54f604d ("serial: 8250: Add
serial8250_handle_irq_locked()") the function was reduced to a wrapper
that takes the port lock via guard(uart_port_lock_irqsave) whose
destructor is plain uart_port_unlock_irqrestore(). The sysrq-aware
unlock helper is no longer called, so port->sysrq_ch is captured but
never dispatched: BREAK + SysRq key is consumed silently.

This was the very condition Johan Hovold's 853a9ae29e978 ("serial:
8250: fix handle_irq locking", 2021) introduced
uart_unlock_and_check_sysrq_irqrestore() to address.

Switch to the new guard(uart_port_lock_check_sysrq_irqsave), whose
destructor is the sysrq-aware unlock helper, restoring the pre-split
behaviour. Update the Context: comment on serial8250_handle_irq_locked()
so future HW-specific 8250 wrappers know to use the same guard or the
explicit sysrq-aware unlock.

Verified on RTL8196E with CONFIG_MAGIC_SYSRQ_SERIAL=y: BREAK + 'h' on
the console UART produces the SysRq help dump in dmesg and the brk
counter in /proc/tty/driver/serial increments correctly.

Fixes: 8324a54f604d ("serial: 8250: Add serial8250_handle_irq_locked()")
Cc: stable@vger.kernel.org
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jacques Nilo <jnilo@free.fr>
---
 drivers/tty/serial/8250/8250_port.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index e4e6a53eb..59203bbfb 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1786,7 +1786,10 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 }
 
 /*
- * Context: port's lock must be held by the caller.
+ * Context: port's lock must be held by the caller. The caller must
+ * release it via guard(uart_port_lock_check_sysrq_irqsave) or
+ * uart_unlock_and_check_sysrq_irqrestore(), which captures SysRq
+ * character on unlock.
  */
 void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir)
 {
@@ -1839,7 +1842,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	if (iir & UART_IIR_NO_INT)
 		return 0;
 
-	guard(uart_port_lock_irqsave)(port);
+	guard(uart_port_lock_check_sysrq_irqsave)(port);
 	serial8250_handle_irq_locked(port, iir);
 
 	return 1;
-- 
2.43.0


