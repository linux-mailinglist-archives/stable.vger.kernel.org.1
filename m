Return-Path: <stable+bounces-1444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B75227F7FB1
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49EA0B21A6B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12C92EAEA;
	Fri, 24 Nov 2023 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="moLxajZF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA7C35F04;
	Fri, 24 Nov 2023 18:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD86FC433C7;
	Fri, 24 Nov 2023 18:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851414;
	bh=JpkfhW5hwbD/ZFuFo5muuxhZpgRvYGbupQfsIwjiEls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=moLxajZFECx3robLl3KqNOPl7yIv5v2EDPH4VdVY6GbQ5l8vAdJ1moK4z5kVnHsMD
	 OaHXJjjSiWKzJKMfo11mgJkxeCuhr2zhCdZpY0sUnJVKA8Nh1v6UL0bSbgeNm3/xjz
	 KSdHu4chrD+tXeu4gu2aitgBQqpnJEYIoC2J6pYE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Lunn <andrew@lunn.ch>,
	Klaus Kudielka <klaus.kudielka@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.5 414/491] net: phylink: initialize carrier state at creation
Date: Fri, 24 Nov 2023 17:50:50 +0000
Message-ID: <20231124172037.043877323@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Klaus Kudielka <klaus.kudielka@gmail.com>

commit 02d5fdbf4f2b8c406f7a4c98fa52aa181a11d733 upstream.

Background: Turris Omnia (Armada 385); eth2 (mvneta) connected to SFP bus;
SFP module is present, but no fiber connected, so definitely no carrier.

After booting, eth2 is down, but netdev LED trigger surprisingly reports
link active. Then, after "ip link set eth2 up", the link indicator goes
away - as I would have expected it from the beginning.

It turns out, that the default carrier state after netdev creation is
"carrier ok". Some ethernet drivers explicitly call netif_carrier_off
during probing, others (like mvneta) don't - which explains the current
behaviour: only when the device is brought up, phylink_start calls
netif_carrier_off.

Fix this for all drivers using phylink, by calling netif_carrier_off in
phylink_create.

Fixes: 089381b27abe ("leds: initial support for Turris Omnia LEDs")
Cc: stable@vger.kernel.org
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phylink.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1568,6 +1568,7 @@ struct phylink *phylink_create(struct ph
 	pl->config = config;
 	if (config->type == PHYLINK_NETDEV) {
 		pl->netdev = to_net_dev(config->dev);
+		netif_carrier_off(pl->netdev);
 	} else if (config->type == PHYLINK_DEV) {
 		pl->dev = config->dev;
 	} else {



