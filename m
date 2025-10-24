Return-Path: <stable+bounces-189239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EBAC06B18
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 16:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A23135AFE0
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 14:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE5B28489B;
	Fri, 24 Oct 2025 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zanders.be header.i=@zanders.be header.b="ef2wfPPe"
X-Original-To: stable@vger.kernel.org
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8683221FC7
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316067; cv=none; b=WpOngCFqsblJ+TexIobT6VaI7JfpiAmUvOqfPphb0YpQg9vTcCP3SH5dmcoy6V6EYgy5I8DWiS7xj7qS9Tc2pwtOImCbjN1PVXAsWylBClDqjJ8QT8jECToUTLO+aJ0fmRxCr9oVbm5Tb5DcZdrnL+aOSYMjzkH9vuAe1VINtdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316067; c=relaxed/simple;
	bh=yu44MeTCSGtBLP2wTFOlLQQ+OjwbkPqd16XX93JL7pE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QVnX20XJKBDl039j7i05VBRpg+bJ7HDXj95nKkY9foSJZjkhLEGuoa8hHsnCxapVt02zFnvnQdc5g7cDx10xUiTyztDqvdviKc9DW9oT+mCy7weK4OaTNUduYQdllTIM492IHJ1QvcV7YJj7As8IeQzIhEsBPJ4nsO4q56fO1+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zanders.be; spf=pass smtp.mailfrom=zanders.be; dkim=pass (2048-bit key) header.d=zanders.be header.i=@zanders.be header.b=ef2wfPPe; arc=none smtp.client-ip=94.124.121.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zanders.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zanders.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=zanders.be; s=202002;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=9jOpAJme9DuMAmtZlIRWeuJwP51wNjY5mc3K702Yvm4=;
	b=ef2wfPPe0x/vZCMzVbqoYMZ3YGbc8+qSj0ro1fh7vCLrw2Y1vwlII5SquYEZHsmveAPgiMJzrwLKq
	 msfzBRXCKNKVqrW2jJHW7TO4wn1glYLbp6MK+iH+Ak2orNOd6ycIKVWqAujuvx8UEunbaLaD0TTQPf
	 UOnZyR/cCPo4Xo5YQ2zRCHg6kCcgpNG9KV28kc+qYKk1XsRUDI4+cCCM6o5r0xhYCY5ImEwaEQLAEu
	 hItpJNfKanS5LgC3y4lfDENAG80GgpBkXZNTbXIdtTGdek9Ji/xFUNmg74kJz0JhnjxgPTuN3xrb9k
	 f68xpJkw/0hKPpxfIMDNj6rIyB98bsA==
X-MSG-ID: 95a6f307-b0e5-11f0-8e1f-00505681446f
From: Maarten Zanders <maarten@zanders.be>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	=?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: Maarten Zanders <maarten@zanders.be>,
	stable@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: nxp: imx6ul: correct SAI3 interrupt line
Date: Fri, 24 Oct 2025 16:21:06 +0200
Message-ID: <20251024142106.608225-1-maarten@zanders.be>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i.MX6UL reference manual lists two possible interrupt lines for
SAI3 (56 and 57, offset +32). The current device tree entry uses
the first one (24), which prevents IRQs from being handled properly.

Use the second interrupt line (25), which does allow interrupts
to work as expected.

Fixes: 36e2edf6ac07 ("ARM: dts: imx6ul: add sai support")
Signed-off-by: Maarten Zanders <maarten@zanders.be>
Cc: stable@vger.kernel.org
---
 arch/arm/boot/dts/nxp/imx/imx6ul.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
index 6de224dd2bb9..6eb80f867f50 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
@@ -339,7 +339,7 @@ sai3: sai@2030000 {
 					#sound-dai-cells = <0>;
 					compatible = "fsl,imx6ul-sai", "fsl,imx6sx-sai";
 					reg = <0x02030000 0x4000>;
-					interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6UL_CLK_SAI3_IPG>,
 						 <&clks IMX6UL_CLK_SAI3>,
 						 <&clks IMX6UL_CLK_DUMMY>, <&clks IMX6UL_CLK_DUMMY>;
-- 
2.51.0


