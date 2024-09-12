Return-Path: <stable+bounces-75928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C106B975F53
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 04:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA8D1F22810
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 02:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10AB7DA9C;
	Thu, 12 Sep 2024 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="IPSSpRXK"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76583A268;
	Thu, 12 Sep 2024 02:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109765; cv=none; b=Zry+3k6nRLemBQ9UjjXsH/WV5DWWR9RoBPCl3/bt/p+04r4cYZ51mBICgLzk0MoIeF5EfaGFMce+Sh8fHH7fRMr65DskytheI7uUCqOxmZOdhgokWqAg9X+6bxYub0H3UlcAENR/VwHSd7473j63E6W9gN685+2UjUReVcJWU4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109765; c=relaxed/simple;
	bh=utyDe5eZCMdGV6R5hhAx0NCl89O3xZZBOa2ynVuR1cE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bSZuvU1Fs0PwBJubk5YzxGQVRGxYXReNIopjccp0+F9s3Cm9TR1nwLhH59eSxj42WKlPITX+y8WgvDl9H0/WPPkav+AWlun4L6f8NwWzrq2S+SCFlKLZgD6La2E8LgB1G4LTaA+3q0ZDciXGHtbVAyd1VPeotTCGcHq6c/ERFlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IPSSpRXK; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726109751;
	bh=ItiN5nFTSra7Vr5po2FBwHrIsvZx+V/Mwk2BLpZP71Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=IPSSpRXKpXuUP0u5I9OBP5qiysimWY/wdjY1N4oRebsFUMoiDvPE+c1Lr+EzOFGS4
	 +RziF8RuB9n+oNEr5EezsC6hldM6HcCnOUNE9fwg7sC13DUfXRqlyN2kpzQog7za6J
	 9W89W1lHP8sHtDoDZ+hRQH9eR7el0MA0Kmr3G/7M=
X-QQ-mid: bizesmtp81t1726109745ti5gwwm0
X-QQ-Originating-IP: Q9VlWd8TNoXtY9lblvywY1Ehy7N3aYevzbIayxgrJRM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Sep 2024 10:55:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7041621352797983170
From: WangYuli <wangyuli@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	william.qiu@starfivetech.com,
	emil.renner.berthing@canonical.com,
	conor.dooley@microchip.com,
	wangyuli@uniontech.com,
	xingyu.wu@starfivetech.com,
	walker.chen@starfivetech.com,
	robh@kernel.org,
	hal.feng@starfivetech.com
Cc: kernel@esmil.dk,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	richardcochran@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH 6.6 v2 1/4] riscv: dts: starfive: add assigned-clock* to limit frquency
Date: Thu, 12 Sep 2024 10:55:05 +0800
Message-ID: <3A31C289BC240955+20240912025539.1928223-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

From: William Qiu <william.qiu@starfivetech.com>

[ Upstream commit af571133f7ae028ec9b5fdab78f483af13bf28d3 ]

In JH7110 SoC, we need to go by-pass mode, so we need add the
assigned-clock* properties to limit clock frquency.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 .../riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 062b97c6e7df..4874e3bb42ab 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -204,6 +204,8 @@ &i2c6 {
 
 &mmc0 {
 	max-frequency = <100000000>;
+	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
+	assigned-clock-rates = <50000000>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
 	mmc-ddr-1_8v;
@@ -220,6 +222,8 @@ &mmc0 {
 
 &mmc1 {
 	max-frequency = <100000000>;
+	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
+	assigned-clock-rates = <50000000>;
 	bus-width = <4>;
 	no-sdio;
 	no-mmc;
-- 
2.43.4


