Return-Path: <stable+bounces-152483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7542AD61D2
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C7217FDE9
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC102475F2;
	Wed, 11 Jun 2025 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RpV9QkIZ"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432F221CC5D;
	Wed, 11 Jun 2025 21:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678511; cv=none; b=YWqUvn21kMtUf7pb7hnirnf4GINUqPDKZ/8zqyyCUyZvfOxTu/QDLMKh5yjg/l3Y9h6PtiIs2MsCYyW5GCkB9VilRGv9W7K3ipHuvqnXhUaS9HKcYv5+Ci8sIF1L+fUrJgBF7haQl+MpWl9n2Busu5DBDyuyKPZrnOJiT81QvtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678511; c=relaxed/simple;
	bh=1DZZD4FZcsjJllv0se6Cxs7D753+HnCfVphExKcrBrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t5TNd1EXWwHsDAqbzKMpNP98sm4qZqPJoS5/CFqBFAsGCGBcQism/nCiBAQraI3wbMDoxV10cVfpts7CePYw9ClsDxh0ocDFx8YOHp6ET3943wvdVE8/BPv9hYjshVgtcQEnyfZVeIduBx7YjyvZOkuetEHmpMseKrXbLo2FliM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RpV9QkIZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749678507;
	bh=1DZZD4FZcsjJllv0se6Cxs7D753+HnCfVphExKcrBrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RpV9QkIZM07oSWPYP+3CivXV6O8AORZD+eNgWccoVp6DoJYxvOzJK2VGpbfyHIaPP
	 NpXFEzNRidq5PYV2zfuhyiLOZsZHqcgIw34LVpolcsYeyNQMc20Jq/Pfl69XE1Bev+
	 NAzS26bbewJS99qunCqOyHoX7PLKPre4qPcxtDdDvXXXPAg2Z4mM5wzbzn/O0qsL9o
	 c5WPkt1WzMLF3P/uDD5ERyModWtqH8XL2V81zMsp1qT08G3YDrgMwBRSl/k9wEm4pr
	 gCUz+aams06njY+b8+tknv0q63P/Y9uiTT8oZptNNUNiy884kdLFiaS+nGHCKZ30Z9
	 amPMd+wZLjclQ==
Received: from localhost (unknown [212.93.144.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 427C817E14DE;
	Wed, 11 Jun 2025 23:48:27 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 12 Jun 2025 00:47:47 +0300
Subject: [PATCH 1/3] dt-bindings: display: vop2: Add optional PLL clock
 property for rk3576
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-rk3576-hdmitx-fix-v1-1-4b11007d8675@collabora.com>
References: <20250612-rk3576-hdmitx-fix-v1-0-4b11007d8675@collabora.com>
In-Reply-To: <20250612-rk3576-hdmitx-fix-v1-0-4b11007d8675@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, Andy Yan <andyshrk@163.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.14.2

As with the RK3588 SoC, RK3576 also allows the use of HDMI PHY PLL as an
alternative and more accurate pixel clock source for VOP2.

Document the optional PLL clock property.

Moreover, given that this is part of a series intended to address some
recent display problems, provide the appropriate tags to facilitate
backporting.

Fixes: c3b7c5a4d7c1 ("dt-bindings: display: vop2: Add rk3576 support")
Cc: stable@vger.kernel.org
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../bindings/display/rockchip/rockchip-vop2.yaml   | 56 +++++++++++++++++-----
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
index f546d481b7e5f496e1684f95edaa2fb97b840503..93da1fb9adc47b20dafc5fb03ee72f458a0f6228 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
@@ -64,10 +64,10 @@ properties:
       - description: Pixel clock for video port 0.
       - description: Pixel clock for video port 1.
       - description: Pixel clock for video port 2.
-      - description: Pixel clock for video port 3.
-      - description: Peripheral(vop grf/dsi) clock.
-      - description: Alternative pixel clock provided by HDMI0 PHY PLL.
-      - description: Alternative pixel clock provided by HDMI1 PHY PLL.
+      - {}
+      - {}
+      - {}
+      - {}
 
   clock-names:
     minItems: 5
@@ -77,10 +77,10 @@ properties:
       - const: dclk_vp0
       - const: dclk_vp1
       - const: dclk_vp2
-      - const: dclk_vp3
-      - const: pclk_vop
-      - const: pll_hdmiphy0
-      - const: pll_hdmiphy1
+      - {}
+      - {}
+      - {}
+      - {}
 
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -175,10 +175,24 @@ allOf:
     then:
       properties:
         clocks:
-          maxItems: 5
+          minItems: 5
+          items:
+            - {}
+            - {}
+            - {}
+            - {}
+            - {}
+            - description: Alternative pixel clock provided by HDMI PHY PLL.
 
         clock-names:
-          maxItems: 5
+          minItems: 5
+          items:
+            - {}
+            - {}
+            - {}
+            - {}
+            - {}
+            - const: pll_hdmiphy0
 
         interrupts:
           minItems: 4
@@ -208,11 +222,29 @@ allOf:
       properties:
         clocks:
           minItems: 7
-          maxItems: 9
+          items:
+            - {}
+            - {}
+            - {}
+            - {}
+            - {}
+            - description: Pixel clock for video port 3.
+            - description: Peripheral(vop grf/dsi) clock.
+            - description: Alternative pixel clock provided by HDMI0 PHY PLL.
+            - description: Alternative pixel clock provided by HDMI1 PHY PLL.
 
         clock-names:
           minItems: 7
-          maxItems: 9
+          items:
+            - {}
+            - {}
+            - {}
+            - {}
+            - {}
+            - const: dclk_vp3
+            - const: pclk_vop
+            - const: pll_hdmiphy0
+            - const: pll_hdmiphy1
 
         interrupts:
           maxItems: 1

-- 
2.49.0


