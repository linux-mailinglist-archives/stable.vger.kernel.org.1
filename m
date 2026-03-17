Return-Path: <stable+bounces-226277-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBb+BYWFuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226277-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:47:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8022AE658
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE452302CEA8
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739613F23DE;
	Tue, 17 Mar 2026 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qYv6mC0K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174BD3F2101;
	Tue, 17 Mar 2026 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765995; cv=none; b=bZbvUriRh1sbyuLP7t06weKQ3zNLNUn1ZTjijEzAYvjZIn7DKlab2KI8DEqe4z4O5dZLP/DpqnY+27ZHsFr5tq/b4eywHagSc01AqAsrvQapYZGfOEZNPpVTbg0s7wme7nQo92ESrBwFH6ak7TPNEcgVOZ07QbsO/8Tlz3cjAWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765995; c=relaxed/simple;
	bh=er2uH0mHoQuyNJMCTCRrM4m79iV2ptu4LCRD6vhlxt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnY+6qD2+IYuGJqwjJO7wJw79g/Crsndn4HLE82mr08mESxnuM2dSGmFQDMfoR57qVYREHonHBpvsTXGqIetIGk3uPMA/8M8rtes0zOUwnn3o2/CUKkksylZk94hGI/HqbayXwFlfspqHO+fax5ot6xurPg2JOweBSkxRWkrtSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qYv6mC0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4573DC4CEF7;
	Tue, 17 Mar 2026 16:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765994;
	bh=er2uH0mHoQuyNJMCTCRrM4m79iV2ptu4LCRD6vhlxt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qYv6mC0KgB7WirB93sEvJ6atJFDEGEg6zdCHHreIihlTOg167X7ys8qGhO5YRpe2f
	 dU9j9tE6RGb2nJZaoI4uvg0tkEqOqmqJAG+QEUI5BId7EYI2dUaweYuW/7TpeVnfQV
	 bzeR/BdsRFANSi2KZuIFKpHEd0CUSTBkMC9ooCCw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dayu Jiang <jiangdayu@xiaomi.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 6.19 146/378] usb: xhci: Prevent interrupt storm on host controller error (HCE)
Date: Tue, 17 Mar 2026 17:31:43 +0100
Message-ID: <20260317163012.386768467@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226277-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: AB8022AE658
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dayu Jiang <jiangdayu@xiaomi.com>

commit d6d5febd12452b7fd951fdd15c3ec262f01901a4 upstream.

The xHCI controller reports a Host Controller Error (HCE) in UAS Storage
Device plug/unplug scenarios on Android devices. HCE is checked in
xhci_irq() function and causes an interrupt storm (since the interrupt
isn’t cleared), leading to severe system-level faults.

When the xHC controller reports HCE in the interrupt handler, the driver
only logs a warning and assumes xHC activity will stop as stated in xHCI
specification. An interrupt storm does however continue on some hosts
even after HCE, and only ceases after manually disabling xHC interrupt
and stopping the controller by calling xhci_halt().

Add xhci_halt() to xhci_irq() function where STS_HCE status is checked,
mirroring the existing error handling pattern used for STS_FATAL errors.

This only fixes the interrupt storm. Proper HCE recovery requires resetting
and re-initializing the xHC.

CC: stable@vger.kernel.org
Signed-off-by: Dayu Jiang <jiangdayu@xiaomi.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://patch.msgid.link/20260304223639.3882398-3-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-ring.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3195,6 +3195,7 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd
 
 	if (status & STS_HCE) {
 		xhci_warn(xhci, "WARNING: Host Controller Error\n");
+		xhci_halt(xhci);
 		goto out;
 	}
 



