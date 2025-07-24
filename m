Return-Path: <stable+bounces-164608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91398B10B17
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 15:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA3DAA2860
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 13:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A845C2D77E0;
	Thu, 24 Jul 2025 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwGwjMgX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624102BE643;
	Thu, 24 Jul 2025 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362746; cv=none; b=k1VII//pd3U1+JqbO8K0WcdFak/CxZ4I1ym0CsvjZLtoM/YP34YkDeG0gL27y3F6vkkDTzG1fmtAtb97PFAQ8S+lRy7bUClTewFYWWZSBwq1KR/6let01JEt0VjyGP0ScYFviV0KM0QoiBXUJ6ZNKS9LqhBgYZyGPAdFHskVAgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362746; c=relaxed/simple;
	bh=EnT4paXlhJPUP8+mIB7o5aRRtP4WZADwwl9CUlZpo3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoxCHxP7rzKr0d5E/vk/tC9/n7k3rmpjBoD7rj7Ddz6yXymZlJhi+wDLJrzFGrd/4Kp2DrE3PZcUjt4cOt5v06I7ces1+cIAJJYhNJnalqMHfdX2IBXquVKnXBf+Na8ipAfWCvP1p29s8EsuwgTB9m9MEsYt4ZAKbOPmst2vR+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwGwjMgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E69DC4CEF6;
	Thu, 24 Jul 2025 13:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753362746;
	bh=EnT4paXlhJPUP8+mIB7o5aRRtP4WZADwwl9CUlZpo3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UwGwjMgX1qyHE8qc85t9P1ww2WhT8ej49SDR8kJ8+OSfgvj1wkzBQQQROHe6iJlJP
	 hEB5pytAVYQ2LUvYPANfxGkg6H2rizGopewMdHWENxGIneAJwDMhvhGACzXl9YkSsW
	 eO6ML37EDCbMozshMwgiGo8crJNzSuL4cOPE+5tirlILnd+Xxhe1MCaxX5jQyUEl1U
	 izMkVS4f5SPBiQIETJOOFKDradG8dYbXN7UygsssANEi2Ztg5nVpmwDwJKzWN3nDox
	 Q4lt1fQwCgmXVJ9El3nzZ7IsvzlfL11G+GC+0BFC/6ptNTiNPJsR+b1tUImBkZ3pl2
	 3tytPYqCkZewQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uevkD-000000000aJ-34An;
	Thu, 24 Jul 2025 15:12:21 +0200
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: JC Kuo <jckuo@nvidia.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-phy@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 2/3] phy: ti: omap-usb2: fix device leak at unbind
Date: Thu, 24 Jul 2025 15:12:05 +0200
Message-ID: <20250724131206.2211-3-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250724131206.2211-1-johan@kernel.org>
References: <20250724131206.2211-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference to the control device taken by
of_find_device_by_node() during probe when the driver is unbound.

Fixes: 478b6c7436c2 ("usb: phy: omap-usb2: Don't use omap_get_control_dev()")
Cc: stable@vger.kernel.org	# 3.13
Cc: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/phy/ti/phy-omap-usb2.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index c1a0ef979142..c444bb2530ca 100644
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
2.49.1


