Return-Path: <stable+bounces-76167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 574C2979A29
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 05:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21973283441
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 03:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB0C17C8D;
	Mon, 16 Sep 2024 03:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="SwgVg0x1"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C3D512;
	Mon, 16 Sep 2024 03:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726458406; cv=none; b=BdkQxWlHTTnb+yNcYdv1+UXZpqhesLIaStaw8AE46vwzxBKdXVfL48swRvCFm2pwhA5IGWcVB2u1JfLiedek8NKFos+hZAbYY96L8z8yWNy8NrpZPOD4yaSeBgH/68ymBBDJKZaDglT5I9Iv9gVNErp1J5ZBoUCJXX8fHVUoe+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726458406; c=relaxed/simple;
	bh=VuAIVCJNSJoz/GC/v+9u7ba9qjXlmR/tvJHqlqR0Njg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rPG/kp469/6W+0LMh42kzUeTRylF0LxoDGtLuP+McQiN22K64+UM5zdSBbQPFnOqPxYgB+dKbEKiaqHIDB/KH2QE3Ikp9URM7Mv82F7jvtiCK7w1LSpBqdyL2UEvxZp/mkXEDncZa2aS7gBtQvDfjCS79epuCjFbmytQcqDlnsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SwgVg0x1; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726458372;
	bh=oS1UTktNh75XFPJPLOQ/Ru4zh7JkPk8tpfPT4RroVJo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=SwgVg0x1LW+TaZoguR/cWNhKzM8f5pJJinyG6M7pvv71TZNsSHFRTRcGmaBywjl+/
	 nxVobLiXTX4GPZhYkUk19CkTHqq3bX2SotBICqJ/KYAhtSjZvHDRuO/UtMDZXscjFL
	 a9SH5oberC05GzCxplD1s2MBnHM96NCeYwiUGIVA=
X-QQ-mid: bizesmtpip4t1726458367tzuj61x
X-QQ-Originating-IP: XyfFy0cPrBc6K6VxWKwtPQjgg4hHB8d4W0JC00QuX90=
Received: from avenger-OMEN-by-HP-Gaming-Lapto ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 16 Sep 2024 11:46:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14372591705973062368
From: WangYuli <wangyuli@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	william.qiu@starfivetech.com,
	emil.renner.berthing@canonical.com,
	conor.dooley@microchip.com,
	wangyuli@uniontech.com
Cc: kernel@esmil.dk,
	conor@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6 v3] riscv: dts: starfive: add assigned-clock* to limit frquency
Date: Mon, 16 Sep 2024 11:46:02 +0800
Message-ID: <247345579659D8F7+20240916034603.59120-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

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
2.43.0


