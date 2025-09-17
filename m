Return-Path: <stable+bounces-179830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB672B7C803
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8BC1C03B90
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84304371EAD;
	Wed, 17 Sep 2025 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqZTn4uF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB237426D
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110159; cv=none; b=JN/khtbojStBipEfcm04oBeI9NdyKaV8g3JljRUc9Kr8XeSR0SHqdfeqLy959Tnk9H+azoHcTEoCSePfb/7mekopgZYz8j4WuBsiO5SwbY2s5wuv94SoSFPdjpCvOm8Hyh5RPyTnWZlEJaEKZ3j0C0j8SiH6idol/hTdkZd5VvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110159; c=relaxed/simple;
	bh=nVWn6avPD8U90xT2D23RIyZ6p5ZNBzAkgc3Y+X7z0Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsIJ8h24g85bVZKMJbDssW5lSpKFZrD5YoFHLgW7eJEeLmRJiPIxLwKt4FzubktOpJr9E4/9SR73iZOLmYO+AW87zprfyxw6u4ur4naL8M6Gjvh+XwISUDvUSKrn5wy9fh5mXNufY94fYyGzB/GZurYv7l3IoU/gITHx3t6EdqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqZTn4uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB65CC116B1;
	Wed, 17 Sep 2025 11:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758110158;
	bh=nVWn6avPD8U90xT2D23RIyZ6p5ZNBzAkgc3Y+X7z0Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DqZTn4uFCSY1THXBMhcn224K2yDt9DSWpzfQ0AEPd+moxFbeSFP/nT/5hG2kpkaYI
	 nNUHBLQHojwxX12Hb7CGruGJLq8AAD8m3j2KKNdd3QYMN1Ly9lSiqlU/Mw8hatBw+y
	 wS7HGpJEE0Sh+VgKhBGPZsrnxOc7GjxKg6ekyo0iM97ji3/+xFUkD9L2DoJC5OwCwh
	 idFkRSJGd30+uoxpyJfMypfUOHkb7h2ex/GZQkK9FK3s1SSdzCSsf7/35/6z1Jeu+W
	 +gRuJav2yjGJNtak46WjIsRg3VfqTvdXFWE0l+n3VcQv8RDMdG0e/xH+gdYDKJtBnb
	 O21B7uB2gUnGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 1/2] dt-bindings: serial: 8250: allow clock 'uartclk' and 'reg' for nxp,lpc1850-uart
Date: Wed, 17 Sep 2025 07:55:53 -0400
Message-ID: <20250917115554.481057-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091753-raider-wake-9e9d@gregkh>
References: <2025091753-raider-wake-9e9d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit d2db0d78154442fb89165edf8836bf2644c6c58d ]

Allow clock 'uartclk' and 'reg' for nxp,lpc1850-uart to align existed
driver and dts. It is really old platform. Keep the same restriction for
others.

Allow dmas and dma-names property, which allow maxItems 4 because very old
platform (arch/arm/boot/dts/nxp/lpc/lpc18xx.dtsi) use duplicate "tx", "rx",
"tx", "rx" as dma-names.

Fix below CHECK_DTB warnings:
  arch/arm/boot/dts/nxp/lpc/lpc4337-ciaa.dtb: serial@40081000 (nxp,lpc1850-uart): clock-names: ['uartclk', 'reg'] is too long

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Acked-by: "Rob Herring (Arm)" <robh@kernel.org>
Link: https://lore.kernel.org/r/20250602142745.942568-1-Frank.Li@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: a1b51534b532 ("dt-bindings: serial: 8250: allow "main" and "uart" as clock names")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/serial/8250.yaml      | 41 +++++++++++++++++--
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index c6bc27709bf72..2766bb6ff2d1b 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -49,6 +49,24 @@ allOf:
         - required: [ clock-frequency ]
         - required: [ clocks ]
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,lpc1850-uart
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: uartclk
+            - const: reg
+    else:
+      properties:
+        clock-names:
+          items:
+            - const: core
+            - const: bus
+
 properties:
   compatible:
     oneOf:
@@ -142,9 +160,22 @@ properties:
 
   clock-names:
     minItems: 1
-    items:
-      - const: core
-      - const: bus
+    maxItems: 2
+    oneOf:
+      - items:
+          - const: core
+          - const: bus
+      - items:
+          - const: uartclk
+          - const: reg
+
+  dmas:
+    minItems: 1
+    maxItems: 4
+
+  dma-names:
+    minItems: 1
+    maxItems: 4
 
   resets:
     maxItems: 1
@@ -237,7 +268,9 @@ if:
   properties:
     compatible:
       contains:
-        const: spacemit,k1-uart
+        enum:
+          - spacemit,k1-uart
+          - nxp,lpc1850-uart
 then:
   required: [clock-names]
   properties:
-- 
2.51.0


