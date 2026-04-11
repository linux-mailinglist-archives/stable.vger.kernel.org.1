Return-Path: <stable+bounces-235759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACCJC9uP2mmI3wgAu9opvQ
	(envelope-from <stable+bounces-235759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 20:15:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6D83E145B
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 20:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68215301AB85
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 18:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6502FD7BC;
	Sat, 11 Apr 2026 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKIaemnI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6FF2FD1AA
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775931249; cv=none; b=ShAVR1a68Hwsut9zZBBjwSZGlgwnP+m8CTvkO/gw9XJBjAMTUuBPoirr+LgoGapFrfIGecLADxmnfSNRz6BmyN1BeOWarw1ssfq8AUF51jqPXJN1CxFE1nnVnBaB0tSHOF0b7jNkNIBSwiCi62zXloKXBawrOED2MvGTIhSdh4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775931249; c=relaxed/simple;
	bh=5aq4N62foqNYT+t5VZ1OlYE14tvZzl8HniGQVdkmFvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lgzz1UP0FO0Ahljj2VWUDm1l/lj1aHzYGyJGBVfnMnTX6GBzcEjcMIcBDB5+cV0oXTMHKX24KcNs69X4+qiOJ8NUU4wIjX4uCi+WwLf2r/alsb8p9ecM3rWVqR4wsE5BPyFaFc/cHI4vrZIDaxIL/mw66ettwpFkv4tlmYb3t/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKIaemnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64ACFC2BCAF;
	Sat, 11 Apr 2026 18:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775931249;
	bh=5aq4N62foqNYT+t5VZ1OlYE14tvZzl8HniGQVdkmFvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WKIaemnIgKh0kxl5WODW2aDuv8zip9Kt48OEHq/F/NwSBaAfWrmX9hokXlWBsF/rf
	 w2zOcKhYYEwF8YyoxIqsFhNkwUB7loU/UwL2E8ephx6H6kYBbzxYFpV0j9KT4/qgdb
	 4YJMwY0Q/iETxfbKQxNUgrTm1eDqULm0aXNgw3662topztzJE9nnJNX6e3k691MoZ0
	 Mr4YXM/Y3+q0S3vWJrvqL5lJBROdZPOxeZAQQyFzdOvfUpLWMN5cNlQKpCfLrBfBij
	 ZM82uiqC09Be7gNnkLEBeS/3W9r5FApGGtFtX+5U4yfdfTco/Lc+qXeO0k7tvcNhgd
	 UbgvJtJlgTSZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: gadget: u_ether: Fix race between gether_disconnect and eth_stop
Date: Sat, 11 Apr 2026 14:14:06 -0400
Message-ID: <20260411181406.842742-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040857-duvet-scorer-b82f@gregkh>
References: <2026040857-duvet-scorer-b82f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235759-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,msgid.link:url]
X-Rspamd-Queue-Id: 6C6D83E145B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kuen-Han Tsai <khtsai@google.com>

[ Upstream commit e1eabb072c75681f78312c484ccfffb7430f206e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/u_ether.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 5e5f699a434f4..ca8ba978159a3 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -1141,6 +1141,10 @@ void gether_disconnect(struct gether *link)
 
 	DBG(dev, "%s\n", __func__);
 
+	spin_lock(&dev->lock);
+	dev->port_usb = NULL;
+	spin_unlock(&dev->lock);
+
 	netif_stop_queue(dev->net);
 	netif_carrier_off(dev->net);
 
@@ -1178,10 +1182,6 @@ void gether_disconnect(struct gether *link)
 	dev->header_len = 0;
 	dev->unwrap = NULL;
 	dev->wrap = NULL;
-
-	spin_lock(&dev->lock);
-	dev->port_usb = NULL;
-	spin_unlock(&dev->lock);
 }
 EXPORT_SYMBOL_GPL(gether_disconnect);
 
-- 
2.53.0


