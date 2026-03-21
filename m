Return-Path: <stable+bounces-227665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHCjICUxvmmqIwMAu9opvQ
	(envelope-from <stable+bounces-227665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:48:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E122E37A7
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B064D303A8D3
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 05:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC2228688C;
	Sat, 21 Mar 2026 05:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cmtdq40r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D921B4F0A
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 05:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774072029; cv=none; b=HB7L6xygWxxWzvi+l8UC8YSyX9T314gA9TMyUM4EmK94sLLloeWwWQVeO6N5m/CpQYsrX+dydnRSGxLL2CVV+Nb1yXrofuc4Jc7YRHxS/m/1mEd2n096Gs882wD+3zX5ymQrr6vDCgeN4ZUpdleiwvJWI+teEqidpAWC2nC3C4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774072029; c=relaxed/simple;
	bh=b6VMoLGSecFz460JyT15z5Q1oYGFFv12gAaSXfvV6sA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ubIYVQXzoY0rWU2xlgIcPo1F4t44TFtV5a/WKkcoc96Ksx2wjUe7shfgPVnEmJ31S7hNhveF5LWiXPr0M7EDmFwMF15rOxfTOQQokR+S3mUpuXvqIr4AVxdPcBxsjqtSBj8yO98srVmJn81mgZVgi+Vkz/FprpPdy4CF8NyaPVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cmtdq40r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F110C19421;
	Sat, 21 Mar 2026 05:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774072028;
	bh=b6VMoLGSecFz460JyT15z5Q1oYGFFv12gAaSXfvV6sA=;
	h=Subject:To:Cc:From:Date:From;
	b=Cmtdq40rzHVokOOdnxgTbo5RkpPWkuY03PQyk8+YQ9+MQGVTNrZkYCwouUVSs9VEg
	 Pl5pKyQmz+reEQTfI4Pab8FP0O9uPOckgMVV5m8co1geiM2ez1RPRegE/JG7VzphhE
	 /fni+B1zFvrNb2Hb8SfR09UD714knNyfjwa3/Ca0=
Subject: FAILED: patch "[PATCH] serial: 8250: always disable IRQ during THRE test" failed to apply to 5.15-stable tree
To: zhangpeng.00@bytedance.com,alban.bedel@lht.dlh.de,gregkh@linuxfoundation.org,maximilian.lueer@lht.dlh.de,songmuchun@bytedance.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 21 Mar 2026 06:46:33 +0100
Message-ID: <2026032133-finalize-barometer-aa69@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227665-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,gregkh:email,dlh.de:email,bytedance.com:email]
X-Rspamd-Queue-Id: E8E122E37A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 24b98e8664e157aff0814a0f49895ee8223f382f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032133-finalize-barometer-aa69@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 24b98e8664e157aff0814a0f49895ee8223f382f Mon Sep 17 00:00:00 2001
From: Peng Zhang <zhangpeng.00@bytedance.com>
Date: Tue, 24 Feb 2026 13:16:39 +0100
Subject: [PATCH] serial: 8250: always disable IRQ during THRE test

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

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index cc94af2d578a..a743964c9d22 100644
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


