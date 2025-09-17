Return-Path: <stable+bounces-179832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F20B7C880
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5410E580C73
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 11:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68EC3728A3;
	Wed, 17 Sep 2025 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2wjnyTc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E7E371E83
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110269; cv=none; b=M93HveFipwYzUcwzWayJlF1r/81Lm2zemOglrNx1xqy3mpKYJ+LCyoQOaPh4KdkfMs3BVjLXa268wnE2r1pboJbrwtoA/J4d4HsIqApxdO7yUixE6CajCL6cmNRjQKBv2ryF6k6y8eQOZoprh0xP9YTRKeQ3rOmw39m7ifQ0EEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110269; c=relaxed/simple;
	bh=Vl2YtEdIMi6cNAhh8vL6qXidRyXiJCWsjCjLptnUIdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuY9ukn6cdUG5N48xiL+Rl9k8FHhouqGzJvbvBaInkGN00pPvlkdYy5PSLaqxW+nd54Tm5UbmlCbeVImXGkf13pw4GFUfZx9kKJYC5OJsVuy4s+gjkJ+vYgWq1pb94IIE5+3r+e67fK6cBzcUTIIoDxHUVWggEQNBk7/RkfSnss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2wjnyTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718CBC4CEF0;
	Wed, 17 Sep 2025 11:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758110269;
	bh=Vl2YtEdIMi6cNAhh8vL6qXidRyXiJCWsjCjLptnUIdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b2wjnyTc7YfPrCifhpbjzFC0d6ncGHPVh8RAOOy8BhGzaEHgJwyE4rawWPeLI4sRv
	 8c23u5VyjYOAuYaAuSDKoYWPNVkxxX5idPrpMAHdu3gpj3V4P5RD3m9mx90KES4PrH
	 Z3yZXRz1Qrv9/KtZXyYcYIP47nYQNe0M51PGFOzkZNV3A03O+bdPWkBulRl4NC3/yQ
	 amj5Gv3w8RvnlfrX99G/2TpzDx2hC6QOqpuEDGOIHyfWUP3K9rPumMHqeIjgQuAQ1V
	 RGGVpBLxjtLd010gOw4gPbTuIAP4pg/+E7/THpmWhY4JQeKwpWbhwcMJ4gdeJWzXmQ
	 Gwh31NoTZ10Zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 1/3] dt-bindings: serial: 8250: allow clock 'uartclk' and 'reg' for nxp,lpc1850-uart
Date: Wed, 17 Sep 2025 07:57:44 -0400
Message-ID: <20250917115746.482046-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091759-buddy-verdict-96be@gregkh>
References: <2025091759-buddy-verdict-96be@gregkh>
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
Stable-dep-of: 387d00028ccc ("dt-bindings: serial: 8250: move a constraint")
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


