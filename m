Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6110B7ECC3B
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjKOT1f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjKOT1c (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:27:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC2D1A3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:27:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1285CC433C8;
        Wed, 15 Nov 2023 19:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076449;
        bh=jf4G5SclBGX5ToFvzM6IjabetLrIeyZWjA3IhRKjsSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LR5I/GnGDWbWS6WziX+bwMl2aQoUsLEZ4gUiVt6mjWyL5IMdQ7dCacVpndNERhSMG
         MIKqh+RjOBDEEU66x8LrpnVoPhFw6tgisQeY5llQrmTBPWmPAhhcv+bFURqifNf0AA
         fVL+jZXOrDEtAr7RDMGrU/zEhATB1TtL4DZXt6VU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Brad Griffis <bgriffis@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 295/550] arm64: tegra: Fix P3767 QSPI speed
Date:   Wed, 15 Nov 2023 14:14:39 -0500
Message-ID: <20231115191621.266036773@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brad Griffis <bgriffis@nvidia.com>

[ Upstream commit 57ea99ba176913c325fc8324a24a1b5e8a6cf520 ]

The QSPI device used on Jetson Orin NX and Nano modules (p3767) is
the same as Jetson AGX Orin (p3701) and should have a maximum speed of
102 MHz.

Fixes: 13b0aca303e9 ("arm64: tegra: Support Jetson Orin NX")
Signed-off-by: Brad Griffis <bgriffis@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/nvidia/tegra234-p3767.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3767.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3767.dtsi
index 2ea102b3a7f40..2e0fb61a1167f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3767.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3767.dtsi
@@ -28,7 +28,7 @@ spi@3270000 {
 			flash@0 {
 				compatible = "jedec,spi-nor";
 				reg = <0>;
-				spi-max-frequency = <136000000>;
+				spi-max-frequency = <102000000>;
 				spi-tx-bus-width = <4>;
 				spi-rx-bus-width = <4>;
 			};
-- 
2.42.0



