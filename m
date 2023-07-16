Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD168755593
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjGPUmV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjGPUmT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:42:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CBC9F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:42:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B863E60EBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34C1C433C7;
        Sun, 16 Jul 2023 20:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540138;
        bh=dCLzMXIe6DuOXech8x1D6cYxPoqyyaTBEAzn+XVtMLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/Blh7TspyVSZbqO+iLpuzy8DyxjvEQkukZEP1IZmiC41fJyU8uXtVWdl92I9NsVX
         A7nkNmqCVyd+BHrKKNIvSpmkELs3A6Zf5X75TtmiAYeSt2+bxJwZHKgQeSB8lgEaFD
         4ITQj67z7sSffDHT2YU4yLiMVsQVg2j8/D9X07Zc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 229/591] ARM: dts: stm32: Fix audio routing on STM32MP15xx DHCOM PDK2
Date:   Sun, 16 Jul 2023 21:46:08 +0200
Message-ID: <20230716194929.797475734@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Marek Vasut <marex@denx.de>

[ Upstream commit e3f2778b1b6ced649bffdc7cbb05b80bb92f2108 ]

The audio routing flow is not correct, the flow should be from source
(second element in the pair) to sink (first element in the pair). The
flow now is from "HP_OUT" to "Playback", where "Playback" is source
and "HP_OUT" is sink, i.e. the direction is swapped and there is no
direct link between the two either.

Fill in the correct routing, where "HP_OUT" supplies the "Headphone Jack",
"Line In Jack" supplies "LINE_IN" input, "Microphone Jack" supplies "MIC_IN"
input and "Mic Bias" supplies "Microphone Jack".

Fixes: 34e0c7847dcf ("ARM: dts: stm32: Add DH Electronics DHCOM STM32MP1 SoM and PDK2 board")
Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi
index 5f586f024060f..38f46c2c83aa6 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi
@@ -137,10 +137,13 @@ reg_panel_supply: regulator-panel-supply {
 
 	sound {
 		compatible = "audio-graph-card";
-		routing =
-			"MIC_IN", "Capture",
-			"Capture", "Mic Bias",
-			"Playback", "HP_OUT";
+		widgets = "Headphone", "Headphone Jack",
+			  "Line", "Line In Jack",
+			  "Microphone", "Microphone Jack";
+		routing = "Headphone Jack", "HP_OUT",
+			  "LINE_IN", "Line In Jack",
+			  "MIC_IN", "Microphone Jack",
+			  "Microphone Jack", "Mic Bias";
 		dais = <&sai2a_port &sai2b_port>;
 		status = "okay";
 	};
-- 
2.39.2



