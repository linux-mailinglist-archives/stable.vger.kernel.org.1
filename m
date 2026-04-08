Return-Path: <stable+bounces-233850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iINQNbxC1mkFCwgAu9opvQ
	(envelope-from <stable+bounces-233850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 13:57:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2393BB90B
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 13:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA459303C4F1
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 11:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D963A1D07;
	Wed,  8 Apr 2026 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vlvMxEYU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EDB258EDB
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649430; cv=none; b=ZsKYsxDl8tLgafLArqGnMubhxZ+lbvRUjG+IBntSoA1cGqBwrwuhWBIOoB5f9CWZ48kMy1EfnGvO8rh5lVzSmoBCE2DqeONayuBYBl8owJNFa0kedbSpYjOAYxsa/H0/HvdaF7t3hWJwpaA5exjEkVVsm1fmadLFN/XDbr/MZT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649430; c=relaxed/simple;
	bh=Ny2Q75TEt2joGAxxFSQaj2wF9aA5YGl/6wo5L1l5lZo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JRNrjeDTmOlT8g2qO7Jj++HpB0rNZmIVK1JXpSakPiYXbb+RTHJZzIlPHvbYuSxhSlqz8kMHTg3YxH5UgULmV4XykSlYycCe1HyfjK0ffK9/lV8BznuI0lhAkO6fC0Jby34lxaN2zhYyCybGozu5mWbpZXEiH+BR0dIuVHZxrG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vlvMxEYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F68C19424;
	Wed,  8 Apr 2026 11:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775649429;
	bh=Ny2Q75TEt2joGAxxFSQaj2wF9aA5YGl/6wo5L1l5lZo=;
	h=Subject:To:Cc:From:Date:From;
	b=vlvMxEYU9c2KUs41nmTwRohWfyGeaa0W3ZAuW11XQ4msPJpOJ96bY8Br2dZXyM+d9
	 FM9jex5l3JoB/4nLVgqALP6ZH2i2txdxX+I1JtpT8pox92k6HKcjHoXCmFen4M5Yc5
	 kGyQJTDsyEc9iVocvYEeuH/HOfTOYUaIJZ7bslO0=
Subject: FAILED: patch "[PATCH] usb: gadget: u_ether: Fix race between gether_disconnect and" failed to apply to 5.15-stable tree
To: khtsai@google.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 13:56:57 +0200
Message-ID: <2026040856-reunion-region-2d33@gregkh>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233850-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 0A2393BB90B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e1eabb072c75681f78312c484ccfffb7430f206e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040856-reunion-region-2d33@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e1eabb072c75681f78312c484ccfffb7430f206e Mon Sep 17 00:00:00 2001
From: Kuen-Han Tsai <khtsai@google.com>
Date: Wed, 11 Mar 2026 17:12:15 +0800
Subject: [PATCH] usb: gadget: u_ether: Fix race between gether_disconnect and
 eth_stop

A race condition between gether_disconnect() and eth_stop() leads to a
NULL pointer dereference. Specifically, if eth_stop() is triggered
concurrently while gether_disconnect() is tearing down the endpoints,
eth_stop() attempts to access the cleared endpoint descriptor, causing
the following NPE:

  Unable to handle kernel NULL pointer dereference
  Call trace:
   __dwc3_gadget_ep_enable+0x60/0x788
   dwc3_gadget_ep_enable+0x70/0xe4
   usb_ep_enable+0x60/0x15c
   eth_stop+0xb8/0x108

Because eth_stop() crashes while holding the dev->lock, the thread
running gether_disconnect() fails to acquire the same lock and spins
forever, resulting in a hardlockup:

  Core - Debugging Information for Hardlockup core(7)
  Call trace:
   queued_spin_lock_slowpath+0x94/0x488
   _raw_spin_lock+0x64/0x6c
   gether_disconnect+0x19c/0x1e8
   ncm_set_alt+0x68/0x1a0
   composite_setup+0x6a0/0xc50

The root cause is that the clearing of dev->port_usb in
gether_disconnect() is delayed until the end of the function.

Move the clearing of dev->port_usb to the very beginning of
gether_disconnect() while holding dev->lock. This cuts off the link
immediately, ensuring eth_stop() will see dev->port_usb as NULL and
safely bail out.

Fixes: 2b3d942c4878 ("usb ethernet gadget: split out network core")
Cc: stable <stable@kernel.org>
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
Link: https://patch.msgid.link/20260311-gether-disconnect-npe-v1-1-454966adf7c7@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 1a9e7c495e2e..23c7c0cdf202 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -1223,6 +1223,11 @@ void gether_disconnect(struct gether *link)
 
 	DBG(dev, "%s\n", __func__);
 
+	spin_lock(&dev->lock);
+	dev->port_usb = NULL;
+	link->is_suspend = false;
+	spin_unlock(&dev->lock);
+
 	netif_stop_queue(dev->net);
 	netif_carrier_off(dev->net);
 
@@ -1260,11 +1265,6 @@ void gether_disconnect(struct gether *link)
 	dev->header_len = 0;
 	dev->unwrap = NULL;
 	dev->wrap = NULL;
-
-	spin_lock(&dev->lock);
-	dev->port_usb = NULL;
-	link->is_suspend = false;
-	spin_unlock(&dev->lock);
 }
 EXPORT_SYMBOL_GPL(gether_disconnect);
 


