Return-Path: <stable+bounces-228278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLkPLN5RwWnqSAQAu9opvQ
	(envelope-from <stable+bounces-228278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:44:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EC02F5180
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E39A311DDAC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837123B38A5;
	Mon, 23 Mar 2026 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N29Fe2EN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4575D23BCFD;
	Mon, 23 Mar 2026 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274667; cv=none; b=arkW7mdflgBBcSAJ7v+t3//uDFkOk5XxKkdnZkvnn2l+DCwIz4JXqKrY2+3fgoGkvrlrgudnwfy/S5CNpkDUQ6FVagiZ8W0ZtARp+nD7cXMT0Exe5fDcVBY3KZRAalbvUCOo4jLUyrdsdfX8bO3Wo335ExHS5HgK4S6534q2Www=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274667; c=relaxed/simple;
	bh=PgaB0uceDATYatEzhCR59mT4oJPE7rowdup3pzCU5gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2ePGhtuaeA8KhaXySyCPE/kk5WAjbk1Aa9F3b6vhyTMYEaQ23Ul3xZgMG/XzX1g5t7S4kX3OnZ7maKLDel5LZue5GQO8/dVgSCtUghEyDYKuKsFFe/GHyZfaPlz0FJoB/1TRuVlbon6HwdCWhkMr/dJ2SAmIYUDwJw1fKa/zl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N29Fe2EN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD54BC2BCB4;
	Mon, 23 Mar 2026 14:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274667;
	bh=PgaB0uceDATYatEzhCR59mT4oJPE7rowdup3pzCU5gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N29Fe2ENG/YjelpC/WV2GIBv3NE0AAd3xcljUmBwjpYtHDg2KMjUn8p1no8eJIjdP
	 wVpzgYu2uBP3Vnu+yoglJLQEEvZapz3vzg8D4M/DYgadCmJloRVutSH1q1Lm0Monjc
	 IDMas3w43Tma1iord4Rm3TkM+Z66bvU/z+w8vKno=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Alban Bedel <alban.bedel@lht.dlh.de>,
	Maximilian Lueer <maximilian.lueer@lht.dlh.de>
Subject: [PATCH 6.18 069/212] serial: 8250: always disable IRQ during THRE test
Date: Mon, 23 Mar 2026 14:44:50 +0100
Message-ID: <20260323134505.950339978@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228278-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 30EC02F5180
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Zhang <zhangpeng.00@bytedance.com>

commit 24b98e8664e157aff0814a0f49895ee8223f382f upstream.

commit 039d4926379b ("serial: 8250: Toggle IER bits on only after irq
has been set up") moved IRQ setup before the THRE test, in combination
with commit 205d300aea75 ("serial: 8250: change lock order in
serial8250_do_startup()") the interrupt handler can run during the
test and race with its IIR reads. This can produce wrong THRE test
results and cause spurious registration of the
serial8250_backup_timeout timer. Unconditionally disable the IRQ for
the short duration of the test and re-enable it afterwards to avoid
the race.

Fixes: 039d4926379b ("serial: 8250: Toggle IER bits on only after irq has been set up")
Depends-on: 205d300aea75 ("serial: 8250: change lock order in serial8250_do_startup()")
Cc: stable <stable@kernel.org>
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Alban Bedel <alban.bedel@lht.dlh.de>
Tested-by: Maximilian Lueer <maximilian.lueer@lht.dlh.de>
Link: https://patch.msgid.link/20260224121639.579404-1-alban.bedel@lht.dlh.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_port.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2147,8 +2147,7 @@ static void serial8250_THRE_test(struct
 	if (up->port.flags & UPF_NO_THRE_TEST)
 		return;
 
-	if (port->irqflags & IRQF_SHARED)
-		disable_irq_nosync(port->irq);
+	disable_irq(port->irq);
 
 	/*
 	 * Test for UARTs that do not reassert THRE when the transmitter is idle and the interrupt
@@ -2170,8 +2169,7 @@ static void serial8250_THRE_test(struct
 		serial_port_out(port, UART_IER, 0);
 	}
 
-	if (port->irqflags & IRQF_SHARED)
-		enable_irq(port->irq);
+	enable_irq(port->irq);
 
 	/*
 	 * If the interrupt is not reasserted, or we otherwise don't trust the iir, setup a timer to



