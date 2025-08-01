Return-Path: <stable+bounces-165765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A69BB18749
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 20:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197A61C82C5F
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 18:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91C52874F7;
	Fri,  1 Aug 2025 18:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="eq7b4+be"
X-Original-To: stable@vger.kernel.org
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80F6188CC9;
	Fri,  1 Aug 2025 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754072574; cv=none; b=togK6UiV3MsRzAJmU+kyQwxZsaJQ52T+Qdnwt8S0YAHt46nnhCS/t2J6gTRdhysS0qhXVxB3ZUQjDWrEoKN/kt2HTu4vlXTccd+m7epfdD7J9j2A9TyacCfr3l/QOairf+qKscLuucOpRfa7Tgw3HrRKYyO7vVOvo7FUjY4Bxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754072574; c=relaxed/simple;
	bh=WF0QhmeUbVgpA2hYHTvKf+I3icXtibEH9SWu6vSv6bk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IsB7iGSFTQFwelNjX57g7/uTX6GIFMLvV5SznlIoq0UB0ZQOuHS6FZOrpPwb+PT+SdgdaXCDcveLN2MPEAE0eEg0RtfLtgCouXlTdxz0KZSYPekIqZZV8+CLCDp3eYvbU4soRgTzcSjcsdwvqgvRePM/v4sb0qGqjCgOLnFv/s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=eq7b4+be; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=new2025; t=1754072570;
	bh=WF0QhmeUbVgpA2hYHTvKf+I3icXtibEH9SWu6vSv6bk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:Message-ID:Date:From:Reply-To:Subject:To:
	 Cc:In-Reply-To:References:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:User-Agent:Content-Type:Content-Transfer-Encoding;
	b=eq7b4+be3D8CGX1DnDUvCfReusRDKoHIATKVTrXS8tkld1HUqpgZ/YeqbGBqKZheZ
	 1BfLYO7crUo3EikNDGwqcsLh5MbBKlqdQDF/9/+w9RxET1p2g2ElcBwvBzGAYiurSJ
	 8vMtwmTgTwozSV3ZFL/3SH4RhytSAdRIjta+tTS/crPKZ3LpELuZWrCvVGGP1demjR
	 hUu1FNI4056LLADoQfzlKrQXvqDG12xtMVKEEgY7pIWCvxW52MY+H6zCESWmmOXC3R
	 sJ8//l4zdG+G1GgTHbtgi0MioKHrQO0u42o/WW+cfGqsqpovEcsRBKCPFrFEIcjXzg
	 AiP7JRSMrMClA==
Received: from integral2.. (unknown [182.253.126.229])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id 921273126FCE;
	Fri,  1 Aug 2025 18:22:47 +0000 (UTC)
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Oliver Neukum <oneukum@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>,
	John Ernberg <john.ernberg@actia.se>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Netdev Mailing List <netdev@vger.kernel.org>,
	Linux USB Mailing List <linux-usb@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Armando Budianto <sprite@gnuweeb.org>,
	gwml@vger.gnuweeb.org,
	stable@vger.kernel.org
Subject: [PATCH net v1] net: usbnet: Fix the wrong netif_carrier_on() call placement
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
Date: Sat,  2 Aug 2025 01:20:44 +0700
Message-Id: <20250801182044.39420-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit in the Fixes tag breaks my laptop (found by git bisect).
My home RJ45 LAN cable cannot connect after that commit.

The call to netif_carrier_on() should be done when netif_carrier_ok()
is false. Not when it's true. Because calling netif_carrier_on() when
__LINK_STATE_NOCARRIER is not set actually does nothing.

Cc: Armando Budianto <sprite@gnuweeb.org>
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/netdev/0752dee6-43d6-4e1f-81d2-4248142cccd2@gnuweeb.org
Fixes: 0d9cfc9b8cb1 ("net: usbnet: Avoid potential RCU stall on LINK_CHANGE event")
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 drivers/net/usb/usbnet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index bc1d8631ffe0..1eb98eeb64f9 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1107,31 +1107,31 @@ static const struct ethtool_ops usbnet_ethtool_ops = {
 };
 
 /*-------------------------------------------------------------------------*/
 
 static void __handle_link_change(struct usbnet *dev)
 {
 	if (!test_bit(EVENT_DEV_OPEN, &dev->flags))
 		return;
 
 	if (!netif_carrier_ok(dev->net)) {
+		if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
+			netif_carrier_on(dev->net);
+
 		/* kill URBs for reading packets to save bus bandwidth */
 		unlink_urbs(dev, &dev->rxq);
 
 		/*
 		 * tx_timeout will unlink URBs for sending packets and
 		 * tx queue is stopped by netcore after link becomes off
 		 */
 	} else {
-		if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
-			netif_carrier_on(dev->net);
-
 		/* submitting URBs for reading packets */
 		tasklet_schedule(&dev->bh);
 	}
 
 	/* hard_mtu or rx_urb_size may change during link change */
 	usbnet_update_max_qlen(dev);
 
 	clear_bit(EVENT_LINK_CHANGE, &dev->flags);
 }
 
-- 
Ammar Faizi


