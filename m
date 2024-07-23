Return-Path: <stable+bounces-60794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DAF93A2D4
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 16:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F4D9B23CA7
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B951015251C;
	Tue, 23 Jul 2024 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="Wo7UBGfY"
X-Original-To: stable@vger.kernel.org
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E718414C59A;
	Tue, 23 Jul 2024 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745250; cv=none; b=ffB4KrJGi4Oo20wDLu+mWmu7l7xKPJmpo5kLpPJSZ4iZK2rN7zmVwYCSSLdzpDrl+W73FAG7aKnhVRll9Q0adVALbUtbsrrSuK2lgoLWNCmB/df1WnPq8EkUc1coc18nECUKQ7TAF1xtWxgBw2AC+QuYrv8QFlQOVgFwnpbFL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745250; c=relaxed/simple;
	bh=75GRhItwcVfF6+PhFRKfBxniuEzzQfAL1uhTyz+xRns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JlGFCrGXA0/qC3jlEAwbzzl7j6yidVrYW5cXRFd5nn4JphuhroljGC6L7M1lmj3SRM2E2nIfLvkC0XxhrPWeNAwf3pVtaPx5/b6YPVYukhJsBnD804xkIIkEEaiO9wypFH6PCiN0yncZo+NTuy0XROFFZtqADg8zm3MV5MrGVTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=Wo7UBGfY; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1721744728;
	bh=OX/Gd4MFPxCKqZe87BS/KG6ALl+pygGDpsu0MExr26A=;
	h=From:To:Cc:Subject:Date:From;
	b=Wo7UBGfYVfcctO8yVTMcaBzr6ULCBOn7rlO/BKrEUiicXaSuU1Xvx7LE5X82Iz0a6
	 yYX3VZXjpeGUUldnYVcZ6QHhtzfex6eL35/fFV1+5n1KeB56/y/bHEE2ZUPz22QAQ8
	 0qoHBPPERxC8d65Y/Y+hatPIlW1C7RqRWn4d3f8o=
Received: from vokac-nb.ysoft.local (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id 4AD59A0454;
	Tue, 23 Jul 2024 16:25:28 +0200 (CEST)
From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
	stable@vger.kernel.org
Subject: [PATCH] ARM: dts: imx6dl-yapp43: Increase LED current to match the yapp4 HW design
Date: Tue, 23 Jul 2024 16:25:19 +0200
Message-ID: <20240723142519.134083-1-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On the imx6dl-yapp4 revision based boards, the RGB LED is not driven
directly by the LP5562 driver but through FET transistors. Hence the LED
current is not determined by the driver but by the LED series resistors.

On the imx6dl-yapp43 revision based boards, we removed the FET transistors
to drive the LED directly from the LP5562 but forgot to tune the output
current to match the previous HW design.

Set the LED current on imx6dl-yapp43 based boards to the same values
measured on the imx6dl-yapp4 boards and limit the maximum current to 20mA.

Fixes: 7da4734751e0 ("ARM: dts: imx6dl-yapp43: Add support for new HW revision of the IOTA board")
Cc: <stable@vger.kernel.org>
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-yapp43-common.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp43-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp43-common.dtsi
index 8cfb553a4db3..208356c7d355 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp43-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp43-common.dtsi
@@ -274,24 +274,24 @@ leds: led-controller@30 {
 
 		led@0 {
 			chan-name = "R";
-			led-cur = /bits/ 8 <0x20>;
-			max-cur = /bits/ 8 <0x60>;
+			led-cur = /bits/ 8 <0x6e>;
+			max-cur = /bits/ 8 <0xc8>;
 			reg = <0>;
 			color = <LED_COLOR_ID_RED>;
 		};
 
 		led@1 {
 			chan-name = "G";
-			led-cur = /bits/ 8 <0x20>;
-			max-cur = /bits/ 8 <0x60>;
+			led-cur = /bits/ 8 <0xbe>;
+			max-cur = /bits/ 8 <0xc8>;
 			reg = <1>;
 			color = <LED_COLOR_ID_GREEN>;
 		};
 
 		led@2 {
 			chan-name = "B";
-			led-cur = /bits/ 8 <0x20>;
-			max-cur = /bits/ 8 <0x60>;
+			led-cur = /bits/ 8 <0xbe>;
+			max-cur = /bits/ 8 <0xc8>;
 			reg = <2>;
 			color = <LED_COLOR_ID_BLUE>;
 		};
-- 
2.43.0


