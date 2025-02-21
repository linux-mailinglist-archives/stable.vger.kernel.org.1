Return-Path: <stable+bounces-118593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9887DA3F6BE
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 15:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433E63B4DC5
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 14:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697B220C48B;
	Fri, 21 Feb 2025 14:05:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D592515530C
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146711; cv=none; b=iA9rq46PTMBCpLZF5xJYLFcpjCbErjLe2nPSkjJhbl3z/XZVaTnvKqexNB8472UTkzL9xB84+T2IocC6bT+7L4qncuWciWINdVLtuMdMvrKzvm/KhKCWo4qZ28BpCz2MDGUGDZCDtZ2LD3RHUc6btHu4cqsOPTCnWgG3qswP8tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146711; c=relaxed/simple;
	bh=ud9Ewppi6nbTHhEJv90ldubIDs0VF8/bmpXcameaIzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MyHx84qXAmQoQEepfV/bC9oDUr9WAWhb/WR+pMlfoFCpPVYrJCewswki1tHxr0/LLW37b1n69wQrvR1r5TcWvZltTs8CwrBo28vWPBhuTdmDWRzIoAQb1tIr97yyyl3h8+4dOAfdvMHJOW6sOGlWxIGaXYP/2JyBcRpUiab+j9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YzsMd2NfgzTCq;
	Fri, 21 Feb 2025 15:05:01 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YzsMc4HR9zYHX;
	Fri, 21 Feb 2025 15:05:00 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 21 Feb 2025 15:04:34 +0100
Subject: [PATCH v2 2/5] arm64: dts: rockchip: fix pinmux of UART5 for PX30
 Ringneck on Haikou
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-ringneck-dtbos-v2-2-310c0b9a3909@cherry.de>
References: <20250221-ringneck-dtbos-v2-0-310c0b9a3909@cherry.de>
In-Reply-To: <20250221-ringneck-dtbos-v2-0-310c0b9a3909@cherry.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@cherry.de>

UART5 uses GPIO0_B5 as UART RTS but muxed in its GPIO function,
therefore UART5 must request this pin to be muxed in that function, so
let's do that.

Fixes: 5963d97aa780 ("arm64: dts: rockchip: add rs485 support on uart5 of px30-ringneck-haikou")
Cc: stable@vger.kernel.org
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index 2321536c553fed20bc02d91f40a5d5a6dc20892c..e9ebac0f4984a26ec288083f74c7e193cdbec326 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -194,6 +194,13 @@ sd_card_led_pin: sd-card-led-pin {
 			  <3 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	uart {
+		uart5_rts_pin: uart5-rts-pin {
+			rockchip,pins =
+			  <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &pwm0 {
@@ -227,7 +234,7 @@ &uart0 {
 };
 
 &uart5 {
-	pinctrl-0 = <&uart5_xfer>;
+	pinctrl-0 = <&uart5_xfer &uart5_rts_pin>;
 	rts-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };

-- 
2.48.1


