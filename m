Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAC679F19D
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 21:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjIMTDm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 15:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjIMTDj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 15:03:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4069B1986
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 12:03:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6238FC433C8;
        Wed, 13 Sep 2023 19:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694631814;
        bh=r0Jy7D2COUUaYmmGKNITcMPHMAkvD+FR28DryogRnIo=;
        h=Subject:To:Cc:From:Date:From;
        b=YYygd6tYaqg5ze6viUipaAiWXVeHm6cv7U+V5QslxVUybHSVHHVPXSRvvh2w41Uev
         QFs0XAru+z8SLrxt3urnbAQPe0aH0v8eE1bniDn7H0rHM5LT+s1MHa8h1uyf2IUZrL
         AV2WydTd/5FlIFCXFeDszunK0QE0uxkjH1nkBRlo=
Subject: FAILED: patch "[PATCH] arm64: tegra: Update AHUB clock parent and rate" failed to apply to 5.10-stable tree
To:     spujar@nvidia.com, treding@nvidia.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 13 Sep 2023 21:03:20 +0200
Message-ID: <2023091319-garter-composite-636c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x dc6d5d85ed3a3fe566314f388bce4c71a26b1677
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091319-garter-composite-636c@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

dc6d5d85ed3a ("arm64: tegra: Update AHUB clock parent and rate")
2838cfddbc1c ("arm64: tegra: Bump #address-cells and #size-cells")
132b552cba15 ("arm64: tegra: Fix up compatible string for SDMMC1 on Tegra234")
b2fbcbe1ae19 ("arm64: tegra: Use correct compatible string for Tegra234 HDA")
7f0ea5acfc19 ("arm64: tegra: Use correct compatible string for Tegra194 HDA")
47a2f35d9ea7 ("arm64: tegra: Fix non-prefetchable aperture of PCIe C3 controller")
6f380a4ec04f ("arm64: tegra: Separate AON pinmux from main pinmux on Tegra194")
794b834d4cd3 ("arm64: tegra: Add ECAM aperture info for all the PCIe controllers")
8fbd2d118917 ("arm64: tegra: Enable GTE nodes")
78159542034f ("arm64: tegra: Sort nodes by unit-address")
d71b893a119d ("arm64: tegra: Add Tegra234 SDMMC1 device tree node")
1bbba854bc40 ("arm64: tegra: Add SBSA UART for Tegra234")
7a2c613bdbd8 ("arm64: tegra: Add PWM fan for Jetson AGX Orin")
2566d28c4097 ("arm64: tegra: Populate Tegra234 PWMs")
04491207d2d1 ("arm64: tegra: Remove unused property for I2C")
248400656b1c ("arm64: tegra: Fix Prefetchable aperture ranges of Tegra234 PCIe controllers")
68c31ad01105 ("arm64: tegra: Add NVDEC on Tegra234")
e25770feb6d6 ("arm64: tegra: Fix ranges for host1x nodes")
8aec2c17b95e ("arm64: tegra: Enable MGBE on Jetson AGX Orin Developer Kit")
610cdf3186bc ("arm64: tegra: Add MGBE nodes on Tegra234")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dc6d5d85ed3a3fe566314f388bce4c71a26b1677 Mon Sep 17 00:00:00 2001
From: Sameer Pujar <spujar@nvidia.com>
Date: Thu, 29 Jun 2023 10:42:17 +0530
Subject: [PATCH] arm64: tegra: Update AHUB clock parent and rate

I2S data sanity test failures are seen at lower AHUB clock rates
on Tegra234. The Tegra194 uses the same clock relationship for AHUB
and it is likely that similar issues would be seen. Thus update the
AHUB clock parent and rates here as well for Tegra194, Tegra186
and Tegra210.

Fixes: 177208f7b06d ("arm64: tegra: Add DT binding for AHUB components")
Cc: stable@vger.kernel.org
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 7e4c496fd91c..2b3bb5d0af17 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -135,7 +135,8 @@ tegra_ahub: ahub@2900800 {
 			clocks = <&bpmp TEGRA186_CLK_AHUB>;
 			clock-names = "ahub";
 			assigned-clocks = <&bpmp TEGRA186_CLK_AHUB>;
-			assigned-clock-parents = <&bpmp TEGRA186_CLK_PLL_A_OUT0>;
+			assigned-clock-parents = <&bpmp TEGRA186_CLK_PLLP_OUT0>;
+			assigned-clock-rates = <81600000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x02900800 0x02900800 0x11800>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 154fc8c0eb6d..33f92b77cd9d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -231,7 +231,8 @@ tegra_ahub: ahub@2900800 {
 				clocks = <&bpmp TEGRA194_CLK_AHUB>;
 				clock-names = "ahub";
 				assigned-clocks = <&bpmp TEGRA194_CLK_AHUB>;
-				assigned-clock-parents = <&bpmp TEGRA194_CLK_PLLA_OUT0>;
+				assigned-clock-parents = <&bpmp TEGRA194_CLK_PLLP_OUT0>;
+				assigned-clock-rates = <81600000>;
 				status = "disabled";
 
 				#address-cells = <2>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 617583ff2736..e7b4e3013964 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1386,7 +1386,8 @@ tegra_ahub: ahub@702d0800 {
 			clocks = <&tegra_car TEGRA210_CLK_D_AUDIO>;
 			clock-names = "ahub";
 			assigned-clocks = <&tegra_car TEGRA210_CLK_D_AUDIO>;
-			assigned-clock-parents = <&tegra_car TEGRA210_CLK_PLL_A_OUT0>;
+			assigned-clock-parents = <&tegra_car TEGRA210_CLK_PLL_P>;
+			assigned-clock-rates = <81600000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x702d0000 0x702d0000 0x0000e400>;

