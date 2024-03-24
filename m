Return-Path: <stable+bounces-31214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8039F889434
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 08:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F127B2BB9F
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 07:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11A3209309;
	Mon, 25 Mar 2024 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFGNyECk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F08839F4;
	Sun, 24 Mar 2024 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320615; cv=none; b=uip22V2ST9Syer/OwXLEqrdDbJ88Y7FoEO4NDMSQg2rMYW+D0ZrYftfmIUtRP+EaNiTib00HMVgxHk36/NafEMYJpopZoH/guUHh8HIF70GS+SgnyNnN5LSE996f4OCI59XVZuZ5BtNnh/8NNybm9cLQNzoRoNdd77lZlpo4xkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320615; c=relaxed/simple;
	bh=5jaLuzVu03LfcgTNCeqDwZBUUHqQVrNeybRDDhk2+Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccg085dFVXmplQQwIF4arnqXp1tmarLAgG/BvodOSeV9TxPAKDMHSa5nfzkcXiG9+RwHnLw5E+HndtLYNd+22MGwhCcp5rMbGWSxC++UWERvrrqAGmSqUNtPuBXWqOIY2yQOlsdOHep442TlwcPfT9mV18xpHFfug7DJ2np/2Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFGNyECk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD4EC433A6;
	Sun, 24 Mar 2024 22:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320614;
	bh=5jaLuzVu03LfcgTNCeqDwZBUUHqQVrNeybRDDhk2+Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PFGNyECkU6NIXS2EjoQ5dQAY49VepYYwqJMJUYX3toXqNUSuq4UEhyAVIJxhZzGiz
	 icraJZyYaCiWtLS8j6Wk0QwnKp+4E07O5ubwWsFiAN6eA9E1VHn14eUyZ1ksmd4ipv
	 GkHL/IdHrqo+QwWubpQEa3g/6NPIVPV1EmKfieN0Jg3h19TovTx8+BcylyrtM9Tlb+
	 ZQpcapJwVgi9ebWBK+9QzUy6nQmeqrhSn/nfJTBTlVsILn081aN2ZCYy1twxvc2wj4
	 t3aTRIdddgjmvPPWmN3Qxak/r+5L30BCH3wgcz3kGGn/+ghEzy9Jdc/vJoBQk55Bn7
	 KiEKl8mR5wlXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 175/713] arm64: dts: imx8mm-kontron: Disable pullups for I2C signals on SL/BL i.MX8MM
Date: Sun, 24 Mar 2024 18:38:21 -0400
Message-ID: <20240324224720.1345309-176-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Frieder Schrempf <frieder.schrempf@kontron.de>

[ Upstream commit f19e5bb91d53264d7dac5d845a4825afadf72440 ]

There are external pullup resistors on the board and due to silicon
errata ERR050080 let's disable the internal ones to prevent any
unwanted behavior in case they wear out.

Fixes: 8668d8b2e67f ("arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts  | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
index dcec57c20399e..5fd2e45258b11 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
@@ -279,8 +279,8 @@ MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19
 
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
-			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x400001c3
+			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x40000083
+			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x40000083
 		>;
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
index 1f8326613ee9e..2076148e08627 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
@@ -237,8 +237,8 @@ MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x19
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x400001c3
-			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c3
+			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x40000083
+			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x40000083
 		>;
 	};
 
-- 
2.43.0


