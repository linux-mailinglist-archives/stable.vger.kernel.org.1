Return-Path: <stable+bounces-155723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ADFAE436F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D219A3BF11A
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3C724DCFD;
	Mon, 23 Jun 2025 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="rO6nA/SF"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3DD248191;
	Mon, 23 Jun 2025 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685172; cv=none; b=WxB6x7rcQiWeCozLuesKT6LUmiKaQaZiYV1nPXMAxiV4Kg1esc4NQvv5c0xB98RpugRy1FneL8fcijPZz5I8rNnqhaDMEWFWrwdAefDGYrjd+3mZ9ClBF2XxYRNBZhy5tVfup6Gko1lQo9s0kjy9fOU63lZ5HDF4UDkBZRpjlNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685172; c=relaxed/simple;
	bh=cpmV6b+GhiiDRqvRjUyDnp4tw6x/y7Th+CAWM/jTP8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KotG/OWlxhpgood89odaEnK9PesWjPrPFEiVMO79/OXYJpJ25bd6a1yAKmMmaVcFMeVK1ERhTa+fIRGtq4BFZp9N9ExSXXy4WpqoMoQl3nDEY/CwNdJNNUfbGIJDJKf9fMmz/DgGsR+irrOpQTyxdgl/HbR0bjNoRTbFgPBsmTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=rO6nA/SF; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 84BC71FC30;
	Mon, 23 Jun 2025 15:26:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1750685166;
	bh=u+uFiP/cQeKkOTD6fc5wQMcjMGmy3Mcby1TgFOYHp5E=; h=From:To:Subject;
	b=rO6nA/SFi386mqqis4g2A7h4UbC+DOwyyYEhBIcZUrQOvduPGB9q1ake9SCkiUGjA
	 3bQ24qb0BVQvS+6SSdF3N6W/rEn4QIOqiBdqJuXqgRtKlT5JX0myKtimX81ukmm4JW
	 LNiyRuPf2m8P0hSKfxEtV2SzX5GNcbDmmgAZVy+L+uymG0eVrIMipRzt0Z9HhwtVHL
	 ev1m1+6TfyAY5aECOULVChITLLIDtPPt5EwXpqp7lf1hFktPiJNdyB8zNojZU7G1cO
	 UKN/qF7vYSaHJoXlmmPYh1H450pJizr0Ytha2iNgRxV790/uKAVXY53Kn+EeKNHTK5
	 IK2gCsyu13BQQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] arm64: dts: freescale: imx8mm-verdin: Keep LDO5 always on
Date: Mon, 23 Jun 2025 15:25:45 +0200
Message-Id: <20250623132545.111619-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

LDO5 regulator is used to power the i.MX8MM NVCC_SD2 I/O supply, that is
used for the SD2 card interface and also for some GPIOs.

When the SD card interface is not enabled the regulator subsystem could
turn off this supply, since it is not used anywhere else, however this
will also remove the power to some other GPIOs, for example one I/O that
is used to power the ethernet phy, leading to a non working ethernet
interface.

[   31.820515] On-module +V3.3_1.8_SD (LDO5): disabling
[   31.821761] PMIC_USDHC_VSELECT: disabling
[   32.764949] fec 30be0000.ethernet end0: Link is Down

Fix this keeping the LDO5 supply always on.

Cc: stable@vger.kernel.org
Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for verdin imx8m mini")
Fixes: f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index d29710772569..1594ce9182a5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -464,6 +464,7 @@ reg_vdd_phy: LDO4 {
 			};
 
 			reg_nvcc_sd: LDO5 {
+				regulator-always-on;
 				regulator-max-microvolt = <3300000>;
 				regulator-min-microvolt = <1800000>;
 				regulator-name = "On-module +V3.3_1.8_SD (LDO5)";
-- 
2.39.5


