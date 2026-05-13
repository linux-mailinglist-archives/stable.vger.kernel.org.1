Return-Path: <stable+bounces-246860-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIBgAwaDBGrVKwIAu9opvQ
	(envelope-from <stable+bounces-246860-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:56:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 611FA5347AA
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 558C2309C10E
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EF234FF74;
	Wed, 13 May 2026 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="XfittQgl"
X-Original-To: stable@vger.kernel.org
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11023446AF;
	Wed, 13 May 2026 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778679053; cv=none; b=ArL66NB0TtEjZgnsa6lbN+Z7EVE7uROzR8dF32gXpYAEQsrZArmrnkV6l9dRO9CFzJDyMXxe9NbvAfOcWWMGTH1UeaVNq0CbUd4q1lEwBlOdaYOMZSIOP+tx5fa/3CZowCn1kmkrM3NvTiuHwU8E9/HBCjQ5CR5vX2E8pWq6kJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778679053; c=relaxed/simple;
	bh=1pChfbj8tFToy9AdYZiA72qsSNyQ/k6eQBBa/U5DLbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZE1vpa/BmBOSCbwlTYNuRPt4oUQT9p86NPF+1q93DkITOeQVplmuhF+HuH1pUFSRu1HvULUGaaKtNSr6IMMBklKNGdlgNpJJ4u8ygg2Xc5y3maQvQYsY2vRDAkXGaozb7vD8Zxv3YN+uLmaoxrRDz/VajAcJaaB/SGY5katsM9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=XfittQgl; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from Gigabyte.tail209581.ts.net (unknown [IPv6:2a02:8428:7df0:ac01:62d2:7d04:a603:94c1])
	(Authenticated sender: jnilo@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 0F90078034D;
	Wed, 13 May 2026 15:30:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1778679049;
	bh=1pChfbj8tFToy9AdYZiA72qsSNyQ/k6eQBBa/U5DLbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XfittQgl+I8wB5mr1P1x3IMGUdUOoQ16Y8sb3qBh20JB89AkaKRwSSCYriEZUajEF
	 WmlrFgsCQEQEo2xEJ7JR5BmKq4PwKtwFTDfNW2mteFs6NDT1EdwoIn9c5e6n8tvJcy
	 YoH9oCKYCjPvbmjeiCkiu8DOnxoT+Z2f73pbr8GIsjVmPI1t7U135cG3oSZiUhzToa
	 qmzp3ZAXAewsPGOdQkl1mapoeSyNpXLD8O/kImHSnAbtBsBj74zo3+yrZNCGN9REvh
	 hg6OM6y12FlScQK9NSbMeQQqkCOtDX29E/9QWK1iXZl8SEUjGexHmvwQudjpyRIIKV
	 EFvOlEdUVwPDA==
From: Jacques Nilo <jnilo@free.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jacques Nilo <jnilo@free.fr>
Subject: [PATCH v2 1/3] serial: core: introduce guard(uart_port_lock_check_sysrq_irqsave)
Date: Wed, 13 May 2026 15:30:23 +0200
Message-ID: <3849af4bc55d5d2a424fa850844e94d641b2f8a6.1778675349.git.jnilo@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778675349.git.jnilo@free.fr>
References: <cover.1778592805.git.jnilo@free.fr> <cover.1778675349.git.jnilo@free.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 611FA5347AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[free.fr,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[free.fr:s=smtp-20201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,vger.kernel.org,free.fr];
	TAGGED_FROM(0.00)[bounces-246860-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jnilo@free.fr,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[free.fr:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[free.fr];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
---
 include/linux/serial_core.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 4f7bbdd90..d1404c97d 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -1286,6 +1286,18 @@ static inline void uart_unlock_and_check_sysrq_irqrestore(struct uart_port *port
 }
 #endif	/* CONFIG_MAGIC_SYSRQ_SERIAL */
 
+/*
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
 /*
  * We do the SysRQ and SAK checking like this...
  */
-- 
2.43.0


