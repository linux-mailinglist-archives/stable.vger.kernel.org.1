Return-Path: <stable+bounces-46175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C8B8CEFB6
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 17:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46234281750
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 15:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED56763511;
	Sat, 25 May 2024 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eG5MEmDj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE47D4EB51
	for <stable@vger.kernel.org>; Sat, 25 May 2024 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716649839; cv=none; b=q8k6jxvsRP9bQEdx393IOaRbsnMhCIwqvQPMMhSWrn+QHIO6VjfAy1vMctZ3augkdj82EYdVUxLWs0qypT9inxLEC46LU20e1IyI0Dobi7QaGIbian4WNAhCuE7/UA/6BXwv/crekvP+AxADku1DRInPpxx6gEgYoIQAgRZob6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716649839; c=relaxed/simple;
	bh=lBZDgxMyLk6EAS5ZGODs74pXyYGwVsK/nXOuV9pAEOA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ihnHhI1smHlOpBwJFmIIzJW5Vmj/TRKR1RtKdlsM3ZJwg8cz2TR66WE6+xTc1q38MelwEMz+ZoO10AOXc8R36yEVgd+FEyFzDqkK6jmJZLzPMiyXFuhVJUnR4NBALYLcwk00j4Dky6OPin4Fo1YzKCXY+WgSHA6b1eZWwIAvUaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eG5MEmDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36356C3277B;
	Sat, 25 May 2024 15:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716649839;
	bh=lBZDgxMyLk6EAS5ZGODs74pXyYGwVsK/nXOuV9pAEOA=;
	h=Subject:To:Cc:From:Date:From;
	b=eG5MEmDjvkHk1TyLmuQGfyVRai8u5wI8tD+v8h9QiSisn55l8qYgWPFlUpTiKeXDI
	 OEVS161Mu2/NFkY+8KKkCE3jBMLNbYohUUB1LNx2pGYwxiWQzg5D9ggZ5iaLrzx1f9
	 eh2yrNsl0RgK61DO4TQ4hE5GoEN23XS9U9z5Ay3I=
Subject: FAILED: patch "[PATCH] dt-bindings: adc: axi-adc: add clocks property" failed to apply to 5.10-stable tree
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,Stable@ver.kernel.org,krzysztof.kozlowski@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 25 May 2024 17:10:22 +0200
Message-ID: <2024052522-mud-contempt-f78d@gregkh>
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
git cherry-pick -x 19fb11d7220b8abc016aa254dc7e6d9f2d49b178
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024052522-mud-contempt-f78d@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 19fb11d7220b8abc016aa254dc7e6d9f2d49b178 Mon Sep 17 00:00:00 2001
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 26 Apr 2024 17:42:12 +0200
Subject: [PATCH] dt-bindings: adc: axi-adc: add clocks property

Add a required clock property as we can't access the device registers if
the AXI bus clock is not properly enabled.

Note this clock is a very fundamental one that is typically enabled
pretty early during boot. Independently of that, we should really rely on
it to be enabled.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Fixes: 96553a44e96d ("dt-bindings: iio: adc: add bindings doc for AXI ADC driver")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20240426-ad9467-new-features-v2-3-6361fc3ba1cc@analog.com
Cc: <Stable@ver.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index 3d49d21ad33d..e1f450b80db2 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -28,6 +28,9 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
   dmas:
     maxItems: 1
 
@@ -48,6 +51,7 @@ required:
   - compatible
   - dmas
   - reg
+  - clocks
 
 additionalProperties: false
 
@@ -58,6 +62,7 @@ examples:
         reg = <0x44a00000 0x10000>;
         dmas = <&rx_dma 0>;
         dma-names = "rx";
+        clocks = <&axi_clk>;
         #io-backend-cells = <0>;
     };
 ...


