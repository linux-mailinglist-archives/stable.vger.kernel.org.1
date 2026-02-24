Return-Path: <stable+bounces-217908-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MznCNWYnWnwQgQAu9opvQ
	(envelope-from <stable+bounces-217908-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 13:25:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8BC186ED5
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 13:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A2F930B6F19
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 12:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4023396D25;
	Tue, 24 Feb 2026 12:23:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D431396D03;
	Tue, 24 Feb 2026 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935781; cv=none; b=XhFoJxk6ERf4m9wezQ2/IqWEL9kjlc8J/R1tSvHtIIenr6ikwjqG/YawH3utSBp3slCLpRk4SMO+iArm7vptYrY9dN+BRgjhGXq08Z0Adjc4L3SHQr7xbA1wyCsukU41BizI93XvNxJjCGDly2U2phTUAHcIOstwSVDURplsAp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935781; c=relaxed/simple;
	bh=TXKJIKiEPtHfcGEJx/r052JjVn3m4tuf41dI1DM7msk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CiC/HaFcpOECUwxSUQGu82gGIQS3rE2g9VQVFuDkJoq4b0A2ZkKvWBtgGutUkuEko1+xVt4TSsJTZLeHiBCGUElQQVvmu5mFZvORW6+ZzbHhfViq5KKR9NdrepBxacwfjYGCYYTAYWY/XYm1Y2lVrwW+VwmTTDB1MHxUPg3kc5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=lht.dlh.de; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=lht.dlh.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id C56BCDF9503;
	Tue, 24 Feb 2026 13:17:18 +0100 (CET)
Received: from albans-vm.. (unknown [213.61.141.186])
	(Authenticated sender: albeu@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 9DB3420039E;
	Tue, 24 Feb 2026 13:16:58 +0100 (CET)
From: Alban Bedel <alban.bedel@lht.dlh.de>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	stable@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Alban Bedel <alban.bedel@lht.dlh.de>,
	Maximilian Lueer <maximilian.lueer@lht.dlh.de>
Subject: [PATCH v4] serial: 8250: always disable IRQ during THRE test
Date: Tue, 24 Feb 2026 13:16:39 +0100
Message-Id: <20260224121639.579404-1-alban.bedel@lht.dlh.de>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-217908-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alban.bedel@lht.dlh.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bytedance.com:email,lht.dlh.de:mid,dlh.de:email]
X-Rspamd-Queue-Id: 8E8BC186ED5
X-Rspamd-Action: no action

From: Peng Zhang <zhangpeng.00@bytedance.com>

commit 039d4926379b ("serial: 8250: Toggle IER bits on only after irq
has been set up") moved IRQ setup before the THRE test, in combination
with commit 205d300aea75 ("serial: 8250: change lock order in
serial8250_do_startup()") the interrupt handler can run during the
test and race with its IIR reads. This can produce wrong THRE test
results and cause spurious registration of the
serial8250_backup_timeout timer. Unconditionally disable the IRQ for
the short duration of the test and re-enable it afterwards to avoid
the race.

Cc: stable@vger.kernel.org
Fixes: 039d4926379b ("serial: 8250: Toggle IER bits on only after irq has been set up")
Depends-on: 205d300aea75 ("serial: 8250: change lock order in serial8250_do_startup()")
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Alban Bedel <alban.bedel@lht.dlh.de>
Tested-by: Maximilian Lueer <maximilian.lueer@lht.dlh.de>
---
Changelog:

v2: Replaced disable_irq_nosync() with disable_irq() to prevent interrupts
    that are currently being handled
v3: Added changelog
v4: Updated commit message to mention the addtional relation to commit
    205d300aea75
---

Commit 039d4926379b ("serial: 8250: Toggle IER bits on only after irq
has been set up"), in combination with 205d300aea75 ("serial: 8250:
change lock order in serial8250_do_startup()"), introduced a bug which
showed in some of our devices after updating them to kernel
5.15.169. These devices have an I2C touch screen which is behind an
UART to I2C bridge. This bug lead to an ever growing latency on the
bus, delaying the touch events by up to several seconds.

Looking for other solutions than reverting commit 039d4926379b I found
Peng Zhang's patch, backported it to 5.15 and could confirm that it
solve the high delay issue.

As this a quiet sever regression I'm taking the liberty to re-submit
Peng Zhang's patch in the hope it will be considered for inclusion. I
added the changelog requested by greg k-h's patch email bot after the
v2 submission, as well as the mention of commit 205d300aea75 requested
by Jiri Slaby after v3.

Also please note that commit 039d4926379b was backported as far back as
5.10, so quiet a few stable kernels are affected. This patch doesn't
apply as-is on older kernels, I can provide a patch for 5.15 if desired.

Alban Bedel
---
 drivers/tty/serial/8250/8250_port.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index cc94af2d578a6..a743964c9d227 100644
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


