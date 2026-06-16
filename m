Return-Path: <stable+bounces-265433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QkPUFxuKMWo0mAUAu9opvQ
	(envelope-from <stable+bounces-265433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:38:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD2E693547
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:38:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Qv0k1Hbp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265433-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265433-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BE16319DB3E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B0647AF5F;
	Tue, 16 Jun 2026 17:32:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3843A3E78;
	Tue, 16 Jun 2026 17:32:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631178; cv=none; b=tDHWo/nj+K8V/6yzw4Zi4qXyTUpTaaYcmw6z//lsPkT8bTXo/WQPcQaYU4EAQdoRKBPpNCTZuMoz9HROD5qbPuPl4EdU7QTjT4Nk2bsmKuY2zzwnLOthOtocG51GpeTKy+aFqhx8H0mnKSzJ+06udvrcRtmyv1Jvxr+sKLSyhlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631178; c=relaxed/simple;
	bh=vA4W3axpsa6D3RBCTY3plh6uepX8HdHRNmqp+AryzxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+TIkAW0uY+ptAg4YzYwaG8BAl0xSUDYQopuYnsn8CPxx/vV986aKz2T+J6J0egqhewtUWxRT7a+dcHGupsAvF3a0cViW+VfNN/LyWdpP0j6VU4486Z1dYNDI6sKFNmPzZcAW3prQDQ4Hzy7wP8i0SX9gjgcuZDud3lphLtRb5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qv0k1Hbp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6871C1F000E9;
	Tue, 16 Jun 2026 17:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631177;
	bh=yvNq9VkjZDM31M9njzKgbGVKekOQM12bdQwnBzOOwg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qv0k1HbpnLxHDoIOqEktagpAm6nwpsiz2qWjrAyUS76M7X5ECdoiv6JKLuLjqJGry
	 Niv/GhJbycYwALgonwgzI4T4FH0K82Am7lRyGL5gM5ATVYdC6nC3akP8ncaYJ1Dg6t
	 yvaYlRID32Y8hqGXHNk242TXoQhwHZavQoIUlzrI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH 6.1 170/522] serial: altera_jtaguart: handle uart_add_one_port() failures
Date: Tue, 16 Jun 2026 20:25:17 +0530
Message-ID: <20260616145134.107391705@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265433-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:ae878000@gmail.com,m:mhun512@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADD2E693547

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Myeonghun Pak <mhun512@gmail.com>

commit ea66be25f0e934f49d24cd0c5845d13cdba3520b upstream.

altera_jtaguart_probe() maps the register window before registering the
UART port, but it ignores failures from uart_add_one_port(). If port
registration fails, probe still returns success and the mapping remains
live until a later remove path that is not part of probe failure cleanup.

Return the uart_add_one_port() error and unmap the register window on
that failure path.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 5bcd601049c6 ("serial: Add driver for the Altera JTAG UART")
Cc: stable <stable@kernel.org>
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20260512065837.79528-1-mhun512@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/altera_jtaguart.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -425,6 +425,7 @@ static int altera_jtaguart_probe(struct
 	struct resource *res_mem;
 	int i = pdev->id;
 	int irq;
+	int ret;
 
 	/* -1 emphasizes that the platform must have one port, no .N suffix */
 	if (i == -1)
@@ -464,7 +465,11 @@ static int altera_jtaguart_probe(struct
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->dev = &pdev->dev;
 
-	uart_add_one_port(&altera_jtaguart_driver, port);
+	ret = uart_add_one_port(&altera_jtaguart_driver, port);
+	if (ret) {
+		iounmap(port->membase);
+		return ret;
+	}
 
 	return 0;
 }



