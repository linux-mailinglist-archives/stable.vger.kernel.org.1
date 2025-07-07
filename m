Return-Path: <stable+bounces-160400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B7EAFBCDB
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 22:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8103A56F6
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 20:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B155222FF2E;
	Mon,  7 Jul 2025 20:53:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29492224B12;
	Mon,  7 Jul 2025 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921598; cv=none; b=VKcZtTARV9J3+zSzGPHchhmeV8h8NZJBx8xj880PnHW8UJ+EHvUCTaI+2yaH1TYEYFTUsZBPiRcaWzJldVP/tsk/5rv+rluxWGc3SqkcB9Kz2xzUJkbZ0Z51hoNgnzMMzNAurWyUvk/8tLUobbOOB0xHERBAX+jRfAsSqSKwM4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921598; c=relaxed/simple;
	bh=pxcNxU2q3DYnjRVs7cAG42rFk5bj6Pl/hOFsTqtjDio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CQsbNhifSNnhEmKx4g0geMyuEBRVul5wRDJPBSsyin4EHa/oHXmiYVJrzlSOBQl+ayQPBjez67BbZwZZANQM9eG7ACTn7x8Pcwsg3nPKumG+yfGkHabJRBwgRYP9c4gAx+aaAeR6rzN1UP90nI8QSigI8+z6t6QWUCGImRdlHqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1uYsGx-008ZxD-TF;
	Mon, 07 Jul 2025 20:17:08 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 4/7] arm64: dts: imx8mm-venice-gw7902: Increase HS400 USDHC clock speed
Date: Mon,  7 Jul 2025 13:16:59 -0700
Message-Id: <20250707201702.2930066-4-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250707201702.2930066-1-tharvey@gateworks.com>
References: <20250707201702.2930066-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IMX8M reference manuals indicate in the USDHC Clock generator section
that the clock rate for DDR is 1/2 the input clock therefore HS400 rates
clocked at 200Mhz require a 400Mhz SDHC clock.

This showed about a 1.5x improvement in read performance for the eMMC's
used on the various imx8m{m,n,p}-venice boards.

Fixes: ef484dfcf6f7 ("arm64: dts: imx: Add i.mx8mm/imx8mn Gateworks gw7902 dts support")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
index 46d1ee0a4ee8..c09b40fc6dec 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
@@ -743,6 +743,8 @@ &usdhc3 {
 	pinctrl-0 = <&pinctrl_usdhc3>;
 	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
 	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	assigned-clocks = <&clk IMX8MM_CLK_USDHC3>;
+	assigned-clock-rates = <400000000>;
 	bus-width = <8>;
 	non-removable;
 	status = "okay";
-- 
2.25.1


