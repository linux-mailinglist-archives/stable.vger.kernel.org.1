Return-Path: <stable+bounces-263946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LBb/F5BqMWo+iwUAu9opvQ
	(envelope-from <stable+bounces-263946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:24:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59893690FCB
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:23:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=zZBq8JdX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263946-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263946-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 552553018EB0
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B6743E490;
	Tue, 16 Jun 2026 15:22:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60EE26B0A9;
	Tue, 16 Jun 2026 15:22:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623329; cv=none; b=gcH7rhaLaWkkI9sts2VA8D7QGBFvjkczB5wj2sU4uWEM573S1m4UnGHILd66LsWBSiwBkLuW8oY1Ac5sJj2KFAYdCBKlAJJZla1hoHADD8RGeWDZ4i9Muv976wCExsmzXeCoQU28wqnd3TOTtc0/cTx0YIFTJjImqSk3vtia4G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623329; c=relaxed/simple;
	bh=wderISA0kBWDOqeJIZ03BEuIKuY2mkWjfAPZdPESFFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYGGAQmpPpuf+ClwTLRntM2B2FO4/0eLR+UP4YFMBCJwEEumMhndfvmpRQdMrVQC4psEIZbCiFjsVmj2EaWthRx5HttAs25zCK7Qf1oIyTg99ZPvDdccIeijooxsywXG3Tv9X2T5rnATtQ+m/fDvw8wTUvBUv1OseW29nLuQGOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zZBq8JdX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54DD1F000E9;
	Tue, 16 Jun 2026 15:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623327;
	bh=zouz3215zAQAeUd/pDFWT7e79yLluZnH86zcErMNjR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zZBq8JdX+hY6qEDj2HqwsudHRT2a3hlCyEFyy+Y/tntOarefK5pkQNODKs0Pr3JVi
	 LDPcW8DXuPy1PEB9s2fa5x4mEn/qo5dyKbWB06wFrGPrD+pwInr+2MBqf/h1a2mzYD
	 on//HjAnPISrKnmVW02MVTNLJ7ig2jDjNhZriqY4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 127/378] net: mctp: usb: fix race between urb completion and rx_retry cancellation
Date: Tue, 16 Jun 2026 20:25:58 +0530
Message-ID: <20260616145117.019884007@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263946-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jk@codeconstruct.com.au,m:pabeni@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,codeconstruct.com.au:email,msgid.link:url,rx_retry_work.work:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59893690FCB

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Kerr <jk@codeconstruct.com.au>

[ Upstream commit 54665dce982689e2fd99b32e9a0dcc204fda8a51 ]

It's possible that sequencing between setting ->stopped and cancelling
the rx_retry work (in ndo_stop) could leave us with an urb queued:

    T1: ndo_stop                  T2: rx_retry_work
    ------------                  ----------------
                                  LD: ->stopped => false
    ST: ->stopped <= true
    usb_kill_urb()
                                  mctp_usb_rx_queue()
                                    usb_submit_urb()
    cancel_delayed_work_sync()

That urb completion can then re-schedule rx_retry_work.

Strenghen the sequencing between the stop (preventing another requeue)
and the cancel by updating both atomically under a new rx lock. After
setting ->rx_stopped, and cancelling pending work, we know that the
requeue cannot occur, so all that's left is killing any pending urb.

Fixes: 0791c0327a6e ("net: mctp: Add MCTP USB transport driver")
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
Link: https://patch.msgid.link/20260608-dev-mctp-usb-rx-requeue-v2-1-29a3aa507609@codeconstruct.com.au
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/mctp/mctp-usb.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index 3b5dff14417747..cf6f6a93a45112 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -22,7 +22,6 @@
 struct mctp_usb {
 	struct usb_device *usbdev;
 	struct usb_interface *intf;
-	bool stopped;
 
 	struct net_device *netdev;
 
@@ -32,6 +31,9 @@ struct mctp_usb {
 	struct urb *tx_urb;
 	struct urb *rx_urb;
 
+	/* enforces atomic access to rx_stopped and requeuing the retry work */
+	spinlock_t rx_lock;
+	bool rx_stopped;
 	struct delayed_work rx_retry_work;
 };
 
@@ -122,6 +124,7 @@ static const unsigned long RX_RETRY_DELAY = HZ / 4;
 
 static int mctp_usb_rx_queue(struct mctp_usb *mctp_usb, gfp_t gfp)
 {
+	unsigned long flags;
 	struct sk_buff *skb;
 	int rc;
 
@@ -147,7 +150,10 @@ static int mctp_usb_rx_queue(struct mctp_usb *mctp_usb, gfp_t gfp)
 	return rc;
 
 err_retry:
-	schedule_delayed_work(&mctp_usb->rx_retry_work, RX_RETRY_DELAY);
+	spin_lock_irqsave(&mctp_usb->rx_lock, flags);
+	if (!mctp_usb->rx_stopped)
+		schedule_delayed_work(&mctp_usb->rx_retry_work, RX_RETRY_DELAY);
+	spin_unlock_irqrestore(&mctp_usb->rx_lock, flags);
 	return rc;
 }
 
@@ -248,9 +254,6 @@ static void mctp_usb_rx_retry_work(struct work_struct *work)
 	struct mctp_usb *mctp_usb = container_of(work, struct mctp_usb,
 						 rx_retry_work.work);
 
-	if (READ_ONCE(mctp_usb->stopped))
-		return;
-
 	mctp_usb_rx_queue(mctp_usb, GFP_KERNEL);
 }
 
@@ -258,7 +261,7 @@ static int mctp_usb_open(struct net_device *dev)
 {
 	struct mctp_usb *mctp_usb = netdev_priv(dev);
 
-	WRITE_ONCE(mctp_usb->stopped, false);
+	WRITE_ONCE(mctp_usb->rx_stopped, false);
 
 	netif_start_queue(dev);
 
@@ -268,17 +271,21 @@ static int mctp_usb_open(struct net_device *dev)
 static int mctp_usb_stop(struct net_device *dev)
 {
 	struct mctp_usb *mctp_usb = netdev_priv(dev);
+	unsigned long flags;
 
 	netif_stop_queue(dev);
 
 	/* prevent RX submission retry */
-	WRITE_ONCE(mctp_usb->stopped, true);
+	spin_lock_irqsave(&mctp_usb->rx_lock, flags);
+	mctp_usb->rx_stopped = true;
+	cancel_delayed_work(&mctp_usb->rx_retry_work);
+	spin_unlock_irqrestore(&mctp_usb->rx_lock, flags);
+
+	flush_delayed_work(&mctp_usb->rx_retry_work);
 
 	usb_kill_urb(mctp_usb->rx_urb);
 	usb_kill_urb(mctp_usb->tx_urb);
 
-	cancel_delayed_work_sync(&mctp_usb->rx_retry_work);
-
 	return 0;
 }
 
@@ -331,6 +338,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
 	dev->netdev = netdev;
 	dev->usbdev = interface_to_usbdev(intf);
 	dev->intf = intf;
+	spin_lock_init(&dev->rx_lock);
 	usb_set_intfdata(intf, dev);
 
 	dev->ep_in = ep_in->bEndpointAddress;
-- 
2.53.0




