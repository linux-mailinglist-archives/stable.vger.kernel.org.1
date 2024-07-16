Return-Path: <stable+bounces-59386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD791931F53
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 05:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB7C1C20F58
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 03:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED2218C31;
	Tue, 16 Jul 2024 03:36:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D4B11725;
	Tue, 16 Jul 2024 03:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721101013; cv=none; b=KsoK/vxI6brgWZinOYxJ+hPVfyn3JInoJ2hAl2dwjCU/he2A+3uUzS9V9Zy/JHovhoX6FhF4fQP4tynad38jtmxr01byHVds0DS1fAugaPbWQ9d1AXHSIVYfL14hSG3zJ+wgUbTTLKlptok47M43UmRvVRlmhr9sb2c3FKvO8KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721101013; c=relaxed/simple;
	bh=Tt99vW0yPGRlG70EaM0HA3UHhbwRYeYBF2lX+BqlYa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=orCx1o7jx0BAjJqwraNm/MbLFu1Q5Pw9+Bt6iuxWrU5DGEoctls3lhddWi8rhr9P9CLx/arCsMC7wEXPCdTOFYuBYrrUZdOfb8qpntx+6CpIehISuAc0bdAi4EFdQcDDUeRvk+orKYj4jXkRqGXhyNt17wA7BjnfgcSh2WdCnks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F0B841A092E;
	Tue, 16 Jul 2024 05:36:43 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B989F1A0914;
	Tue, 16 Jul 2024 05:36:43 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C5835180222B;
	Tue, 16 Jul 2024 11:36:41 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: tj@kernel.org,
	dlemoal@kernel.org,
	cassel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: linux-ide@vger.kernel.org,
	stable@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 1/4] dt-bindings: ata: Add i.MX8QM AHCI compatible string
Date: Tue, 16 Jul 2024 11:18:12 +0800
Message-Id: <1721099895-26098-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721099895-26098-1-git-send-email-hongxing.zhu@nxp.com>
References: <1721099895-26098-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Add i.MX8QM AHCI "fsl,imx8qm-ahci" compatible strings.

i.MX8QM AHCI SATA doesn't require AHB clock rate to set the vendor
specified TIMER1MS register. ahb clock is not required by i.MX8QM AHCI.

Update the description of clocks in the dt-binding accordingly.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/ata/imx-sata.yaml     | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/imx-sata.yaml b/Documentation/devicetree/bindings/ata/imx-sata.yaml
index 68ffb97ddc9b2..f4eb3550a0960 100644
--- a/Documentation/devicetree/bindings/ata/imx-sata.yaml
+++ b/Documentation/devicetree/bindings/ata/imx-sata.yaml
@@ -19,6 +19,7 @@ properties:
       - fsl,imx53-ahci
       - fsl,imx6q-ahci
       - fsl,imx6qp-ahci
+      - fsl,imx8qm-ahci
 
   reg:
     maxItems: 1
@@ -27,12 +28,14 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 2
     items:
       - description: sata clock
       - description: sata reference clock
       - description: ahb clock
 
   clock-names:
+    minItems: 2
     items:
       - const: sata
       - const: sata_ref
@@ -58,6 +61,25 @@ properties:
     $ref: /schemas/types.yaml#/definitions/flag
     description: if present, disable spread-spectrum clocking on the SATA link.
 
+  phys:
+    items:
+      - description: phandle to SATA PHY.
+          Since "REXT" pin is only present for first lane of i.MX8QM PHY, it's
+          calibration result will be stored, passed through second lane, and
+          shared with all three lanes PHY. The first two lanes PHY are used as
+          calibration PHYs, although only the third lane PHY is used by SATA.
+      - description: phandle to the first lane PHY of i.MX8QM.
+      - description: phandle to the second lane PHY of i.MX8QM.
+
+  phy-names:
+    items:
+      - const: sata-phy
+      - const: cali-phy0
+      - const: cali-phy1
+
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -65,6 +87,31 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx53-ahci
+              - fsl,imx6q-ahci
+              - fsl,imx6qp-ahci
+    then:
+      properties:
+        clock-names:
+          minItems: 3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qm-ahci
+    then:
+      properties:
+        clock-names:
+          minItems: 2
+
 additionalProperties: false
 
 examples:
-- 
2.37.1


