Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBB779F19A
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 21:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjIMTDP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 15:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjIMTDP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 15:03:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EB5170F
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 12:03:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78069C433CA;
        Wed, 13 Sep 2023 19:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694631791;
        bh=sxBVPVoJTKj+oZS1cdRHD1gP7nJVJCQTPGZiedIBe+k=;
        h=Subject:To:Cc:From:Date:From;
        b=wu4mP5ecTPsg5xEjxSR+jSXkn/Nruyx1O8A4JkmPkX/9s8M5MnvBWdQ/0n/pfeEfz
         A2DxxacAE3eOmbhfX82SBEmlDSNUxOQqKPDkEvfZc/Zy6e0MrZhFDDjBvnwDLbFgDd
         gIvMy9P1iHqH+9RlDSZUVHC20q35w/abr1Ojjr3s=
Subject: FAILED: patch "[PATCH] arm64: tegra: Update AHUB clock parent and rate on Tegra234" failed to apply to 6.1-stable tree
To:     sheetal@nvidia.com, mkumard@nvidia.com, spujar@nvidia.com,
        treding@nvidia.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 13 Sep 2023 21:03:03 +0200
Message-ID: <2023091303-gossip-dork-5e54@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e483fe34adab3197558b7284044c1b26f5ede20e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091303-gossip-dork-5e54@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

e483fe34adab ("arm64: tegra: Update AHUB clock parent and rate on Tegra234")
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

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e483fe34adab3197558b7284044c1b26f5ede20e Mon Sep 17 00:00:00 2001
From: Sheetal <sheetal@nvidia.com>
Date: Thu, 29 Jun 2023 10:42:16 +0530
Subject: [PATCH] arm64: tegra: Update AHUB clock parent and rate on Tegra234

I2S data sanity tests fail beyond a bit clock frequency of 6.144MHz.
This happens because the AHUB clock rate is too low and it shows
9.83MHz on boot.

The maximum rate of PLLA_OUT0 is 49.152MHz and is used to serve I/O
clocks. It is recommended that AHUB clock operates higher than this.
Thus fix this by using PLLP_OUT0 as parent clock for AHUB instead of
PLLA_OUT0 and fix the rate to 81.6MHz.

Fixes: dc94a94daa39 ("arm64: tegra: Add audio devices on Tegra234")
Cc: stable@vger.kernel.org
Signed-off-by: Sheetal <sheetal@nvidia.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index f4974e81dd4b..0f12a8debd8a 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -180,7 +180,8 @@ tegra_ahub: ahub@2900800 {
 				clocks = <&bpmp TEGRA234_CLK_AHUB>;
 				clock-names = "ahub";
 				assigned-clocks = <&bpmp TEGRA234_CLK_AHUB>;
-				assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLA_OUT0>;
+				assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLP_OUT0>;
+				assigned-clock-rates = <81600000>;
 				status = "disabled";
 
 				#address-cells = <2>;

