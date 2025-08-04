Return-Path: <stable+bounces-166461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA9AB19F91
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 12:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 867057A7613
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 10:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A392246766;
	Mon,  4 Aug 2025 10:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HcbtjkNq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FE822259D
	for <stable@vger.kernel.org>; Mon,  4 Aug 2025 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754302641; cv=none; b=lJVBURPsmnMjNnfUeOeAG0yH1G67z/7Kpdmp2Mh/zp7AGnHyvPB/BcZ+RNmcvd14DnqyDuYEsXj4EsdqWRSFIDYI9M1BJi+WWY56zFWJJc3kByUZpSWt7mWe9asUOEMPPIKhuRVcnCVTJA5n51HB+zoQZK+X5H77l3OGzovhe8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754302641; c=relaxed/simple;
	bh=9EB99z//htr6I6ttL4rQBDNTDy1zNSH4442e4g+2/OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sA9EoopOpfLhuq4RAn1nD2KvV0OEA4wu6kWL3k1OnUiOWOzKyY3tDlGrkhjxkjzUOhEy8I0QmJEdbts2NbGT9tQT2d+R0PAFpMbp4LfvZlsGVwj0Pe8Aj8wyYUMjX8j1KxcE5u/hzIZ+/8/zMSRVeE3MKsaepoKjiJAyC6tNc9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HcbtjkNq; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32117db952aso1406993a91.0
        for <stable@vger.kernel.org>; Mon, 04 Aug 2025 03:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754302639; x=1754907439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUDLsxXiD/VylUkDEBtoWAUjUDY+mInmp98SkOYqi9w=;
        b=HcbtjkNq22I3LuqIqyG9XY/nEqRNzhtrVB1y2PeYYVO62DDHvDUtikUElYnfQfgWxv
         GcD57Z0XvRWrDYI4VrkeiXXe7mseZDe4EnMzSusT1whhSRHE4kxInzWaBGbx1Dv/OUDh
         GvuAWv8SBciwbxOy5mFwOwa9m8Dxs8stdKvng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754302639; x=1754907439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUDLsxXiD/VylUkDEBtoWAUjUDY+mInmp98SkOYqi9w=;
        b=qQxULZZtWoPDijSuy0pvarVlr9ecIx5lmyGbeM2wQXli3uMIQxn4wdA78MvTv6quGQ
         TMw9pAFISWSUDRmUx9xZLbtPNpYBfoA5RVgIiM5sPQAzI2JODPEOcx6a3sKw4HGmV3Eg
         MPKx+MINbGcWTHQwzWK+Q7WRaf+0myZ6TeV7o51dLrYN894nwvc0QhVGmv1XrvMgl9aO
         0AVfDyBPab99iiGeR4wKB2GxXR65dlO/nSqeZFhben8K0eG8Gbwu6S1DPbYs6VOfojzN
         4spJ3lKGaQTBJD9rHZrqdn2Efdu6RDheXK+NRIVDeaRL5oVS1UmVtj/KDQJXrFRoK3yd
         w/rQ==
X-Gm-Message-State: AOJu0Ywdrxow+T12QQG5E+gIPha7SkGh4F57g7V5l7Z7HU3LpOPEN5Lz
	kql4aVLMZEBwpzgpJMCa5q5EiMA9TXLPOt87eN98TKQUqLGeo1uE4cgsCRL6My4kkQI55HxNkFe
	o/Z4=
X-Gm-Gg: ASbGncvm8G/jw2GhXbLSVa8MCSzZUvczUbpt96D3Fw+j60q7r9OHx36Iyu7J7vlvTS5
	8PwTC9mM8dhvyibbk6sBxVAxbI/xtwC0dkJX2t9YsDXaGLg34uyLPDDcsE7A9fNP/NeB9FDmpgo
	1FQImBDkA2d6ZAdeso4DB6UEAnuuuwtUlJy/W5e4hy4+sjI7bjobBknHxy9kPUS/4m9/flOajQE
	wYLjHSyQl9Jq/y+oVz8vtUMqm3kCxGs1ErG0JaZbIZhilcBbcBcvK60HEiU0RyWcXtSdY1pkHYU
	Ut5P9IQcm79clgXBXXji6uAlWXlXuMxfbVvuOr5UGAYbNI0Xii4xFv3Q3RkiAAOvkLzfx905INp
	sEgGAfWAjuHXZpFdGMUnLTBYtIQHqRYaMwgqiTNwMV03voT5r
X-Google-Smtp-Source: AGHT+IF4j3hAlE3PAMGm17m3AIvdwyISzHyOYkZKH+tEosP2S+R/0+s9IavMVeMnMDPKNYmpJiJ7uw==
X-Received: by 2002:a17:90b:4a02:b0:313:f6fa:5bca with SMTP id 98e67ed59e1d1-321162a25dbmr10605766a91.22.1754302639078;
        Mon, 04 Aug 2025 03:17:19 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:3668:3855:6e9a:a21e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63dc1bb7sm14085261a91.10.2025.08.04.03.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 03:17:18 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>
Subject: [PATCH 6.12 2/6] drm/i915/hdmi: propagate errors from intel_hdmi_init_connector()
Date: Mon,  4 Aug 2025 19:16:40 +0900
Message-ID: <938a984204146a4b6628030af87ff374cb41936c.1754302552.git.senozhatsky@chromium.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <e53d47b06b3ba07b4add2c6930ddafba91a49b41.1754302552.git.senozhatsky@chromium.org>
References: <e53d47b06b3ba07b4add2c6930ddafba91a49b41.1754302552.git.senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit 7fb56536fa37e23bc291d31c10e575d500f4fda7 ]

Propagate errors from intel_hdmi_init_connector() to be able to handle
them at callers. This is similar to intel_dp_init_connector().

Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Reported-and-tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Closes: https://lore.kernel.org/r/20241031105145.2140590-1-senozhatsky@chromium.org
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/cdaf9e32cc4880c46e120933438c37b4d87be12e.1735568047.git.jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 10 ++++++----
 drivers/gpu/drm/i915/display/intel_hdmi.h |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index cd9ee171e0df..c5b2fbaeff89 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -3015,7 +3015,7 @@ void intel_infoframe_init(struct intel_digital_port *dig_port)
 	}
 }
 
-void intel_hdmi_init_connector(struct intel_digital_port *dig_port,
+bool intel_hdmi_init_connector(struct intel_digital_port *dig_port,
 			       struct intel_connector *intel_connector)
 {
 	struct intel_display *display = to_intel_display(dig_port);
@@ -3033,17 +3033,17 @@ void intel_hdmi_init_connector(struct intel_digital_port *dig_port,
 		    intel_encoder->base.base.id, intel_encoder->base.name);
 
 	if (DISPLAY_VER(display) < 12 && drm_WARN_ON(dev, port == PORT_A))
-		return;
+		return false;
 
 	if (drm_WARN(dev, dig_port->max_lanes < 4,
 		     "Not enough lanes (%d) for HDMI on [ENCODER:%d:%s]\n",
 		     dig_port->max_lanes, intel_encoder->base.base.id,
 		     intel_encoder->base.name))
-		return;
+		return false;
 
 	ddc_pin = intel_hdmi_ddc_pin(intel_encoder);
 	if (!ddc_pin)
-		return;
+		return false;
 
 	drm_connector_init_with_ddc(dev, connector,
 				    &intel_hdmi_connector_funcs,
@@ -3088,6 +3088,8 @@ void intel_hdmi_init_connector(struct intel_digital_port *dig_port,
 					   &conn_info);
 	if (!intel_hdmi->cec_notifier)
 		drm_dbg_kms(display->drm, "CEC notifier get failed\n");
+
+	return true;
 }
 
 /*
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.h b/drivers/gpu/drm/i915/display/intel_hdmi.h
index 9b97623665c5..fc64a3affc71 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.h
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.h
@@ -22,7 +22,7 @@ struct intel_encoder;
 struct intel_hdmi;
 union hdmi_infoframe;
 
-void intel_hdmi_init_connector(struct intel_digital_port *dig_port,
+bool intel_hdmi_init_connector(struct intel_digital_port *dig_port,
 			       struct intel_connector *intel_connector);
 bool intel_hdmi_compute_has_hdmi_sink(struct intel_encoder *encoder,
 				      const struct intel_crtc_state *crtc_state,
-- 
2.50.1.565.gc32cd1483b-goog


