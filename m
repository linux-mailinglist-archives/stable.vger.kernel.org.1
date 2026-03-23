Return-Path: <stable+bounces-229241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EGyCGJcwWlZSgQAu9opvQ
	(envelope-from <stable+bounces-229241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:29:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F572F65BA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48D21309FC1D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BBA3AD539;
	Mon, 23 Mar 2026 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VSHY11cw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9879B248F6F;
	Mon, 23 Mar 2026 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278503; cv=none; b=OHzbrI8D3OGmgHXQKU4AG9y+0Rwq1Gn9KVasB/LgLc/0dwdSI0DCsC0SlFkL91dmCz0hcU8Z8qzcdH2u3BDZoaWLLObWAvZclXP7YAIr5Oiy+ui/gskPc1+jGfq6zgIEu/QKjhe5qdbxjxIX0dl3d8gSdE1TupDmAbDUUQ7YpnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278503; c=relaxed/simple;
	bh=s7rosTRlsNzHNIW/CN/bJtRTlWOOhg4NFIGL671gKv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqdEaDU26ijZ/D/tDFrHpKMUZX1J0EPVChtNraBYYWgBpXSc9Kbsfz0+KIxQbctqs0EeabPbitz+28rgLFfAZMiX9BykLkleMcnDgir8oTxXJjoYRTZa9nhoeW/+1d8HIZx2OtwETpHI8jdG6WdvuSFdRI+B2bzCzhcBm8Tf5AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VSHY11cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4FBC4CEF7;
	Mon, 23 Mar 2026 15:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278503;
	bh=s7rosTRlsNzHNIW/CN/bJtRTlWOOhg4NFIGL671gKv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VSHY11cwWtVDjEQ8dsyoYyHeKe+eq9X26CF6YrH5RnGW+saSSNTrjnbK7fPahxsQS
	 6gB7Y170NTYEgmxGu9DKkhBGR2QbfWP9Sb8iN4beF+A2pT4Fhsa0Kb/6GsC8RIJSuw
	 fN3SzfukwMpueEI1x6TOvd1jFr6T/3tQbVFaMhys=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH 6.6 284/567] usb: renesas_usbhs: fix use-after-free in ISR during device removal
Date: Mon, 23 Mar 2026 14:43:24 +0100
Message-ID: <20260323134540.854186411@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229241-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 89F572F65BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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



