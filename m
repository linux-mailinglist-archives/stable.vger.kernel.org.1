Return-Path: <stable+bounces-45506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E4F8CAE7A
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 14:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A95C5B21C78
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 12:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F0A770E2;
	Tue, 21 May 2024 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T0TPkoOP"
X-Original-To: stable@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36D428E7;
	Tue, 21 May 2024 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716295428; cv=none; b=Y3oOMtxWyvR2bDzxBzF10HjwRLnfHc2d3htezVCWPUu5cMMwkLm/knt60fzHIeI1vPyhcRNZPYka0qoTq3v4Rn8BxCrsO61/KIMDEJXrkkvPLtNuEr/sg8XejYwNnmiQxNlhlj7sNIj1i20pVGvkwUW72wvd2Ke527xEf7iEU8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716295428; c=relaxed/simple;
	bh=De/fD9//lDT8ckW0UEfL/y/2vXEAMHB5t/X7InMzgMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J+spu9DUGdMtd3CGqI/Me2G5OVeBLqW2C4jG63mVQygRrwiAQ4eQ/p+TGjvnppIEuwl38Ar8YXw2HdsEzU3K3xuBHts/AXiWJm2LOk92izSgE2u9ylzWYmxN6A2oPbv6DVpBkAgAKX7U3quf8vUgoeA0eUpvi0lFCGRQSu3DkB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T0TPkoOP; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C39972000D;
	Tue, 21 May 2024 12:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716295423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sBHQDVV1jw6tvsDFIyAbBrREYTF4ioSRIEty/E5nqPU=;
	b=T0TPkoOP0Oln6RdV1lZQCjpQhTbgt3GaQ2j94Yw+Z8ea1ETp/x9tnsAhm4sBjHTyc6FJgn
	ytWWeoxfxTEk9DRNo9H0PwHB7pR2Pneu3gAkZMBkMNmRjUKRSysG1FysIfeyhisO+FGl/C
	1M0B2q6KFUg4mUr/1La3Z1dM/N8QS2k8w0lqGNJNER9rQ48bQBD3G7P1A2yjXX43m5bIiF
	PPYfG4iD+8h8bvYfzF+aqwAynnJ4FrKOTo9mpAs0uERH4ylCAm5P8jy+o+JUEya2/dc16T
	04ABdjNOV7G8j+J1cf9hnRsL52YYj1FjUXuFLcv32oLzhnCOb8y2jKxLCeGxXA==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 21 May 2024 14:44:11 +0200
Subject: [PATCH net] net: ti: icssg_prueth: Fix NULL pointer dereference in
 prueth_probe()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-icssg-prueth-fix-v1-1-b4b17b1433e9@bootlin.com>
X-B4-Tracking: v=1; b=H4sIABqXTGYC/x2MQQ5AQAwAvyI9a1K7y8FXxIFV9LJki0jE3zWOM
 8nMA8pZWKEtHsh8icqWDKqygLgOaWGUyRgcuUC1q1Ci6oJ7PvlYcZYbyY/kqQmxjgyW7ZlN/8s
 OEh/Qv+8HZjSKXWcAAAA=
To: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: romain.gantois@bootlin.com

In the prueth_probe() function, if one of the calls to emac_phy_connect()
fails due to of_phy_connect() returning NULL, then the subsequent call to
phy_attached_info() will dereference a NULL pointer.

Check the return code of emac_phy_connect and fail cleanly if there is an
error.

Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Hello everyone,

There is a possible NULL pointer dereference in the prueth_probe() function of
the icssg_prueth driver. I discovered this while testing a platform with one
PRUETH MAC enabled out of the two available.

These are the requirements to reproduce the bug:

prueth_probe() is called
either eth0_node or eth1_node is not NULL
in emac_phy_connect: of_phy_connect() returns NULL

Then, the following leads to the NULL pointer dereference:

prueth->emac[PRUETH_MAC0]->ndev->phydev is set to NULL
prueth->emac[PRUETH_MAC0]->ndev->phydev is passed to phy_attached_info()
-> phy_attached_print() dereferences phydev which is NULL

This series provides a fix by checking the return code of emac_phy_connect().

Best Regards,

Romain
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 7c9e9518f555a..1ea3fbd5e954e 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1039,7 +1039,12 @@ static int prueth_probe(struct platform_device *pdev)
 
 		prueth->registered_netdevs[PRUETH_MAC0] = prueth->emac[PRUETH_MAC0]->ndev;
 
-		emac_phy_connect(prueth->emac[PRUETH_MAC0]);
+		ret = emac_phy_connect(prueth->emac[PRUETH_MAC0]);
+		if (ret) {
+			dev_err(dev,
+				"can't connect to MII0 PHY, error -%d", ret);
+			goto netdev_unregister;
+		}
 		phy_attached_info(prueth->emac[PRUETH_MAC0]->ndev->phydev);
 	}
 
@@ -1051,7 +1056,12 @@ static int prueth_probe(struct platform_device *pdev)
 		}
 
 		prueth->registered_netdevs[PRUETH_MAC1] = prueth->emac[PRUETH_MAC1]->ndev;
-		emac_phy_connect(prueth->emac[PRUETH_MAC1]);
+		ret = emac_phy_connect(prueth->emac[PRUETH_MAC1]);
+		if (ret) {
+			dev_err(dev,
+				"can't connect to MII1 PHY, error %d", ret);
+			goto netdev_unregister;
+		}
 		phy_attached_info(prueth->emac[PRUETH_MAC1]->ndev->phydev);
 	}
 

---
base-commit: e4a87abf588536d1cdfb128595e6e680af5cf3ed
change-id: 20240521-icssg-prueth-fix-03b03064c5ce

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


