Return-Path: <stable+bounces-223211-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yC2oNCCYqWm7AgEAu9opvQ
	(envelope-from <stable+bounces-223211-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 15:50:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F72213D81
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 15:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D386330CDE73
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 14:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD223A960A;
	Thu,  5 Mar 2026 14:34:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2041334685
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721282; cv=none; b=cZ2UvRcp5n7fTqMOevDhEeIuzCyokfQP1a9Q+VC3G99W7qwidV8xDtBhlW4o8Un5R4stXrCcuwLCd+ULZ76et68xYykjHr+pA+uGjvykNL5KOh/GsaOu7KP2no6CDy26kJB/2aT3kZBVVrBtTpunBDri9dok/2M09OtLgBtnHUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721282; c=relaxed/simple;
	bh=cSSLChh269Nxbhsa4GCVe/nCyfZMnRXsR/UYDpHBOKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWNX5js5ysgUzyjLC50pin1ioV/4CXAKA80SYcIz3hquQEPsHooome4+QsBmkLNe0LTOy+Rsft9CJa5EgtYHXY9AoAF0/ev21Zany06vYfL0cOYcpMbnMnn5vNwgHfjNP9Arlf8vP5nfWH9OQAtRhoxxJQ0zENwPW3s3DcASYPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vy9mZ-000462-Pg; Thu, 05 Mar 2026 15:34:31 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vy9mX-003twk-1w;
	Thu, 05 Mar 2026 15:34:30 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vy9mY-00000002E88-3fBv;
	Thu, 05 Mar 2026 15:34:30 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net v1 1/4] net: usb: lan78xx: fix silent drop of packets with checksum errors
Date: Thu,  5 Mar 2026 15:34:26 +0100
Message-ID: <20260305143429.530909-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305143429.530909-1-o.rempel@pengutronix.de>
References: <20260305143429.530909-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Rspamd-Queue-Id: 22F72213D81
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223211-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Do not drop packets with checksum errors at the USB driver level;
pass them to the network stack.

Previously, the driver dropped all packets where the 'Receive Error
Detected' (RED) bit was set, regardless of the specific error type. This
caused packets with only IP or TCP/UDP checksum errors to be dropped
before reaching the kernel, preventing the network stack from accounting
for them or performing software fallback.

Add a mask for hard hardware errors to safely drop genuinely corrupt
frames, while allowing checksum-errored frames to pass with their
ip_summed field explicitly set to CHECKSUM_NONE.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 4 +++-
 drivers/net/usb/lan78xx.h | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index a0021df12fde..1c8f69190378 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3829,6 +3829,7 @@ static void lan78xx_rx_csum_offload(struct lan78xx_net *dev,
 	 */
 	if (!(dev->net->features & NETIF_F_RXCSUM) ||
 	    unlikely(rx_cmd_a & RX_CMD_A_ICSM_) ||
+	    unlikely(rx_cmd_a & RX_CMD_A_CSE_MASK_) ||
 	    ((rx_cmd_a & RX_CMD_A_FVTG_) &&
 	     !(dev->net->features & NETIF_F_HW_VLAN_CTAG_RX))) {
 		skb->ip_summed = CHECKSUM_NONE;
@@ -3901,7 +3902,8 @@ static int lan78xx_rx(struct lan78xx_net *dev, struct sk_buff *skb,
 			return 0;
 		}
 
-		if (unlikely(rx_cmd_a & RX_CMD_A_RED_)) {
+		if (unlikely(rx_cmd_a & RX_CMD_A_RED_) &&
+		    (rx_cmd_a & RX_CMD_A_RX_HARD_ERRS_MASK_)) {
 			netif_dbg(dev, rx_err, dev->net,
 				  "Error rx_cmd_a=0x%08x", rx_cmd_a);
 		} else {
diff --git a/drivers/net/usb/lan78xx.h b/drivers/net/usb/lan78xx.h
index 968e5e5faee0..17a934acff3d 100644
--- a/drivers/net/usb/lan78xx.h
+++ b/drivers/net/usb/lan78xx.h
@@ -74,6 +74,9 @@
 #define RX_CMD_A_ICSM_			(0x00004000)
 #define RX_CMD_A_LEN_MASK_		(0x00003FFF)
 
+#define RX_CMD_A_RX_HARD_ERRS_MASK_ \
+	(RX_CMD_A_RX_ERRS_MASK_ & ~RX_CMD_A_CSE_MASK_)
+
 /* Rx Command B */
 #define RX_CMD_B_CSUM_SHIFT_		(16)
 #define RX_CMD_B_CSUM_MASK_		(0xFFFF0000)
-- 
2.47.3


