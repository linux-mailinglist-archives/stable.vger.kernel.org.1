Return-Path: <stable+bounces-210636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDmdOFUucGniWwAAu9opvQ
	(envelope-from <stable+bounces-210636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:39:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D7B4F326
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0B53B0226C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 01:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3552307492;
	Wed, 21 Jan 2026 01:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBwa+cqJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901FC19CD05
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768959542; cv=none; b=HLGSa6Z5UBffckwz0VI3NTtZY2ls/i37K1rJPs48w5mzDlXCY57pqEjG0t/L51UfmMy+v7xGjK7Hq+CHcuQZVqqcDybNO1VnPISdy3QKsy0VsZ2M7l0r8EpzjVOX0GIqTYhXTrAUj2y3OUDw4WaSpXj+8/Ls/CVyaGWpb835QXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768959542; c=relaxed/simple;
	bh=CB/CPHbAfyLKI5qRI2rsKznfQEwJ31tcdgMyUsZ2ZkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vwwh0qX5XdUUQwvqJTsV5GDzLrYozhPz0tr+EZjoNSTPDJwbk1NcsBcHtqk7Z2Tk342Z7ORE+NrUMowfVIp9T+Ln2JNNylEL/b7E6G0Oeh1TfsDjWwnCg2cRPJOmVdkuCcfOwgzEEK3/TP220q9nG5OhtQzhH6sUyECQ87sc6FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBwa+cqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44089C19423;
	Wed, 21 Jan 2026 01:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768959538;
	bh=CB/CPHbAfyLKI5qRI2rsKznfQEwJ31tcdgMyUsZ2ZkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TBwa+cqJsFrN301yooLeIueqkRjuiOK2wtcIRhrS+R0qmG+JZQ3HavdVguqfi8QXl
	 74FFoXHUnw8WNJqtEJ3xD90J9bbb+4OigPvIOxxLklINnDqUwObRvvE8LHmHzav/NQ
	 3xQz7miCMyCDCoaeSsdyh0qyDdE482ROSWRUrqkEnSdQeMT1QZ1NnxU9IFHY9/lupk
	 KyHHNsybzS5181EqQ88uCDoojrwLn9l/buNB0sHLTnJd4XMoCJF7/brxS2Cwj0kmJ7
	 QZ/5Eg+m3gA9045IsjmOp95k/CuI2/yop5u5x7UkfRwm0UAsgCv2cIyDoe4z+FP+II
	 JC5dje0tjQdwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dragan Simic <dsimic@manjaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] phy: phy-rockchip-inno-usb2: Use dev_err_probe() in the probe path
Date: Tue, 20 Jan 2026 20:38:55 -0500
Message-ID: <20260121013856.1104103-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012036-dress-salvaging-8848@gregkh>
References: <2026012036-dress-salvaging-8848@gregkh>
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
	TAGGED_FROM(0.00)[bounces-210636-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,sntech.de:email,manjaro.org:email]
X-Rspamd-Queue-Id: 57D7B4F326
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
index 4f71373ae6e1a..78a6dccba07a3 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -424,11 +424,9 @@ static int rockchip_usb2phy_extcon_register(struct rockchip_usb2phy *rphy)
 
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
@@ -438,10 +436,9 @@ static int rockchip_usb2phy_extcon_register(struct rockchip_usb2phy *rphy)
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
@@ -1413,10 +1410,8 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	}
 
 	ret = rockchip_usb2phy_clk480m_register(rphy);
-	if (ret) {
-		dev_err(dev, "failed to register 480m output clock\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register 480m output clock\n");
 
 	if (rphy->phy_cfg->phy_tuning) {
 		ret = rphy->phy_cfg->phy_tuning(rphy);
@@ -1436,8 +1431,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 
 		phy = devm_phy_create(dev, child_np, &rockchip_usb2phy_ops);
 		if (IS_ERR(phy)) {
-			dev_err_probe(dev, PTR_ERR(phy), "failed to create phy\n");
-			ret = PTR_ERR(phy);
+			ret = dev_err_probe(dev, PTR_ERR(phy), "failed to create phy\n");
 			goto put_child;
 		}
 
@@ -1474,8 +1468,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
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


