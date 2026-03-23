Return-Path: <stable+bounces-228548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEN0KI5PwWnLSAQAu9opvQ
	(envelope-from <stable+bounces-228548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:34:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 147002F4C79
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3498319FF33
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5FF3A0B0B;
	Mon, 23 Mar 2026 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wefSUGaF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F93B175A80;
	Mon, 23 Mar 2026 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275423; cv=none; b=FiwOkyNg9L0ov0azUlvsQXe5BIskFAFMP3MnqmxkkJV7Folx1h8XugfwR9L7W4sdj6it4UlueEdo2/3MLiPKsfrWqEK9E2avDBY7KuELIQhS461tacnrtTjbe+k7pvNsrwArmBwM+Qq6ltFKcAtr6ecgF8ykKy1gCA2jmDoVPM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275423; c=relaxed/simple;
	bh=4q8GA5TR+eOvhqcXLHyR3KUD47yBkYRKcoJSCpDsVu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tEpjEFYBNqCFkzO7UwRi9Qv9OKODjSS2O7QiwbiApdeaxf69Sg70yjkk4UGw/LKnkV67eez4Y8siFYwRJFlqhBM+FfCFQiLsX1nQvzJQeMQ6lQfRzt/MReA03DCGppFgS1wgHZ6uQfVS9YWKZMdaBrM3cYgY4Cjys336FgyoFA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wefSUGaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723FBC4CEF7;
	Mon, 23 Mar 2026 14:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275422;
	bh=4q8GA5TR+eOvhqcXLHyR3KUD47yBkYRKcoJSCpDsVu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wefSUGaFHzobctUKlbZtZ+Qtfe27v+duJAQ0ifa+3iSCO5cSigxKwpUxaCoVdAlsy
	 r/c6/UwIxmn6LTYfhivpSSv7scL5fZZd4vTVrlA5eZNrpkLrXQlCNJ8Qqlx+3Xhn5b
	 yblUy4+bt23Ui6VGacsVTHFrqHAjPIObNzSGMWi8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 092/460] net: usb: lan78xx: fix silent drop of packets with checksum errors
Date: Mon, 23 Mar 2026 14:41:28 +0100
Message-ID: <20260323134528.926485470@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228548-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 147002F4C79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleksij Rempel <o.rempel@pengutronix.de>

commit e4f774a0cc955ce762aec91c66915a6e15087ab7 upstream.

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
Link: https://patch.msgid.link/20260305143429.530909-2-o.rempel@pengutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/lan78xx.c |    4 +++-
 drivers/net/usb/lan78xx.h |    3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3537,6 +3537,7 @@ static void lan78xx_rx_csum_offload(stru
 	 */
 	if (!(dev->net->features & NETIF_F_RXCSUM) ||
 	    unlikely(rx_cmd_a & RX_CMD_A_ICSM_) ||
+	    unlikely(rx_cmd_a & RX_CMD_A_CSE_MASK_) ||
 	    ((rx_cmd_a & RX_CMD_A_FVTG_) &&
 	     !(dev->net->features & NETIF_F_HW_VLAN_CTAG_RX))) {
 		skb->ip_summed = CHECKSUM_NONE;
@@ -3609,7 +3610,8 @@ static int lan78xx_rx(struct lan78xx_net
 			return 0;
 		}
 
-		if (unlikely(rx_cmd_a & RX_CMD_A_RED_)) {
+		if (unlikely(rx_cmd_a & RX_CMD_A_RED_) &&
+		    (rx_cmd_a & RX_CMD_A_RX_HARD_ERRS_MASK_)) {
 			netif_dbg(dev, rx_err, dev->net,
 				  "Error rx_cmd_a=0x%08x", rx_cmd_a);
 		} else {
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



