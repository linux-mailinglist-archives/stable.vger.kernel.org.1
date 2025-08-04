Return-Path: <stable+bounces-166460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757DCB19F8F
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 12:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30EE43BB862
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 10:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F9D242D87;
	Mon,  4 Aug 2025 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EGfpnLlf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5704D1F30BB
	for <stable@vger.kernel.org>; Mon,  4 Aug 2025 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754302639; cv=none; b=UEf9GaRd6hqJbbamL695AtzaaQ+lUkksYzDoEhzJkWHgZfv8ZJ1kZw2GBIG5tLjAzsJJ3rJb3CwWHQA8FIjTS8q9T0YeYkH+cd9IcqJkVaUOVKbppIZi++EGOjm3PnNW2y+ODlm3olKXbwr5zr2wOcbQZ1zyAFkfgvO9yqJ3CwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754302639; c=relaxed/simple;
	bh=nc3d/hX49oKJAQcAgKhBVUuBGLeuidzlYV9930U6d+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFGoIaFiQ/Lr3NzlNoIY60v3JTcXAU/ozb2KKV8moGrN7uLg84UhvbvvLV2R46h9EzUC0xketudWIKQByY70m52s47B7rM5F+NMrXOeLE0ghUPR/MbdnmwTuRpIgW17a8ClknH/o/wShZMWje7vu04yf6OTbLfdeXJvMp5XYyOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EGfpnLlf; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b34a8f69862so2057394a12.2
        for <stable@vger.kernel.org>; Mon, 04 Aug 2025 03:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754302637; x=1754907437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F1zq3t+h47i4c+yJ8sxjMUedDaNM1tz4evqY5ODnIuI=;
        b=EGfpnLlfE6WPSa1xRTgL6BnZ9Mx7Jtwb/zh2J4lYI/BiSgyYmagWiqVahcTSa+ka5c
         U8C580r4AUyzXy+j1C7jYHDEvjpRCjNyBeCpYr7RuNwiQYwyvGLDLcHkkHMfEP2fk8lQ
         7O6fDJILumDkyRaRvnYTXz7vjfJrGyB2U6OS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754302637; x=1754907437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1zq3t+h47i4c+yJ8sxjMUedDaNM1tz4evqY5ODnIuI=;
        b=LF7atG1FhRoWglWzSbLryTbSxaR1eVIbMmySY1tPY3J8xyzFW+mC/TVs8Hholzv1Uv
         i16aXsSHafmuDX4q/RVPHSGgNP89vTdaPaa10aZKdB77A4xHCcroyyLhY2Vv+q+LUwcN
         uz3GcCs60ujdeE+uV/mfZTb0EI779YNzJwnBBWPwxXHub9/HQyykaAMC9rsb+0yJPdPa
         BWdVbY/l96GB7JayLaMQk1A2+OsHgjztRjO4k5Mwml6T+wLE/UfOmT9a9ibwA2mOdGtS
         IYoTwTLijP7/tPWcThB1p+HIQ1pIwz5ZINJc2DaNCaqzfEO6NyRXOjCdr6MQW1E9Kcrl
         F34w==
X-Gm-Message-State: AOJu0YzvOpij+rGuBzbLKzp4V+ktGLSqKF2CLXzJpZUMGYiGy7PXuLbC
	ODOmqEsO0AJ9fFbVswfHC+IFm1gbpZ88RzgbFUcLattVOOJAuE0IcdJAvH2zTnGzUxHb28bxPL7
	R8I0=
X-Gm-Gg: ASbGncsf5ujIRuoARDyUR9BGZgZgjCU8prJSyTlxB36sPO4MesZEIlGB86QNnMV8jLx
	vgSkqILxKlWA/8YZLibsQPB4LFjqnLPWRFYdyC+SPsVbZ3lc5UEu5LiD0DdkCl2XrYschhhrnHc
	bf2kItI/PMNCELOy/VsQKcSsybi0u+omwV7puRNKa1oAtTFzHCAF1JUgs1WLCL2LPl/PbK14h+9
	8zZKQ0nN9VIxHfdL9sxl9LeLoWtEi5uMNC11t+/IuR2cyA2TZ5G7vmsCxJrbnQvMk9e+7abbZJx
	YCNfDh9JDnBT7C4vFpUNW1glrrZncL06cnqhBG/akXcOIRMMuKZLI7nQzS/ENsW0aCzBjQByHaE
	koygBzT3JjKpVOdqknIvpM3UZ4b6dfUUVLoPcOaZezrkWLqnz
X-Google-Smtp-Source: AGHT+IEkCq1r2Lxi8fVGKXkO/OUoP+VByAXFo7pTmACKmu9sqrYTqMVs0BpFiLb3+c+D3jYXPAOxRg==
X-Received: by 2002:a17:90b:17c7:b0:31f:5ebe:fa1c with SMTP id 98e67ed59e1d1-321161195b4mr13000212a91.0.1754302637375;
        Mon, 04 Aug 2025 03:17:17 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:3668:3855:6e9a:a21e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63dc1bb7sm14085261a91.10.2025.08.04.03.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 03:17:16 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 6.12 1/6] drm/i915/ddi: change intel_ddi_init_{dp, hdmi}_connector() return type
Date: Mon,  4 Aug 2025 19:16:39 +0900
Message-ID: <e53d47b06b3ba07b4add2c6930ddafba91a49b41.1754302552.git.senozhatsky@chromium.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit e1980a977686d46dbf45687f7750f1c50d1d6cf8 ]

The caller doesn't actually need the returned struct intel_connector;
it's stored in the ->attached_connector of intel_dp and
intel_hdmi. Switch to returning an int with 0 for success and negative
errors codes to be able to indicate success even when we don't have a
connector.

Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/8ef7fe838231919e85eaead640c51ad3e4550d27.1735568047.git.jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 34dee523f0b6..b567efc5b93c 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -4413,8 +4413,7 @@ static const struct drm_encoder_funcs intel_ddi_funcs = {
 	.late_register = intel_ddi_encoder_late_register,
 };
 
-static struct intel_connector *
-intel_ddi_init_dp_connector(struct intel_digital_port *dig_port)
+static int intel_ddi_init_dp_connector(struct intel_digital_port *dig_port)
 {
 	struct drm_i915_private *i915 = to_i915(dig_port->base.base.dev);
 	struct intel_connector *connector;
@@ -4422,7 +4421,7 @@ intel_ddi_init_dp_connector(struct intel_digital_port *dig_port)
 
 	connector = intel_connector_alloc();
 	if (!connector)
-		return NULL;
+		return -ENOMEM;
 
 	dig_port->dp.output_reg = DDI_BUF_CTL(port);
 	if (DISPLAY_VER(i915) >= 14)
@@ -4437,7 +4436,7 @@ intel_ddi_init_dp_connector(struct intel_digital_port *dig_port)
 
 	if (!intel_dp_init_connector(dig_port, connector)) {
 		kfree(connector);
-		return NULL;
+		return -EINVAL;
 	}
 
 	if (dig_port->base.type == INTEL_OUTPUT_EDP) {
@@ -4453,7 +4452,7 @@ intel_ddi_init_dp_connector(struct intel_digital_port *dig_port)
 		}
 	}
 
-	return connector;
+	return 0;
 }
 
 static int intel_hdmi_reset_link(struct intel_encoder *encoder,
@@ -4623,20 +4622,19 @@ static bool bdw_digital_port_connected(struct intel_encoder *encoder)
 	return intel_de_read(dev_priv, GEN8_DE_PORT_ISR) & bit;
 }
 
-static struct intel_connector *
-intel_ddi_init_hdmi_connector(struct intel_digital_port *dig_port)
+static int intel_ddi_init_hdmi_connector(struct intel_digital_port *dig_port)
 {
 	struct intel_connector *connector;
 	enum port port = dig_port->base.port;
 
 	connector = intel_connector_alloc();
 	if (!connector)
-		return NULL;
+		return -ENOMEM;
 
 	dig_port->hdmi.hdmi_reg = DDI_BUF_CTL(port);
 	intel_hdmi_init_connector(dig_port, connector);
 
-	return connector;
+	return 0;
 }
 
 static bool intel_ddi_a_force_4_lanes(struct intel_digital_port *dig_port)
@@ -5185,7 +5183,7 @@ void intel_ddi_init(struct intel_display *display,
 	intel_infoframe_init(dig_port);
 
 	if (init_dp) {
-		if (!intel_ddi_init_dp_connector(dig_port))
+		if (intel_ddi_init_dp_connector(dig_port))
 			goto err;
 
 		dig_port->hpd_pulse = intel_dp_hpd_pulse;
@@ -5199,7 +5197,7 @@ void intel_ddi_init(struct intel_display *display,
 	 * but leave it just in case we have some really bad VBTs...
 	 */
 	if (encoder->type != INTEL_OUTPUT_EDP && init_hdmi) {
-		if (!intel_ddi_init_hdmi_connector(dig_port))
+		if (intel_ddi_init_hdmi_connector(dig_port))
 			goto err;
 	}
 
-- 
2.50.1.565.gc32cd1483b-goog


