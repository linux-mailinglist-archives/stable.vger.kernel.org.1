Return-Path: <stable+bounces-56213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95AF91DF21
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5321C20F71
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 12:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D2114B946;
	Mon,  1 Jul 2024 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BdB3KHpq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D322514A0A0
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836782; cv=none; b=K0KOnbIYpzrFHx2A+hxZ52AaP6mlI0z6mrD990WglNRcWykA9IjsKyHUQATus8zIkdgaIWFA0vxK+y4hb2dRsLwhsTzT6wQ2U81c8MR3GWGDInj8H0OiB0areydmu7pLSrAx0BDNSHDzbwz6e8vF8qxufp5r2hHM71yAoxzNlm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836782; c=relaxed/simple;
	bh=gplZwq33xV66Pt1TrjOP2SqBHUadCJzdRPO7IkyxOzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uEH/Ixph3ZGYutFuMzDYLZu6GMauju+62Xy6Ok4Tj80hPoVhgUlSb3/13cOuAIVtNfvWwgT1Fb4tccz8izyriFy+9L+149IfjcULV9tKuuH7lYly7EhMjVBDMPGcvr+YAeNznjpXYCovS2kdN/Vs/2NX++xFuLvg7CMWK2ieoyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BdB3KHpq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4256aee6d4fso18562805e9.3
        for <stable@vger.kernel.org>; Mon, 01 Jul 2024 05:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719836779; x=1720441579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kp1SNxyHHsGqs0VRE8jPxl4brl2/S70AtaP9sNNVFrU=;
        b=BdB3KHpqCKkehMcQpebYoAe3WXFbmZVrgEk7NTQDpmMrGn7pfFFQSrqyre3wErpl5S
         swv/XrtwSbUSw5YwtUkp8nYxi1s3ume0AEjtcgpQ3ZjLKpJ0lw+TD11LOsL5if8Y2xut
         zuH2Yh7+YMqfueDDSIfayDy78zOHuBQdwB2jz8boFphRsGvj9NSsp9/5IDs20Epdd0VY
         ihZ2sZ3KfL+vW8oAZGTRGiw6ae47KLU8Q93H28A59q+eT/p0nqVztFMD88/hvT0XteAI
         CR/uaKdzzmQyICj5nLBi8eyR+w8wp0xk9st0r27wgxpx/BJRCBMge2tFk5baOaZKq/t2
         iNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719836779; x=1720441579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kp1SNxyHHsGqs0VRE8jPxl4brl2/S70AtaP9sNNVFrU=;
        b=Ar9VXdHlA2TMHinPoiq6Icyzx0PHlOicGL8a8abRALiH4dITyJcT4NoIfuZvscUg/1
         wEa9/KeStHWuqJLthr7VQS3DiFC0g0bpIl5XaHLGc/N543RId0ssuqZZcpTbGLYw3lez
         MEmioNMfap5nVInVc0XlKWm9H15mvB+65Qu+MBWBtg9X1aD38t2igUSz3lEmntWvGGH5
         FHZtfFnCFYc/I9dtNtFhr0f7kuPMAE8q6eY63IPUsxYQrY19YcPcoP2ZTPMt4dBFAlTs
         H1bt91Kj/mC6rK6f3eOw1TLd5Gjs9wuJHPwcc14te0nrzFGAYY3gI5ko4cuuJGDfcW4v
         3edg==
X-Forwarded-Encrypted: i=1; AJvYcCWuAepVslEcN00DOs+R3hit6flIrg9ghjQhxM60iDX+I27xNd/yKQ0qLGYwSY7uLlPQirP+j2Ez2zFDHT4buuVPZ3jaXNdx
X-Gm-Message-State: AOJu0Yxal5j9zN7sW7L6lydLc9IaWI4ZwSbOED2asEnMvanpvI/wKuHm
	LA/7dIVAvGm2iykQ8uRw3w7s7GYkqbqxA7yO+umvqRoHyPAxzElweGeGxAL0UV4=
X-Google-Smtp-Source: AGHT+IE6wtj0iJ1TUMYwMocSYCW3jFplu3JLk5hLl34UfJIR7op6ci3FtVwF6fD4tmvQaTIDMAA2nA==
X-Received: by 2002:a05:6000:18ae:b0:360:8863:fd1e with SMTP id ffacd0b85a97d-3677569e291mr4614273f8f.12.1719836779173;
        Mon, 01 Jul 2024 05:26:19 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4258014f8b7sm56150815e9.41.2024.07.01.05.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 05:26:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: codecs: wcd939x: Fix typec mux and switch leak during device removal
Date: Mon,  1 Jul 2024 14:26:16 +0200
Message-ID: <20240701122616.414158-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver does not unregister typec structures (typec_mux_dev and
typec_switch_desc) during removal leading to leaks.  Fix this by moving
typec registering parts to separate function and using devm interface to
release them.  This also makes code a bit simpler:
 - Smaller probe() function with less error paths and no #ifdefs,
 - No need to store typec_mux_dev and typec_switch_desc in driver state
   container structure.

Cc: <stable@vger.kernel.org>
Fixes: 10f514bd172a ("ASoC: codecs: Add WCD939x Codec driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware.
---
 sound/soc/codecs/wcd939x.c | 113 ++++++++++++++++++++++---------------
 1 file changed, 66 insertions(+), 47 deletions(-)

diff --git a/sound/soc/codecs/wcd939x.c b/sound/soc/codecs/wcd939x.c
index 72d8a6a35052..28cb74f6f330 100644
--- a/sound/soc/codecs/wcd939x.c
+++ b/sound/soc/codecs/wcd939x.c
@@ -181,8 +181,6 @@ struct wcd939x_priv {
 	/* typec handling */
 	bool typec_analog_mux;
 #if IS_ENABLED(CONFIG_TYPEC)
-	struct typec_mux_dev *typec_mux;
-	struct typec_switch_dev *typec_sw;
 	enum typec_orientation typec_orientation;
 	unsigned long typec_mode;
 	struct typec_switch *typec_switch;
@@ -3519,6 +3517,68 @@ static const struct component_master_ops wcd939x_comp_ops = {
 	.unbind = wcd939x_unbind,
 };
 
+static void __maybe_unused wcd939x_typec_mux_unregister(void *data)
+{
+	struct typec_mux_dev *typec_mux = data;
+
+	typec_mux_unregister(typec_mux);
+}
+
+static void __maybe_unused wcd939x_typec_switch_unregister(void *data)
+{
+	struct typec_switch_dev *typec_sw = data;
+
+	typec_switch_unregister(typec_sw);
+}
+
+static int wcd939x_add_typec(struct wcd939x_priv *wcd939x, struct device *dev)
+{
+#if IS_ENABLED(CONFIG_TYPEC)
+	int ret;
+	struct typec_mux_dev *typec_mux;
+	struct typec_switch_dev *typec_sw;
+	struct typec_mux_desc mux_desc = {
+		.drvdata = wcd939x,
+		.fwnode = dev_fwnode(dev),
+		.set = wcd939x_typec_mux_set,
+	};
+	struct typec_switch_desc sw_desc = {
+		.drvdata = wcd939x,
+		.fwnode = dev_fwnode(dev),
+		.set = wcd939x_typec_switch_set,
+	};
+
+	/*
+	 * Is USBSS is used to mux analog lines,
+	 * register a typec mux/switch to get typec events
+	 */
+	if (!wcd939x->typec_analog_mux)
+		return 0;
+
+	typec_mux = typec_mux_register(dev, &mux_desc);
+	if (IS_ERR(typec_mux))
+		return dev_err_probe(dev, PTR_ERR(typec_mux),
+				     "failed to register typec mux\n");
+
+	ret = devm_add_action_or_reset(dev, wcd939x_typec_mux_unregister,
+				       typec_mux);
+	if (ret)
+		return ret;
+
+	typec_sw = typec_switch_register(dev, &sw_desc);
+	if (IS_ERR(typec_sw))
+		return dev_err_probe(dev, PTR_ERR(typec_sw),
+				     "failed to register typec switch\n");
+
+	ret = devm_add_action_or_reset(dev, wcd939x_typec_switch_unregister,
+				       typec_sw);
+	if (ret)
+		return ret;
+#endif
+
+	return 0;
+}
+
 static int wcd939x_add_slave_components(struct wcd939x_priv *wcd939x,
 					struct device *dev,
 					struct component_match **matchptr)
@@ -3567,42 +3627,13 @@ static int wcd939x_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-#if IS_ENABLED(CONFIG_TYPEC)
-	/*
-	 * Is USBSS is used to mux analog lines,
-	 * register a typec mux/switch to get typec events
-	 */
-	if (wcd939x->typec_analog_mux) {
-		struct typec_mux_desc mux_desc = {
-			.drvdata = wcd939x,
-			.fwnode = dev_fwnode(dev),
-			.set = wcd939x_typec_mux_set,
-		};
-		struct typec_switch_desc sw_desc = {
-			.drvdata = wcd939x,
-			.fwnode = dev_fwnode(dev),
-			.set = wcd939x_typec_switch_set,
-		};
-
-		wcd939x->typec_mux = typec_mux_register(dev, &mux_desc);
-		if (IS_ERR(wcd939x->typec_mux)) {
-			ret = dev_err_probe(dev, PTR_ERR(wcd939x->typec_mux),
-					    "failed to register typec mux\n");
-			goto err_disable_regulators;
-		}
-
-		wcd939x->typec_sw = typec_switch_register(dev, &sw_desc);
-		if (IS_ERR(wcd939x->typec_sw)) {
-			ret = dev_err_probe(dev, PTR_ERR(wcd939x->typec_sw),
-					    "failed to register typec switch\n");
-			goto err_unregister_typec_mux;
-		}
-	}
-#endif /* CONFIG_TYPEC */
+	ret = wcd939x_add_typec(wcd939x, dev);
+	if (ret)
+		goto err_disable_regulators;
 
 	ret = wcd939x_add_slave_components(wcd939x, dev, &match);
 	if (ret)
-		goto err_unregister_typec_switch;
+		goto err_disable_regulators;
 
 	wcd939x_reset(wcd939x);
 
@@ -3619,18 +3650,6 @@ static int wcd939x_probe(struct platform_device *pdev)
 
 	return 0;
 
-#if IS_ENABLED(CONFIG_TYPEC)
-err_unregister_typec_mux:
-	if (wcd939x->typec_analog_mux)
-		typec_mux_unregister(wcd939x->typec_mux);
-#endif /* CONFIG_TYPEC */
-
-err_unregister_typec_switch:
-#if IS_ENABLED(CONFIG_TYPEC)
-	if (wcd939x->typec_analog_mux)
-		typec_switch_unregister(wcd939x->typec_sw);
-#endif /* CONFIG_TYPEC */
-
 err_disable_regulators:
 	regulator_bulk_disable(WCD939X_MAX_SUPPLY, wcd939x->supplies);
 	regulator_bulk_free(WCD939X_MAX_SUPPLY, wcd939x->supplies);
-- 
2.43.0


