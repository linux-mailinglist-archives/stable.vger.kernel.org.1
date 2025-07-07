Return-Path: <stable+bounces-160403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A14AAFBCE4
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 22:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7703B1F98
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 20:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662B4267B12;
	Mon,  7 Jul 2025 20:53:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40712676C2;
	Mon,  7 Jul 2025 20:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921605; cv=none; b=t4nSJpctOkwhk1vSkoEqyAYFe1SIFIgFsBu5oN3QGdU3KIkTzp/5rJv2rGRPAGPifx5fw54hlAlFWfIqR610F3zDoSvorZmuWhSZvR9elvMFpL5L/f43JE32zRjmQ+x+JrkJ72WZUTIrjoir7BFsKWcv413uFgZL75ZzwqPrIZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921605; c=relaxed/simple;
	bh=AhPu55hIj7vvFlbU0Y9Fthcl1WLiShaBnsH5ivBZzoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IfhTvT7TB6v4HUTlW6KR77t8TKUhMROnDbroS51tOQ3V2eXuwocFKQg5khaCWGPdBGyZ5CN+ecThTXiSONBspmkcp2tSVHcw6O7qSIHNmB6nMBCZsSJGGaLThqU5Bflu1c0irqP3Bx+VrS7gEFbo7a8s28LpWbRKGayvzassew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1uYsGz-008ZxD-Re;
	Mon, 07 Jul 2025 20:17:10 +0000
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
Subject: [PATCH 6/7] arm64: dts: imx8mm-venice-gw7903: Increase HS400 USDHC clock speed
Date: Mon,  7 Jul 2025 13:17:01 -0700
Message-Id: <20250707201702.2930066-6-tharvey@gateworks.com>
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

Fixes: a72ba91e5bc7 ("arm64: dts: imx: Add i.mx8mm Gateworks gw7903 dts support")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
index c0aadff4e25b..636daa3d6ca2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
@@ -621,6 +621,8 @@ &usdhc3 {
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


