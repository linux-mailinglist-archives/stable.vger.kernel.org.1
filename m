Return-Path: <stable+bounces-259194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LlRM/gxG2qkAAkAu9opvQ
	(envelope-from <stable+bounces-259194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:52:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 717F1612B18
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2D5E30C39CA
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108C9137750;
	Sat, 30 May 2026 18:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JjXwNN9P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59EF1A9F90;
	Sat, 30 May 2026 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166921; cv=none; b=P3ai5ovbQNlhaOtm43GhgtOoZ6xm8PFvv2V9F81yDQ9zdxKrAZAzzjMMCNGl5rjaQk1WnLjhawECdZuxcXhiYfV2awxEleCgtFyIJZMJMpj7IBhVH3xnKINY12t+d4POtnibWc8Av42IrtFuogivmIdXPYrWPxaIrD74g/Q10WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166921; c=relaxed/simple;
	bh=Rjnt2kVZO1pz79V8ujjsWG0xsLeUUqJ18BUJdHQoRQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0VisoqfzzF0JPIrN8qsolss7/BE0+vBgBn7dWHlgYGhygLsDMMS1MpTNIvV93sVTI3Lmo31BI6aIBkh4GTRlc3KCn9Xc2Ks6Gncc/5dqomuQGGoBrgkE1+C8g8RgJCstfLIB66cJZPSkQOakVTwiTxkZYHxyiibLlm/eY2oqRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JjXwNN9P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3620A1F00893;
	Sat, 30 May 2026 18:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780166920;
	bh=ziTDa0UVoVpQrGcVOzZoLV4mGWzmO//r/+ncPKO/6K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JjXwNN9P4Ud5TFj9fV+PeqgbqqXkGHZSbvmapqgnuAe/ADtMCOJookh/BU1zBO4mc
	 GnYDPBOSF0gPcJ/u7uRY4FQoRKyVJ1Xyji9PF74mHxssl6Z0qHG0oySPCTcwV5FpaX
	 KgCUSLjKxcMEY2m7o5Plx5BgYVASp+uPQK/0osRQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Lunn <andrew@lunn.ch>,
	Morduan Zang <zhangdandan@uniontech.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 482/589] net: usb: rtl8150: free skb on usb_submit_urb() failure in xmit
Date: Sat, 30 May 2026 18:06:03 +0200
Message-ID: <20260530160237.318884624@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259194-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,uniontech.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 717F1612B18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Morduan Zang <zhangdandan@uniontech.com>

[ Upstream commit adbe2cdf75461891e50dbe11896ac78e9af1f874 ]

When rtl8150_start_xmit() fails to submit the tx URB, the URB is never
handed to the USB core and write_bulk_callback() will not run.  The
driver returns NETDEV_TX_OK, which tells the networking stack that the
skb has been consumed, but nothing actually frees the skb on this
error path:

  dev->tx_skb = skb;
  ...
  if ((res = usb_submit_urb(dev->tx_urb, GFP_ATOMIC))) {
          ...
          /* no kfree_skb here */
  }
  return NETDEV_TX_OK;

This leaks the skb on every submit failure and also leaves dev->tx_skb
pointing at memory that the driver itself may later free, which is
fragile.

Free the skb with dev_kfree_skb_any() in the error path and clear
dev->tx_skb so no stale pointer is left behind.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>
Link: https://patch.msgid.link/E7D3E1C013C5A859+20260424015517.9574-1-zhangdandan@uniontech.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/rtl8150.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index 51bd522fada53..a992253000c85 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -712,6 +712,13 @@ static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
 			netdev->stats.tx_errors++;
 			netif_start_queue(netdev);
 		}
+		/*
+		 * The URB was not submitted, so write_bulk_callback() will
+		 * never run to free dev->tx_skb.  Drop the skb here and
+		 * clear tx_skb to avoid leaving a stale pointer.
+		 */
+		dev->tx_skb = NULL;
+		dev_kfree_skb_any(skb);
 	} else {
 		netdev->stats.tx_packets++;
 		netdev->stats.tx_bytes += skb_len;
-- 
2.53.0




