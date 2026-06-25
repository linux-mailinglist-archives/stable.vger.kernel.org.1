Return-Path: <stable+bounces-268445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P/8aFDgoPWpoyAgAu9opvQ
	(envelope-from <stable+bounces-268445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:08:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B52726C5ED3
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:08:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=cOkPfT+i;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268445-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268445-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFD4F303F704
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990C12DB79C;
	Thu, 25 Jun 2026 13:07:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE622BE026;
	Thu, 25 Jun 2026 13:07:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392877; cv=none; b=Th5v185zrZMizDF6Aazck2MHt1uZ2fsLH3uBYMez9CAIw9iwGkl/m67lNTLPI1d+7UKBqqFvXuwKlj6Zc6z8i92EWbYtfFd9Fa/bXY1TP8OWKgUXptX/SHEYwErBwjuxLH2SwaqsNlI3n9XLN2LmBqpSgdYTKg5Ffvg76z3/Wyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392877; c=relaxed/simple;
	bh=xLXFKI0YN3xqrTaSe6lu0cK5kNWBnT0Bt6VOIX3ovV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IptscoDuZAWqojkHaf0KeuEV0Z6o4CWLl/j/n+SevkDl16Y2oo2MC1GlubpM58yi+4RDQzVgKg4dnNVessTJp2tBAelDHCBLWgAjOoe0N0oWdNVqU2nAPtWae4/XGcH5S4EQpSdM5nnJ4ZVOpyjJRiPCeuK6IwQRWMLg4gyRhXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cOkPfT+i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FEC1F000E9;
	Thu, 25 Jun 2026 13:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782392876;
	bh=6zz+eeDHFMzvPjpHB8DUH21fcYS2wUMMr6Rn+CIB7To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cOkPfT+iEGGjLUwcGq/erc84xA7hLz7l1pGAzdGQ0Z48wHGVTGUNPKUaemU06VqJg
	 X6mz0of7rjg8zkej5kitq6v04WZ5Nn66V/2abcaspDQD4QLV7mY1XWleBPvw8gbUj4
	 iIybApr27RhEiRtcbCaAzazhOg9IBiRKqEoqKWqE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.18 50/60] Input: rmi4 - fix memory leak in rmi_set_attn_data()
Date: Thu, 25 Jun 2026 14:03:35 +0100
Message-ID: <20260625125653.011259136@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625125645.554579168@linuxfoundation.org>
References: <20260625125645.554579168@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268445-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:dmitry.torokhov@gmail.com,m:dmitrytorokhov@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B52726C5ED3

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit a55a683a8e2bddb5467baab3e597a93022d4ee05 upstream.

kfifo_put() returns 0 if the FIFO is full. In this case, we must
free the memory allocated for the attention data to avoid a leak.

Fixes: b908d3cd812a ("Input: synaptics-rmi4 - allow to add attention data")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Link: https://patch.msgid.link/20260505045952.1570713-5-dmitry.torokhov@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/rmi4/rmi_driver.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -183,7 +183,11 @@ void rmi_set_attn_data(struct rmi_device
 	attn_data.size = size;
 	attn_data.data = fifo_data;
 
-	kfifo_put(&drvdata->attn_fifo, attn_data);
+	if (!kfifo_put(&drvdata->attn_fifo, attn_data)) {
+		dev_warn_ratelimited(&rmi_dev->dev,
+				     "Failed to enqueue attention data, FIFO full\n");
+		kfree(fifo_data);
+	}
 }
 EXPORT_SYMBOL_GPL(rmi_set_attn_data);
 



