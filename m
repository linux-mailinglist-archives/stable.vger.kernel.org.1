Return-Path: <stable+bounces-214904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UH8tK/XUiWmBCAAAu9opvQ
	(envelope-from <stable+bounces-214904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 13:37:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CF810ECA4
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 13:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDDF0300E3A4
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 11:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C4A371056;
	Mon,  9 Feb 2026 11:37:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E1336F427;
	Mon,  9 Feb 2026 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770637074; cv=none; b=VvA+Wsg1wD0NNk8jGQ1dImGdWQHSQelRfkCZM1sSpfcIyY6eOmsODpz0+lHOPVmM7UHMIbhf3ofFLcJZX23NycRzn5HLW+Fiu64ZJYXmiKI8YbL8v6fTyR0t1JaF0jcQ/fJONhbGDrZgodssMUbE2Aic1LLMIFJaMijXlubdc3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770637074; c=relaxed/simple;
	bh=e3sacGlxfTPmKEADMHmwZehhprRXlmYcEZyhypxurQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hes3MI5wIJXFaYjAWQ/GDfRHWk8+BM9WAH5yjJRBeQV19RixHN4Pj0QK6PNyO5U1t5eKnltDdMlf4LNzLhpH8JEhbGSQLbX7Nin1qX4HPmBlf1KfiYGtDSqes1VCHzF8z3eRucZdx8Fs0g9JjaHkrWcLtchYvx1aNkj2RnUjvvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=lht.dlh.de; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=lht.dlh.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 9A81FDF94D6;
	Mon,  9 Feb 2026 12:32:36 +0100 (CET)
Received: from albans-vm.. (unknown [213.61.141.186])
	(Authenticated sender: albeu@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 054702003C1;
	Mon,  9 Feb 2026 12:32:13 +0100 (CET)
From: Alban Bedel <alban.bedel@lht.dlh.de>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lennert Buytenhek <buytenh@arista.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	stable@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Alban Bedel <alban.bedel@lht.dlh.de>,
	Maximilian Lueer <maximilian.lueer@lht.dlh.de>
Subject: [PATCH v3] serial: 8250: always disable IRQ during THRE test
Date: Mon,  9 Feb 2026 12:32:07 +0100
Message-Id: <20260209113207.2118445-1-alban.bedel@lht.dlh.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[lht.dlh.de : SPF not aligned (relaxed), No valid DKIM,quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-214904-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alban.bedel@lht.dlh.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lht.dlh.de:mid,bytedance.com:email,dlh.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53CF810ECA4
X-Rspamd-Action: no action

From: Peng Zhang <zhangpeng.00@bytedance.com>

commit 039d4926379b ("serial: 8250: Toggle IER bits on only after irq
has been set up") moved IRQ setup before the THRE test, so the interrupt
handler can run during the test and race with its IIR reads. This can
produce wrong THRE test results and cause spurious registration of the
serial8250_backup_timeout timer. Unconditionally disable the IRQ for the
short duration of the test and re-enable it afterwards to avoid the race.

Cc: stable@vger.kernel.org
Fixes: 039d4926379b ("serial: 8250: Toggle IER bits on only after irq has been set up")
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Alban Bedel <alban.bedel@lht.dlh.de>
Tested-by: Maximilian Lueer <maximilian.lueer@lht.dlh.de>
---
Changelog:

v2: Replaced disable_irq_nosync() with disable_irq() to prevent interrupts
    that are currently being handled
v3: Added changelog
---

Commit 039d4926379b ("serial: 8250: Toggle IER bits on only after irq
has been set up") introduced a bug which showed in some of our devices
after updating them to kernel 5.15.169. These devices have an I2C
touch screen which is behind an UART to I2C bridge. This bug lead to
an ever growing latency on the bus, delaying the touch events by up to
several seconds.

Looking for other solutions than reverting commit 039d4926379b I found
Peng Zhang's patch, backported it to 5.15 and could confirm that it
solve the high delay issue.

As this a quiet sever regression I'm taking the liberty to re-submit
Peng Zhang's patch in the hope it will be considered for inclusion. I
added the changelog requested by greg k-h's patch email bot after the
last submission.

Also please note that commit 039d4926379b was backported as far back as
5.10, so quiet a few stable kernels are affected. This patch doesn't
apply as-is on older kernels, I can provide a patch for 5.15 if desired.

Alban Bedel
---
 drivers/tty/serial/8250/8250_port.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 719faf92aa8ae..f1740cc911431 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2147,8 +2147,7 @@ static void serial8250_THRE_test(struct uart_port *port)
 	if (up->port.flags & UPF_NO_THRE_TEST)
 		return;
 
-	if (port->irqflags & IRQF_SHARED)
-		disable_irq_nosync(port->irq);
+	disable_irq(port->irq);
 
 	/*
 	 * Test for UARTs that do not reassert THRE when the transmitter is idle and the interrupt
@@ -2170,8 +2169,7 @@ static void serial8250_THRE_test(struct uart_port *port)
 		serial_port_out(port, UART_IER, 0);
 	}
 
-	if (port->irqflags & IRQF_SHARED)
-		enable_irq(port->irq);
+	enable_irq(port->irq);
 
 	/*
 	 * If the interrupt is not reasserted, or we otherwise don't trust the iir, setup a timer to
-- 
2.39.5


