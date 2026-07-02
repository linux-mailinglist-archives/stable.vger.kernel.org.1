Return-Path: <stable+bounces-270693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZrusEcyURmo4ZAsAu9opvQ
	(envelope-from <stable+bounces-270693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:41:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB906FA65A
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:41:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="Z/X7w/t5";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270693-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270693-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA3513261485
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFB63B7B91;
	Thu,  2 Jul 2026 16:26:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A2397E81;
	Thu,  2 Jul 2026 16:26:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009605; cv=none; b=bzOn0zCPV3xggDUbkksaLHJ7zGYoBJAo4yej1hAia+KZlmB9y6qtv8hfc1D59wuelL4SbOVFVsIX+Xqg/fSKwK2gbRgZENTNCVGJ3tsiFAKXKJ7OObxSZfsOm+lQe5kgTIJKS1CAYhW9ROvi2EWoY4GU/N5oPDEgDfssFdMaLoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009605; c=relaxed/simple;
	bh=yTSTeNk3K1sCqQlHLX0A0aiEgm/byLi6VO5dLGNFG5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lh9ba/pAgDSo/OTHTmm/BsI8d45UPOggegGP0Y/vbHKTQ9QqCWokqVKSCCXASJ8T2y8T6sKjIgw27oMn6eRKpl1tuoQ2hYHCNhWqSUhMg6D+zTMHpstdUabR+RVC5yuKxUD+dx2pChKwM5US/+xTOfbEnuUjw8AKN2WNxWOqnV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z/X7w/t5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E081F00A3A;
	Thu,  2 Jul 2026 16:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009602;
	bh=JEHJAVBVMkDrmbsAvMsHd6M6+BKqT5dlBwaCdX0W+hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z/X7w/t5QVReSBu4zlDSaOsnVmGB6ZnH09jBYLnOBx6EbIu2G/4korWG8OlnD71fk
	 YUn6cQUgu7jd0bjx6Mtj61RIRNlKJE7uWPnVxXxYcfen2lN0pgAho9syHiD5H8abHz
	 nj9JSaf7w3eLDoM8TlOz/LXj8sWmNh9vKGp6Z2+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Wang <00107082@163.com>,
	Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Justin Chen <justin.chen@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 18/95] xhci: fix memory leak regression when freeing xhci vdev devices depth first
Date: Thu,  2 Jul 2026 18:19:21 +0200
Message-ID: <20260702155109.589842234@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155109.196223802@linuxfoundation.org>
References: <20260702155109.196223802@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,163.com,gmail.com,linux.intel.com,broadcom.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-270693-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:00107082@163.com,m:michal.pecio@gmail.com,m:mathias.nyman@linux.intel.com,m:justin.chen@broadcom.com,m:sashal@kernel.org,m:michalpecio@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,broadcom.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5EB906FA65A

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit edcbe06453ddfde21f6aa763f7cab655f26133cc upstream

Suspend-resume cycle test revealed a memory leak in 6.17-rc3

Turns out the slot_id race fix changes accidentally ends up calling
xhci_free_virt_device() with an incorrect vdev parameter.
The vdev variable was reused for temporary purposes right before calling
xhci_free_virt_device().

Fix this by passing the correct vdev parameter.

The slot_id race fix that caused this regression was targeted for stable,
so this needs to be applied there as well.

Fixes: 2eb03376151b ("usb: xhci: Fix slot_id resource race conflict")
Reported-by: David Wang <00107082@163.com>
Closes: https://lore.kernel.org/linux-usb/20250829181354.4450-1-00107082@163.com
Suggested-by: Michal Pecio <michal.pecio@gmail.com>
Suggested-by: David Wang <00107082@163.com>
Cc: stable@vger.kernel.org
Tested-by: David Wang <00107082@163.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250902105306.877476-4-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index fb81e61a599d75..7f75298a09d6fc 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -961,7 +961,7 @@ static void xhci_free_virt_devices_depth_first(struct xhci_hcd *xhci, int slot_i
 out:
 	/* we are now at a leaf device */
 	xhci_debugfs_remove_slot(xhci, slot_id);
-	xhci_free_virt_device(xhci, vdev, slot_id);
+	xhci_free_virt_device(xhci, xhci->devs[slot_id], slot_id);
 }
 
 int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,
-- 
2.53.0




