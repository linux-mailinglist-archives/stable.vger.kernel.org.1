Return-Path: <stable+bounces-229689-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAbtFGtxwWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229689-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:59:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD12D2F93E8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5279631BFBA1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07BB3BF671;
	Mon, 23 Mar 2026 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ScGUJies"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71DE3BF66F;
	Mon, 23 Mar 2026 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282601; cv=none; b=E7WkFtUejHHRV1Dr8HdzUVbEu3olyQox3Y8epn3ykA48najSHp2AlKZoCvXMJ9CRkaag6ZIUoqYlA8Hh/UXmBA6PdXdrxhEUQqVky1BXualAgsrx1jp90Shw9n4g0aILIzPiyHDcief0bbnd09Di2+E+JCPR0iKcXKuWQZrIGfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282601; c=relaxed/simple;
	bh=krjPHeUYHKSxSlM6TzmYOMIevxjvHQcihJScY77Mo7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpI3UcLkj2kblsPHnbFAgiL4kGlCsOOjFVdcox1pBNdNz3hxt6Y87OFWM0mugQgmofwFNHH4SLa6KxPss8FrYesNUi2BhIhQUoTA8thD5dfPlPqPlV+jGOMFKn624dr5IkoY5vdGG7W0VoNL5dTg7LBlsMhRjav6Ru1A1Hnn388=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ScGUJies; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA48C2BC9E;
	Mon, 23 Mar 2026 16:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282601;
	bh=krjPHeUYHKSxSlM6TzmYOMIevxjvHQcihJScY77Mo7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ScGUJiesjAoZDNBg6e59OY9A9Sq+RNNDIsH9/wrUyACjgy4qHyTu6ov79nwXCzjb8
	 IIsOlUL+k5l8TlbXpYmh7lDmhWGjj5+bhKTQ9fESbWWJyn+O4B5+M6XlqcX7qUU0jw
	 62Yrosc/F/i71h6vvg7VLbPtU7Ab9JcMHjXfPrx4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH 6.1 216/481] usb: renesas_usbhs: fix use-after-free in ISR during device removal
Date: Mon, 23 Mar 2026 14:43:18 +0100
Message-ID: <20260323134530.420120704@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229689-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CD12D2F93E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fan Wu <fanwu01@zju.edu.cn>

commit 3cbc242b88c607f55da3d0d0d336b49bf1e20412 upstream.

In usbhs_remove(), the driver frees resources (including the pipe array)
while the interrupt handler (usbhs_interrupt) is still registered. If an
interrupt fires after usbhs_pipe_remove() but before the driver is fully
unbound, the ISR may access freed memory, causing a use-after-free.

Fix this by calling devm_free_irq() before freeing resources. This ensures
the interrupt handler is both disabled and synchronized (waits for any
running ISR to complete) before usbhs_pipe_remove() is called.

Fixes: f1407d5c6624 ("usb: renesas_usbhs: Add Renesas USBHS common code")
Cc: stable <stable@kernel.org>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260303073344.34577-1-fanwu01@zju.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/renesas_usbhs/common.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -800,6 +800,15 @@ static void usbhs_remove(struct platform
 
 	usbhs_platform_call(priv, hardware_exit, pdev);
 	reset_control_assert(priv->rsts);
+
+	/*
+	 * Explicitly free the IRQ to ensure the interrupt handler is
+	 * disabled and synchronized before freeing resources.
+	 * devm_free_irq() calls free_irq() which waits for any running
+	 * ISR to complete, preventing UAF.
+	 */
+	devm_free_irq(&pdev->dev, priv->irq, priv);
+
 	usbhs_mod_remove(priv);
 	usbhs_fifo_remove(priv);
 	usbhs_pipe_remove(priv);



