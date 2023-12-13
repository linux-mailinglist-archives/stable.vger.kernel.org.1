Return-Path: <stable+bounces-5785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2651D80D6E6
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E4D282215
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EB651C35;
	Mon, 11 Dec 2023 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gQ0oW3QH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6DEFBE0;
	Mon, 11 Dec 2023 18:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FAEC433C8;
	Mon, 11 Dec 2023 18:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319657;
	bh=U+EbMyU8OupsoElxnNQKzTqeUXwXD0+DeuXFA/qLFeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQ0oW3QHeCAK1mfq0nck1FNT21LhHXaLoQR0xnYaJHkeK+R9NT5lKktJYGvPOKUXS
	 /5B8QN5wYmbN9CrT4x1qlXFnkkAbXowRz2D7WJOtUZtZgxSf0/QzpZ8WzVwvcxsu4f
	 1HEgCue8CnHhmZdcFVStq+V7mvFD6+ztWew1pKeI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eugen Hristev <eugen.hristev@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH 6.6 187/244] arm64: dts: mediatek: mt8186: fix clock names for power domains
Date: Mon, 11 Dec 2023 19:21:20 +0100
Message-ID: <20231211182054.327099293@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
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

From: Eugen Hristev <eugen.hristev@collabora.com>

commit 9adf7580f6d498a5839e02fa1d1535e934364602 upstream.

Clocks for each power domain are split into big categories: pd clocks
and subsys clocks.
According to the binding, all clocks which have a dash '-' in their name
are treated as subsys clocks, and must be placed at the end of the list.
The other clocks which are pd clocks must come first.
Fixed the naming and the placing of all clocks in the power domains.
For the avoidance of doubt, prefixed all subsys clocks with the 'subsys'
prefix. The binding does not enforce strict clock names, the driver
uses them in bulk, only making a difference for pd clocks vs subsys clocks.

The above problem appears to be trivial, however, it leads to incorrect
power up and power down sequence of the power domains, because some
clocks will be mistakenly taken for subsys clocks and viceversa.
One consequence is the fact that if the DIS power domain goes power down
and power back up during the boot process, when it comes back up, there
are still transactions left on the bus which makes the display inoperable.

Some of the clocks for the DIS power domain were wrongly using '_' instead
of '-', which again made these clocks being treated as pd clocks instead of
subsys clocks.

Cc: stable@vger.kernel.org
Fixes: d9e43c1e7a38 ("arm64: dts: mt8186: Add power domains controller")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Link: https://lore.kernel.org/r/20231005103041.352478-1-eugen.hristev@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 42 +++++++++++++++---------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index f4c4f61c779d..df0c04f2ba1d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -924,7 +924,8 @@ power-domain@MT8186_POWER_DOMAIN_CSIRX_TOP {
 					reg = <MT8186_POWER_DOMAIN_CSIRX_TOP>;
 					clocks = <&topckgen CLK_TOP_SENINF>,
 						 <&topckgen CLK_TOP_SENINF1>;
-					clock-names = "csirx_top0", "csirx_top1";
+					clock-names = "subsys-csirx-top0",
+						      "subsys-csirx-top1";
 					#power-domain-cells = <0>;
 				};
 
@@ -942,7 +943,8 @@ power-domain@MT8186_POWER_DOMAIN_ADSP_AO {
 					reg = <MT8186_POWER_DOMAIN_ADSP_AO>;
 					clocks = <&topckgen CLK_TOP_AUDIODSP>,
 						 <&topckgen CLK_TOP_ADSP_BUS>;
-					clock-names = "audioadsp", "adsp_bus";
+					clock-names = "audioadsp",
+						      "subsys-adsp-bus";
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
@@ -975,8 +977,11 @@ power-domain@MT8186_POWER_DOMAIN_DIS {
 						 <&mmsys CLK_MM_SMI_COMMON>,
 						 <&mmsys CLK_MM_SMI_GALS>,
 						 <&mmsys CLK_MM_SMI_IOMMU>;
-					clock-names = "disp", "mdp", "smi_infra", "smi_common",
-						     "smi_gals", "smi_iommu";
+					clock-names = "disp", "mdp",
+						      "subsys-smi-infra",
+						      "subsys-smi-common",
+						      "subsys-smi-gals",
+						      "subsys-smi-iommu";
 					mediatek,infracfg = <&infracfg_ao>;
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -993,15 +998,17 @@ power-domain@MT8186_POWER_DOMAIN_VDEC {
 
 					power-domain@MT8186_POWER_DOMAIN_CAM {
 						reg = <MT8186_POWER_DOMAIN_CAM>;
-						clocks = <&topckgen CLK_TOP_CAM>,
-							 <&topckgen CLK_TOP_SENINF>,
+						clocks = <&topckgen CLK_TOP_SENINF>,
 							 <&topckgen CLK_TOP_SENINF1>,
 							 <&topckgen CLK_TOP_SENINF2>,
 							 <&topckgen CLK_TOP_SENINF3>,
+							 <&camsys CLK_CAM2MM_GALS>,
 							 <&topckgen CLK_TOP_CAMTM>,
-							 <&camsys CLK_CAM2MM_GALS>;
-						clock-names = "cam-top", "cam0", "cam1", "cam2",
-							     "cam3", "cam-tm", "gals";
+							 <&topckgen CLK_TOP_CAM>;
+						clock-names = "cam0", "cam1", "cam2",
+							      "cam3", "gals",
+							      "subsys-cam-tm",
+							      "subsys-cam-top";
 						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
@@ -1020,9 +1027,9 @@ power-domain@MT8186_POWER_DOMAIN_CAM_RAWA {
 
 					power-domain@MT8186_POWER_DOMAIN_IMG {
 						reg = <MT8186_POWER_DOMAIN_IMG>;
-						clocks = <&topckgen CLK_TOP_IMG1>,
-							 <&imgsys1 CLK_IMG1_GALS_IMG1>;
-						clock-names = "img-top", "gals";
+						clocks = <&imgsys1 CLK_IMG1_GALS_IMG1>,
+							 <&topckgen CLK_TOP_IMG1>;
+						clock-names = "gals", "subsys-img-top";
 						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
@@ -1041,8 +1048,11 @@ power-domain@MT8186_POWER_DOMAIN_IPE {
 							 <&ipesys CLK_IPE_LARB20>,
 							 <&ipesys CLK_IPE_SMI_SUBCOM>,
 							 <&ipesys CLK_IPE_GALS_IPE>;
-						clock-names = "ipe-top", "ipe-larb0", "ipe-larb1",
-							      "ipe-smi", "ipe-gals";
+						clock-names = "subsys-ipe-top",
+							      "subsys-ipe-larb0",
+							      "subsys-ipe-larb1",
+							      "subsys-ipe-smi",
+							      "subsys-ipe-gals";
 						mediatek,infracfg = <&infracfg_ao>;
 						#power-domain-cells = <0>;
 					};
@@ -1061,7 +1071,9 @@ power-domain@MT8186_POWER_DOMAIN_WPE {
 						clocks = <&topckgen CLK_TOP_WPE>,
 							 <&wpesys CLK_WPE_SMI_LARB8_CK_EN>,
 							 <&wpesys CLK_WPE_SMI_LARB8_PCLK_EN>;
-						clock-names = "wpe0", "larb-ck", "larb-pclk";
+						clock-names = "wpe0",
+							      "subsys-larb-ck",
+							      "subsys-larb-pclk";
 						mediatek,infracfg = <&infracfg_ao>;
 						#power-domain-cells = <0>;
 					};
-- 
2.43.0




