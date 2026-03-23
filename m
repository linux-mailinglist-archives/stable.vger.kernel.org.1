Return-Path: <stable+bounces-229187-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2kN6FBtbwWlKSgQAu9opvQ
	(envelope-from <stable+bounces-229187-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:24:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6182F6379
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A83A3028242
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2F53B47D3;
	Mon, 23 Mar 2026 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XqRlZckL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524253B47CC;
	Mon, 23 Mar 2026 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278335; cv=none; b=uInpftkpPAZkN+I0Un9EfjZqlXsA2OCoNAMqoFOlVXQcmCci95X8OO/tNtReLxrk9oJyw7AoPfi5m0ZRxpBj1vVV5l5NXtTr/q5GKA5qB1V+HZHUN0L5yinU9/i9Wqb5fIWzvtwqWxqjRBtedTyjPQjpH1tMWo5rTlW2sOC+z6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278335; c=relaxed/simple;
	bh=U29+0NKCpZycOWQo7KBSOfBCY44nReAHzXqRUZ7HUi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVWK9XSqLzQQtNe68S/UH4cb9BoErKuO50Si0w5ki0z1LsN/0bIkT6yw+Ay89vaPmRoZ5gZU2FXlGUGbA/ircQu99iKvcwMiu/X24TLClSIrXaX68/7iotSVO2Gurvk1SxIlYn9FUt6OUK3nSjl8uitEetqq2oMCCp24zFCBg9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XqRlZckL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928BAC4CEF7;
	Mon, 23 Mar 2026 15:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278335;
	bh=U29+0NKCpZycOWQo7KBSOfBCY44nReAHzXqRUZ7HUi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XqRlZckLLL+zgimlCRqcxt3mqh7GMfM3F4r0JwjJCkJwPpCZKcVbEZ+ZXYCyqvgRt
	 ObzrpQ8aJRRxpKq3QZmLp6X+eGLZFzcNcZKQ+B9Zvup04s+w22qzQsLvrX21PCb/u+
	 8CEY1Rkyl0XBuwGsxqAsOa9U6hDzvmvbV8izflfg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dayu Jiang <jiangdayu@xiaomi.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 6.6 273/567] usb: xhci: Prevent interrupt storm on host controller error (HCE)
Date: Mon, 23 Mar 2026 14:43:13 +0100
Message-ID: <20260323134540.585843131@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229187-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 3A6182F6379
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3219,6 +3219,7 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd
 
 	if (status & STS_HCE) {
 		xhci_warn(xhci, "WARNING: Host Controller Error\n");
+		xhci_halt(xhci);
 		goto out;
 	}
 



