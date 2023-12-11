Return-Path: <stable+bounces-5720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2919980D61B
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6CBC1F21ACA
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C485FC06;
	Mon, 11 Dec 2023 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MOjLWN2r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4F7C2D0;
	Mon, 11 Dec 2023 18:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DBEC433C8;
	Mon, 11 Dec 2023 18:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319484;
	bh=nfasymoxfCW6RrpChNUozkvwpcgxg+3wKy70VqxCZA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MOjLWN2rb3Jp7dj7zmXSltgpddNObdACoJvv7iSMAJe2fxi3t/K2AmxQ21F9RRFTX
	 Uti91XNQLGGtXb9mV3I0WiiD7yGcQhncR/XpTmtC3sGJMZxzF1kamKMSkanJwXu+EB
	 oOzWZGDDYdrJuwP8oZ6KNwt6RN2pHd1rWtDVRgD4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 123/244] arm64: dts: imx8-apalis: set wifi regulator to always-on
Date: Mon, 11 Dec 2023 19:20:16 +0100
Message-ID: <20231211182051.334032122@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

[ Upstream commit 04179605ab604dba32571a05cd06423afc9eca19 ]

Make sure that the wifi regulator is always on. The wifi driver itself
puts the wifi module into suspend mode. If we cut the power the driver
will crash when resuming from suspend.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Fixes: ad0de4ceb706 ("arm64: dts: freescale: add initial apalis imx8 aka quadmax module support")
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
index 9b1b522517f8e..0878a15acc1ba 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
@@ -82,12 +82,9 @@
 		pinctrl-0 = <&pinctrl_wifi_pdn>;
 		gpio = <&lsio_gpio1 28 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		regulator-always-on;
 		regulator-name = "wifi_pwrdn_fake_regulator";
 		regulator-settling-time-us = <100>;
-
-		regulator-state-mem {
-			regulator-off-in-suspend;
-		};
 	};
 
 	reg_pcie_switch: regulator-pcie-switch {
-- 
2.42.0




