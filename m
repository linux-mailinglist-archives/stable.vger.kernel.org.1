Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E49772C12E
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbjFLK5N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbjFLK4r (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:56:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936265592
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:44:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27CB1615B7
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F19C433EF;
        Mon, 12 Jun 2023 10:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566671;
        bh=cRg3EsJtGoOLW9nKE4p8sMfe20F3hiea+VP5UZCi14s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RHXZ/J9RqEaOektaQbOUVJitHijfhGM+43Q4hCdszYtT0sRt5X/8xa+813Myv0zVk
         30P/PMvc2VHT2cOdM/C1XNmQAL83rak0MgKQYVY7HLUE6sHKLlMoqvIwqOcPecvvH1
         IpcrIYJl2M076UZQxEuFP8PAxiiM+sVkyxRz+c50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adam Ford <aford173@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 113/132] arm64: dts: imx8mn-beacon: Fix SPI CS pinmux
Date:   Mon, 12 Jun 2023 12:27:27 +0200
Message-ID: <20230612101715.443214884@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

[ Upstream commit 9bf2e534313fcf420367668cc1f30e10469901dc ]

The final production baseboard had a different chip select than
earlier prototype boards.  When the newer board was released,
the SPI stopped working because the wrong pin was used in the device
tree and conflicted with the UART RTS. Fix the pinmux for
production boards.

Fixes: 36ca3c8ccb53 ("arm64: dts: imx: Add Beacon i.MX8M Nano development kit")
Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
index 9e82069c941fa..5a1f7c30afe57 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
@@ -81,7 +81,7 @@ sound {
 &ecspi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_espi2>;
-	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
 	eeprom@0 {
@@ -202,7 +202,7 @@ pinctrl_espi2: espi2grp {
 			MX8MN_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
 			MX8MN_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
 			MX8MN_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
-			MX8MN_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x41
+			MX8MN_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x41
 		>;
 	};
 
-- 
2.39.2



