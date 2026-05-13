Return-Path: <stable+bounces-246859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPWoKiODBGrVKwIAu9opvQ
	(envelope-from <stable+bounces-246859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:56:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF045347E8
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8057C316B14B
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ACB2DC321;
	Wed, 13 May 2026 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="ZHQqttjp"
X-Original-To: stable@vger.kernel.org
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208F62C0294;
	Wed, 13 May 2026 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778679051; cv=none; b=nduLr9JPg4LI110LqEwVk7Indzt6QOjQ2JQ6Gz4q24impTAPrwMpwdZPV2WTjBCGCOYibvp7+ENCaDxoDtjPaIW6eP/XaQf2HRac8Oz5j0Faxe/W/85uBRaHLOKv9f1Ddkfx8h6Fkfi20OyxrXO+i2k7W5l+juuLXbhi3xAaark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778679051; c=relaxed/simple;
	bh=xxJ11X8Ap3+WgkD4gY836+zpjIwtlOMw+QVSO3NxgJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pP+QCxO8EC8+iTEeQ7Y5yNRuO0lDD0eK0ujFErGkKJKowNOWAToUU7YxyUTH2on+DG7ccB5XZ3Ze4tYaWdNXl0vwj642cFv827qGbU1R5ygR+1JWNJvUdel8ChgQdnEk263mwrWvlL4NAD/kLYwbdVa/wpB1H8KJHfj98XqFO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=ZHQqttjp; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from Gigabyte.tail209581.ts.net (unknown [IPv6:2a02:8428:7df0:ac01:62d2:7d04:a603:94c1])
	(Authenticated sender: jnilo@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id C6A65780375;
	Wed, 13 May 2026 15:30:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1778679040;
	bh=xxJ11X8Ap3+WgkD4gY836+zpjIwtlOMw+QVSO3NxgJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZHQqttjpONhjd+JCawRSgbnItk9EBWoo8z3rDbesROllyN6ZFGOAqRA7t23TT8Zgc
	 MHgTCMX2SnzvxTnYZ+2GfWfbBCnAQX6DkTzd6NqcOwPy/7qUBSVOUiq+1wE5HopVtD
	 qg5sWsDfFCX3CQgNXAF8VW+yWB5XXTKkhsQ1xIZlvW9XRPJHWd2GazMj8jErAiqS0Y
	 Qhq7kM0qoml0zt4DCoPFVkP/CaLQV0g3WNtcbzF7GgeflxdMudPw7mz2lWfd04OUGI
	 kmvfO4dDtzMyrIptDO8XUJmzfNQ9PulyrbYf6sm2+yK3T4zwd+1AoLRkIrndR9IOyb
	 ctVd7vA7+7/HA==
From: Jacques Nilo <jnilo@free.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jacques Nilo <jnilo@free.fr>
Subject: [PATCH v2 0/3] serial: 8250: fix BREAK+SysRq dispatch on guard()-locked IRQ handlers
Date: Wed, 13 May 2026 15:30:22 +0200
Message-ID: <cover.1778675349.git.jnilo@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778592805.git.jnilo@free.fr>
References: <cover.1778592805.git.jnilo@free.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4FF045347E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[free.fr,quarantine];
	R_DKIM_ALLOW(-0.20)[free.fr:s=smtp-20201208];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,vger.kernel.org,free.fr];
	TAGGED_FROM(0.00)[bounces-246859-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This series fixes a silent regression where a SysRq character entered as
BREAK + key on the serial console is consumed by the kernel but never
dispatched to handle_sysrq(). Same description as v1 [1].

v1 -> v2 (per Ilpo's review [2]):

 - Renamed the new lock guard from uart_port_lock_sysrq_irqsave to
   uart_port_lock_check_sysrq_irqsave, preserving the "check" semantics
   of the destructor's underlying helper
   uart_unlock_and_check_sysrq_irqrestore(). Mechanical rename across
   patches 2/3 and 3/3; Ilpo's Reviewed-by trailers from v1 carried
   forward.

 - Patch 1/3 commit message reflowed: the "guard(...)" form is spelled
   out, the "lock side is identical" sentence moved up next to the
   variant introduction, the now-redundant naming-rationale sentence
   removed, and "opt in by using" tightened to "must use".

 - Added Cc: stable@vger.kernel.org to patch 1/3 (prerequisite for the
   stable backport of 2/3 and 3/3); no Fixes: tag, since 1/3 adds new
   API rather than fixing existing code.

 - Collapsed the DEFINE_LOCK_GUARD_1 destructor expression to a single
   line, which fits within the expected indentation.

No re-test of the BREAK + 'h' path was performed for v2 since the
diff against v1 is purely a textual rename plus the commit-message
reflow above; the v1 RTL8196E validation (BREAK + 'h' on the console
UART producing the SysRq help dump, brk counter incrementing in
/proc/tty/driver/serial) continues to apply unchanged. Built and
booted on tty-next (base 16e95bfb79b5).

[1] https://lore.kernel.org/linux-serial/cover.1778592805.git.jnilo@free.fr/
[2] https://lore.kernel.org/linux-serial/3439217b-90b5-5d21-e777-d238b3ffc1a0@linux.intel.com/

Jacques Nilo (3):
  serial: core: introduce guard(uart_port_lock_check_sysrq_irqsave)
  serial: 8250: dispatch SysRq character in serial8250_handle_irq()
  serial: 8250_dw: dispatch SysRq character in dw8250_handle_irq()

 drivers/tty/serial/8250/8250_dw.c   |  2 +-
 drivers/tty/serial/8250/8250_port.c |  7 +++++--
 include/linux/serial_core.h         | 12 ++++++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)


base-commit: 16e95bfb79b5d9d01dc7651d98caf3c2ace331cd
-- 
2.43.0


