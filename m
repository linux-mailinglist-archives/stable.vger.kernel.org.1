Return-Path: <stable+bounces-95327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D009D78F3
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 23:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD565B21CC5
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 22:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF21117AE1C;
	Sun, 24 Nov 2024 22:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="KVFQ9XGe"
X-Original-To: stable@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8BF169397
	for <stable@vger.kernel.org>; Sun, 24 Nov 2024 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732488514; cv=none; b=CdnmR1dX1PoHHDrRZ9xw36iBJoyRnG6ic0uUm/X4Y855K/FEwyx4q5LxQyFmwSJRc9UM3V4R2hT3cBqiEcORB/yqW3XIGLUiDUJRXOyPq+RDg21d6YTVth6CrWGBrqF+yLVXvMZjzk21FWnlSa5pYCBTanBpVNtr2suluDFLv4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732488514; c=relaxed/simple;
	bh=AWLd/g1xcrYnMgN+qA9lGa22Gi84QJD+HEWnWynym+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NESjdv0WqhNfnZfGVK/bC1DF9cOr3U3jc4GoMNABrC3fRsDGOp5ZAQUIBh76bATWF1xqtMQhJLCyOGQNpOO3BzMU/GWI9ZuFOSscVABmeFttWWtTGl5omB0FodDmRTdsQPfs1t3Jy9MQ6T6R0Ofo5UEF5HGbsITEGF0miW7c7Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=KVFQ9XGe; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 31FCC889E9;
	Sun, 24 Nov 2024 23:48:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732488503;
	bh=8BmP5farunaXks7Deyq0Pqjsft7Toz6QqZdEGzvbVS4=;
	h=From:To:Cc:Subject:Date:From;
	b=KVFQ9XGeaQ2WN6f4EAzbRogMNmhws8S3vfJ4iU7yFBBRAhfpnPrI3uA2LUaBImdDA
	 i16sYk5hObGbCVFpZJzUoX4B5bHNB+jk5TMgEH6CSdOBNdM0VqOMKG5zR/+odZur95
	 js1rGcjr9dPY1zKqTd5O4yVGSs4dmuvZEYa/Btuvb0X/Wrplxb2tBBc61kgUwwsbbD
	 +WA0qP3PgeNV/Qulh7Ya+9ydO5Shd4cFxq2rEQAbxiae9E7V8X7v0FGOC5hTTKqfLI
	 +t/o3/iTQ/heSafJg1Tknd5f4Ptu/nhTcFQomJkcqTZZY1HxOjwL6p3w68GlytGUew
	 49A1nyspjKWLg==
From: Marek Vasut <marex@denx.de>
To: dri-devel@lists.freedesktop.org
Cc: Marek Vasut <marex@denx.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	David Airlie <airlied@gmail.com>,
	Hironori KIKUCHI <kikuchan98@gmail.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panel: st7701: Add prepare_prev_first flag to drm_panel
Date: Sun, 24 Nov 2024 23:48:07 +0100
Message-ID: <20241124224812.150263-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The DSI host must be enabled for the panel to be initialized in
prepare(). Set the prepare_prev_first flag to guarantee this.
This fixes the panel operation on NXP i.MX8MP SoC / Samsung DSIM
DSI host.

Fixes: 849b2e3ff969 ("drm/panel: Add Sitronix ST7701 panel driver")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Chris Morgan <macromorgan@hotmail.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org # v6.2+
---
Note that the prepare_prev_first flag was added in Linux 6.2.y commit
5ea6b1702781 ("drm/panel: Add prepare_prev_first flag to drm_panel"),
hence the CC stable v6.2+, even if the Fixes tag points to a commit
in Linux 5.1.y .
---
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index eef03d04e0cd2..1f72ef7ca74c9 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -1177,6 +1177,7 @@ static int st7701_probe(struct device *dev, int connector_type)
 		return dev_err_probe(dev, ret, "Failed to get orientation\n");
 
 	drm_panel_init(&st7701->panel, dev, &st7701_funcs, connector_type);
+	st7701->panel.prepare_prev_first = true;
 
 	/**
 	 * Once sleep out has been issued, ST7701 IC required to wait 120ms
-- 
2.45.2


