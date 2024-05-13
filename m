Return-Path: <stable+bounces-43612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CF48C3FB0
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED0E1F22E81
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 11:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF58014C58E;
	Mon, 13 May 2024 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LLskMZLo"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7534714BFA2;
	Mon, 13 May 2024 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715599168; cv=none; b=jQJ2J8UoTu1V0Vjb3TW8gpu8SgE9MqX8TDpy/b6a0m1uFBL1Q7YHzXtPzudJcPQd1+YBQpugUjLY8W6ytg+xDHMyJXf/5RSRP4JBBOKuuKFNv5EfKNWLIR0XW6wjrsg8DDCDcpPZjYptuJKvv9R5CJhc1rRx0z7C+pnoKCV68lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715599168; c=relaxed/simple;
	bh=D7rNxISVW39MhcpOP+VwuzECmODJNMC2uz6SkfFgig8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bb0gxN0qV7DtHC9m9GC+7ebI0USXulUCxLq/N++rAd13ijBPX6T/Iyo/kG8pMs5GrPqULmY+gLtJDpFNl51dmDW6/7sVWLwIylyNwSIrkbePBciuWNr5sjk9mlVmanxXEIygNRbMHIBtisKn0HAzl4sarrRZNy19oeyWCM7e/+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LLskMZLo; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 45F111C0002;
	Mon, 13 May 2024 11:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715599162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gKVOMxd20VDSKzHJcmThHdOq/cAuIl6aUIXNfYUiTgQ=;
	b=LLskMZLonnaI268MC2Xt6BbpwnLc9evFKKmQrTkPQApcjiBoH5mqjIq8rIv2wnEK2rOeUl
	dMb0mU/XK31GAtE4WKIbC/lpiulpVvXXeQyuySDg1d0YTCWXPSWfyYyRmDlALc/h7Xybl4
	mK76KNb/DPLMhIkDjmfoevShpP+KFbvEv19hgOpLB89Uv/WoBBLlPtN24sL1eVcoFKmJnK
	skqphk7IjcE9pnfgCqAX2TrfAs18joiOMjBQMzu9M+hRhX60ocbPp6NYJQ5iMC4enX1ZEq
	ArZ4QX+Qb7FFZBDX6nHvATdu+IjnobvmTtaM02LOZDFJVwXZDABeiwwLWlK5qg==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: lan966x: remove debugfs directory in probe() error path
Date: Mon, 13 May 2024 13:18:53 +0200
Message-ID: <20240513111853.58668-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

A debugfs directory entry is create early during probe(). This entry is
not removed on error path leading to some "already present" issues in
case of EPROBE_DEFER.

Create this entry later in the probe() code to avoid the need to change
many 'return' in 'goto' and add the removal in the already present error
path.

Fixes: 942814840127 ("net: lan966x: Add VCAP debugFS support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 2635ef8958c8..61d88207eed4 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -1087,8 +1087,6 @@ static int lan966x_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, lan966x);
 	lan966x->dev = &pdev->dev;
 
-	lan966x->debugfs_root = debugfs_create_dir("lan966x", NULL);
-
 	if (!device_get_mac_address(&pdev->dev, mac_addr)) {
 		ether_addr_copy(lan966x->base_mac, mac_addr);
 	} else {
@@ -1179,6 +1177,8 @@ static int lan966x_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, -ENODEV,
 				     "no ethernet-ports child found\n");
 
+	lan966x->debugfs_root = debugfs_create_dir("lan966x", NULL);
+
 	/* init switch */
 	lan966x_init(lan966x);
 	lan966x_stats_init(lan966x);
@@ -1257,6 +1257,8 @@ static int lan966x_probe(struct platform_device *pdev)
 	destroy_workqueue(lan966x->stats_queue);
 	mutex_destroy(&lan966x->stats_lock);
 
+	debugfs_remove_recursive(lan966x->debugfs_root);
+
 	return err;
 }
 
-- 

This patch was previously sent as part of a bigger series:
  https://lore.kernel.org/lkml/20240430083730.134918-9-herve.codina@bootlin.com/
As it is a simple fix, this v2 is the patch extracted from the series
and sent alone to net.

Changes v1 -> v2
  Add 'Reviewed-by: Andrew Lunn <andrew@lunn.ch>'

2.44.0

