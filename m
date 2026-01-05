Return-Path: <stable+bounces-204856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C2ECF4D78
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 17:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B09E230074BE
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 16:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5DE32C943;
	Mon,  5 Jan 2026 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEVnTES2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857433A9FD
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631727; cv=none; b=TiJRjoR2vpRaumAzr0Y15HsNMjKgqIImWhcjU8s2pe9s8PBVNntBTyPoZ+te/I9yjz/1BwaKiZar93IjkPBbziK9uU5pp6xLTF/pDQYUIRGscqEG+Rs5OOKef3dKDxanKy+Fa5O4+qLi53gATtylQJRbFXW7jLQlvAhYLsrhE3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631727; c=relaxed/simple;
	bh=QylOY5xMPASMCvOa2RvcMo3gMZroM9uB/QM2mNgwKHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDftc3LWuc8L+OvB+1JfXtqsDLb+pQ2PIH5KHpHSpocPKfM9WTj9BL2tMqPTNFmPyJjR7YKplTgo14BeI08OseyjIbnqhkAHzfuFxwdmmLqzCT6ecsAVqatgP/sN5wH9l3C18MqCvJAnKI4jskeanOOXcF/0Iep3Llvf1hh4Ll8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEVnTES2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD1DC116D0;
	Mon,  5 Jan 2026 16:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767631726;
	bh=QylOY5xMPASMCvOa2RvcMo3gMZroM9uB/QM2mNgwKHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nEVnTES2u1q0YSZ7x0NbrECbMxkawlwPpYEh0McQ2Qe3b1TZ1I6JGPPOWzN/dvhwK
	 OjjyNm9Fw/SHrcto2iYwqanzf3xmzokuhqP2n+9ohgSFf7yQbY8eS/rhDDNviZdLzA
	 5sstR8JV6k/qumrg+MIvDWFPSXe9EPLZyXqOEDKTXWu8Se43rOb8iwj4JodWl2TRxG
	 T69eTWbkjhojHx0HKC8mfwHN5MBCu/0hhlQwi5RN8m1t/2W1/9XTjCDr+QiLVKo3hd
	 Bu78mPiSGZkQLe58HgSX8ELLos9/6Wh4TXSlxV6AR3Z5vc4EP+WpJVM6zbG7zreL8V
	 ng20gqewyBvRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Yemike Abhilash Chandra <y-abhilashchandra@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] arm64: dts: ti: k3-j721e-sk: Fix pinmux for pin Y1 used by power regulator
Date: Mon,  5 Jan 2026 11:48:43 -0500
Message-ID: <20260105164843.2676258-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010552-unmoved-tipoff-f490@gregkh>
References: <2026010552-unmoved-tipoff-f490@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Siddharth Vadapalli <s-vadapalli@ti.com>

[ Upstream commit 51f89c488f2ecc020f82bfedd77482584ce8027a ]

The SoC pin Y1 is incorrectly defined in the WKUP Pinmux device-tree node
(pinctrl@4301c000) leading to the following silent failure:

    pinctrl-single 4301c000.pinctrl: mux offset out of range: 0x1dc (0x178)

According to the datasheet for the J721E SoC [0], the pin Y1 belongs to the
MAIN Pinmux device-tree node (pinctrl@11c000). This is confirmed by the
address of the pinmux register for it on page 142 of the datasheet which is
0x00011C1DC.

Hence fix it.

[0]: https://www.ti.com/lit/ds/symlink/tda4vm.pdf

Fixes: 97b67cc102dc ("arm64: dts: ti: k3-j721e-sk: Add DT nodes for power regulators")
Cc: stable@vger.kernel.org
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Link: https://patch.msgid.link/20251119160148.2752616-1-s-vadapalli@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index d06266610d5e..ac9914e81518 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -425,6 +425,12 @@ ekey_reset_pins_default: ekey-reset-pns-pins-default {
 			J721E_IOPAD(0x124, PIN_INPUT, 7) /* (Y24) PRG0_PRU1_GPO9.GPIO0_72 */
 		>;
 	};
+
+	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1dc, PIN_OUTPUT, 7) /* (Y1) SPI1_CLK.GPIO0_118 */
+		>;
+	};
 };
 
 &wkup_pmx0 {
@@ -480,12 +486,6 @@ J721E_WKUP_IOPAD(0xd4, PIN_OUTPUT, 7) /* (G26) WKUP_GPIO0_9 */
 		>;
 	};
 
-	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x1dc, PIN_OUTPUT, 7) /* (Y1) SPI1_CLK.GPIO0_118 */
-		>;
-	};
-
 	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0xf8, PIN_INPUT_PULLUP, 0) /* (J25) WKUP_I2C0_SCL */
-- 
2.51.0


