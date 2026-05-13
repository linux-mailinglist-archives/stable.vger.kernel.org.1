Return-Path: <stable+bounces-246862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIpNDx2DBGrVKwIAu9opvQ
	(envelope-from <stable+bounces-246862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:56:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F9A5347D7
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AACE835A2D4E
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EF034677F;
	Wed, 13 May 2026 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="hXUtLtwv"
X-Original-To: stable@vger.kernel.org
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84466426D33;
	Wed, 13 May 2026 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778679070; cv=none; b=IyeGFVew/pq3cL/LyMlvZWHjxOXI1Yk7T5laAGJznjhhx+9xau3C+vKonWy+5IUjdrmqWfVLQvSSBqkiRQXEoX+K5nM/rO6K14R95eyzgNpE+1EuMqLwgd+9bUQNyabXaKpk4sdPBkFffloUUD55ItfrJhNxeRVkJ0Zqjtg1sJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778679070; c=relaxed/simple;
	bh=MWDkcVOr6KS8kDZhMAwM+aCcisSi6DzrNcUYEZllN14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qepcLF5xPOkRY3UsfSkckDpNu0xM6r4HD9WJDz2jiNC1DhHkMfnp2R5Hb6LKW3dFQm4T4IH5Rm8EFNb4tCksf/JemfGnYIVDXnklNlYgTWD54zs0IyGfYWJnvPxZ3tEWXUfsDE11D6o6OwbgApukQbo7g8Bl3qMOwupcedfsVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=hXUtLtwv; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from Gigabyte.tail209581.ts.net (unknown [IPv6:2a02:8428:7df0:ac01:62d2:7d04:a603:94c1])
	(Authenticated sender: jnilo@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id F2760780509;
	Wed, 13 May 2026 15:30:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1778679068;
	bh=MWDkcVOr6KS8kDZhMAwM+aCcisSi6DzrNcUYEZllN14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hXUtLtwvC5L5z814SH67pRKvxZiH0CANuMcq1ZRMCMJvcmrAxm9es/x+PTJFylgq2
	 CW99/6GNMtNQkUuyuZRxl6hYV8z64rjNWPSHEWf8cx/RIYog9FUq+ZtoQVaBOs8wDv
	 1UYYwjCGaVcnLOWsWv24I3ZdZZqWJKrMU+Eum5JxK+WgCTzRYfJ08Ops80PT5zSnH5
	 WgZiQb6GJ9e9YITTH/YQJ3PKejMoAG0QUWNhnm7afUNu8d6apD6MWtRGNdQuPgPkhU
	 /+Rn/6eBYnljGmo2pWZR4IxQW89PJ5LU3dpK06YlEnWwsJJ/rQfYWWqHsVSe8OngDr
	 YqUYGNEp6MnaA==
From: Jacques Nilo <jnilo@free.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jacques Nilo <jnilo@free.fr>
Subject: [PATCH v2 3/3] serial: 8250_dw: dispatch SysRq character in dw8250_handle_irq()
Date: Wed, 13 May 2026 15:30:25 +0200
Message-ID: <ed56fcaf4af24e4ed011a7bce206e0182acb761c.1778675349.git.jnilo@free.fr>
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
X-Rspamd-Queue-Id: 90F9A5347D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[free.fr,quarantine];
	R_DKIM_ALLOW(-0.20)[free.fr:s=smtp-20201208];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,vger.kernel.org,free.fr];
	TAGGED_FROM(0.00)[bounces-246862-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

dw8250_handle_irq() calls serial8250_handle_irq_locked() with the port
lock held via guard(uart_port_lock_irqsave). The guard destructor is
plain uart_port_unlock_irqrestore(), so a SysRq character captured into
port->sysrq_ch by uart_prepare_sysrq_char() is dropped without ever
being dispatched to handle_sysrq().

This is the same regression pattern as in serial8250_handle_irq(),
introduced when 883c5a2bc934 ("serial: 8250_dw: Rework
dw8250_handle_irq() locking and IIR handling") moved the function to
the guard()-based locking scheme without using the sysrq-aware unlock
helper.

Switch to guard(uart_port_lock_check_sysrq_irqsave) so that captured
sysrq_ch is dispatched on scope exit, matching the fix in
serial8250_handle_irq().

Fixes: 883c5a2bc934 ("serial: 8250_dw: Rework dw8250_handle_irq() locking and IIR handling")
Cc: stable@vger.kernel.org
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jacques Nilo <jnilo@free.fr>
---
 drivers/tty/serial/8250/8250_dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 55e40c10f..9d552b224 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -416,7 +416,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 	unsigned int quirks = d->pdata->quirks;
 	unsigned int status;
 
-	guard(uart_port_lock_irqsave)(p);
+	guard(uart_port_lock_check_sysrq_irqsave)(p);
 
 	switch (FIELD_GET(DW_UART_IIR_IID, iir)) {
 	case UART_IIR_NO_INT:
-- 
2.43.0


