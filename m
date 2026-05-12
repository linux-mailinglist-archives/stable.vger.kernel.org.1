Return-Path: <stable+bounces-245610-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPlkHgoxA2oA1gEAu9opvQ
	(envelope-from <stable+bounces-245610-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:54:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B65F6521BC4
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DE3B30C368B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47816399CE4;
	Tue, 12 May 2026 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="EIi8lVHL"
X-Original-To: stable@vger.kernel.org
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319643905E6;
	Tue, 12 May 2026 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593616; cv=none; b=OqEY6t2nmMINdrDgWyKBvrwrEqJzNaCEcLR+yvUfmSdnl0boO/qOWrfg5Uvg7MScOloeevgNKlbIk2G/hsdGMxgYtKSpK3K5adMe8ZaMMRd8ChX0HIzKcVRmSP+wo6aDhlecE+MThMZIuVptjhMFkD0RF5qrnNVdC1uLbegCZ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593616; c=relaxed/simple;
	bh=pD/TIRqDBL2gNCarLAfMgoSHPi48/blEreoh5bgIh4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxHk53uwYyemCMv5/bGmPCPSmpVf2EzHfFeh860YjfWGuRWLznLaGErdoi7OBijkLlMmoSiarQsFUXqXIbEiA+rlNbPXo4AakVT7RDgfVVpSYlNypY8wKcPlczt8IpIMRafW7cklFS9m1VvL1EfYQLpntL1YebzgUIvJfdhO3cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=EIi8lVHL; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from Gigabyte.tail209581.ts.net (unknown [IPv6:2a02:8428:7df0:ac01:fbfd:168d:553c:3eec])
	(Authenticated sender: jnilo@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id B8F96780371;
	Tue, 12 May 2026 15:46:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1778593611;
	bh=pD/TIRqDBL2gNCarLAfMgoSHPi48/blEreoh5bgIh4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EIi8lVHL4tB2DyOnrijHsxieXXdI74ApcqFhFRkGrsCuycGgeNnFni2qNizxht9uF
	 ZJTN9r35hihLAKdhWVI1n1Ph9cqsd1qQ9NjTySIJBAm7q/2rzEePiqdVX2F+JsVwEx
	 G3uVFqsCBL2HQ/fdMAiqqZr26I6q9LJmq5Fn9sCrdMehVHkIZ6+2oZhCYhRcR5RZHl
	 YUIXkygLbqFtZuxBQh6blT0sIhvBPBegfAii0VWTushYwLCtyR3KepmAOC1k+JVCWj
	 TxAZ5ucewjcblQ3O1fpuitXibZYbKh59+EyD4ArS6tNgldO5WMn/HVJZ4Wcfu8SXMV
	 GTYQU0LfTA6fQ==
From: Jacques Nilo <jnilo@free.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Jacques Nilo <jnilo@free.fr>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] serial: 8250_dw: dispatch SysRq character in dw8250_handle_irq()
Date: Tue, 12 May 2026 15:46:14 +0200
Message-ID: <340a4a76e5dbeb2e49ad4b8d41b9631e09e94bec.1778592805.git.jnilo@free.fr>
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
X-Rspamd-Queue-Id: B65F6521BC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[free.fr,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[free.fr:s=smtp-20201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,kernel.org,free.fr];
	TAGGED_FROM(0.00)[bounces-245610-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
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

Switch to guard(uart_port_lock_sysrq_irqsave) so that captured
sysrq_ch is dispatched on scope exit, matching the fix in
serial8250_handle_irq().

Fixes: 883c5a2bc934 ("serial: 8250_dw: Rework dw8250_handle_irq() locking and IIR handling")
Cc: stable@vger.kernel.org
Signed-off-by: Jacques Nilo <jnilo@free.fr>
---
 drivers/tty/serial/8250/8250_dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 55e40c10f..237543fa7 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -416,7 +416,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 	unsigned int quirks = d->pdata->quirks;
 	unsigned int status;
 
-	guard(uart_port_lock_irqsave)(p);
+	guard(uart_port_lock_sysrq_irqsave)(p);
 
 	switch (FIELD_GET(DW_UART_IIR_IID, iir)) {
 	case UART_IIR_NO_INT:
-- 
2.43.0


