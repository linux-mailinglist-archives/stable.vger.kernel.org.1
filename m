Return-Path: <stable+bounces-73975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FAA97101F
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 09:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047A41F22CD1
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 07:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8522F1B12F9;
	Mon,  9 Sep 2024 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="YATu8KTc"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2343B17557C;
	Mon,  9 Sep 2024 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868030; cv=none; b=IUJOrnoye3sAXLFQcPCecZkvfQe6mV2tx1BbnPPNTAdNW8fe2V1R2Ix3yeMkJDFkEHUVDhKbe/HX3kB45yT0Q4yYl5bG764sZac/4+XV95ex+Y95H8AXZXfEUBt1YEdG5Dwc2MvpyuRCgGhRWJakyCwxhOJmHKj+jMVGC+6Kz4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868030; c=relaxed/simple;
	bh=cvqm85HxZws8m0ffPbvyp+Zw+eEM2Dc4RD3F3vWaoqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YwSvdnNAjeJTbKyfZqH8YoUsiTCbT0OSoSlYwOPXLWkqGOSpxKAzPOd2maWpPJyYbvSRDh4P4oI9kfpqIfwHvQmSx6fbR97JTzk76nsT5lMuxvXNO8E9bBAqF7nFijCkQ22Oe/Ks7atN8k25Gzy7EoSfLLKX+/cFx44PCGV+7DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=YATu8KTc; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1725868016;
	bh=prMGJ3mMUTIxkfIlbBVGa2TBtFoTvRzNWFckIJQYeCI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=YATu8KTcxIIFSwGCvlSFrVs4Bkf3b2J3mn22Z4kzm64Vdt85bIuMI23qSCbXDQfZP
	 enIC9007YDTdtXxdIfM8ooNg0INpE6gVVT6UksXkqmzjQAmN9lM8hbwLSMao3PHtSf
	 U8O7uV+I4fZ5tC/xB3r/jTppovKgnVh4OBv2ZCW4=
X-QQ-mid: bizesmtpsz13t1725868011tpw342
X-QQ-Originating-IP: NHWKxukEJ5SZHvLWpkrfTWlhEG3Mlt8ERQZDBoe249Q=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 09 Sep 2024 15:46:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17961958660430279513
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
Subject: [PATCH 6.6 1/4] riscv: dts: starfive: add assigned-clock* to limit frquency
Date: Mon,  9 Sep 2024 15:46:27 +0800
Message-ID: <D200DC520B462771+20240909074645.1161554-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

From: William Qiu <william.qiu@starfivetech.com>

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


