Return-Path: <stable+bounces-160399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9D1AFBCD8
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 22:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5063E16FEB5
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 20:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2266F21FF53;
	Mon,  7 Jul 2025 20:53:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871B93597A;
	Mon,  7 Jul 2025 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921595; cv=none; b=gK+GqgL6AFszAuqlWu8NyN71D9yG51Tb6hQ4Jw6B8tysdeHhSFFEtugdSmm5+dUzCSDkdXUHTE0vMLUvndoi0wgdAyBpkgL+QdJB0oAmlmNVcktWZA5U+kGlT0ZC6tcj1hdr3K2NO3bGp8t5q31Ca7RN6hIB+k/6PDORpINg3tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921595; c=relaxed/simple;
	bh=mJMkveb2/cNKWBYAnuHOdf6Rm4p3JAFtb17gRdWcwU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AEOIC0skafjDe2pZ+Iej5ADuUWbLUcjqRSnwg9/okh19FtqzJIi+UC2Ycptlsp0rXeNuftyk8beNDAAekEi9GL1i7Y4V3WkZDBrVUarSKpGmCUcKQ3tlz+3oz7sN8XoQQ+7KElVTQCJvkaKroc+hyRu7KeOgA2656gbkZjHuGvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1uYsGw-008ZxD-UQ;
	Mon, 07 Jul 2025 20:17:07 +0000
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
Subject: [PATCH 3/7] arm64: dts: imx8mm-venice-gw7901: Increase HS400 USDHC clock speed
Date: Mon,  7 Jul 2025 13:16:58 -0700
Message-Id: <20250707201702.2930066-3-tharvey@gateworks.com>
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

Fixes: 2b1649a83afc ("arm64: dts: imx: Add i.mx8mm Gateworks gw7901 dts support")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
index d8b67e12f7d7..272c2b223d16 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
@@ -833,6 +833,8 @@ &usdhc3 {
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


