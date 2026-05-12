Return-Path: <stable+bounces-245609-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP7KEUM2A2of1wEAu9opvQ
	(envelope-from <stable+bounces-245609-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:16:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C98552228D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5522630C0372
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EE3397B1B;
	Tue, 12 May 2026 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="kY5x5MdD"
X-Original-To: stable@vger.kernel.org
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1718239061D;
	Tue, 12 May 2026 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593605; cv=none; b=s0nhIqrKnv15CiYW9Y90p0nlycgChfUrEGW2tHTvsV8ghVFnNPYEBceg0jT6VP0XrFmT+CB+RQWv82CiOZhwYKgtYTBvn7nJswz9lpm2YeJugG/gdnaFjYxU7PvM2jq23GT8xdooov07BiE0R6ih+jrMciV4ndkWfC3wBV0Bors=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593605; c=relaxed/simple;
	bh=m437a1eC5erEltzYgDEjAvmQ4AYcGoZ1JiHBWjIqBso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWLS2rmAwVXE9egO1u63AYPBDgl907HVgu1mrcpubLAW/b6f5pyIH6FiyXEwscMcvEeC6VzsqtVU8O33+9e2L6VxRVdWuqYqp+mq1WQqQ8O0iF4IKnatf30fkQJVbNBEFYXM+yoCRSCyPlFw79hgM2TaeWzEKBpgSFUHQE4Pbjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=kY5x5MdD; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from Gigabyte.tail209581.ts.net (unknown [IPv6:2a02:8428:7df0:ac01:fbfd:168d:553c:3eec])
	(Authenticated sender: jnilo@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id B2E6F780375;
	Tue, 12 May 2026 15:46:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1778593602;
	bh=m437a1eC5erEltzYgDEjAvmQ4AYcGoZ1JiHBWjIqBso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kY5x5MdDeaqvpAEbPzcHe7ZuTdd2WNanEinBt3W3CJYWuhoplqFcQ8sP7X0Lo8WtC
	 X0OJ+9/o0QqxcoViwbQIUiQCiTF2Dp8Kz9xl3OQhGfR9Fa7knWWFmw0XHFHTx3w+LK
	 tsiOp1G+ihVNcnJNr3OtY7BYuIE5kgiI+7UcBka+/nbLi5aVG8SsZs2k1J15n8MPmr
	 CjA2KxUZZvqPUoqXlVCVw2vRO/rcHeb0/2Iejtg+IQCBjDesSUGUVr0ZqsYRmnie/n
	 3jDjNDeMFNPkAqSy3RC7KdN9fi+OM+4WwfbjNP//dFMIo0ATIMK9yG4aK1YQbCxWMb
	 6QgIqRce1E9dw==
From: Jacques Nilo <jnilo@free.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Jacques Nilo <jnilo@free.fr>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] serial: 8250: dispatch SysRq character in serial8250_handle_irq()
Date: Tue, 12 May 2026 15:46:13 +0200
Message-ID: <5d6d693aa9e92f05412d0f9395872d41e1b8e444.1778592805.git.jnilo@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778592805.git.jnilo@free.fr>
References: <5efe9e03-4d86-43a0-9ec2-e610ff31095d@free.fr> <cover.1778592805.git.jnilo@free.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4C98552228D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[free.fr,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[free.fr:s=smtp-20201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,kernel.org,free.fr];
	TAGGED_FROM(0.00)[bounces-245609-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jnilo@free.fr,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[free.fr:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[free.fr];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
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

Switch to the new guard(uart_port_lock_sysrq_irqsave), whose destructor
is the sysrq-aware unlock helper, restoring the pre-split behaviour.
Update the Context: comment on serial8250_handle_irq_locked() so future
HW-specific 8250 wrappers know to use the same guard or the explicit
sysrq-aware unlock.

Verified on RTL8196E with CONFIG_MAGIC_SYSRQ_SERIAL=y: BREAK + 'h' on
the console UART produces the SysRq help dump in dmesg and the brk
counter in /proc/tty/driver/serial increments correctly.

Fixes: 8324a54f604d ("serial: 8250: Add serial8250_handle_irq_locked()")
Cc: stable@vger.kernel.org
Signed-off-by: Jacques Nilo <jnilo@free.fr>
---
 drivers/tty/serial/8250/8250_port.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index e4e6a53eb..64f3487e8 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1786,7 +1786,10 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 }
 
 /*
- * Context: port's lock must be held by the caller.
+ * Context: port's lock must be held by the caller. The caller must
+ * release it via guard(uart_port_lock_sysrq_irqsave) or
+ * uart_unlock_and_check_sysrq_irqrestore(), which captures SysRq
+ * character on unlock.
  */
 void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir)
 {
@@ -1839,7 +1842,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	if (iir & UART_IIR_NO_INT)
 		return 0;
 
-	guard(uart_port_lock_irqsave)(port);
+	guard(uart_port_lock_sysrq_irqsave)(port);
 	serial8250_handle_irq_locked(port, iir);
 
 	return 1;
-- 
2.43.0


