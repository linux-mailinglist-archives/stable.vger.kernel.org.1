Return-Path: <stable+bounces-180382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF29B7F71E
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A7C1C27B32
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E607D3195FA;
	Wed, 17 Sep 2025 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8521qd4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B88303A39
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115976; cv=none; b=A4Ftt6qLRZc0+DOH61KbYNjV8pYpXv9RZvUvPO7zeDs/5/UnCa7JKDIuZJHfE2P/xi1sa6GTml1vsirFmOa9sl/t3o8wlXCr3g7+2ZHWy//khA2dMvmWRSvCGJJCTRgtE6a4X2QNGyb+UB+CQ3OjE5U5i6O5b4u/+JZnR9NyG00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115976; c=relaxed/simple;
	bh=8leQjEPLXkRxssTfI+mFFCIn7AiHJsZSfyqddCF6/XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYDqeLM3zQ6MJedRbKg8veYyU8mb3TuSIQBJzx+Nf4x4VFCDYa5txk5Me2+Vw9wfD08aHmV+c9B6LPzn8PFvH/7G+V9MHBmj16SaTk2KM0Ri3FMuzzUC4bFHyb+KUjc1r5TBy/vSnozhkpRCujXcXwZ0Yy48wgoQ/9ALC7SyGn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8521qd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94951C4AF11;
	Wed, 17 Sep 2025 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758115976;
	bh=8leQjEPLXkRxssTfI+mFFCIn7AiHJsZSfyqddCF6/XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m8521qd4XaWY6pt8RX/8OJJ8G85APtMmD1Ew7WzmjZ2c5w63z434hepbhHK5ej5X5
	 BdWZWD1BPVn54s2Ty7gbBazEM5J/mrUEirK3qNxQm9eguG2NDc5ALZ1LRPJPHyDw8Q
	 WrOepdMgGunJBJ7StqasJs+JHwKknrR1JUVjUAn8g9Ral7WMEePi01sxl8PlHe0T2o
	 9veSbwfCZX+lD6Q7J12c3VwrfvjVgIblh9fEel+VXOiqiknuzCeO0ndeXGOzt/+pdm
	 Q8HAorXw8o3evIqEGsjK+y+oI0IXzSH11DEVNtqgdAaOwiLks0YLCXh0vaXZUDc4D2
	 gGTkp/hxHMiDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] phy: ti: omap-usb2: fix device leak at unbind
Date: Wed, 17 Sep 2025 09:32:52 -0400
Message-ID: <20250917133252.552245-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917133252.552245-1-sashal@kernel.org>
References: <2025091751-nuzzle-jolt-dcac@gregkh>
 <20250917133252.552245-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 64961557efa1b98f375c0579779e7eeda1a02c42 ]

Make sure to drop the reference to the control device taken by
of_find_device_by_node() during probe when the driver is unbound.

Fixes: 478b6c7436c2 ("usb: phy: omap-usb2: Don't use omap_get_control_dev()")
Cc: stable@vger.kernel.org	# 3.13
Cc: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20250724131206.2211-3-johan@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/ti/phy-omap-usb2.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index dd55f4db72707..5a80d77c72b9d 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -363,6 +363,13 @@ static void omap_usb2_init_errata(struct omap_usb *phy)
 		phy->flags |= OMAP_USB2_DISABLE_CHRG_DET;
 }
 
+static void omap_usb2_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int omap_usb2_probe(struct platform_device *pdev)
 {
 	struct omap_usb	*phy;
@@ -373,6 +380,7 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	struct device_node *control_node;
 	struct platform_device *control_pdev;
 	const struct usb_phy_data *phy_data;
+	int ret;
 
 	phy_data = device_get_match_data(&pdev->dev);
 	if (!phy_data)
@@ -423,6 +431,11 @@ static int omap_usb2_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 		phy->control_dev = &control_pdev->dev;
+
+		ret = devm_add_action_or_reset(&pdev->dev, omap_usb2_put_device,
+					       phy->control_dev);
+		if (ret)
+			return ret;
 	} else {
 		if (of_property_read_u32_index(node,
 					       "syscon-phy-power", 1,
-- 
2.51.0


