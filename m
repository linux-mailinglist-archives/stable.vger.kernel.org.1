Return-Path: <stable+bounces-122504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15865A59FF0
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D5B171804
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED74422B59D;
	Mon, 10 Mar 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WsZY2dVi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA14722FF40;
	Mon, 10 Mar 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628682; cv=none; b=MYvwGrA1sQPIK6nbNLO9gK21w8plODeigEGFIrulGwpZzCseBFwqg2XBp9Q0rf6hPkALD+mgbCxX6DlH1IIW4uMF+yd+As+XU14xoruTWMESB8UMxQAIC+Yq4HB3mG9OCSgm3V0cYpK84eFAfZttwo6Myw/ibm5sMu2lVOln5Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628682; c=relaxed/simple;
	bh=nLBLRuSSFDwCfoZ7bZ4Y1Tz+8W8MwmpoCE9vqIxLc08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g72IujwaiSUOPwIbJJ6X5cl3jAYU/lG3LYBLfgr8uOhaLUppc4OsFN5GI3m6BQ0m1JBex+1VzyN4pSzeSXCwTDRbhc6MwPVKeXDACyIYU87maI9+rBGY1S4Dz2W8UcFoWD62RRSJT+sw0c0ktFGn6JIQ6OqvNFED4i7VG3Td0P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WsZY2dVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052B5C4CEE5;
	Mon, 10 Mar 2025 17:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741628682;
	bh=nLBLRuSSFDwCfoZ7bZ4Y1Tz+8W8MwmpoCE9vqIxLc08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WsZY2dVi6XaomWsU8GNYuaYF4NKh8Mjs45MVioZ2psHz20vBOEAIaI+y6nRpZvofZ
	 avZ5bXqrYidNZf1D/gzilLwF8ytGFd+AoePjoxCnV/e7N1BARhDS5jIx7MTL+kC3E8
	 k0cGqNrA5lfTL0e/jCY+a4aEmqsa5nLjkqQUNx6w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>,
	Guenter Roeck <groeck@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Sebastian Reichel <sre@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 032/620] dt-bindings: Another pass removing cases of allOf containing a $ref
Date: Mon, 10 Mar 2025 17:57:58 +0100
Message-ID: <20250310170546.849101654@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring <robh@kernel.org>

[ Upstream commit dca669354e6ff494222dfc461bed1087264f3755 ]

Another pass at removing unnecessary use of 'allOf' with a '$ref'.

json-schema versions draft7 and earlier have a weird behavior in that
any keywords combined with a '$ref' are ignored (silently). The correct
form was to put a '$ref' under an 'allOf'. This behavior is now changed
in the 2019-09 json-schema spec and '$ref' can be mixed with other
keywords.

Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-By: Vinod Koul <vkoul@kernel.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Marek Behún <kabel@kernel.org>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220228213802.1639658-1-robh@kernel.org
Stable-dep-of: 609bc99a4452 ("dt-bindings: leds: class-multicolor: Fix path to color definitions")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../bindings/connector/usb-connector.yaml         |  3 +--
 .../bindings/display/brcm,bcm2711-hdmi.yaml       |  3 +--
 .../bindings/display/bridge/adi,adv7511.yaml      |  5 ++---
 .../bindings/display/bridge/synopsys,dw-hdmi.yaml |  5 ++---
 .../bindings/display/panel/display-timings.yaml   |  3 +--
 .../devicetree/bindings/display/ste,mcde.yaml     |  4 ++--
 .../devicetree/bindings/input/adc-joystick.yaml   |  9 ++++-----
 .../bindings/leds/cznic,turris-omnia-leds.yaml    |  3 +--
 .../devicetree/bindings/leds/leds-lp50xx.yaml     |  3 +--
 .../devicetree/bindings/mfd/google,cros-ec.yaml   | 12 ++++--------
 .../bindings/mtd/rockchip,nand-controller.yaml    |  3 +--
 .../devicetree/bindings/net/ti,cpsw-switch.yaml   |  3 +--
 .../bindings/phy/phy-stm32-usbphyc.yaml           |  3 +--
 .../bindings/power/supply/sbs,sbs-manager.yaml    |  4 +---
 .../bindings/remoteproc/ti,k3-r5f-rproc.yaml      |  3 +--
 .../devicetree/bindings/soc/ti/ti,pruss.yaml      | 15 +++------------
 .../devicetree/bindings/sound/st,stm32-sai.yaml   |  3 +--
 .../devicetree/bindings/sound/tlv320adcx140.yaml  | 13 ++++++-------
 .../devicetree/bindings/spi/spi-controller.yaml   |  4 +---
 .../devicetree/bindings/usb/st,stusb160x.yaml     |  4 +---
 20 files changed, 36 insertions(+), 69 deletions(-)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 7eb8659fa610f..0420fa5635322 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -104,8 +104,7 @@ properties:
       - "1.5A" and "3.0A", 5V 1.5A and 5V 3.0A respectively, as defined in USB
         Type-C Cable and Connector specification, when Power Delivery is not
         supported.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/string
+    $ref: /schemas/types.yaml#/definitions/string
     enum:
       - default
       - 1.5A
diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
index a1d5a32660e0d..a9d34dd7bbc53 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
@@ -72,8 +72,7 @@ properties:
       - const: hpd-removed
 
   ddc:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/phandle
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: >
       Phandle of the I2C controller used for DDC EDID probing
 
diff --git a/Documentation/devicetree/bindings/display/bridge/adi,adv7511.yaml b/Documentation/devicetree/bindings/display/bridge/adi,adv7511.yaml
index d3dd7a79b9093..f08a01dfedf3f 100644
--- a/Documentation/devicetree/bindings/display/bridge/adi,adv7511.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/adi,adv7511.yaml
@@ -76,9 +76,8 @@ properties:
 
   adi,input-depth:
     description: Number of bits per color component at the input.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [ 8, 10, 12 ]
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 8, 10, 12 ]
 
   adi,input-colorspace:
     description: Input color space.
diff --git a/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
index 9be44a682e67a..b00246faea57c 100644
--- a/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
@@ -26,9 +26,8 @@ properties:
   reg-io-width:
     description:
       Width (in bytes) of the registers specified by the reg property.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [1, 4]
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 4]
     default: 1
 
   clocks:
diff --git a/Documentation/devicetree/bindings/display/panel/display-timings.yaml b/Documentation/devicetree/bindings/display/panel/display-timings.yaml
index 56903ded005e5..6d30575819d3b 100644
--- a/Documentation/devicetree/bindings/display/panel/display-timings.yaml
+++ b/Documentation/devicetree/bindings/display/panel/display-timings.yaml
@@ -31,8 +31,7 @@ properties:
 patternProperties:
   "^timing":
     type: object
-    allOf:
-      - $ref: panel-timing.yaml#
+    $ref: panel-timing.yaml#
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/ste,mcde.yaml b/Documentation/devicetree/bindings/display/ste,mcde.yaml
index de0c678b3c294..564ea845c82e0 100644
--- a/Documentation/devicetree/bindings/display/ste,mcde.yaml
+++ b/Documentation/devicetree/bindings/display/ste,mcde.yaml
@@ -58,8 +58,8 @@ patternProperties:
   "^dsi@[0-9a-f]+$":
     description: subnodes for the three DSI host adapters
     type: object
-    allOf:
-      - $ref: dsi-controller.yaml#
+    $ref: dsi-controller.yaml#
+
     properties:
       compatible:
         const: ste,mcde-dsi
diff --git a/Documentation/devicetree/bindings/input/adc-joystick.yaml b/Documentation/devicetree/bindings/input/adc-joystick.yaml
index 721878d5b7af2..2ee04e03bc224 100644
--- a/Documentation/devicetree/bindings/input/adc-joystick.yaml
+++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
@@ -61,11 +61,10 @@ patternProperties:
         description: EV_ABS specific event code generated by the axis.
 
       abs-range:
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32-array
-          - items:
-              - description: minimum value
-              - description: maximum value
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        items:
+          - description: minimum value
+          - description: maximum value
         description: >
           Minimum and maximum values produced by the axis.
           For an ABS_X axis this will be the left-most and right-most
diff --git a/Documentation/devicetree/bindings/leds/cznic,turris-omnia-leds.yaml b/Documentation/devicetree/bindings/leds/cznic,turris-omnia-leds.yaml
index c7ed2871da06a..9362b1ef9e88a 100644
--- a/Documentation/devicetree/bindings/leds/cznic,turris-omnia-leds.yaml
+++ b/Documentation/devicetree/bindings/leds/cznic,turris-omnia-leds.yaml
@@ -32,8 +32,7 @@ properties:
 patternProperties:
   "^multi-led@[0-9a-b]$":
     type: object
-    allOf:
-      - $ref: leds-class-multicolor.yaml#
+    $ref: leds-class-multicolor.yaml#
     description:
       This node represents one of the RGB LED devices on Turris Omnia.
       No subnodes need to be added for subchannels since this controller only
diff --git a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
index c192b5feadc76..f12fe5b53f30d 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
@@ -55,8 +55,7 @@ properties:
 patternProperties:
   '^multi-led@[0-9a-f]$':
     type: object
-    allOf:
-      - $ref: leds-class-multicolor.yaml#
+    $ref: leds-class-multicolor.yaml#
     properties:
       reg:
         minItems: 1
diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index d793dd0316b75..546746c2e406d 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -39,18 +39,14 @@ properties:
     description:
       This property specifies the delay in usecs between the
       assertion of the CS and the first clock pulse.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - default: 0
-      - minimum: 0
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
 
   google,cros-ec-spi-msg-delay:
     description:
       This property specifies the delay in usecs between messages.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - default: 0
-      - minimum: 0
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
 
   google,has-vbc-nvram:
     description:
diff --git a/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
index 0922536b18114..d681a4676f069 100644
--- a/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
@@ -96,8 +96,7 @@ patternProperties:
 
       rockchip,boot-ecc-strength:
         enum: [16, 24, 40, 60, 70]
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32
+        $ref: /schemas/types.yaml#/definitions/uint32
         description: |
           If specified it indicates that a different BCH/ECC setting is
           supported by the boot ROM.
diff --git a/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml b/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml
index 07a00f53adbf9..31bf825c65987 100644
--- a/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml
+++ b/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml
@@ -88,8 +88,7 @@ properties:
         type: object
         description: CPSW external ports
 
-        allOf:
-          - $ref: ethernet-controller.yaml#
+        $ref: ethernet-controller.yaml#
 
         properties:
           reg:
diff --git a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
index 3329f1d33a4fe..3da0c4ee45cff 100644
--- a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
@@ -76,8 +76,7 @@ patternProperties:
 
       connector:
         type: object
-        allOf:
-          - $ref: ../connector/usb-connector.yaml
+        $ref: /schemas/connector/usb-connector.yaml
         properties:
           vbus-supply: true
 
diff --git a/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.yaml b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.yaml
index 72e8f274c791d..99f506d6b0a02 100644
--- a/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.yaml
+++ b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.yaml
@@ -46,9 +46,7 @@ additionalProperties: false
 patternProperties:
   "^i2c@[1-4]$":
     type: object
-
-    allOf:
-      - $ref: /schemas/i2c/i2c-controller.yaml#
+    $ref: /schemas/i2c/i2c-controller.yaml#
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
index 130fbaacc4b15..3daa4b37f4f6d 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
@@ -94,8 +94,7 @@ patternProperties:
       addresses. Cache and memory access settings are provided through a
       Memory Protection Unit (MPU), programmable only from the R5Fs.
 
-    allOf:
-      - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
+    $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
 
     properties:
       compatible:
diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
index 9d128b9e7deb6..64461d4320048 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
@@ -281,10 +281,7 @@ patternProperties:
       PRUSS INTC Node. Each PRUSS has a single interrupt controller instance
       that is common to all the PRU cores. This should be represented as an
       interrupt-controller node.
-
-    allOf:
-      - $ref: /schemas/interrupt-controller/ti,pruss-intc.yaml#
-
+    $ref: /schemas/interrupt-controller/ti,pruss-intc.yaml#
     type: object
 
   mdio@[a-f0-9]+$:
@@ -292,10 +289,7 @@ patternProperties:
       MDIO Node. Each PRUSS has an MDIO module that can be used to control
       external PHYs. The MDIO module used within the PRU-ICSS is an instance of
       the MDIO Controller used in TI Davinci SoCs.
-
-    allOf:
-      - $ref: /schemas/net/ti,davinci-mdio.yaml#
-
+    $ref: /schemas/net/ti,davinci-mdio.yaml#
     type: object
 
   "^(pru|rtu|txpru)@[0-9a-f]+$":
@@ -305,10 +299,7 @@ patternProperties:
       inactive by using the standard DT string property, "status". The ICSSG IP
       present on K3 SoCs have additional auxiliary PRU cores with slightly
       different IP integration.
-
-    allOf:
-      - $ref: /schemas/remoteproc/ti,pru-rproc.yaml#
-
+    $ref: /schemas/remoteproc/ti,pru-rproc.yaml#
     type: object
 
 required:
diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml b/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
index f97132400bb60..2c5e237db4995 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
@@ -113,8 +113,7 @@ patternProperties:
           By default, custom protocol is assumed, meaning that protocol is
           configured according to protocol defined in related DAI link node,
           such as i2s, left justified, right justified, dsp and pdm protocols.
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/flag
+        $ref: /schemas/types.yaml#/definitions/flag
 
       "#clock-cells":
         description: Configure the SAI device as master clock provider.
diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
index d77c8283526d9..2ad17b361db0a 100644
--- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
@@ -176,13 +176,12 @@ patternProperties:
        4 - Drive weak low and active high
        5 - Drive Hi-Z and active high
 
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32-array
-      - minItems: 2
-        maxItems: 2
-        items:
-          maximum: 15
-        default: [2, 2]
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+    items:
+      maximum: 15
+    default: [2, 2]
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 36b72518f5654..6d0511a8727f7 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -93,9 +93,7 @@ properties:
 patternProperties:
   "^.*@[0-9a-f]+$":
     type: object
-
-    allOf:
-      - $ref: spi-peripheral-props.yaml
+    $ref: spi-peripheral-props.yaml
 
     required:
       - compatible
diff --git a/Documentation/devicetree/bindings/usb/st,stusb160x.yaml b/Documentation/devicetree/bindings/usb/st,stusb160x.yaml
index 9a51efa9d101e..35477fc6d9f43 100644
--- a/Documentation/devicetree/bindings/usb/st,stusb160x.yaml
+++ b/Documentation/devicetree/bindings/usb/st,stusb160x.yaml
@@ -32,9 +32,7 @@ properties:
 
   connector:
     type: object
-
-    allOf:
-      - $ref: ../connector/usb-connector.yaml
+    $ref: /schemas/connector/usb-connector.yaml#
 
     properties:
       compatible:
-- 
2.39.5




