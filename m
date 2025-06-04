Return-Path: <stable+bounces-151476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 899AFACE6E5
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 00:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8E2172900
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 22:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977D6233155;
	Wed,  4 Jun 2025 22:56:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153471DD9AD;
	Wed,  4 Jun 2025 22:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749077800; cv=none; b=rZ6A1ywb43KdErlNunups5H5n1asE3txMT5TDIQj/wcz5WdLpgD83Ls0RhG5JxzoD/wNY1vVfQO4PXTrhT9Gq3wmYZ1aK8sdIeKkJBSgoph1N1xdDCSvjnLYqGA3sm+JzcdRjfY36cBCjVu9mRuZilhfFzZejJDk3fZzR+YDYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749077800; c=relaxed/simple;
	bh=ZHlgGgUqVKbA1IEcDNtc3T5KZlXhrj4WQoznUCuYpig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hrXh6AV+WUCp7zkxQqwJKcIb96M+7Y6xW1rFcGqHLH847c3J+FoifVX0D15EaTHCrljgvF7cmlvPBdCK0L7OiT58NLwESpd/NssAMcXrmFuZtodPk0Bqt43DP0F7T4Q1d3Dcb97gqoit++yYyROPUe3QP/9csCA3i7AyeIg7dQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1uMx2A-007Xnu-Cx;
	Wed, 04 Jun 2025 22:56:34 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: imx@lists.linux.dev,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	stable@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 3/4] arm64: dts: imx8mp-venice-gw73xx: fix TPM SPI frequency
Date: Wed,  4 Jun 2025 15:56:29 -0700
Message-Id: <20250604225630.1430502-3-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250604225630.1430502-1-tharvey@gateworks.com>
References: <20250604225630.1430502-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IMX8MPDS Table 37 [1] shows that the max SPI master read frequency
depends on the pins the interface is muxed behind with ECSPI2
muxed behind ECSPI2 supporting up to 25MHz.

Adjust the spi-max-frequency based on these findings.

[1] https://www.nxp.com/webapp/Download?colCode=IMX8MPIEC

Fixes: 2b3ab9d81ab4 ("arm64: dts: imx8mp-venice-gw73xx: add TPM device")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2: add cc to stable
---
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi
index e2b5e7ac3e46..5eb114d2360a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi
@@ -122,7 +122,7 @@ &ecspi2 {
 	tpm@1 {
 		compatible = "atmel,attpm20p", "tcg,tpm_tis-spi";
 		reg = <0x1>;
-		spi-max-frequency = <36000000>;
+		spi-max-frequency = <25000000>;
 	};
 };
 
-- 
2.25.1


