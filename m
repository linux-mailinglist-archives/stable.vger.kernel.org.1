Return-Path: <stable+bounces-254522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FvhEii5FmqLqAcAu9opvQ
	(envelope-from <stable+bounces-254522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:28:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3885E1CE0
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E71933073940
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 09:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD79C3E5EDB;
	Wed, 27 May 2026 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="VpH5rKFj"
X-Original-To: stable@vger.kernel.org
Received: from va-2-43.ptr.blmpb.com (va-2-43.ptr.blmpb.com [209.127.231.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C193E9C24
	for <stable@vger.kernel.org>; Wed, 27 May 2026 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779873695; cv=none; b=rbFJ16khMXEY34WkKAnfmeKyBHXzhuVcKn0KYSpvTRUJrN/v32teL5t0QCaaOxm+XH8dPYTM+fRWejgV4/s4kDU6CPcuEqvsLqtNnNo0VV5uIBTFX5ycGPfwusUObsyCZMGhOFi3NWC5M1ymi5IEx6ENck/R/RLzdEeYKdwzRcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779873695; c=relaxed/simple;
	bh=S+5GI1blprI6x2YklGfEGYsrCFCSjrI/gKpgddM49DY=;
	h=To:Message-Id:Content-Type:Date:From:Cc:Subject:Mime-Version; b=VASS05IcrwlrfiVCmsvaKtXBn+RSH2VFskFAuECeLkGKd6JujhvwdW9mP9GkC10vfQdKA0gVCa2HTgLAapDEuRgmP/Evpf3mXVA0+FcKK1a39CCVlBhOLdRG+wvo1my9V/mEb5qBOZcS7ssEYuAESQStkpPrdilPNEwYfQYMLmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=VpH5rKFj; arc=none smtp.client-ip=209.127.231.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1779873673;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=InUK12/NH4edD4/4dGiVUh9j6QptA0Nv0X9+dE9Re14=;
 b=VpH5rKFjcxuABYBKjekDRvIwqk3oeqPJ4q/V5dHZf/MzPPJansa4yG8Q7QGqoCvirxec8y
 z2qB+nY4lgtVCeLaEW/8D2Ft5W1vsmYnJO3lxlWEnEWQIxUdtCUn+3X5E6fuIM/zJDDR/h
 GKVZmoUoRtvS0KGMpcZkJJn1aQshPavL2McHepv9nIUCP8XUUuZcHfS1GSgkvqIrr/4Fh1
 ViZlz1aM/I/txLhL7+VKYoKihqDh2REycHGeLGp4TpQl7/TLp3z3iqJHtHBDQtziOJMSNW
 gf089dQNHNdv7ZckuZT4Q/IOU86tg0ExBCu87rJ8kQioL7adtDKf4DFCxW0X6w==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	"Jiri Slaby" <jirislaby@kernel.org>, 
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Xin Zhao" <jackzxcui1989@163.com>, 
	"Andy Shevchenko" <andy.shevchenko@gmail.com>, 
	"Kees Cook" <kees@kernel.org>, "Ingo Molnar" <mingo@kernel.org>, 
	"Bing Fan" <tombinfan@tencent.com>, 
	"Guanbing Huang" <albanhuang@tencent.com>, 
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Message-Id: <20260527092052.2086342-1-wangzhaolong@fnnas.com>
X-Lms-Return-Path: <lba+26a16b787+9545ca+vger.kernel.org+wangzhaolong@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 17:20:51 +0800
Received: from MiniServer ([113.111.184.228]) by smtp.feishu.cn with ESMTPS; Wed, 27 May 2026 17:21:10 +0800
X-Original-From: Wang Zhaolong <wangzhaolong@fnnas.com>
From: "Wang Zhaolong" <wangzhaolong@fnnas.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 7bit
Cc: "Wang Zhaolong" <wangzhaolong@fnnas.com>, <stable@vger.kernel.org>
Subject: [PATCH] serial: 8250: serialize shared IRQ startup
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[fnnas-com.20200927.dkim.feishu.cn:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[fnnas.com];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,linux.intel.com,163.com,gmail.com,tencent.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[fnnas-com.20200927.dkim.feishu.cn:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangzhaolong@fnnas.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254522-lists,stable=lfdr.de];
	NEURAL_HAM(-0.00)[-0.833];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fnnas-com.20200927.dkim.feishu.cn:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fnnas.com:mid,fnnas.com:email]
X-Rspamd-Queue-Id: DA3885E1CE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Concurrent startup of two 8250 ports sharing the same IRQ can trigger an
IRQ core warning:

  Unbalanced enable for IRQ 3
  WARNING: CPU: 0 PID: 580 at kernel/irq/manage.c:774 __enable_irq+0x3b/0x60
  Call Trace:
   enable_irq+0x8d/0x120
   serial8250_do_startup+0x80d/0xa80
   uart_port_startup+0x13d/0x440
   uart_port_activate+0x5b/0xb0
   tty_port_open+0xa1/0x120
   uart_open+0x1e/0x30
   tty_open+0x140/0x7a0

The second port can then run the shared-IRQ startup test while the IRQ core
is still enabling the line for the first port.  The local
disable_irq_nosync()/enable_irq() pair is balanced, but the interleaving can
still unbalance the IRQ core disable depth.

That makes the QEMU legacy serial ports enter the shared-IRQ THRE test path:

  serial8250_do_startup()
    if (port->irqflags & IRQF_SHARED)
      disable_irq_nosync(port->irq)
    ...
    if (port->irqflags & IRQF_SHARED)
      enable_irq(port->irq)

One possible interleaving is:

  CPU0, ttyS1                         CPU1, ttyS3

  serial_link_irq_chain()
    hash_add(i)
    i->head = &ttyS1
    request_irq()
                                        serial_link_irq_chain()
                                          find i in irq_lists
                                          list_add(&ttyS3, i->head)
                                        serial8250_do_startup()
                                          disable_irq_nosync(irq)
    irq_startup()
      desc->depth = 0
                                          enable_irq(irq)
                                            WARN: Unbalanced enable for IRQ 3

Keep hash_mutex held in serial_link_irq_chain() until the first request_irq()
has completed.  This prevents another 8250 port sharing the IRQ from joining
the chain and running the THRE test while the IRQ core is still starting the
interrupt.

This was reproduced in QEMU with ttyS1 and ttyS3 sharing IRQ 3.  With this
change, 100000 synchronized open/close iterations on /dev/ttyS1 and /dev/ttyS3
completed without the warning.

Fixes: 64c79dfbc458 ("serial: 8250_pnp: Support configurable reg shift property")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221579
Cc: stable@vger.kernel.org # 6.10+
Assisted-by: Codex:gpt-5
Signed-off-by: Wang Zhaolong <wangzhaolong@fnnas.com>
---
 drivers/tty/serial/8250/8250_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a428e88938eb..64eed4dc343f 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -132,12 +132,10 @@ static void serial_do_unlink(struct irq_info *i, struct uart_8250_port *up)
  */
 static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_port *up)
 {
 	struct irq_info *i;
 
-	guard(mutex)(&hash_mutex);
-
 	hash_for_each_possible(irq_lists, i, node, up->port.irq)
 		if (i->irq == up->port.irq)
 			return i;
 
 	i = kzalloc_obj(*i);
@@ -154,10 +152,12 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
 static int serial_link_irq_chain(struct uart_8250_port *up)
 {
 	struct irq_info *i;
 	int ret;
 
+	guard(mutex)(&hash_mutex);
+
 	i = serial_get_or_create_irq_info(up);
 	if (IS_ERR(i))
 		return PTR_ERR(i);
 
 	scoped_guard(spinlock_irq, &i->lock) {
@@ -169,10 +169,15 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 
 		INIT_LIST_HEAD(&up->list);
 		i->head = &up->list;
 	}
 
+	/*
+	 * Keep the shared-IRQ chain locked until the first handler is installed.
+	 * Otherwise another UART can join early and run startup IRQ masking while
+	 * the IRQ core is still enabling the line, unbalancing the disable depth.
+	 */
 	ret = request_irq(up->port.irq, serial8250_interrupt, up->port.irqflags, up->port.name, i);
 	if (ret < 0)
 		serial_do_unlink(i, up);
 
 	return ret;
-- 
2.54.0

