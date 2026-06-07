Return-Path: <stable+bounces-261780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nqS9NH1OJWqkGgIAu9opvQ
	(envelope-from <stable+bounces-261780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:57:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 02254650272
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:57:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=qwqtEPEV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261780-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-261780-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 013913004DBB
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0687330337;
	Sun,  7 Jun 2026 10:56:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C518D12CDA5;
	Sun,  7 Jun 2026 10:56:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829815; cv=none; b=Oqw5Aw+d/lGEM0ykmNlSxEkEL7zJ5XE+SL/iIuDNNffvFtDR8BoyD91VcJJ5FvJTlyfO9MXSDdmSTWlwvYJc1pJnOdtnv15P7OhMbiM2s8QL7YLpn8YWSLraHuxEOlQfAHYqs8NaHL/9K8ZmrYQgSFX4t5VuY0g20crhPXTtYcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829815; c=relaxed/simple;
	bh=USR1GX/iTwimqhGLrdvXZsIGU0IGQBW0jj1gPXYpNZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uv6Nc1w/urv/derZ7rUEInVk2377HgUQPi+iFHCKMeQuySDjwsSy2ZZA+fumTus7xIDgoEmpXP2ui8Q8vFgsTQ240W3rJt43Mri/kT2GzTvMD0/JDYAoJLg6r+g/ctpDIzoo5VIZWvyuMc8JJwIewySkSHvdlMD44AFd+9CBWJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qwqtEPEV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15491F00893;
	Sun,  7 Jun 2026 10:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829814;
	bh=nF52bDA+Vo84wxrabO2Wc8tnNemC579h98qNHl+Ul+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qwqtEPEVn0xyrNySPtd4V52D4yeKFNVGfne9ZPRThMxsjlOvJNu/uqjPLLL521BD4
	 4OaL0yKLebQrQ8lqd0O2m3K7sBnSQWWdjug2I1pLDvCXWgBKKlmZrKqUzgzz2jCTux
	 2KoY5XkrkqhZNtMqgbobc5WSip5piRNWxaoMpQS0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacques Nilo <jnilo@free.fr>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 7.0 315/332] serial: core: introduce guard(uart_port_lock_check_sysrq_irqsave)
Date: Sun,  7 Jun 2026 12:01:24 +0200
Message-ID: <20260607095739.688716201@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261780-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jnilo@free.fr,m:ilpo.jarvinen@linux.intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,free.fr,linux.intel.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,intel.com:email,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02254650272

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacques Nilo <jnilo@free.fr>

commit c3cce2e67bb22a223f5b8ef05db0fcde70994068 upstream.

uart_handle_break() and uart_prepare_sysrq_char() (in
include/linux/serial_core.h) capture a SysRq character into
port->sysrq_ch while the port lock is held and rely on the unlock
helper -- uart_unlock_and_check_sysrq_irqrestore() -- to dispatch the
captured character to handle_sysrq() on scope exit.

The existing guard(uart_port_lock_irqsave) cannot be used by IRQ
handlers that process RX, because its destructor calls plain
uart_port_unlock_irqrestore() and silently drops port->sysrq_ch.

Add a dedicated guard(uart_port_lock_check_sysrq_irqsave) variant
whose destructor is the sysrq-aware unlock helper. The lock side is
identical to uart_port_lock_irqsave -- only the unlock-time behaviour
differs. Callers that may capture SysRq characters must use
guard(uart_port_lock_check_sysrq_irqsave); the existing
guard(uart_port_lock_irqsave) keeps its current plain-unlock semantics
for the many callers that do not process RX.

The new macro is placed after the CONFIG_MAGIC_SYSRQ_SERIAL block so
both definitions of uart_unlock_and_check_sysrq_irqrestore() (sysrq
enabled and disabled) are visible at expansion time. When
CONFIG_MAGIC_SYSRQ_SERIAL=n the destructor degenerates to plain
uart_port_unlock_irqrestore(), so there is no overhead.

No functional change on its own; users are converted in the following
patches.

Cc: stable@vger.kernel.org
Signed-off-by: Jacques Nilo <jnilo@free.fr>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://patch.msgid.link/3849af4bc55d5d2a424fa850844e94d641b2f8a6.1778675349.git.jnilo@free.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/serial_core.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -1275,6 +1275,18 @@ static inline void uart_unlock_and_check
 #endif	/* CONFIG_MAGIC_SYSRQ_SERIAL */
 
 /*
+ * Variant of guard(uart_port_lock_irqsave) for IRQ handlers that may capture
+ * a SysRq character via uart_prepare_sysrq_char(). The destructor uses the
+ * sysrq-aware unlock helper so that a captured port->sysrq_ch is dispatched
+ * to handle_sysrq() on scope exit. The plain guard variant silently drops
+ * sysrq_ch and must not be used by callers that process RX.
+ */
+DEFINE_LOCK_GUARD_1(uart_port_lock_check_sysrq_irqsave, struct uart_port,
+                    uart_port_lock_irqsave(_T->lock, &_T->flags),
+                    uart_unlock_and_check_sysrq_irqrestore(_T->lock, _T->flags),
+                    unsigned long flags);
+
+/*
  * We do the SysRQ and SAK checking like this...
  */
 static inline int uart_handle_break(struct uart_port *port)



