Return-Path: <stable+bounces-160402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C78FAFBCE1
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 22:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF1D1AA833B
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 20:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB24266581;
	Mon,  7 Jul 2025 20:53:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E33A264F81;
	Mon,  7 Jul 2025 20:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921603; cv=none; b=d+YJlnkcZKHPJmo9HeIMw6ntqVFM09bioojyoEXOJUqf4ZTsje/zfxRfay2OiY7LATeuR+JvUsn/D39x1Jg6OdP5y0c3LHAosE1AwJlXPtKPn/YJj+qU0vPSREAx8faw6j86CArwdcrDxH5UMmne4Jy84iAb+PmlfeQv7bncqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921603; c=relaxed/simple;
	bh=8vF7fm7k62PSnORc+G6az6hIqw/bf22dYMf1aYkkPbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oXNpshPvCRPW3WNYoL8OH+gPK8IC8IQE/qyK0qceP+5SH6RVypIXJMABv1Q32mxLyvPbjS3SORrp1XJEvNToqjqzXtJeGj+XubXuHWrMYdqFW/5dpRxyfZbsIDJ5MVSA5md1Z0Uly3V7m6AU+Wuv0o5oqooml+DfH7Fp6wPa2NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1uYsGv-008ZxD-VH;
	Mon, 07 Jul 2025 20:17:06 +0000
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
Subject: [PATCH 2/7] arm64: dts: imx8mp-venice-gw702x: Increase HS400 USDHC clock speed
Date: Mon,  7 Jul 2025 13:16:57 -0700
Message-Id: <20250707201702.2930066-2-tharvey@gateworks.com>
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
used on the various imx8mp-venice boards.

Fixes: 0d5b288c2110 ("arm64: dts: freescale: Add imx8mp-venice-gw7905-2x")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
index 10713c34ff39..cbf0c9a740fa 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
@@ -434,6 +434,8 @@ &usdhc3 {
 	pinctrl-0 = <&pinctrl_usdhc3>;
 	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
 	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
+	assigned-clock-rates = <400000000>;
 	bus-width = <8>;
 	non-removable;
 	status = "okay";
-- 
2.25.1


