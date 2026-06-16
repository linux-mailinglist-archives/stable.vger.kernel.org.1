Return-Path: <stable+bounces-266367-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dhh3FNebMWp+oAUAu9opvQ
	(envelope-from <stable+bounces-266367-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:54:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4878B6948EA
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:54:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=hcM0lSx3;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266367-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266367-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C6F1300A660
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7484C4779BF;
	Tue, 16 Jun 2026 18:54:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553113CC303;
	Tue, 16 Jun 2026 18:54:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636050; cv=none; b=DllqRhXpyqlpNnB/H0Yr8Gb2enHKIkpcfFBDkCmkFVIu+v+WZOJuFrwuRcZ97IVgbd2nRwAZaPVupWXaQyGAXlxjHBzqAlAXB9lBxxTcErYlsAsJEAjGFCrgqqdxY/+9G5U/d1FCAl/PE6yj9rlzu6h/19q73lRTjeYidWhbWBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636050; c=relaxed/simple;
	bh=aHpZctLFRsm7zALIqLPmUGMMEOg2TB+PDRC5NeNx9Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8YrEqr/fCbRhM5KTsBnRwnD4HqpbRewBbc+XQnfUUKgJEUDLkLasF9ckG1dXie16Sel3hqPEW2xdFMo7BfjzhY9ehl6+p+H6bqdy3IOnD4Q2pWL2lopgZLio4ObwxzHWJRi1+ARCmzOL72XZa+696beeI+1kexChHyz96j+/4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hcM0lSx3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547F11F000E9;
	Tue, 16 Jun 2026 18:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781636049;
	bh=1QCU/i6Hwz5rawo2XEfmZJYxQYs3iwSG5yAMG44ojIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hcM0lSx3dW803DINhAvAXWhAkkECVA8qIpFw/7yKw0UVOhcJPn/7Rbf7nIrlQgc25
	 4QvZF+3MEMmBWVmC4XgwMH0ApFJN77O+njWyxpEsMHaD58gwaHirrrrdAm3SaaWSUC
	 flGVlrhqL20hGb9UmpNJ+ryDoPRtFahxlGPTmZ0M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Michal Pecio <michal.pecio@gmail.com>
Subject: [PATCH 5.10 122/342] usb: core: Fix SuperSpeed root hub wMaxPacketSize
Date: Tue, 16 Jun 2026 20:26:58 +0530
Message-ID: <20260616145053.891959720@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266367-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:mathias.nyman@linux.intel.com,m:michal.pecio@gmail.com,m:michalpecio@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux.intel.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4878B6948EA

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Pecio <michal.pecio@gmail.com>

commit d1e280334b7f0a1df441e08bd1f6a1bcc36b3bbb upstream.

There is no good reason to have wBytesPerInterval < wMaxPacketSize -
either one is too low or the other too high, and we may want to warn
about such descriptors. Start with cleaning up our own root hubs.

USB 3.2 section 10.15.1 sets wMaxPacketSize and wBytesPerInterval of
SuperSpeed hub status endpoints at 2 bytes, so reduce wMaxPacketSize
from its former value of 4, which was derived from USB 2.0 spec and
the kernel's USB_MAXCHILDREN limit. They don't apply because USB 3.2
10.15.2.1 specifies SuperSpeed hubs to have up to 15 ports.

Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Link: https://patch.msgid.link/20260518073121.7bc1da0f.michal.pecio@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/hcd.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -353,9 +353,7 @@ static const u8 ss_rh_config_descriptor[
 	USB_DT_ENDPOINT, /* __u8 ep_bDescriptorType; Endpoint */
 	0x81,       /*  __u8  ep_bEndpointAddress; IN Endpoint 1 */
 	0x03,       /*  __u8  ep_bmAttributes; Interrupt */
-		    /* __le16 ep_wMaxPacketSize; 1 + (MAX_ROOT_PORTS / 8)
-		     * see hub.c:hub_configure() for details. */
-	(USB_MAXCHILDREN + 1 + 7) / 8, 0x00,
+	0x02, 0x00, /* __le16 ep_wMaxPacketSize; 2 bytes per USB3 10.15.1 */
 	0x0c,       /*  __u8  ep_bInterval; (256ms -- usb 2.0 spec) */
 
 	/* one SuperSpeed endpoint companion descriptor */



