Return-Path: <stable+bounces-166462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B28B19F90
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 12:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E0F1897EEE
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 10:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8542494F0;
	Mon,  4 Aug 2025 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d9LU+DXd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBA5248F6F
	for <stable@vger.kernel.org>; Mon,  4 Aug 2025 10:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754302643; cv=none; b=M7dwFBzlo1yzZ3080QLICNgPh6P1x3XxeBEHt+Fj/oxUOKG1b6XtarBEcAnz7ifS/47lxL4mafwtKeZSpETBnQiGT2Osto4HuYV3/0KB5bEaALIBoOHcDdzV2nd3zhpOEvP1kOys9UWRzDaKthFx3wr+lAMoxmh1GKHw1Il65yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754302643; c=relaxed/simple;
	bh=XKypYcvpCZkHaEQ9Cn6lcz3HTb6aLEyTK/YbOq6/atY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVNZxTdjnRuJY67HUbDBmpTTVZPDwwOS9/0ZhtAslmLrlqUQkxCTMfM7OZswhTBKWJFlnoWzKbTngrzVW9UTJMY/jKEmJVdVzLKPjr0yy7a4ilZxQWmSv3lUMconVVLsTGTknv1fM9OiOJn1oNuwzEjekdWUsI6+9YmZwwJ5xgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d9LU+DXd; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32128c1bf32so1452135a91.2
        for <stable@vger.kernel.org>; Mon, 04 Aug 2025 03:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754302641; x=1754907441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqEET19x8Tr7XYh5rZpfKl3Tkz58u/1qMUrTTSKvoI0=;
        b=d9LU+DXd8dFTH7mbOB4YpkKfLBfLPIPzGuiLvoso2UlPlykT4pH8bbJHGG1WtG1RO2
         acOHMbRjjaX29FLO3d4GMWGI5vXW0wAjkE8ioszN9yEGEXso/yz+/Cf4sr5UYNyi+L9y
         F/xc+C3wHToMySXcKynmWumvQBqRzTybZY4uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754302641; x=1754907441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqEET19x8Tr7XYh5rZpfKl3Tkz58u/1qMUrTTSKvoI0=;
        b=cLgek5CYtp9XsHnxG5g89YuoCH/d7b7gFs5WwJriptqZZiVjFOjDFJ644E8+XfV9Zv
         T0tk0+wtn9DJpP68QoNpetBZG2roxbvwkZtGxuk22dVbZKuOCfnpNvGtdzAWGGNOh7/q
         RVZAjXflImTYd2UFFHqd9Rxcm6wAD1+UudHRD/PEoyJeEUDDrBySKMjIcS+gBWgZKvRr
         j4YSvQjiVNMTh3+nDA4CW+lFk55bwgyBmJp9XJaFOIAP8xAUzCRTGXeVEIB4iyEyt8WK
         JKW40b6fqhSfFdxLUNtY+82fVLhATD0Q4XFUmJVYCUa0QGz5eerSJWcltXADkPoukXOm
         NdUg==
X-Gm-Message-State: AOJu0YzqQk27KkRF3BNUjPvN0DUl4VwA+riaKb0h0qCgRZ4f2Wu5llVi
	jCekKq5uN42/EVlmKf938z7imkPuvIrEpcvXwgvoRzT61JL/i9zyFT3K/McwP/ObIzKmVIKHGYr
	11FI=
X-Gm-Gg: ASbGnct4PScXVCQEl+TrF/EMCqvMAJp7S+qE8rs6bFIvdu+b2ndbJzQkRMPfQJGRloV
	JJ985z2H2YzRd14rg2DyqBf+dwH0dmm8KI+oweSuE0meOmOt8SfOKZEjo67j+9EzZUoosZFGxZJ
	aDVm23Y+1AI9msh83xlNNk+/OfitiPkOlh3rff8UDijcRuB9s4U7Okxdbwcw1RUw/SyL6uo30U2
	RtLVz3cBm+bBOhs16PI9EvpDYYN4k5avoHlkEefKqOM/Xwut8S0hNKIl5WURLx4YRZXgujr05u1
	tK+t6SM+SDlrwpwZl99ujxAYigJfypHJ1gx76TsP1eW7mIMOT+YBZfstvE4rv2Vf7A5C/e8bYCO
	91G2v0tW0Yleyd+5A+94grDYaNku1RwF79ExQmvgwnt9tPwir
X-Google-Smtp-Source: AGHT+IHiiAMfM1xOQXwKxeRQcveGoMeSUlJJmThSqyMjVim8kKs7k5JF0SSYn+scg3DtFZ2p3azKAw==
X-Received: by 2002:a17:90b:3b45:b0:31e:ff94:3fa0 with SMTP id 98e67ed59e1d1-321161d6078mr12954999a91.6.1754302640750;
        Mon, 04 Aug 2025 03:17:20 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:3668:3855:6e9a:a21e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63dc1bb7sm14085261a91.10.2025.08.04.03.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 03:17:20 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>
Subject: [PATCH 6.12 3/6] drm/i915/hdmi: add error handling in g4x_hdmi_init()
Date: Mon,  4 Aug 2025 19:16:41 +0900
Message-ID: <ebf6995a6202f266badbec356c6b87a55cf478dc.1754302552.git.senozhatsky@chromium.org>
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

[ Upstream commit 7603ba81225c815d2ceb4ad52f13e8df4b9d03cc ]

Handle encoder and connector init failures in g4x_hdmi_init(). This is
similar to g4x_dp_init().

Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Reported-and-tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Closes: https://lore.kernel.org/r/20241031105145.2140590-1-senozhatsky@chromium.org
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/cafae7bf1f9ffb8f6a1d7a508cd2ce7dcf06fef7.1735568047.git.jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/g4x_hdmi.c | 35 ++++++++++++++++---------
 drivers/gpu/drm/i915/display/g4x_hdmi.h |  5 ++--
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/g4x_hdmi.c b/drivers/gpu/drm/i915/display/g4x_hdmi.c
index 46f23bdb4c17..b89a364a3924 100644
--- a/drivers/gpu/drm/i915/display/g4x_hdmi.c
+++ b/drivers/gpu/drm/i915/display/g4x_hdmi.c
@@ -683,7 +683,7 @@ static bool assert_hdmi_port_valid(struct drm_i915_private *i915, enum port port
 			 "Platform does not support HDMI %c\n", port_name(port));
 }
 
-void g4x_hdmi_init(struct drm_i915_private *dev_priv,
+bool g4x_hdmi_init(struct drm_i915_private *dev_priv,
 		   i915_reg_t hdmi_reg, enum port port)
 {
 	struct intel_display *display = &dev_priv->display;
@@ -693,10 +693,10 @@ void g4x_hdmi_init(struct drm_i915_private *dev_priv,
 	struct intel_connector *intel_connector;
 
 	if (!assert_port_valid(dev_priv, port))
-		return;
+		return false;
 
 	if (!assert_hdmi_port_valid(dev_priv, port))
-		return;
+		return false;
 
 	devdata = intel_bios_encoder_data_lookup(display, port);
 
@@ -707,15 +707,13 @@ void g4x_hdmi_init(struct drm_i915_private *dev_priv,
 
 	dig_port = kzalloc(sizeof(*dig_port), GFP_KERNEL);
 	if (!dig_port)
-		return;
+		return false;
 
 	dig_port->aux_ch = AUX_CH_NONE;
 
 	intel_connector = intel_connector_alloc();
-	if (!intel_connector) {
-		kfree(dig_port);
-		return;
-	}
+	if (!intel_connector)
+		goto err_connector_alloc;
 
 	intel_encoder = &dig_port->base;
 
@@ -723,9 +721,10 @@ void g4x_hdmi_init(struct drm_i915_private *dev_priv,
 
 	mutex_init(&dig_port->hdcp_mutex);
 
-	drm_encoder_init(&dev_priv->drm, &intel_encoder->base,
-			 &intel_hdmi_enc_funcs, DRM_MODE_ENCODER_TMDS,
-			 "HDMI %c", port_name(port));
+	if (drm_encoder_init(&dev_priv->drm, &intel_encoder->base,
+			     &intel_hdmi_enc_funcs, DRM_MODE_ENCODER_TMDS,
+			     "HDMI %c", port_name(port)))
+		goto err_encoder_init;
 
 	intel_encoder->hotplug = intel_hdmi_hotplug;
 	intel_encoder->compute_config = g4x_hdmi_compute_config;
@@ -788,5 +787,17 @@ void g4x_hdmi_init(struct drm_i915_private *dev_priv,
 
 	intel_infoframe_init(dig_port);
 
-	intel_hdmi_init_connector(dig_port, intel_connector);
+	if (!intel_hdmi_init_connector(dig_port, intel_connector))
+		goto err_init_connector;
+
+	return true;
+
+err_init_connector:
+	drm_encoder_cleanup(&intel_encoder->base);
+err_encoder_init:
+	kfree(intel_connector);
+err_connector_alloc:
+	kfree(dig_port);
+
+	return false;
 }
diff --git a/drivers/gpu/drm/i915/display/g4x_hdmi.h b/drivers/gpu/drm/i915/display/g4x_hdmi.h
index 817f55c7a3a1..a52e8986ec7a 100644
--- a/drivers/gpu/drm/i915/display/g4x_hdmi.h
+++ b/drivers/gpu/drm/i915/display/g4x_hdmi.h
@@ -16,14 +16,15 @@ struct drm_connector;
 struct drm_i915_private;
 
 #ifdef I915
-void g4x_hdmi_init(struct drm_i915_private *dev_priv,
+bool g4x_hdmi_init(struct drm_i915_private *dev_priv,
 		   i915_reg_t hdmi_reg, enum port port);
 int g4x_hdmi_connector_atomic_check(struct drm_connector *connector,
 				    struct drm_atomic_state *state);
 #else
-static inline void g4x_hdmi_init(struct drm_i915_private *dev_priv,
+static inline bool g4x_hdmi_init(struct drm_i915_private *dev_priv,
 				 i915_reg_t hdmi_reg, int port)
 {
+	return false;
 }
 static inline int g4x_hdmi_connector_atomic_check(struct drm_connector *connector,
 						  struct drm_atomic_state *state)
-- 
2.50.1.565.gc32cd1483b-goog


