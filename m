Return-Path: <stable+bounces-196720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5F6C80CE1
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAD674E585B
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45807306B3E;
	Mon, 24 Nov 2025 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XIIdrSb7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF417306B2C
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763991499; cv=none; b=L0EBHh9zcU2c1htI+oR4U+y2Xysu36MCeP3RkUTWb33JWym6ZyzYOi6qfkl+SL6Bma914X02bmRkitRRBh2SWvMYXGW7mYLtHFhMccNfyFheNLciBPKfP546aC34uweVUAAMkvcvWTPafaRVfqU5CHOhVghVVtgSr2eDMdwZQ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763991499; c=relaxed/simple;
	bh=RCPhjLTnnrcKRTDpbr6tftgaJRtTX3ctHVdMtzC6Lvc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=syv4HiA/XUjjBkTm2hKyBS4rsf+zMfNa2i0a45ZJchG0hSv0ftyR/WI6dftrr9+89/Qwl5X42p5iwDVn4gGy3KC25wKbIIQaOY73ICZIYxybCPLigC1iun0MOFmdm5W9sRRKlZ6QWXgjS+vxB7vYZQEFgogkkjhmO1T/SCpztDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XIIdrSb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEE2C4CEF1;
	Mon, 24 Nov 2025 13:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763991498;
	bh=RCPhjLTnnrcKRTDpbr6tftgaJRtTX3ctHVdMtzC6Lvc=;
	h=Subject:To:Cc:From:Date:From;
	b=XIIdrSb7jS7XY/5btAysgDZMw22v96uMC0f0vi7EjcqEt+htSsE9KqAZalaSLYciY
	 6g8gA5lbGvNt82sw5Rc0qxes+PWODSQZkUNPLr7Llrcw2ojbsY4fmO71GJbvYKj7f0
	 3afIF+JEd1E3asK7z2oa5TxAQ5T5SgFKosIlWrzs=
Subject: FAILED: patch "[PATCH] dt-bindings: pinctrl: toshiba,visconti: Fix number of items" failed to apply to 5.10-stable tree
To: krzk@kernel.org,conor.dooley@microchip.com,krzysztof.kozlowski@linaro.org,linus.walleij@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:38:05 +0100
Message-ID: <2025112405-vixen-monogamy-fb80@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 316e361b5d2cdeb8d778983794a1c6eadcb26814
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112405-vixen-monogamy-fb80@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 316e361b5d2cdeb8d778983794a1c6eadcb26814 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 22 Oct 2025 15:34:26 +0200
Subject: [PATCH] dt-bindings: pinctrl: toshiba,visconti: Fix number of items
 in groups

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

diff --git a/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
index 19d47fd414bc..ce04d2eadec9 100644
--- a/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
@@ -50,18 +50,20 @@ patternProperties:
       groups:
         description:
           Name of the pin group to use for the functions.
-        $ref: /schemas/types.yaml#/definitions/string
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


