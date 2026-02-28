Return-Path: <stable+bounces-220534-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P5IL0RNo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220534-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E12D71C8257
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B37BF3151735
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D484B3CFD12;
	Sat, 28 Feb 2026 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPN6Yw8V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A703CFD07;
	Sat, 28 Feb 2026 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300417; cv=none; b=CewGd7jJL6z3w0bQHpT0gxT3/EMj7lRw+lFZo6WnSa6iVJ4K+6vQTMwIe4cCZND+Wi7ZhMece9fOjEM5FsxgO4kBtic2ekPa56McWZocx9M4IhReKDXNRENI25mdupolVAGdz4vdgTrkiyqYg4GHDfDsCwuiLXHt9gaTq4uTF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300417; c=relaxed/simple;
	bh=sUGRmpIzP6VTIdZXiy1GrpAXt4jwWFVe8WWblpyBuAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzAr4hbipXglxQX8QJBoPHS+rButy6BWIBbhv3UaijcUMmBdmdkEu3YNdaAd2jh2UD62mbuAH5n7fDsGQmZm6zVIa2UQdU6WMn65H+aXtwZTTXN0EyntzG/ivAu2JRGTsDQqdR/J/p1TchYWX/pr3yHzHAYZdQzFwgak5aDNvEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPN6Yw8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C639AC116D0;
	Sat, 28 Feb 2026 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300417;
	bh=sUGRmpIzP6VTIdZXiy1GrpAXt4jwWFVe8WWblpyBuAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SPN6Yw8V5dYYUaFu0/6CTcjIA737CjFIpkaApwqe6dS0HvSblX0tCMGoun+Py6uYg
	 56lFEhx6puRGrdNhTfjA9u4c+3sgPTeWRTjZ+lvV1rhV3ovxCVB4mSlNuBWmAnYh/z
	 dmF9BzvSdvTczJMsHP99HxeT2SpJwAY/ndC9nS0zyMwpffIfglUoYGYGR37lgf7rl/
	 PEXduxZNo0PL0TGZ220txWhYe3VmDKS+jluxpHxtuMFAnRRFvnhrYKr952mBwQr6v9
	 3gx3ETLfnivUW9j0qz8/PyfaTRJlbnDphgksf/kvPA6btZEvgcYBDQ5NsINnmMSAvV
	 PGqs83s9n+50w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ziyi Guo <n7l8m4@u.northwestern.edu>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 455/844] net: usb: kaweth: remove TX queue manipulation in kaweth_set_rx_mode
Date: Sat, 28 Feb 2026 12:26:08 -0500
Message-ID: <20260228173244.1509663-456-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220534-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,northwestern.edu:email]
X-Rspamd-Queue-Id: E12D71C8257
X-Rspamd-Action: no action

From: Ziyi Guo <n7l8m4@u.northwestern.edu>

[ Upstream commit 64868f5ecadeb359a49bc4485bfa7c497047f13a ]

kaweth_set_rx_mode(), the ndo_set_rx_mode callback, calls
netif_stop_queue() and netif_wake_queue(). These are TX queue flow
control functions unrelated to RX multicast configuration.

The premature netif_wake_queue() can re-enable TX while tx_urb is still
in-flight, leading to a double usb_submit_urb() on the same URB:

kaweth_start_xmit() {
    netif_stop_queue();
    usb_submit_urb(kaweth->tx_urb);
}

kaweth_set_rx_mode() {
    netif_stop_queue();
    netif_wake_queue();             // wakes TX queue before URB is done
}

kaweth_start_xmit() {
    netif_stop_queue();
    usb_submit_urb(kaweth->tx_urb); // URB submitted while active
}

This triggers the WARN in usb_submit_urb():

  "URB submitted while active"

This is a similar class of bug fixed in rtl8150 by

- commit 958baf5eaee3 ("net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast").

Also kaweth_set_rx_mode() is already functionally broken, the
real set_rx_mode action is performed by kaweth_async_set_rx_mode(),
which in turn is not a no-op only at ndo_open() time.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
Link: https://patch.msgid.link/20260217175012.1234494-1-n7l8m4@u.northwestern.edu
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/kaweth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/usb/kaweth.c b/drivers/net/usb/kaweth.c
index c9efb7df892ec..e01d14f6c3667 100644
--- a/drivers/net/usb/kaweth.c
+++ b/drivers/net/usb/kaweth.c
@@ -765,7 +765,6 @@ static void kaweth_set_rx_mode(struct net_device *net)
 
 	netdev_dbg(net, "Setting Rx mode to %d\n", packet_filter_bitmap);
 
-	netif_stop_queue(net);
 
 	if (net->flags & IFF_PROMISC) {
 		packet_filter_bitmap |= KAWETH_PACKET_FILTER_PROMISCUOUS;
@@ -775,7 +774,6 @@ static void kaweth_set_rx_mode(struct net_device *net)
 	}
 
 	kaweth->packet_filter_bitmap = packet_filter_bitmap;
-	netif_wake_queue(net);
 }
 
 /****************************************************************
-- 
2.51.0


