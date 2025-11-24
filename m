Return-Path: <stable+bounces-196805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBC7C8280A
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 22:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DB304E35C9
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 21:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB2732E686;
	Mon, 24 Nov 2025 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ec8XHBN0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C832E74B
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764019091; cv=none; b=MBc2WpkYyfOXavt/1xIf9ExqTyQmvbR9x3NUJ+fFIEcvqqEafJjvbpbjwD2HeRNkd58rGSk90ZWhsDBICGmHXNW519op6+fZK6vjg3N8sgEJbtWdeacvwn7JUOQcnJD3aGBCzidYQvsIOE1j5/gSuegQ5OZy2ysG9NAEf/q+wlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764019091; c=relaxed/simple;
	bh=RXe7jUaZtC98c8vMxH/DVbzoX1Iohuw9n5pXxJcOiDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=legF2wX21l0e+DUeteuakVeykdQuu5oRUe54hfjWW1QHxhzQH3HtwtQCUCim6F06gI1XHAKIs+o+pSsJmG347BUviBCKQQeyxK3DTsDjdigGaS8NcO/mdHNCFW8OqzAIn/UH6FIq3ZS6asiO06fFMBi9OOK0sqKLlSXaJA6yBWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ec8XHBN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB45DC16AAE;
	Mon, 24 Nov 2025 21:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764019088;
	bh=RXe7jUaZtC98c8vMxH/DVbzoX1Iohuw9n5pXxJcOiDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ec8XHBN01HyBdk9xa1Y9/At3rZWHQ+H8VVSFg8Qm7TS2cFc7vf4ZbD4b4vl/S72ps
	 djFwJK+bUGD+5NOkbMyt3LPJ2WuqjmHvoRLYrh6ZslM/QJi+wReHqEARvuMXA6/VGX
	 h842bOJ1/KLSVCGl7k+pDhuwJZTdQcQmYtRUpgDGum2I1ylUs8qCQhOW9IbYKC4j6w
	 nvg84TFFLS0Qr93v3xnZd2JwNylLPOe0UUo63SGES7aQXG+UH7OZhkIqa8vn1t4qu3
	 NSJjvUGZFVfjm7EGf8CeSx0WN6d+V6dU+ASUJofwU6jHAiFHO2rRKxdFfE3BVrJSTL
	 GM7QPaQLlfD0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dt-bindings: pinctrl: toshiba,visconti: Fix number of items in groups
Date: Mon, 24 Nov 2025 16:18:06 -0500
Message-ID: <20251124211806.34641-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112404-radial-yoyo-25b9@gregkh>
References: <2025112404-radial-yoyo-25b9@gregkh>
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


