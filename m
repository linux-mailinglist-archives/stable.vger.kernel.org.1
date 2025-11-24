Return-Path: <stable+bounces-196806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA03C828B5
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 22:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FC43AC90B
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 21:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446092E9730;
	Mon, 24 Nov 2025 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEFwFznj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004D0269AEE
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764020010; cv=none; b=rk3aT8PM5slEEcAMYK5PaO8RkY5myMx9GyFhpd6X+xBI6PWiykTpKd61KMWNUwPJadIgXNMgtwkgDDPdD4Y/kN8O2B4Mf0BFaUuSDbdJmUPLJi2gijSYvi3bY+Lc7hlKgiL6+Mhgw9ehgqukZtHKj6WstrCiPvLCUCSC2iWMg5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764020010; c=relaxed/simple;
	bh=RXe7jUaZtC98c8vMxH/DVbzoX1Iohuw9n5pXxJcOiDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0w6NiOABZy+VzvnAsg8nbqdsNb3eHTcdgCkGQVF84eT6fiAqiJC6BvUy9ElrvNPH9E+3CfXIWk3C0AkgqZp76H6hNnoYRE7WTMQgV0KTD3tdnjk+4Q1tzh2bJqNnp2Rqx+BgHKvSrKTSIiFiv92M5kMqOi+QxzwqDxmRDWPf4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEFwFznj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF01C4CEF1;
	Mon, 24 Nov 2025 21:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764020009;
	bh=RXe7jUaZtC98c8vMxH/DVbzoX1Iohuw9n5pXxJcOiDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KEFwFznj7ZoaAz21Prt2rqUu0SiRsIM2OJjrU0BSouSnfEICg0AXqBr3M0aEBe2ft
	 TZQ1E4op/Z4Z5leRf5x4QX20Yrgy7e+osVLde5f4Ez58irERFskOT+X/roCWunMhdW
	 loboEMHIHRYNjv4krBnjSu4rcBOjojzcOm9Mun/Z46iw2hdqYz45gRGiFR2g9rtkWO
	 /NrMvD+t68piDPhqLZ9TZPZbuT6VV9cOfQXmfxHrIKtKmFaCbOxub71+ImhGwF12i+
	 nl7ZUa6vzLOige2MgvFu666gqzpBXWIEJ6uy8vr42/Iv+YZ3pbQuMufcpyl7JUeqGD
	 73S8R+dpHxi6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] dt-bindings: pinctrl: toshiba,visconti: Fix number of items in groups
Date: Mon, 24 Nov 2025 16:33:27 -0500
Message-ID: <20251124213327.39691-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112405-vixen-monogamy-fb80@gregkh>
References: <2025112405-vixen-monogamy-fb80@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 316e361b5d2cdeb8d778983794a1c6eadcb26814 ]

The "groups" property can hold multiple entries (e.g.
toshiba/tmpv7708-rm-mbrc.dts file), so allow that by dropping incorrect
type (pinmux-node.yaml schema already defines that as string-array) and
adding constraints for items.  This fixes dtbs_check warnings like:

  toshiba/tmpv7708-rm-mbrc.dtb: pinctrl@24190000 (toshiba,tmpv7708-pinctrl):
    pwm-pins:groups: ['pwm0_gpio16_grp', 'pwm1_gpio17_grp', 'pwm2_gpio18_grp', 'pwm3_gpio19_grp'] is too long

Fixes: 1825c1fe0057 ("pinctrl: Add DT bindings for Toshiba Visconti TMPV7700 SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[ adjusted $ref context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../pinctrl/toshiba,visconti-pinctrl.yaml     | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
index 9f1dab0c2430b..fb84ea998f476 100644
--- a/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
@@ -46,18 +46,20 @@ patternProperties:
       groups:
         description:
           Name of the pin group to use for the functions.
-        $ref: "/schemas/types.yaml#/definitions/string"
-        enum: [i2c0_grp, i2c1_grp, i2c2_grp, i2c3_grp, i2c4_grp,
-               i2c5_grp, i2c6_grp, i2c7_grp, i2c8_grp,
-               spi0_grp, spi0_cs0_grp, spi0_cs1_grp, spi0_cs2_grp,
-               spi1_grp, spi2_grp, spi3_grp, spi4_grp, spi5_grp, spi6_grp,
-               uart0_grp, uart1_grp, uart2_grp, uart3_grp,
-               pwm0_gpio4_grp, pwm0_gpio8_grp, pwm0_gpio12_grp,
-               pwm0_gpio16_grp, pwm1_gpio5_grp, pwm1_gpio9_grp,
-               pwm1_gpio13_grp, pwm1_gpio17_grp, pwm2_gpio6_grp,
-               pwm2_gpio10_grp, pwm2_gpio14_grp, pwm2_gpio18_grp,
-               pwm3_gpio7_grp, pwm3_gpio11_grp, pwm3_gpio15_grp,
-               pwm3_gpio19_grp, pcmif_out_grp, pcmif_in_grp]
+        items:
+          enum: [i2c0_grp, i2c1_grp, i2c2_grp, i2c3_grp, i2c4_grp,
+                 i2c5_grp, i2c6_grp, i2c7_grp, i2c8_grp,
+                 spi0_grp, spi0_cs0_grp, spi0_cs1_grp, spi0_cs2_grp,
+                 spi1_grp, spi2_grp, spi3_grp, spi4_grp, spi5_grp, spi6_grp,
+                 uart0_grp, uart1_grp, uart2_grp, uart3_grp,
+                 pwm0_gpio4_grp, pwm0_gpio8_grp, pwm0_gpio12_grp,
+                 pwm0_gpio16_grp, pwm1_gpio5_grp, pwm1_gpio9_grp,
+                 pwm1_gpio13_grp, pwm1_gpio17_grp, pwm2_gpio6_grp,
+                 pwm2_gpio10_grp, pwm2_gpio14_grp, pwm2_gpio18_grp,
+                 pwm3_gpio7_grp, pwm3_gpio11_grp, pwm3_gpio15_grp,
+                 pwm3_gpio19_grp, pcmif_out_grp, pcmif_in_grp]
+        minItems: 1
+        maxItems: 8
 
       drive-strength:
         enum: [2, 4, 6, 8, 16, 24, 32]
-- 
2.51.0


