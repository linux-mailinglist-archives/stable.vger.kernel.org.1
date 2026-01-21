Return-Path: <stable+bounces-210648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QK7dLnY2cGl9XAAAu9opvQ
	(envelope-from <stable+bounces-210648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:14:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 658BB4F966
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 759AE80FBA8
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4E425524C;
	Wed, 21 Jan 2026 02:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bO/57XC3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0C131AA8B
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 02:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961617; cv=none; b=US0w6hGcGeztZ/f38oOctJh4wshJoEGtKkJpkDum6PDKFNbAIZht5IGC+VEeoacfikohv103nwqsD/8FOBfPbsaqOXp2GA7ncgGpAGxNhk82OedcuSSAEb2eivmPEzB3nJ4SsE8uM6ufD6R82mr4NJE4iJgiGSYVEfKmIp15Qvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961617; c=relaxed/simple;
	bh=6hyo7/PHPj5QPPVt8ZRkZvHzSGc9MaV1kt6jACR+KIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Io6IkrmTRNRqFJ2zJ7ZKfV75KV86gbqowEYFFTJiMUh6v01EjMs0kzApetp03c/RaY7J1LPQsoD1+fpNGklLpxhoED9gQ77yDK1QyskSReGtJ93e2j5ajXN64th8RhmVyKt1hAZThivffRZ0kUSD38x0tyHUf9VpxCXThlTljAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bO/57XC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005BDC19423;
	Wed, 21 Jan 2026 02:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768961616;
	bh=6hyo7/PHPj5QPPVt8ZRkZvHzSGc9MaV1kt6jACR+KIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bO/57XC3yrVzaH1iuEFK8Quc7pmvngG2e8fUyT6dHV9WanPWh6mpbS7sj+BeFCHod
	 WGWI4QHIS0FF5gZqDGhYvGg7M/Cs/i2qd54JpM153xMUoLavdSNMAdGSq+KY8YergY
	 DvITLorF9nFaNZxy58pQ5GgoIDqJQezJNHdmx5goZ2Hfxi7pvUQaYdIl1gK4Z2p9En
	 3b7ZVIFDa2gOMdOz0Vhr82jJx2TbllEHF5QMhoorjz53S1KFe8HtrDDB08Cwt/ieOz
	 4mMn2UM3Snr0Y1mR2/Hi4KZdEDPQPBiealdBfzAhXGhkd6XsPS64vCFQ3+M4RvRBP9
	 q/qEQH40F5QtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dragan Simic <dsimic@manjaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] phy: phy-rockchip-inno-usb2: Use dev_err_probe() in the probe path
Date: Tue, 20 Jan 2026 21:13:32 -0500
Message-ID: <20260121021333.1126769-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121021333.1126769-1-sashal@kernel.org>
References: <2026012042-dealt-crudeness-5250@gregkh>
 <20260121021333.1126769-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210648-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,sntech.de:email]
X-Rspamd-Queue-Id: 658BB4F966
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dragan Simic <dsimic@manjaro.org>

[ Upstream commit 40452520850683f6771094ca218ff206d1fcb022 ]

Improve error handling in the probe path by using function dev_err_probe()
instead of function dev_err(), where appropriate.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/d4ccd9fc278fb46ea868406bf77811ee507f0e4e.1725524803.git.dsimic@manjaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: e07dea3de508 ("phy: rockchip: inno-usb2: Fix a double free bug in rockchip_usb2phy_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 27 +++++++------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index caa5787f09a52..03a1d1453c311 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -380,11 +380,9 @@ static int rockchip_usb2phy_extcon_register(struct rockchip_usb2phy *rphy)
 
 	if (of_property_read_bool(node, "extcon")) {
 		edev = extcon_get_edev_by_phandle(rphy->dev, 0);
-		if (IS_ERR(edev)) {
-			if (PTR_ERR(edev) != -EPROBE_DEFER)
-				dev_err(rphy->dev, "Invalid or missing extcon\n");
-			return PTR_ERR(edev);
-		}
+		if (IS_ERR(edev))
+			return dev_err_probe(rphy->dev, PTR_ERR(edev),
+					     "invalid or missing extcon\n");
 	} else {
 		/* Initialize extcon device */
 		edev = devm_extcon_dev_allocate(rphy->dev,
@@ -394,10 +392,9 @@ static int rockchip_usb2phy_extcon_register(struct rockchip_usb2phy *rphy)
 			return -ENOMEM;
 
 		ret = devm_extcon_dev_register(rphy->dev, edev);
-		if (ret) {
-			dev_err(rphy->dev, "failed to register extcon device\n");
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(rphy->dev, ret,
+					     "failed to register extcon device\n");
 	}
 
 	rphy->edev = edev;
@@ -1276,10 +1273,8 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	}
 
 	ret = rockchip_usb2phy_clk480m_register(rphy);
-	if (ret) {
-		dev_err(dev, "failed to register 480m output clock\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register 480m output clock\n");
 
 	index = 0;
 	for_each_available_child_of_node(np, child_np) {
@@ -1293,8 +1288,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 
 		phy = devm_phy_create(dev, child_np, &rockchip_usb2phy_ops);
 		if (IS_ERR(phy)) {
-			dev_err_probe(dev, PTR_ERR(phy), "failed to create phy\n");
-			ret = PTR_ERR(phy);
+			ret = dev_err_probe(dev, PTR_ERR(phy), "failed to create phy\n");
 			goto put_child;
 		}
 
@@ -1331,8 +1325,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 						"rockchip_usb2phy",
 						rphy);
 		if (ret) {
-			dev_err(rphy->dev,
-				"failed to request usb2phy irq handle\n");
+			dev_err_probe(rphy->dev, ret, "failed to request usb2phy irq handle\n");
 			goto put_child;
 		}
 	}
-- 
2.51.0


