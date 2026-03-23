Return-Path: <stable+bounces-229670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHKJHWl8wWknTgQAu9opvQ
	(envelope-from <stable+bounces-229670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:46:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 016CF2FA606
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ABB33241913
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0E33B9D9D;
	Mon, 23 Mar 2026 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w6gkF0YC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F163BC69A;
	Mon, 23 Mar 2026 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282550; cv=none; b=aWKwyuJ7N6W1x9Bh8MtK1wpAuuw2FkrobYd/HEHVW8GnohjNJ7ve5hsYZRvK6DmDFqWfg1Oncz2UVMCaCIOFPsCtaPXqA1XMKJ5PXenjB4CHMmDujK//YIgoP1/3f/Vt5nmL0Qc1IIcjJMR84InqAJDvGJe1pKWxU1Y9gQM8f84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282550; c=relaxed/simple;
	bh=lcrAle0FifurQSLntd8Qz4ZkRUtDSUoukH/2pophNww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSjvUvjODj5VvUT2ebFO/V2jXW3om3NKRsZf8gYlh4ds/J2Yj61J31Gg4RIvochBKBVTqkJkg8g78ijo7q70+4ZfZN2lOPw5H9emRJF8c/w5kG4M3vsqzDYGRDODZgRZWtqxTjp9vZHwWhcbRCHxbGg9g5TGyhUj3weigW0sruA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w6gkF0YC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF68CC4CEF7;
	Mon, 23 Mar 2026 16:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282550;
	bh=lcrAle0FifurQSLntd8Qz4ZkRUtDSUoukH/2pophNww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w6gkF0YC8ST5C22epc86ovxDlkYIdsxGPWo/d9/Z3IrdUP2OaonnAKMcV0s8li1sz
	 cdNrUqUV70hr4MrBYcWqylkYL4p+2SWPL+SmyZtTk6tqt5bxLXZ6DTMB7f+P6YUIYD
	 eupSItvGFjzGlz2lW3+M8PKmeqtjgxJxr7JAYjAU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 199/481] net: usb: lan78xx: fix silent drop of packets with checksum errors
Date: Mon, 23 Mar 2026 14:43:01 +0100
Message-ID: <20260323134530.031970356@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229670-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 016CF2FA606
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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



