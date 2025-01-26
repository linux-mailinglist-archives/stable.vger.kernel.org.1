Return-Path: <stable+bounces-110820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CE1A1CE1C
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 20:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA9B27A38E7
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 19:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1519158558;
	Sun, 26 Jan 2025 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dt/fXxCR"
X-Original-To: stable@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D9115DBA3
	for <stable@vger.kernel.org>; Sun, 26 Jan 2025 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737919006; cv=none; b=C0onP6hxScv/W1KB+lucH6uWXielw1JrMY6Y+rWQ0EVmHBC+DDZmxvruwyIZ9uJ11YC9K/TLoyMUFdyU4+hqF/a+isl0ILgJWO/FdEA2hNlGJp3tFfSFZCCd5hW5dWuhYPhq4W/WYumoETKZIDViYedv5cIs+jBVRm7kUGn+pbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737919006; c=relaxed/simple;
	bh=kWFwJhAkccU7aKB3JtXVRSHN7Q0Eq0LEAQpIBvDCGFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XOTGxSsRV13AgMltSv2WKST4JoPWkRZ/qX0HBCR8YDQSKq+9P2OPJGsq8DUMkmkwmkno8Xl3LqKx6Vwdl6qAfpEeq/F/2b3Los7igeWKAkZcHAOAJlQbJ+/FtfocNtdBSzhIUFvzh5NfrYsuP2pW/FG1W6R6V3focsufjOxTrTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dt/fXxCR; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737918996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJQ5JyPH1JLa8mRMcAzP7MxWc1bNNTJLd+qPMpGZOdI=;
	b=Dt/fXxCRawwS23a0uNZGkjhL2jGAEu2e+epzNTBoxc7pCWMIbMp161aAUEytwMA0/VnRCJ
	88RHWCfo3NKgRBCCDJY8rkQ+GVREE1HWz33MlzsBF8gs6KVBwxPvJdFTusj5vLp0aaIl6+
	pSf1q839ku9WEU9UFY0BLotRMJNPI3M=
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Devarsh Thakkar <devarsht@ti.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	DRI Development List <dri-devel@lists.freedesktop.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>,
	Stable List <stable@vger.kernel.org>
Subject: [PATCH v8 04/13] drm/bridge: cdns-dsi: Check return value when getting default PHY config
Date: Mon, 27 Jan 2025 00:45:42 +0530
Message-Id: <20250126191551.741957-5-aradhya.bhatia@linux.dev>
In-Reply-To: <20250126191551.741957-1-aradhya.bhatia@linux.dev>
References: <20250126191551.741957-1-aradhya.bhatia@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Aradhya Bhatia <a-bhatia1@ti.com>

Check for the return value of the phy_mipi_dphy_get_default_config()
call, and incase of an error, return back the same.

Fixes: fced5a364dee ("drm/bridge: cdns: Convert to phy framework")
Cc: Stable List <stable@vger.kernel.org>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 19cc8734a4c8..87921a748cdb 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -575,9 +575,11 @@ static int cdns_dsi_check_conf(struct cdns_dsi *dsi,
 	if (ret)
 		return ret;
 
-	phy_mipi_dphy_get_default_config(mode_clock * 1000,
-					 mipi_dsi_pixel_format_to_bpp(output->dev->format),
-					 nlanes, phy_cfg);
+	ret = phy_mipi_dphy_get_default_config(mode_clock * 1000,
+					       mipi_dsi_pixel_format_to_bpp(output->dev->format),
+					       nlanes, phy_cfg);
+	if (ret)
+		return ret;
 
 	ret = cdns_dsi_adjust_phy_config(dsi, dsi_cfg, phy_cfg, mode, mode_valid_check);
 	if (ret)
-- 
2.34.1


