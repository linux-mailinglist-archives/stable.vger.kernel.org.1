Return-Path: <stable+bounces-158170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22233AE5742
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B394E3406
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8265222581;
	Mon, 23 Jun 2025 22:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vRCV5C6e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7747B223DE5;
	Mon, 23 Jun 2025 22:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717656; cv=none; b=KhrP8CuMcNfFMVaOOQiM0A8TmcJ/tJdatVfwCwuwEMeDOit6saDF5x3lhdH7Zn8dbycvJ0EatvGaJmteqX1sPv3znw9i14XKHXPCymHCSjxfJusybybS4cayyEw3ee79vXrtVCABKGOZDtkKVE/dRqNIV3wiF1sd/B6Mn3nu7Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717656; c=relaxed/simple;
	bh=yd/ogOvrDv5aUqAg4afDkxWUjmpCzKfePPWj9xBkMho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3/O7KFFxm6NFvJGoOKjm5/UrGGLN7sP8tH8oqzmHlVdWgCfcynsGKLS2fodg5JUIOjiZyLbwuL/EZnv5Oh6ItMYNZHqvhozEQfDDEsRpftTSk3v13Ob2bWs3WLl4ByE8rZsh5dA4IBYWMYB4DtqAGVIHzjM6ZSviM9fzfCZX98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vRCV5C6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12400C4CEEA;
	Mon, 23 Jun 2025 22:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717656;
	bh=yd/ogOvrDv5aUqAg4afDkxWUjmpCzKfePPWj9xBkMho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vRCV5C6eN07cyQ0A4k6cWUWoPudotz7mkCwBB8f+Z2f92gGxwUCHYi+B/xK5KKX2i
	 n5GLP/vRCdHqJgYlEZ51RDphlgcMSNa7wPa705RuUH9uT19ZmQXZ3i/EYn/z5Y5a2V
	 32GpYJsHiQkO/+GDLgvYkeW3H/UCTTIh9v/IPViY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Akhil R <akhilrajeev@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andi Shyti <andi@smida.it>
Subject: [PATCH 6.1 492/508] dt-bindings: i2c: nvidia,tegra20-i2c: Specify the required properties
Date: Mon, 23 Jun 2025 15:08:57 +0200
Message-ID: <20250623130657.141796138@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akhil R <akhilrajeev@nvidia.com>

commit 903cc7096db22f889d48e2cee8840709ce04fdac upstream.

Specify the properties which are essential and which are not for the
Tegra I2C driver to function correctly. This was not added correctly when
the TXT binding was converted to yaml. All the existing DT nodes have
these properties already and hence this does not break the ABI.

dmas and dma-names which were specified as a must in the TXT binding
is now made optional since the driver can work in PIO mode if dmas are
missing.

Fixes: f10a9b722f80 ("dt-bindings: i2c: tegra: Convert to json-schema”)
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Cc: <stable@vger.kernel.org> # v5.17+
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Andi Shyti <andi@smida.it>
Link: https://lore.kernel.org/r/20250603153022.39434-1-akhilrajeev@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.yaml |   24 +++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

--- a/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.yaml
@@ -103,7 +103,10 @@ properties:
 
   resets:
     items:
-      - description: module reset
+      - description:
+          Module reset. This property is optional for controllers in Tegra194,
+          Tegra234 etc where an internal software reset is available as an
+          alternative.
 
   reset-names:
     items:
@@ -119,6 +122,13 @@ properties:
       - const: rx
       - const: tx
 
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
 allOf:
   - $ref: /schemas/i2c/i2c-controller.yaml
   - if:
@@ -172,6 +182,18 @@ allOf:
           items:
             - description: phandle to the VENC power domain
 
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - nvidia,tegra194-i2c
+    then:
+      required:
+        - resets
+        - reset-names
+
 unevaluatedProperties: false
 
 examples:



