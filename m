Return-Path: <stable+bounces-85152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1E999E5E1
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3721C235B5
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCFB1D90DC;
	Tue, 15 Oct 2024 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zBGq087e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00101E7C34;
	Tue, 15 Oct 2024 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992149; cv=none; b=r34bFraqFMy5wXwuwLQ3t/pDRRFuqAdERH9wo7eoyvuZvB8YinnKD82zlYgEa6yR+VssUj3LrwPfCnwkEDPlpGZnTl1BM875sWARO4SQdPnY3t3pWoKAb7W8kwrgc2PEqjvNbbceYB9rgS9JJvPvdnE801zW79MTXPv//GF/HLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992149; c=relaxed/simple;
	bh=l684YYI9G9IFTvOsofNriu8yuh7au0UWcEhsc43nTtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hl4nBSjw85s7JZijOVXjthjtR7hbyCoIHKN3rg3I//MzAMx+hQ0cLTsf7nbWgUuzG2/hVDjrjw7vS6sAW6ZN3Tq1qRP9BfY7QNmkFwOh9MoCakRumWikghSmYCvHjf41vxrEl2+sYsV/305q/6bq+ujB2WWTunRLat71PKXgiqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zBGq087e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6306CC4CEC6;
	Tue, 15 Oct 2024 11:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728992148;
	bh=l684YYI9G9IFTvOsofNriu8yuh7au0UWcEhsc43nTtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zBGq087ebzUFE+3tvJycLbFksBPjzOZ5Le/MwxelAedwMad24XMrvQxhW+2JvtMop
	 aq0wOJME4+tJGfV1sOWOLbethPVvdYGVO17Xp5vSMSktgbos0lOM2Xsr4TN8LmZ9Ol
	 npYv955ogWmnTkpew8Sgd/t5dFm0+l12WMMX9M80=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 5.15 032/691] arm64: dts: rockchip: override BIOS_DISABLE signal via GPIO hog on RK3399 Puma
Date: Tue, 15 Oct 2024 13:19:40 +0200
Message-ID: <20241015112441.612249744@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quentin Schulz <quentin.schulz@cherry.de>

commit 741f5ba7ccba5d7ae796dd11c320e28045524771 upstream.

The Qseven BIOS_DISABLE signal on the RK3399-Q7 keeps the on-module eMMC
and SPI flash powered-down initially (in fact it keeps the reset signal
asserted). BIOS_DISABLE_OVERRIDE pin allows to override that signal so
that eMMC and SPI can be used regardless of the state of the signal.

Let's make this GPIO a hog so that it's reserved and locked in the
proper state.

At the same time, make sure the pin is reserved for the hog and cannot
be requested by another node.

Cc: stable@vger.kernel.org
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Link: https://lore.kernel.org/r/20240731-puma-emmc-6-v1-2-4e28eadf32d0@cherry.de
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -108,6 +108,22 @@
 	drive-impedance-ohm = <33>;
 };
 
+&gpio3 {
+	/*
+	 * The Qseven BIOS_DISABLE signal on the RK3399-Q7 keeps the on-module
+	 * eMMC and SPI flash powered-down initially (in fact it keeps the
+	 * reset signal asserted). BIOS_DISABLE_OVERRIDE pin allows to override
+	 * that signal so that eMMC and SPI can be used regardless of the state
+	 * of the signal.
+	 */
+	bios-disable-override-hog {
+		gpios = <RK_PD5 GPIO_ACTIVE_LOW>;
+		gpio-hog;
+		line-name = "bios_disable_override";
+		output-high;
+	};
+};
+
 &gmac {
 	assigned-clocks = <&cru SCLK_RMII_SRC>;
 	assigned-clock-parents = <&clkin_gmac>;
@@ -397,9 +413,14 @@
 
 &pinctrl {
 	pinctrl-names = "default";
-	pinctrl-0 = <&q7_thermal_pin>;
+	pinctrl-0 = <&q7_thermal_pin &bios_disable_override_hog_pin>;
 
 	gpios {
+		bios_disable_override_hog_pin: bios-disable-override-hog-pin {
+			rockchip,pins =
+				<3 RK_PD5 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
 		q7_thermal_pin: q7-thermal-pin {
 			rockchip,pins =
 				<0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;



