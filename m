Return-Path: <stable+bounces-200442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA929CAF504
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 09:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87F3B302D28A
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 08:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3AE29C325;
	Tue,  9 Dec 2025 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="tsOl2uc9"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0213826A0DD;
	Tue,  9 Dec 2025 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765269706; cv=none; b=JHNVvLxjVbBDsyIz/MrUddwyMRGgvjQa50xCdSVqX78iJQYSCgjvwYeaCkMykZn0lE0v7WTJ1pEP9zkBtPbWvsBvdqWe03xh/yfjCHeQHUfyOsJgUl9c9L0mPgF7wDWqSHjGRCUIueYkL5r0eXf4vI3Kd1FEPTbOHRd/XhkWxJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765269706; c=relaxed/simple;
	bh=WedzksBl0cQPgpTL2cdr7phBhYXwQE6EId6jPl+bGaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PMUe8HkzmJOHbQ8KaKLYXB7/MLryLwCkR0oFXmtYDlLZFO66spXsW4XZSXJ7i4DRee2FPRdVup2xIVAOxj6v41Zqo0jSBDIOunqwF5EEmy04ajcPNdFGTO+iQEw70oWxoDYvFo5Z2Rf2TYDldxSGIrQ6piF6rzp5eATiWSlwXEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=tsOl2uc9; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from localhost.localdomain (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id 8C1191FD35;
	Tue,  9 Dec 2025 09:41:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1765269694;
	bh=1VHTUXl3gc+91mo15pIRbZ3NIRKVtsGczrD/Bl81o6k=; h=From:To:Subject;
	b=tsOl2uc9wCitwZsMNcL9p38pZW303QuaAHYLlQ8kCvOi7+sDaKM5czd9qH1GoqGeX
	 nr0QqhB4E6lCrxxzV767GRSL6iUnGPedZOzoipX+Qt/5xzSz1fcFQP6nBHHbWJjDho
	 iFMoPA6taDB4O9ye1dON//V7eaXDUJuzzJWiA3H3A1uMVLhUSAIWeRmkkFId5WUoHA
	 wNrr5QZ14e4CT8wDCKOg25rqt97EyO5LT2l2TuMfsDlEYwxy7GxYRJXFaLDUz02rPp
	 A8NGeI/xj7MRI99pF2m70kXvvMe/oPIDvGXiP/Y2KAUMek8JLvX0JFMJd4m0YAiMC7
	 rKuZJh5lqTg5g==
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] arm64: dts: ti: am62p-verdin: Fix SD regulator startup delay
Date: Tue,  9 Dec 2025 09:41:25 +0100
Message-ID: <20251209084126.33282-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

The power switch used to power the SD card interface might have
more than 2ms turn-on time, increase the startup delay to 20ms to
prevent failures.

Fixes: 87f95ea316ac ("arm64: dts: ti: Add Toradex Verdin AM62P")
Cc: stable@vger.kernel.org
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
index 5e050cbb9eaf..ec9dd931fe92 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
@@ -112,7 +112,7 @@ reg_sd1_vmmc: regulator-sdhci1-vmmc {
 		regulator-max-microvolt = <3300000>;
 		regulator-min-microvolt = <3300000>;
 		regulator-name = "+V3.3_SD";
-		startup-delay-us = <2000>;
+		startup-delay-us = <20000>;
 	};
 
 	reg_sd1_vqmmc: regulator-sdhci1-vqmmc {
-- 
2.47.3


