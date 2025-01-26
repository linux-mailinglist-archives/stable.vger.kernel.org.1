Return-Path: <stable+bounces-110819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CAAA1CE13
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 20:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377A11886504
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 19:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6499188713;
	Sun, 26 Jan 2025 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gwr0vj3i"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A367418C03D;
	Sun, 26 Jan 2025 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737918996; cv=none; b=bHguZVEmHb/WH34TOp9mbti436+rIcTkzQgYOqG6Xg0U9hCjRoqScjtvwb6swr2INCU+e+zAlwln/eR4Z4jy7fhVlQYzfLXrPKwYm7OKgEpl9fiaIJ0t67pqz07rQJqJkcJ2PBJJq1UYG4e3heWS/Br4JiEWTkpL573hCkOw4Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737918996; c=relaxed/simple;
	bh=N9DM0KjNx4iDB4r0QNh7DJ+PDydJZOYkCWFk10H5HFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z28TLxg7luVYd2lbbp9jbSUZ1lK7vgYbKqmzGXGhDHmdliKbNXTdn1b4huQuaYAGakPA7Lam2I6s2J6GqafFZz9BD3Bar1FnYBkWJtwBSvd0B9C0GeTg7mBIZSrrSbljwkgeU6usQcyNNij+34oZmWHInPYzufvXVNGHV3WnBPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gwr0vj3i; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737918987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+Q6zfVhzhKUmuVVVzbJtveMGdbJJ8wyFdxvA6lkWj8=;
	b=Gwr0vj3i+NxX5DKkLHHJsPaJGXKxGR2pMOSbKGnqF+xxHOtqkV2ZvUaKdYmfPYLNw4Z0z8
	Kdp27Iw0P6Vw8l/Q6Pu2jbufirN7V73r7xN4Ew1BBtjXJCSh9ncBCJ6C6sMSCIQQ1U7a7e
	2GPkfkZkIjCRp1qeY1Cv41U4HLBWYeo=
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
Subject: [PATCH v8 03/13] drm/bridge: cdns-dsi: Fix the clock variable for mode_valid()
Date: Mon, 27 Jan 2025 00:45:41 +0530
Message-Id: <20250126191551.741957-4-aradhya.bhatia@linux.dev>
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

The crtc_* mode parameters do not get generated (duplicated in this
case) from the regular parameters before the mode validation phase
begins.

The rest of the code conditionally uses the crtc_* parameters only
during the bridge enable phase, but sticks to the regular parameters
for mode validation. In this singular instance, however, the driver
tries to use the crtc_clock parameter even during the mode validation,
causing the validation to fail.

Allow the D-Phy config checks to use mode->clock instead of
mode->crtc_clock during mode_valid checks, like everywhere else in the
driver.

Fixes: fced5a364dee ("drm/bridge: cdns: Convert to phy framework")
Cc: Stable List <stable@vger.kernel.org>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index b0a1a6774ea6..19cc8734a4c8 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -568,13 +568,14 @@ static int cdns_dsi_check_conf(struct cdns_dsi *dsi,
 	struct phy_configure_opts_mipi_dphy *phy_cfg = &output->phy_opts.mipi_dphy;
 	unsigned long dsi_hss_hsa_hse_hbp;
 	unsigned int nlanes = output->dev->lanes;
+	int mode_clock = (mode_valid_check ? mode->clock : mode->crtc_clock);
 	int ret;
 
 	ret = cdns_dsi_mode2cfg(dsi, mode, dsi_cfg, mode_valid_check);
 	if (ret)
 		return ret;
 
-	phy_mipi_dphy_get_default_config(mode->crtc_clock * 1000,
+	phy_mipi_dphy_get_default_config(mode_clock * 1000,
 					 mipi_dsi_pixel_format_to_bpp(output->dev->format),
 					 nlanes, phy_cfg);
 
-- 
2.34.1


