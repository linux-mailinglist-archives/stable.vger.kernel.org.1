Return-Path: <stable+bounces-165768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9C5B1878D
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 21:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 749457B9920
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 19:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A3028CF77;
	Fri,  1 Aug 2025 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="ElPJ10iS"
X-Original-To: stable@vger.kernel.org
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8D913A3ED;
	Fri,  1 Aug 2025 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754075018; cv=none; b=QZbi3Mcq0QmScBjNqqilP2TxEde8uEPWmkcGt3NeGPxyAHpZPqAgGum7A3HA+PE02LQqjL24ztvUPIx96ZUetmmZnT7AWELKzaAdJk63gOYqrKA816D2jxFsMNlVcGMCiTKOMJZxoqJd2kqwgY28RqFykcp1XTdfHHwnhn2zxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754075018; c=relaxed/simple;
	bh=FaGTwrEKwK7M7Dbun3EZiMSSgUMwYY7IOVqXCmRjdBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CM9Ziyh8P/kXED1vNaz8lQ3AS8krtagQdxvifowfIG4U/2F5gyIVmMR5SYqavHkcyuH/pjfhnoPSlXGWMSrLLhnLfeQhQ6g+htiJL27gcwxm55hlNxpXQz3/297Blz6hqBSOSsjb4WxjHl0cSi1rd6MsSL1sEZWeFhiNhNPwNfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=ElPJ10iS; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=new2025; t=1754075014;
	bh=FaGTwrEKwK7M7Dbun3EZiMSSgUMwYY7IOVqXCmRjdBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:Message-ID:Date:From:Reply-To:Subject:To:
	 Cc:In-Reply-To:References:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:User-Agent:Content-Type:Content-Transfer-Encoding;
	b=ElPJ10iSj97Mm8ptfHfOgnuRfC/eYEGLVJVMd6OtYmhBv3OooQar/4ZoBweiERzHS
	 3TAiZpka87YfhMrUoYF105QxGXZNx4/1oTV29zRW8Bj7dfXT8JlKiLeU5GaL7XylR+
	 oGrHRynOH1pBwW7oGHI7Kg9Bfxxko/r6tJ1dxxw3RxXs69jZ07AYz0BmcYOZSJNt0V
	 mpRIcGgcV4TR0SvZLHGBwtXqKV/viucOknDlnwTCwoDuJddMiRFrkpmcImFSS2VZeR
	 KJthfK8aUuMv5QAo4j4F+mMb97H8Rb9mm31itgX0I4VZWj9C2l6MKKxt1NfogrguLx
	 N5yTD+wDicbNg==
Received: from integral2.. (unknown [182.253.126.229])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id E01813126FD2;
	Fri,  1 Aug 2025 19:03:30 +0000 (UTC)
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Oliver Neukum <oneukum@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Netdev Mailing List <netdev@vger.kernel.org>,
	Linux USB Mailing List <linux-usb@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Armando Budianto <sprite@gnuweeb.org>,
	gwml@vger.gnuweeb.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: usbnet: Fix the wrong netif_carrier_on() call placement
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
Date: Sat,  2 Aug 2025 02:03:10 +0700
Message-Id: <20250801190310.58443-1-ammarfaizi2@gnuweeb.org>
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

v2:
  - Rebase on top of the latest netdev/net tree. The previous patch was
    based on 0d9cfc9b8cb1. Line numbers have changed since then.

 drivers/net/usb/usbnet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index a38ffbf4b3f0..a1827684b92c 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1114,31 +1114,31 @@ static const struct ethtool_ops usbnet_ethtool_ops = {
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
 		queue_work(system_bh_wq, &dev->bh_work);
 	}
 
 	/* hard_mtu or rx_urb_size may change during link change */
 	usbnet_update_max_qlen(dev);
 
 	clear_bit(EVENT_LINK_CHANGE, &dev->flags);
 }
 
-- 
Ammar Faizi


