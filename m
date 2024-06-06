Return-Path: <stable+bounces-49707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6D28FEE82
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3260B1C2526E
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBEA1C5388;
	Thu,  6 Jun 2024 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FUfdJrTH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4861991D0;
	Thu,  6 Jun 2024 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683669; cv=none; b=gGHq5SzYPojmHDp6m5JUoXm4rWdIbqjT1RESDeA4TrHf/Gb0zyz8P0QXMviQKzOxZLqjdd1JmlYjdOjDbNvakIzJPZSExSf2Y1ZbMt7TS1OlYCdvxnvCjvTAhQfcRXuCBSzc9Ul6sLEuwP4baSLKcMzjPRQc78dvt7OXcP/3EQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683669; c=relaxed/simple;
	bh=C8bPFIdnHZouphxm54x6QpqfXldRUWYWyblCYxuG+BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2NpFCllpdNGQnVCUDxLXiEAOqIwRd0UTEz3xz5T/MVUAM3ExxAV6AUZQjYKILdjMJCLC6IiQdXGSuoi/gnsjrtfvcyxgKSxcpXTOJ8o+cioOw9traKWfy1Vu54pTqQY98KYVV1//trq1nLntnZ/3OHEjreDvfvWYWyOX/JtGWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FUfdJrTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7D3C2BD10;
	Thu,  6 Jun 2024 14:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683669;
	bh=C8bPFIdnHZouphxm54x6QpqfXldRUWYWyblCYxuG+BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FUfdJrTH2Xul1INZ4XWvxwRQstsMisY05cBozjneX4grplQhcScvwkB3KIUMKDtPm
	 QAslz+CEtYr+nPts7NGl3mWcJGAMs84tB9wkdd3A8NtTs7RCK31OxAjZ5T8x4gIULG
	 AhEUHMoYGER1hl6RNOaRGTZg8EM7uS3NceY3Majs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rob Herring <robh@kernel.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 557/744] dt-bindings: adc: axi-adc: update bindings for backend framework
Date: Thu,  6 Jun 2024 16:03:49 +0200
Message-ID: <20240606131750.324373908@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nuno Sa <nuno.sa@analog.com>

[ Upstream commit a032b921bdeba2274866daafc8e791edd609eb13 ]

'adi,adc-dev' is now deprecated and must not be used anymore. Hence,
also remove it from being required.

The reason why it's being deprecated is because the axi-adc CORE is now
an IIO service provider hardware (IIO backends) for consumers to make use
of. Before, the logic with 'adi,adc-dev' was the opposite (it was kind
of consumer referencing other nodes/devices) and that proved to be wrong
and to not scale.

Now, IIO consumers of this hardware are expected to reference it using the
io-backends property. Hence, the new '#io-backend-cells' is being added
so the device is easily identified as a provider.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20240210-iio-backend-v11-2-f5242a5fb42a@analog.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 19fb11d7220b ("dt-bindings: adc: axi-adc: add clocks property")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml          | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index 9996dd93f84b2..3d49d21ad33df 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -39,12 +39,15 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
       A reference to a the actual ADC to which this FPGA ADC interfaces to.
+    deprecated: true
+
+  '#io-backend-cells':
+    const: 0
 
 required:
   - compatible
   - dmas
   - reg
-  - adi,adc-dev
 
 additionalProperties: false
 
@@ -55,7 +58,6 @@ examples:
         reg = <0x44a00000 0x10000>;
         dmas = <&rx_dma 0>;
         dma-names = "rx";
-
-        adi,adc-dev = <&spi_adc>;
+        #io-backend-cells = <0>;
     };
 ...
-- 
2.43.0




