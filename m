Return-Path: <stable+bounces-202983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4188CCC0CE
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 14:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D6EF300E017
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 13:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9E6332EA1;
	Thu, 18 Dec 2025 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fD4VAWRC"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A349C23A9B0;
	Thu, 18 Dec 2025 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766064951; cv=none; b=gELvAezUPTxpdqWo9BEBlbLkjh5nd/gynoQNgc/IMImrM/b3aQNfSEmc3C+jdj6IykRhLoes0JyUnPYkIJIW4YJTJaHd5Vk8IWhI3BYMKBNrbbSUBM7PP1E916TC8lWwyQ/UjNTrLFOSIDmabg1lDMJfAu3ymIog1mR/6hujcyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766064951; c=relaxed/simple;
	bh=kt1CFgrJoGGcg4im5yw+G42zbIzjog2txWELjrIDc+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=m2imq0SrMUlysgFBhmTuK1jbVd+SAl244YnZijkdkIPlqz3vDNr9IDwKZwnkz2yF7mD+yReFrE+FHwYXxjbGPP8XJ0+mWO5pY7nV7VtJqLLuMUdFjL853+ex+tjoTuS+sGjwmB/+41GVSkUigTdlHBPp/wbxwuYZrpWiLs3D26M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fD4VAWRC; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1766064948; x=1797600948;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=kt1CFgrJoGGcg4im5yw+G42zbIzjog2txWELjrIDc+c=;
  b=fD4VAWRCPzQ96hYjLy3U/WBLllp0+hd+tykIs1WWylG90IDMcEf05bw4
   2c7SakY5WGEXJIL4XHurMcChXgL37hXvWzMm8z7lTEdk3m+aMcgQFECsy
   4VhMS9PMqrQU1MT0aBs+xJkJkvOEL0y0OLVBgtZwrphbai1jKofKUfx3L
   a67kiJKyf8aVutxLcsyCuxCmmlPKRz1eRfBnREyzzC0dauL8pJ/pq9a8w
   hBmOkWXFIP1EL5IG8KfQeP01P2H6eRjkm1AZFVwNiV5GQzQhzI7/SG4mO
   mJ6VIe6fHuwbCaMvAlAGnD4TMaUN/A10NBXGNYGy1zdQy0wWgT2IOfxkQ
   w==;
X-CSE-ConnectionGUID: XkRRgBcvQem1Rm3CmAuLCw==
X-CSE-MsgGUID: xL5deTY1QNCP3D+M0qYyQA==
X-IronPort-AV: E=Sophos;i="6.21,158,1763449200"; 
   d="scan'208";a="50047202"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 06:35:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 18 Dec 2025 06:35:15 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 18 Dec 2025 06:35:12 -0700
From: Ludovic Desroches <ludovic.desroches@microchip.com>
Date: Thu, 18 Dec 2025 14:34:43 +0100
Subject: [PATCH REGRESSION v3] drm/panel: simple: restore connector_type
 fallback
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251218-lcd_panel_connector_type_fix-v3-1-ddcea6d8d7ef@microchip.com>
X-B4-Tracking: v=1; b=H4sIAPICRGkC/43NuwrCMBQG4FeRzEZ60ovi5CLiolBHkZCentiAJ
 iWRYJG+u6GTuOj4n8v3v1ggbyiw9ezFPEUTjLMp5PMZw07ZK3HTpsxEJkoAAfyGreyVpZtEZy3
 hw3n5GHqS2jy5zjJN+bKqVCFYInpPaTzxZ1Zvd/X2dNofD+ySdp0J6XeYmiNMF/+VRODAdds0p
 PNCgSo2d4PeYWf6Bbr7hEfxCVY/QJFAhHKVly3oJTbf4DiOb0ybjr0pAQAA
X-Change-ID: 20251121-lcd_panel_connector_type_fix-f00fe3766a42
To: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
	<jesszhan0024@gmail.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Anusha Srivatsa <asrivats@redhat.com>, "Luca
 Ceresoli" <luca.ceresoli@bootlin.com>, Jessica Zhang
	<jessica.zhang@oss.qualcomm.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Ludovic Desroches <ludovic.desroches@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5611;
 i=ludovic.desroches@microchip.com; h=from:subject:message-id;
 bh=kt1CFgrJoGGcg4im5yw+G42zbIzjog2txWELjrIDc+c=;
 b=owEBbQKS/ZANAwAKAT455hP3e2QtAcsmYgBpRAMPJ4Y+1SD/eQcI5ztthiQSN1oN5XcndfVAb
 ROaOj6gVZ+JAjMEAAEKAB0WIQQAMEvJiWmsW41tNU0+OeYT93tkLQUCaUQDDwAKCRA+OeYT93tk
 LW3dD/9JdAtSTdSWzh1sKvN174Nx+2vMQMlwHBp+OoWOvllX3QS8Csre61VbxiwIBKR7XEDAWsS
 hratGlsVorpnl8YmJc8u7I18yzk3UUQSWeipbKJUVSufG0uD0yjjeWTTa3u506tkvL60j/GKjKQ
 z0TgczQr0YjpJbRcX1+yqnVf49jp7R1BM57/xBKyyJbrDNOGkygee9VGXoyfYgk1haA0ZqikvEy
 58oLrF630AW9EJfL/H3VUMQ48HmQptsUdGn2J1dMdE8DbxOaSvtnsrWOenk0799ltGGuYVl2apt
 yqZhr8VhdyAuo5yzabm0ilNuEQzglb7LvY0gvt66wQwL4AkMBxg+Fs/FzXX7XJZsBAPRk5+3bKz
 JHVouvFt1GKLfX0kgJCfbzuoQpzmh7/ETG2K1r1e/tHN4AJB5mEoa61fbVbIibst/wJP61v3N03
 GnW48wGuAZmTTvpCO7VwBjggyOd4coZlycWYsznzXOYi5B0rJXCo28lV6trlY6U/Sg3rs1ec/oe
 T31opBXEpWB+yskK2lYyAAv4eEPdAJVotfnakkv7zQ1II+K0VB9q4G5H/WgAqVn6nR9RvbeGl8y
 McuLDWR5eEDci6LDBVxlOfaEz5ET3Pv6KuFpA7LMjjA+aNSBUrp6zIkQbJplLglAC4+Vd20Y5+Y
 BqbIoJ3mxpbb3WA==
X-Developer-Key: i=ludovic.desroches@microchip.com; a=openpgp;
 fpr=665BAA7297BE089A28B77696E332995F09DCC11A

The switch from devm_kzalloc() + drm_panel_init() to
devm_drm_panel_alloc() introduced a regression.

Several panel descriptors do not set connector_type. For those panels,
panel_simple_probe() used to compute a connector type (currently DPI as a
fallback) and pass that value to drm_panel_init(). After the conversion
to devm_drm_panel_alloc(), the call unconditionally used
desc->connector_type instead, ignoring the computed fallback and
potentially passing DRM_MODE_CONNECTOR_Unknown, which
drm_panel_bridge_add() does not allow.

Move the connector_type validation / fallback logic before the
devm_drm_panel_alloc() call and pass the computed connector_type to
devm_drm_panel_alloc(), so panels without an explicit connector_type
once again get the DPI default.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Fixes: de04bb0089a9 ("drm/panel/panel-simple: Use the new allocation in place of devm_kzalloc()")
Cc: stable@vger.kernel.org
---
Changes in v3:
- Add the tag "Cc: stable@vger.kernel.org" in the sign-off area.
- Link to v2: https://lore.kernel.org/r/20251126-lcd_panel_connector_type_fix-v2-1-c15835d1f7cb@microchip.com

Changes in v2:
- Fix a warning introduced by the code move. There is no need to jump to
  free_ddc, we can directly return from the function.
- Link to v1: https://lore.kernel.org/r/20251121-lcd_panel_connector_type_fix-v1-1-fdbbef34a1a4@microchip.com
---
 drivers/gpu/drm/panel/panel-simple.c | 89 ++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 0019de93be1b663f55b04160606363cd043ab38b..5fd75b3939c635ca3e5b293ea37a759f479fa3f8 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -623,49 +623,6 @@ static struct panel_simple *panel_simple_probe(struct device *dev)
 	if (IS_ERR(desc))
 		return ERR_CAST(desc);
 
-	panel = devm_drm_panel_alloc(dev, struct panel_simple, base,
-				     &panel_simple_funcs, desc->connector_type);
-	if (IS_ERR(panel))
-		return ERR_CAST(panel);
-
-	panel->desc = desc;
-
-	panel->supply = devm_regulator_get(dev, "power");
-	if (IS_ERR(panel->supply))
-		return ERR_CAST(panel->supply);
-
-	panel->enable_gpio = devm_gpiod_get_optional(dev, "enable",
-						     GPIOD_OUT_LOW);
-	if (IS_ERR(panel->enable_gpio))
-		return dev_err_cast_probe(dev, panel->enable_gpio,
-					  "failed to request GPIO\n");
-
-	err = of_drm_get_panel_orientation(dev->of_node, &panel->orientation);
-	if (err) {
-		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
-		return ERR_PTR(err);
-	}
-
-	ddc = of_parse_phandle(dev->of_node, "ddc-i2c-bus", 0);
-	if (ddc) {
-		panel->ddc = of_find_i2c_adapter_by_node(ddc);
-		of_node_put(ddc);
-
-		if (!panel->ddc)
-			return ERR_PTR(-EPROBE_DEFER);
-	}
-
-	if (!of_device_is_compatible(dev->of_node, "panel-dpi") &&
-	    !of_get_display_timing(dev->of_node, "panel-timing", &dt))
-		panel_simple_parse_panel_timing_node(dev, panel, &dt);
-
-	if (desc->connector_type == DRM_MODE_CONNECTOR_LVDS) {
-		/* Optional data-mapping property for overriding bus format */
-		err = panel_simple_override_nondefault_lvds_datamapping(dev, panel);
-		if (err)
-			goto free_ddc;
-	}
-
 	connector_type = desc->connector_type;
 	/* Catch common mistakes for panels. */
 	switch (connector_type) {
@@ -690,8 +647,7 @@ static struct panel_simple *panel_simple_probe(struct device *dev)
 		break;
 	case DRM_MODE_CONNECTOR_eDP:
 		dev_warn(dev, "eDP panels moved to panel-edp\n");
-		err = -EINVAL;
-		goto free_ddc;
+		return ERR_PTR(-EINVAL);
 	case DRM_MODE_CONNECTOR_DSI:
 		if (desc->bpc != 6 && desc->bpc != 8)
 			dev_warn(dev, "Expected bpc in {6,8} but got: %u\n", desc->bpc);
@@ -720,6 +676,49 @@ static struct panel_simple *panel_simple_probe(struct device *dev)
 		break;
 	}
 
+	panel = devm_drm_panel_alloc(dev, struct panel_simple, base,
+				     &panel_simple_funcs, connector_type);
+	if (IS_ERR(panel))
+		return ERR_CAST(panel);
+
+	panel->desc = desc;
+
+	panel->supply = devm_regulator_get(dev, "power");
+	if (IS_ERR(panel->supply))
+		return ERR_CAST(panel->supply);
+
+	panel->enable_gpio = devm_gpiod_get_optional(dev, "enable",
+						     GPIOD_OUT_LOW);
+	if (IS_ERR(panel->enable_gpio))
+		return dev_err_cast_probe(dev, panel->enable_gpio,
+					  "failed to request GPIO\n");
+
+	err = of_drm_get_panel_orientation(dev->of_node, &panel->orientation);
+	if (err) {
+		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
+		return ERR_PTR(err);
+	}
+
+	ddc = of_parse_phandle(dev->of_node, "ddc-i2c-bus", 0);
+	if (ddc) {
+		panel->ddc = of_find_i2c_adapter_by_node(ddc);
+		of_node_put(ddc);
+
+		if (!panel->ddc)
+			return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	if (!of_device_is_compatible(dev->of_node, "panel-dpi") &&
+	    !of_get_display_timing(dev->of_node, "panel-timing", &dt))
+		panel_simple_parse_panel_timing_node(dev, panel, &dt);
+
+	if (desc->connector_type == DRM_MODE_CONNECTOR_LVDS) {
+		/* Optional data-mapping property for overriding bus format */
+		err = panel_simple_override_nondefault_lvds_datamapping(dev, panel);
+		if (err)
+			goto free_ddc;
+	}
+
 	dev_set_drvdata(dev, panel);
 
 	/*

---
base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
change-id: 20251121-lcd_panel_connector_type_fix-f00fe3766a42

Best regards,
-- 
Ludovic Desroches <ludovic.desroches@microchip.com>


