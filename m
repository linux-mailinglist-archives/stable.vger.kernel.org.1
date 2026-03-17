Return-Path: <stable+bounces-226291-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IILZC+iGuWncJAIAu9opvQ
	(envelope-from <stable+bounces-226291-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:52:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F5F2AE928
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 978A8300C7FE
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7743F54A6;
	Tue, 17 Mar 2026 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bdcRN1YJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322073F23DD;
	Tue, 17 Mar 2026 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766054; cv=none; b=f9Wvo7JiJaH3fv/w3JtKiADt6WTxs+K4c1BzIEunrcDhdlQmeXDRe/QJLv44EkSeK7JQRioXUrHMTwNKoWhSIOFKNSrEgW+Cp4MgyjAVuh31dTJUJSYr5ePCN12l6fi4BRBX9aLOXAN/MZmfUXKD22g6y5cOCYt6j7PQmOlvLwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766054; c=relaxed/simple;
	bh=VCFsoulLwg9NcKHoTuQ+q+hU7PZp1X9ZV4C+ZcczrCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuRHHDyXXGwNVN93tA6TLvoJylRjBtxUtHQMeUYB7fXTzwjUoCSEOXz5ev8J5BPHMxbBa/fLUstcTOfOcwmNBOLFwZPknsMGdcXqDFX49tKjYKIDdDRblgR6J4lVjvCHA3ng/FEpm2K3dQutOdprVf4JqUqftRawyhlRzJgmdFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bdcRN1YJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F78CC2BC86;
	Tue, 17 Mar 2026 16:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766054;
	bh=VCFsoulLwg9NcKHoTuQ+q+hU7PZp1X9ZV4C+ZcczrCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bdcRN1YJNcdGQbcBZ85hdI6oyqp6al2NZVK5BlfDDgKFEj8P4VyxlxXJs7Bw37Hr1
	 XYqkuUIlEC2/BuZet6DnWj4U01SqBpqsYGPYBfR11ShWCylkA7c0CTnpmprYBP94Tj
	 iFzs0rkb4aUJCyC7c0L7HCuVKK1N5KdWvi+6r280=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH 6.19 159/378] usb: renesas_usbhs: fix use-after-free in ISR during device removal
Date: Tue, 17 Mar 2026 17:31:56 +0100
Message-ID: <20260317163012.860547386@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226291-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,harvard.edu:email,msgid.link:url]
X-Rspamd-Queue-Id: 21F5F2AE928
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -815,6 +815,15 @@ static void usbhs_remove(struct platform
 
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



