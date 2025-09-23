Return-Path: <stable+bounces-181516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8308B96870
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 17:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C494F2A46EF
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 15:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894F22594B7;
	Tue, 23 Sep 2025 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoG6UHcc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9BFDDAB;
	Tue, 23 Sep 2025 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640517; cv=none; b=m9xHtRGHpGhKmjAvf6oh1aIuchBPPselCTXzxXDi8HstOEgSjG99wgn3OItwimWl3bN2reh0KaoKPYM5aHtfgjoELdCossxWCzBzVrGsYlkS03tKEHg06Z4cWwLF50L7iu+pe8SD/qZOHEmjnUDPa3HKsU1lKd5anMQmvGDsYfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640517; c=relaxed/simple;
	bh=DpWHQGigTbPm8gcTYl8TZGOSyPPjUZHRqNSp0PuxL5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JIsDEbd/0dOcS7NyjyIsxiBzYpp4IkLLSwbm2YwF6peLA9aJNv+Mi5CbH1enFHIWKnumCWNFZxsj1TMXfaqF39Uc6B1MZ4LVrUaIC6gg89SfwBYDHnOmHGPkEJx3IDj1icI+HsHPXkmKzUeCKrUfjVjeHfOHLe3zlMkMdwmTKto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoG6UHcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AC5C4CEF5;
	Tue, 23 Sep 2025 15:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758640516;
	bh=DpWHQGigTbPm8gcTYl8TZGOSyPPjUZHRqNSp0PuxL5I=;
	h=From:To:Cc:Subject:Date:From;
	b=JoG6UHccek/HejhsWYNCG4U9q5yKyuDXrXW4Kf5fYXiWWW5RoPw0Dy7BDvBYKXbc8
	 Bm/+jxAExEylddeRevAIff9IgNSO6mE8aLFuCXY4EUsTv/B4AsixuyP7k7pKv5t5xZ
	 cnnOIEq1H1MWRiybjp7Iene2c3lPLKA22HAbz3PgIwGfhQNiAi4Jd7AFIF3p7xIuyv
	 jevnnKRQ7PBhcBDhPkmrQwfd6YvLTPXzZEBewsGyoIzS8fLZgNaZoWGANT1fh87iFZ
	 XbuaGV04X+SfqNndHPhZn+iUhvj/MXmbhhLJijjdaP/29s67470YpAxznys1sZ5r5e
	 trhNn6nok0OTA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v14jW-000000004a8-2ula;
	Tue, 23 Sep 2025 17:15:10 +0200
From: Johan Hovold <johan@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] drm/imx/tve: fix probe device leak
Date: Tue, 23 Sep 2025 17:13:46 +0200
Message-ID: <20250923151346.17512-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken to the DDC device during probe on
probe failure (e.g. probe deferral) and on driver unbind.

Fixes: fcbc51e54d2a ("staging: drm/imx: Add support for Television Encoder (TVEv2)")
Cc: stable@vger.kernel.org	# 3.10
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/imx/ipuv3/imx-tve.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/imx/ipuv3/imx-tve.c b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
index c5629e155d25..895413d26113 100644
--- a/drivers/gpu/drm/imx/ipuv3/imx-tve.c
+++ b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
@@ -525,6 +525,13 @@ static const struct component_ops imx_tve_ops = {
 	.bind	= imx_tve_bind,
 };
 
+static void imx_tve_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int imx_tve_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -546,6 +553,11 @@ static int imx_tve_probe(struct platform_device *pdev)
 	if (ddc_node) {
 		tve->ddc = of_find_i2c_adapter_by_node(ddc_node);
 		of_node_put(ddc_node);
+
+		ret = devm_add_action_or_reset(dev, imx_tve_put_device,
+					       &tve->ddc->dev);
+		if (ret)
+			return ret;
 	}
 
 	tve->mode = of_get_tve_mode(np);
-- 
2.49.1


