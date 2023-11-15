Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77EF7ECEC5
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbjKOToo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjKOTon (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A5A19E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF2AC433C7;
        Wed, 15 Nov 2023 19:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077476;
        bh=i9GewvoW1bDcvY8g09BAx0k8oYRenRCNefKAL2DA/pM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CUe+f/yWYP+1CTZKuabmTOwfYJZTQMOncai7y701Calfj36HFcppuSM7ds6bfFKQH
         CHfipuwyP2o++FW3AZCAYsUQeSIUs1Ft0f+QiMoEScU5tb69wgo8+2ZIexAPscjR+y
         oT7Lq9HO98LApqSrWNruwm2wNfYXdm2p48+uhWX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Brad Griffis <bgriffis@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 319/603] arm64: tegra: Fix P3767 QSPI speed
Date:   Wed, 15 Nov 2023 14:14:24 -0500
Message-ID: <20231115191635.572736910@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 99dd648038ecb..fe08e131b7b9e 100644
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



