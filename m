Return-Path: <stable+bounces-226958-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA1DH402umnXSwIAu9opvQ
	(envelope-from <stable+bounces-226958-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 06:22:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE0A2B5E68
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 06:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2F3B3022072
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 05:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CF2330328;
	Wed, 18 Mar 2026 05:22:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.189.cn (189sx01-ptr.21cn.com [14.18.100.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DBE221FC6
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 05:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.18.100.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773811338; cv=none; b=Yl1OGDkxTShCgeEz9li17sbtktDgu8kvCw6G3pjTg1gXjQiNsiFZV7YsJDJhrqloOw6evYdgewyi6CN4HXfw8JKGVm60Em1hkPZjqPipaEJA1IrUOGdwBfiXluYcKzQmRb+X/zj3Q2QDHGCwAbzvOf6zdyMugOiV4SpL7o9JILY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773811338; c=relaxed/simple;
	bh=f/RwmrWTE9eHoDCmPMlPwDTnokuED+aWXYOEKaa45lc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=iRRZoVxNki9A/HH7GGSmpd30P8PwsRPRbCz99XiN3Z6dbFiNGU4fx4PHNWFunxa0hB4CDWu+QS6p13Rb9ZSTcozDkoTuLYMMsKSkZ5XNAeFFOt79t/x8v4pcpVr7BYQ4ZcVKdtpum5QhUtLZQAkQkpj1/5OVM92BqXT4dgtLszI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=14.18.100.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.242.145:0.828961584
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-106.121.140.245 (unknown [10.158.242.145])
	by mail.189.cn (HERMES) with SMTP id 1345D400087;
	Wed, 18 Mar 2026 13:22:14 +0800 (CST)
Received: from  ([106.121.140.245])
	by gateway-153622-dep-76cc7bc9cd-r45x9 with ESMTP id 81832e8540024c8b95dc37674f229da1 for mkl@pengutronix.de;
	Wed, 18 Mar 2026 13:22:15 CST
X-Transaction-ID: 81832e8540024c8b95dc37674f229da1
X-Real-From: charles_xu@189.cn
X-Receive-IP: 106.121.140.245
X-MEDUSA-Status: 0
Sender: charles_xu@189.cn
From: Charles Xu <charles_xu@189.cn>
To: mkl@pengutronix.de,
	stable@vger.kernel.org
Subject: [PATCH 5.15.y] can: gs_usb: gs_usb_xmit_callback(): fix handling of failed transmitted URBs
Date: Wed, 18 Mar 2026 13:22:13 +0800
Message-Id: <20260318052213.6144-1-charles_xu@189.cn>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-226958-lists,stable=lfdr.de];
	DMARC_NA(0.00)[189.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[charles_xu@189.cn,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.795];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	FREEMAIL_FROM(0.00)[189.cn];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,189.cn:email,189.cn:mid]
X-Rspamd-Queue-Id: 7FE0A2B5E68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit 516a0cd1c03fa266bb67dd87940a209fd4e53ce7 ]

The driver lacks the cleanup of failed transfers of URBs. This reduces the
number of available URBs per error by 1. This leads to reduced performance
and ultimately to a complete stop of the transmission.

If the sending of a bulk URB fails do proper cleanup:
- increase netdev stats
- mark the echo_sbk as free
- free the driver's context and do accounting
- wake the send queue

Closes: https://github.com/candle-usb/candleLight_fw/issues/187
Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Charles Xu <charles_xu@189.cn>
---
 drivers/net/can/usb/gs_usb.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index ffa2a4d92d01..dbe7f5f70bd3 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -458,8 +458,21 @@ static void gs_usb_xmit_callback(struct urb *urb)
 	struct gs_can *dev = txc->dev;
 	struct net_device *netdev = dev->netdev;
 
-	if (urb->status)
-		netdev_info(netdev, "usb xmit fail %d\n", txc->echo_id);
+	if (!urb->status)
+		return;
+
+	if (urb->status != -ESHUTDOWN && net_ratelimit())
+		netdev_info(netdev, "failed to xmit URB %u: %pe\n",
+			    txc->echo_id, ERR_PTR(urb->status));
+
+	netdev->stats.tx_dropped++;
+	netdev->stats.tx_errors++;
+
+	can_free_echo_skb(netdev, txc->echo_id, NULL);
+	gs_free_tx_context(txc);
+	atomic_dec(&dev->active_tx_urbs);
+
+	netif_wake_queue(netdev);
 
 	usb_free_coherent(urb->dev,
 			  urb->transfer_buffer_length,
-- 
2.35.3


