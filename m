Return-Path: <stable+bounces-88042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B7D9AE5DD
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 15:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B641F25117
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 13:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615611DF980;
	Thu, 24 Oct 2024 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="uVfTJ5M5"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DEE1D6DA1;
	Thu, 24 Oct 2024 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775809; cv=none; b=aHCRFSjG5u++WCA3a3ul6Hcn9B0EFLNjS+gL2zet7GX/36LckFzq8qqN5Bnn6T5Iuxstpql/C9jlH07/VpGKtQxzvmv9TMvolHc6iEHgOy0ZgPZGmUxtaOeRZ1xgv7rkEtg2f1/g0ae/KXRrZB8zLiT77VcHx7KX6zAAZ7X1zX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775809; c=relaxed/simple;
	bh=yOU2ORDuPvI9kenldTX2S+yYgb6tjdxsj0kzn3lV6KA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f8GFGYTm94hMZMvG5OJD3m5G21gdyHSjXyh+zw8liHOw1yZRiERIeB8WlKe6VQa9qKoKG4sPrFAbI25+pWCs4NZVThuM28ykVZF+6s26Z9bGRiK9gvJ3KGuBRkMf1kIPlnF0/GPQ8OV7RSVd7fLdBiY2lqC+HskQS/xT4b3LXak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=uVfTJ5M5; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 8B61E1F8C9;
	Thu, 24 Oct 2024 15:06:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1729775196;
	bh=+EvwIl0i2dXYv6BLBgJPCfDIwpV2bZuK0eg1elGHAZ8=; h=From:To:Subject;
	b=uVfTJ5M5yT9Yv80i2dKk8hEu6wlnSTFJ0PYJDkquaGC6izPRnR77NPBch7AUr2vbG
	 ELEzHhA20Qo/li95Ca7hp3gBxrH/TQgZJrKP1W5TuKRygGfUpm6MMOL2+Rds2RQspL
	 sCEdrOY/uu/KsCeH91cUVoxR0bKxunh5kEWDd3EF1vjNlZD4cW2xhtyhYe8q3gBs8Y
	 wjV9zucSpYcFSe7+nnoAZ1+wJOwOh6g1qMAtxKYv0wfJfUZSbZz1A7VvHM9d9y3OCU
	 U8Nu4v+mVJtda56jtA1z/uVeKIz+NfYhobyjnw48Va8B0MquvDavO6dGnVtJbej7WK
	 Gt0y/Cu6I2pCQ==
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
Subject: [PATCH v1] arm64: dts: ti: k3-am62-verdin: Fix SD regulator startup delay
Date: Thu, 24 Oct 2024 15:06:28 +0200
Message-Id: <20241024130628.49650-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
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

Fixes: 316b80246b16 ("arm64: dts: ti: add verdin am62")
Cc: <stable@vger.kernel.org>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 5bef31b8577b..f0eac05f7483 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -160,7 +160,7 @@ reg_sdhc1_vmmc: regulator-sdhci1 {
 		regulator-max-microvolt = <3300000>;
 		regulator-min-microvolt = <3300000>;
 		regulator-name = "+V3.3_SD";
-		startup-delay-us = <2000>;
+		startup-delay-us = <20000>;
 	};
 
 	reg_sdhc1_vqmmc: regulator-sdhci1-vqmmc {
-- 
2.39.5


