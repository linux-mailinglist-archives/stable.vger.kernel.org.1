Return-Path: <stable+bounces-164610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FD7B10B1C
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 15:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457981CE2C62
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 13:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2638A2D838C;
	Thu, 24 Jul 2025 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kfx+E2QO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19932D77FF;
	Thu, 24 Jul 2025 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362746; cv=none; b=PFT7X20fd4WSOfEFjGbcOlfrkt+d8UPFLJ7xEgFBE2aZIi2rcNvP00fM64DUn55Ugzdf9yy9lN90NWpYkrKpAA+WkOQGZ1WW876C+KnEGRTKv58k32Fp89CGY8t5HxqkPlr8ZoU4Eo6dwb5iRB2v06/KtSL5f5wnQEkARCqRCRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362746; c=relaxed/simple;
	bh=OCFXvHWz9Bj8TDQec1Lq7R+FarRLGYrv4c6C8ybgBgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F06lx7W84Ck2gZEPnvXWnAvAZn4Q5d+adWZuNwo6lW0HVEKOovac9vj+cWgsWjy7z+GbZFLdip1E7V1UAOUgOBpiTQBUFxMDlSvCUMZcI9zl6O3cC4yTtVQFNqGrAVd+V3gtIC/0s2iPZBFwcP4MH/03m61RajjuHx5drIrKFs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kfx+E2QO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEA7C4CEF7;
	Thu, 24 Jul 2025 13:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753362746;
	bh=OCFXvHWz9Bj8TDQec1Lq7R+FarRLGYrv4c6C8ybgBgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kfx+E2QOn2KChvZeQD5hgSNiDz7PoR0oC58JcuKE5RIb6pE+Y21BctrIJm3YyQ1il
	 H0nrcUwKsw+pr58xzK/u7AR+TpR3TjR1wyI0KDx+zfcy4IegnSKZynO38X3foJEHrc
	 q034ZV+qiPIYRM93WxNIrrVOCJNAqXJ2DjMrJG3nS6qYdl2vTNbL9XcYhV8PiC9BF5
	 btPP4ENv+XxDoNTnmMZsLgG6yns4TAIoApuW4Kmb2imtS3DHzjozqRgmJsPXoyOwr/
	 h9uv1jeAsd4P8mRsbPpDE2ZGZ4WuCF/HZxNqnDumqth1TydcPxj6zB0R4Wn5gtXT8+
	 QZHtqyBHwQ1Xg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uevkD-000000000aL-3OOa;
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
Subject: [PATCH 3/3] phy: ti-pipe3: fix device leak at unbind
Date: Thu, 24 Jul 2025 15:12:06 +0200
Message-ID: <20250724131206.2211-4-johan@kernel.org>
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

Fixes: 918ee0d21ba4 ("usb: phy: omap-usb3: Don't use omap_get_control_dev()")
Cc: stable@vger.kernel.org	# 3.13
Cc: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/phy/ti/phy-ti-pipe3.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index da2cbacb982c..ae764d6524c9 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -667,12 +667,20 @@ static int ti_pipe3_get_clk(struct ti_pipe3 *phy)
 	return 0;
 }
 
+static void ti_pipe3_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int ti_pipe3_get_sysctrl(struct ti_pipe3 *phy)
 {
 	struct device *dev = phy->dev;
 	struct device_node *node = dev->of_node;
 	struct device_node *control_node;
 	struct platform_device *control_pdev;
+	int ret;
 
 	phy->phy_power_syscon = syscon_regmap_lookup_by_phandle(node,
 							"syscon-phy-power");
@@ -704,6 +712,11 @@ static int ti_pipe3_get_sysctrl(struct ti_pipe3 *phy)
 		}
 
 		phy->control_dev = &control_pdev->dev;
+
+		ret = devm_add_action_or_reset(dev, ti_pipe3_put_device,
+					       phy->control_dev);
+		if (ret)
+			return ret;
 	}
 
 	if (phy->mode == PIPE3_MODE_PCIE) {
-- 
2.49.1


