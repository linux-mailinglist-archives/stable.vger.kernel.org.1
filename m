Return-Path: <stable+bounces-160404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE46AFBCE6
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 22:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02DE13A70F2
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 20:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE482690C4;
	Mon,  7 Jul 2025 20:53:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FE4267F58;
	Mon,  7 Jul 2025 20:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921607; cv=none; b=CgG9C/muyfDXESSCvvCa0oEekM0jz4GQ2Bg0GMa3n7eH6l/53XQSmsdojt5Lma0GgoFkDWC6zuPYCGsnD0eaVq+QNLctRCeZBxr2q/zs1CBI0Nr5LVByLksowA4ZDWlHI6A4LlkIu0/fsLyCv5V073Kp6AtiDPJqtoo89nnZqo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921607; c=relaxed/simple;
	bh=okieobb1yWZlsIc8zi9zL8LYrpIFgedWp2nmr7y7sPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CN7wo0GKwABa+aerFnKUGce1y0sm+G1dO3NUbE0M+TXkbE0nHuY5Kjlhng4/flySINKHMh+/C+P/UmbnZu1+AmoaTV5lvqm29ncZhaa7JrkwBjasJ+ZNTz7Dr81EXbdYHR/rtnfsNZwDS4UCNcPd3mJ2TB7G6dluDYdQUXyR0WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1uYsGy-008ZxD-Sc;
	Mon, 07 Jul 2025 20:17:09 +0000
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
Subject: [PATCH 5/7] arm64: dts: imx8mn-venice-gw7902: Increase HS400 USDHC clock speed
Date: Mon,  7 Jul 2025 13:17:00 -0700
Message-Id: <20250707201702.2930066-5-tharvey@gateworks.com>
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
 arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
index 30c286b34aa5..a5f52f60169e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
@@ -693,6 +693,8 @@ &usdhc3 {
 	pinctrl-0 = <&pinctrl_usdhc3>;
 	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
 	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	assigned-clocks = <&clk IMX8MN_CLK_USDHC3>;
+	assigned-clock-rates = <400000000>;
 	bus-width = <8>;
 	non-removable;
 	status = "okay";
-- 
2.25.1


