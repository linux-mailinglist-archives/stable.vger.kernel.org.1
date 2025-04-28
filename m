Return-Path: <stable+bounces-136846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AC5A9ED2F
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 11:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCA13AE440
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 09:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706DC38F9C;
	Mon, 28 Apr 2025 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h04g84a7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7409E1AC88A;
	Mon, 28 Apr 2025 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745833258; cv=none; b=SHgOI6G1lYrcV4AbBWwSY9YxIZNkYD4ocgMwWKAiPhUabuFBP9hw24Rn+Nn4XhPsJZ7G+EEscYgidiOmACbvNIIuL5UwGIQmd/9zcj2CbMTcZjdBWu4JYwkMHKqnxM+FDAUqrhWfukrJg2e3JJusu+TkMA12+sxbHnKw8dMqRxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745833258; c=relaxed/simple;
	bh=QtEl+2m1eYszmz+3dFc2Lm7goH/HtdUxHXhZ2+8CrUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NKvWhx0YLDzmuewLO/yze02j1BrcA7KT258LKoOadsrclwx/ZTC6mFmZpxfB5ub0OSxkDQZriVC/SXWKws9ZZKAwZkzBGZKu3c22QppTsmViq2Rig8jfJJqq9IzJ8HNNE3gcxQyxp+ay8mLrr9SZC/0EZAfC7txlnYbT8gCdyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h04g84a7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso43521375e9.1;
        Mon, 28 Apr 2025 02:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745833255; x=1746438055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eWdl+Kqq58dT2qY6KpY9tsh+8ZNojmQ7ty0C+vUxAbM=;
        b=h04g84a7jpDGBhGPaigWQdk+0AID4S7B5+IZlsA6oUG6xwpYXj46ejvglURbvLoRSz
         bdcmHOwE7s+UW8hgnUYXTyGe3Rb3vwqCiVttmTBztuZrkmXSQ1hrAtAopw+yI+Q3yKcT
         IqJk+ct3QXORxteNrljBBu4rn4Wm1qUHQcXbKjA+ryPOil90RVJNxvfJKeKyrh+pFOzT
         YJy3NGBtNgayTRxOmi+sKyI1bn0+uq90Um7qgnanLZ2/nOo1pHwCMgdlO6TzvmZmj/3I
         aNfNUp7GqBiJmHM3srjsA+6AaEsAVICTUyY36hOsafaTDqzvolLhXmBZdaGJuQeSdYNS
         4Syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745833255; x=1746438055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWdl+Kqq58dT2qY6KpY9tsh+8ZNojmQ7ty0C+vUxAbM=;
        b=DyrFa31jEGUnR5mB1QS+ZDB1/5KmXeoAJsybq2YXP6c5Fdchv6InETI0VB/tTOh2rM
         DFU07aWH0eMbpJu75AZsytgebU2V/LlTctOXu9TmDljOwE+EhLifPdkY2ae2ShoQ7Yjp
         WrVj3j9tSpRRa7UsPVOcLQG7Nz1hVn9oo5asazcP8cBmZrDyFieWSnWWZSV6ZhJnf2Q2
         Q0IT4gslXOt/y4x8ZKP02OL6Ita6V0wmVGcrbYTGkb55aodHDyZwbT70SNtPxTGkpRw0
         Sdfhr5b5dOr0qoNQm5E9va277InoDbVjzvXvpAWNOfCrWWUO8y4BUsuZRVLZ5N10OAnA
         XQbA==
X-Forwarded-Encrypted: i=1; AJvYcCUnvkd40E9wf0tPiIxJkr1C3ptmzqV5rrqVwC3RcLQ90M5yptgy0FsPE6THJrLskbkPyNxCI2Db@vger.kernel.org, AJvYcCVyYp+/0Apniner+prjqnYRuhbiyLqUuKfakHDWWFwGr0MQ/fDf//keIcpZgz+5A8Bo224+Aq/XqubnOc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIQRnHOffK7pzDQ1GD+WoTrsNaNIHmBRsRP1vnYGt+PVArKxK/
	Q8CtIvfM6hhoTf2GpWpkuUpUf+tsIFumSZtFdnvZwGi1iJK3kQbP
X-Gm-Gg: ASbGncu158dVv/QmOq9uMrdX6HNeta3BTBs6KmQT9vRGwvMkiBNJM98sLGNUrSrNeON
	wgiWy861ysMLPo6cCCzzFxgXLzPqsarzerCUMaM/NZmspnNADnRVtiH23R3mqttUYqGVks2ciIc
	OFye1w3/11OTkMdb/XclPrH8qBfyS5IK7p51wJaUSLzDat4/LPdjuJJqv36nwd+VQ5lnzdGAPlw
	grtNyZHBIl/mQ1y0GNt2HvdlWHoDt1FyPDxR+pciudqoExyfwEGqkjwPdyDHAIqSMZnn814SyXz
	r/3ZBxt0i1uILo9kgIFUzsrw3NiRrOdSSzd0MA==
X-Google-Smtp-Source: AGHT+IH5WZ2I2b6xONMXmkTLp55tTW8AkFEOLovibWPPY96a7fFSfSjudvpq3AXJ+RQ8zoo5DYpahA==
X-Received: by 2002:a05:600c:5120:b0:43d:22d9:4b8e with SMTP id 5b1f17b1804b1-440a65d8e5bmr109031545e9.10.1745833254418;
        Mon, 28 Apr 2025 02:40:54 -0700 (PDT)
Received: from vitor-nb.. ([2001:8a0:e602:d900:4f54:7a4f:dfe1:ebb6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2d8343sm152687785e9.28.2025.04.28.02.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 02:40:54 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	ivitro@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v1] drm/bridge: cdns-dsi: Replace deprecated UNIVERSAL_DEV_PM_OPS()
Date: Mon, 28 Apr 2025 10:40:48 +0100
Message-Id: <20250428094048.1459620-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitor Soares <vitor.soares@toradex.com>

The deprecated UNIVERSAL_DEV_PM_OPS() macro uses the provided callbacks
for both runtime PM and system sleep. This causes the DSI clocks to be
disabled twice: once during runtime suspend and again during system
suspend, resulting in a WARN message from the clock framework when
attempting to disable already-disabled clocks.

[   84.384540] clk:231:5 already disabled
[   84.388314] WARNING: CPU: 2 PID: 531 at /drivers/clk/clk.c:1181 clk_core_disable+0xa4/0xac
...
[   84.579183] Call trace:
[   84.581624]  clk_core_disable+0xa4/0xac
[   84.585457]  clk_disable+0x30/0x4c
[   84.588857]  cdns_dsi_suspend+0x20/0x58 [cdns_dsi]
[   84.593651]  pm_generic_suspend+0x2c/0x44
[   84.597661]  ti_sci_pd_suspend+0xbc/0x15c
[   84.601670]  dpm_run_callback+0x8c/0x14c
[   84.605588]  __device_suspend+0x1a0/0x56c
[   84.609594]  dpm_suspend+0x17c/0x21c
[   84.613165]  dpm_suspend_start+0xa0/0xa8
[   84.617083]  suspend_devices_and_enter+0x12c/0x634
[   84.621872]  pm_suspend+0x1fc/0x368

To address this issue, replace UNIVERSAL_DEV_PM_OPS() with
DEFINE_RUNTIME_DEV_PM_OPS(), which avoids redundant suspend/resume calls
by checking if the device is already runtime suspended.

Cc: <stable@vger.kernel.org> # 6.1.x
Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index b022dd6e6b6e..62179e55e032 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -1258,7 +1258,7 @@ static const struct mipi_dsi_host_ops cdns_dsi_ops = {
 	.transfer = cdns_dsi_transfer,
 };
 
-static int __maybe_unused cdns_dsi_resume(struct device *dev)
+static int cdns_dsi_resume(struct device *dev)
 {
 	struct cdns_dsi *dsi = dev_get_drvdata(dev);
 
@@ -1269,7 +1269,7 @@ static int __maybe_unused cdns_dsi_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cdns_dsi_suspend(struct device *dev)
+static int cdns_dsi_suspend(struct device *dev)
 {
 	struct cdns_dsi *dsi = dev_get_drvdata(dev);
 
@@ -1279,8 +1279,8 @@ static int __maybe_unused cdns_dsi_suspend(struct device *dev)
 	return 0;
 }
 
-static UNIVERSAL_DEV_PM_OPS(cdns_dsi_pm_ops, cdns_dsi_suspend, cdns_dsi_resume,
-			    NULL);
+static DEFINE_RUNTIME_DEV_PM_OPS(cdns_dsi_pm_ops, cdns_dsi_suspend,
+				 cdns_dsi_resume, NULL);
 
 static int cdns_dsi_drm_probe(struct platform_device *pdev)
 {
@@ -1427,7 +1427,7 @@ static struct platform_driver cdns_dsi_platform_driver = {
 	.driver = {
 		.name   = "cdns-dsi",
 		.of_match_table = cdns_dsi_of_match,
-		.pm = &cdns_dsi_pm_ops,
+		.pm = pm_ptr(&cdns_dsi_pm_ops),
 	},
 };
 module_platform_driver(cdns_dsi_platform_driver);
-- 
2.34.1


