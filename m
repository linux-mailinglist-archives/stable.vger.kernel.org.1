Return-Path: <stable+bounces-151475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB5BACE6E3
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 00:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F5E189618C
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 22:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8691822D781;
	Wed,  4 Jun 2025 22:56:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153991E1DEC;
	Wed,  4 Jun 2025 22:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749077798; cv=none; b=VLQwrIlSaTwR6N+9FusHg8R+0MZ+/fhkxo8Q7lx/LlsRXP4+zEh31QPbQvfR8QcUUENwiXtQVH+97T8J6HVTBEtUYaGTUeBpVqdx7QnDm0qTbW/RuOdCupwyR7WhlhSovOK+CGD0OxoZ9N/vdlgl5KNARn9AVTp/reOTOScH/Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749077798; c=relaxed/simple;
	bh=dvxz4ApKIXj+PRCSRR0Dhm/aThflAi0SL2f3734TWgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d4cDouFwgkpPdDHIjE94XpHDvryBY2MnU2cMly5qY3jEOtj30L4BV2zFM7g0/wBC+dSJawH0BLVbyeEes0whtBPnRYXbagegYIolPGFPy8WyymuaIkb6pcY1LCmBuXBdLcWXURoEvIhpOPGxFRzHD7EEILTcHosdTeJqTUFCaKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1uMx2B-007Xnu-CM;
	Wed, 04 Jun 2025 22:56:35 +0000
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
Subject: [PATCH v2 4/4] arm64: dts: imx8mp-venice-gw74xx: fix TPM SPI frequency
Date: Wed,  4 Jun 2025 15:56:30 -0700
Message-Id: <20250604225630.1430502-4-tharvey@gateworks.com>
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

Fixes: 531936b218d8 ("arm64: dts: imx8mp-venice-gw74xx: update to revB PCB")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2:
 - add cc to stable
 - add missing reference
---
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
index f00099f0cd4e..12de7cf1e853 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
@@ -201,7 +201,7 @@ &ecspi1 {
 	tpm@0 {
 		compatible = "atmel,attpm20p", "tcg,tpm_tis-spi";
 		reg = <0x0>;
-		spi-max-frequency = <36000000>;
+		spi-max-frequency = <25000000>;
 	};
 };
 
-- 
2.25.1


