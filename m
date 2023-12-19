Return-Path: <stable+bounces-7895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B029D818513
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 11:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E041F225E9
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 10:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2798014281;
	Tue, 19 Dec 2023 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4BprnG+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9169014273
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d741fb7c8eso2030087b3a.2
        for <stable@vger.kernel.org>; Tue, 19 Dec 2023 02:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702980694; x=1703585494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpa0cPeIq5k6EtBKbQ60Cd5skaYCx6iwUurnvO4vgeg=;
        b=P4BprnG+1Q0ecGVufD8IEaMT2kX71YEcM7f4l9Xi2l7yrYwARqGeNGj/Fpfqoe9CqF
         zb0Ff4g4N/v/rDVOh1AKfOGOMlFp41eX0feO8gUhaeeAUBG0iSt2bx+Gfna41Q+4FXoF
         W61ZcRjG3mOfrC3DpRFfaRE83V2Bx+K3RaMGYNJFrKS7kcKBhNUtLPnIsYk/Cox9tHW9
         SRRq0j2ets6wW15Qc8RP7pDBmOuixWDMFIr1Z2creKBIlBx24Vy2yHU3rB3aWvvqrBLg
         FVYr8X+BCTVBGW9r65BlIWoTmUPFh4DUgvOXLgVedeV4EmyPGrggD2GzgXW2tW5gT3V6
         ol/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702980694; x=1703585494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpa0cPeIq5k6EtBKbQ60Cd5skaYCx6iwUurnvO4vgeg=;
        b=lfPvwdmShfWxbcwBpWy7tZQws+EE1mHIqFaLmy9OERIswycZkDIR87drmhlWG+BL6H
         ZYcGzYSk/+nnks+yYtwSa2R8joS2GhNOwbkgBlnALUdZcHEo1eoVicZS8ciFqmzBUYtc
         +j/4SiJK2z6eakEa4lOe2YZr54pEZdeay91dRx2pYZuzuXmufwPZOWDTVOAn0counEKP
         38iQqqOn2tkbWFlQW5Lh7UiPsTAOrbUxRJVYbCMaDtlhgvf5GV9NDcf8krWjpJjsT4uW
         9SwSqv9CH8yjC4ioy4QOyRtF1s43/sxq37/5Of2TbBGVMcpFhJueydNMhLOvAJRE6aiS
         ZOmg==
X-Gm-Message-State: AOJu0Yyif87h/Vh6BdpDKWcDY2f5/p+98ZiAfEHiaOwRr0GnC0a5tMGT
	wtxp9wOMT+dDrxaxoK3SYOftew==
X-Google-Smtp-Source: AGHT+IEoHQs1/cmJfxKAJVANGfkEJeym2LM3D4d7W/vB2LdRUG9bVCj8gjFRxBVW/5bjQtF7YhEgwA==
X-Received: by 2002:a05:6a20:244d:b0:190:9181:7d6d with SMTP id t13-20020a056a20244d00b0019091817d6dmr21521255pzc.83.1702980693791;
        Tue, 19 Dec 2023 02:11:33 -0800 (PST)
Received: from x-wing.lan ([2406:7400:50:3c7b:ab4:a0e:d8f5:e647])
        by smtp.gmail.com with ESMTPSA id n31-20020a056a000d5f00b006d5723e9a0dsm4388989pfv.74.2023.12.19.02.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 02:11:33 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Stable <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Maxime Ripard <maxime@cerno.tech>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH for-5.15.y 3/3] Revert "drm/bridge: lt9611uxc: Switch to devm MIPI-DSI helpers"
Date: Tue, 19 Dec 2023 15:41:18 +0530
Message-Id: <20231219101118.965996-4-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231219101118.965996-1-amit.pundir@linaro.org>
References: <20231219101118.965996-1-amit.pundir@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit f53a045793289483b3c2930007fc52c7f1f642d5.

This and the dependent fixes broke display on RB5.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 38 +++++++++++++++++-----
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index b58842f69fff..c4454d0f6cad 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -258,18 +258,17 @@ static struct mipi_dsi_device *lt9611uxc_attach_dsi(struct lt9611uxc *lt9611uxc,
 	const struct mipi_dsi_device_info info = { "lt9611uxc", 0, NULL };
 	struct mipi_dsi_device *dsi;
 	struct mipi_dsi_host *host;
-	struct device *dev = lt9611uxc->dev;
 	int ret;
 
 	host = of_find_mipi_dsi_host_by_node(dsi_node);
 	if (!host) {
-		dev_err(dev, "failed to find dsi host\n");
+		dev_err(lt9611uxc->dev, "failed to find dsi host\n");
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
-	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
+	dsi = mipi_dsi_device_register_full(host, &info);
 	if (IS_ERR(dsi)) {
-		dev_err(dev, "failed to create dsi device\n");
+		dev_err(lt9611uxc->dev, "failed to create dsi device\n");
 		return dsi;
 	}
 
@@ -278,9 +277,10 @@ static struct mipi_dsi_device *lt9611uxc_attach_dsi(struct lt9611uxc *lt9611uxc,
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
 			  MIPI_DSI_MODE_VIDEO_HSE;
 
-	ret = devm_mipi_dsi_attach(dev, dsi);
+	ret = mipi_dsi_attach(dsi);
 	if (ret < 0) {
-		dev_err(dev, "failed to attach dsi to host\n");
+		dev_err(lt9611uxc->dev, "failed to attach dsi to host\n");
+		mipi_dsi_device_unregister(dsi);
 		return ERR_PTR(ret);
 	}
 
@@ -355,6 +355,19 @@ static int lt9611uxc_connector_init(struct drm_bridge *bridge, struct lt9611uxc
 	return drm_connector_attach_encoder(&lt9611uxc->connector, bridge->encoder);
 }
 
+static void lt9611uxc_bridge_detach(struct drm_bridge *bridge)
+{
+	struct lt9611uxc *lt9611uxc = bridge_to_lt9611uxc(bridge);
+
+	if (lt9611uxc->dsi1) {
+		mipi_dsi_detach(lt9611uxc->dsi1);
+		mipi_dsi_device_unregister(lt9611uxc->dsi1);
+	}
+
+	mipi_dsi_detach(lt9611uxc->dsi0);
+	mipi_dsi_device_unregister(lt9611uxc->dsi0);
+}
+
 static int lt9611uxc_bridge_attach(struct drm_bridge *bridge,
 				   enum drm_bridge_attach_flags flags)
 {
@@ -375,11 +388,19 @@ static int lt9611uxc_bridge_attach(struct drm_bridge *bridge,
 	/* Attach secondary DSI, if specified */
 	if (lt9611uxc->dsi1_node) {
 		lt9611uxc->dsi1 = lt9611uxc_attach_dsi(lt9611uxc, lt9611uxc->dsi1_node);
-		if (IS_ERR(lt9611uxc->dsi1))
-			return PTR_ERR(lt9611uxc->dsi1);
+		if (IS_ERR(lt9611uxc->dsi1)) {
+			ret = PTR_ERR(lt9611uxc->dsi1);
+			goto err_unregister_dsi0;
+		}
 	}
 
 	return 0;
+
+err_unregister_dsi0:
+	mipi_dsi_detach(lt9611uxc->dsi0);
+	mipi_dsi_device_unregister(lt9611uxc->dsi0);
+
+	return ret;
 }
 
 static enum drm_mode_status
@@ -523,6 +544,7 @@ static struct edid *lt9611uxc_bridge_get_edid(struct drm_bridge *bridge,
 
 static const struct drm_bridge_funcs lt9611uxc_bridge_funcs = {
 	.attach = lt9611uxc_bridge_attach,
+	.detach = lt9611uxc_bridge_detach,
 	.mode_valid = lt9611uxc_bridge_mode_valid,
 	.mode_set = lt9611uxc_bridge_mode_set,
 	.detect = lt9611uxc_bridge_detect,
-- 
2.25.1


