Return-Path: <stable+bounces-151745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAD9AD0C41
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 11:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23D3188EFCA
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 09:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902702046B3;
	Sat,  7 Jun 2025 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yd9e4N9N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17187184F
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749289117; cv=none; b=Jgb0FrX7YVBB1MbGds7kYRTYtVnMLYYdNbcFauLRvCu4qNnNfGNHUF4KVdsQleq+9DU4HnLIXubzuIjNBt94626OgUwfgvpTVCnk4feck71Z03KFarfDzV7J2DHmlvR0jm6tq6pBt9vD0hMZkfa/wRx3yCfSwyiJCNkog1KNnWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749289117; c=relaxed/simple;
	bh=Klfc/06OVgMYY3i0sye3+4oNhQdnQBS1dNCX/PoUxps=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M13BXjrKwfG+rrNWD6ZsBlmJ1/yyno8YzXlkPyWVxtX2MKIYBmC1Cbjb01yp913OoJPOwUQTjfhoVX5EBt6NyB+QX26R6JxKyIuEbSfPSYWnG7ap29tJ0I69UAs8ITuEkAQ6R9jRRHVtEB914917iMZn5AFpEEFhURIvsUqLhwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yd9e4N9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCDFC4CEE4;
	Sat,  7 Jun 2025 09:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749289116;
	bh=Klfc/06OVgMYY3i0sye3+4oNhQdnQBS1dNCX/PoUxps=;
	h=Subject:To:Cc:From:Date:From;
	b=yd9e4N9N/Q/Y6ZlPF7ve/qRrVplp5R87IGjt1xnnNW1UOrmGVRDVy8TJFXyQYE6Y7
	 /14m8P/YxSCKRGl/MjQOOIXMlUNQhgEyeW3PwnuOx6dBYWKG+BGXkPEmOuYQ+3nsEH
	 NgUzO9yB3GZ/3DbYxQ9i4rt0OMfgk3CuLbzVHJcA=
Subject: FAILED: patch "[PATCH] dt-bindings: pwm: adi,axi-pwmgen: Fix clocks" failed to apply to 6.12-stable tree
To: dlechner@baylibre.com,krzysztof.kozlowski@linaro.org,ukleinek@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 07 Jun 2025 11:38:34 +0200
Message-ID: <2025060734-elated-juvenile-da5c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e683131e64f71e957ca77743cb3d313646157329
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025060734-elated-juvenile-da5c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e683131e64f71e957ca77743cb3d313646157329 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 29 May 2025 11:53:19 -0500
Subject: [PATCH] dt-bindings: pwm: adi,axi-pwmgen: Fix clocks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a shortcoming in the bindings that doesn't allow for a separate
external clock.

The AXI PWMGEN IP block has a compile option ASYNC_CLK_EN that allows
the use of an external clock for the PWM output separate from the AXI
clock that runs the peripheral.

This was missed in the original bindings and so users were writing dts
files where the one and only clock specified would be the external
clock, if there was one, incorrectly missing the separate AXI clock.

The correct bindings are that the AXI clock is always required and the
external clock is optional (must be given only when HDL compile option
ASYNC_CLK_EN=1).

Fixes: 1edf2c2a2841 ("dt-bindings: pwm: Add AXI PWM generator")
Cc: stable@vger.kernel.org
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250529-pwm-axi-pwmgen-add-external-clock-v3-2-5d8809a7da91@baylibre.com
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>

diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
index 45e112d0efb4..5575c58357d6 100644
--- a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
+++ b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
@@ -30,11 +30,19 @@ properties:
     const: 3
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: axi
+      - const: ext
 
 required:
   - reg
   - clocks
+  - clock-names
 
 unevaluatedProperties: false
 
@@ -43,6 +51,7 @@ examples:
     pwm@44b00000 {
         compatible = "adi,axi-pwmgen-2.00.a";
         reg = <0x44b00000 0x1000>;
-        clocks = <&spi_clk>;
+        clocks = <&fpga_clk>, <&spi_clk>;
+        clock-names = "axi", "ext";
         #pwm-cells = <3>;
     };


