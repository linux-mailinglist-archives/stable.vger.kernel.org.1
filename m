Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07582755295
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjGPUJe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjGPUJd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:09:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347A39B
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:09:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C669D60EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61FCC433C8;
        Sun, 16 Jul 2023 20:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538172;
        bh=KtVhGJhDVd3HVCDUKdnIWJHxpAUglmwaN93GfO5MUrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=szkY0PLxfVdrBIGaqppc59hHIC/Q6U5+qDODtB9Rzgq9xhshNq6MdbjzGkNLMuPMY
         adrPACAMUkCPI8Kz5I+dsqUm1yim17tu0IiQurKTTJTPxZU0VknmNi6pF5OaYqNY4a
         AIgwE36WCltB7BhQF7Z9uHvEjU3RJ5XpKq5cjRHA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 357/800] ARM: dts: stm32: Fix audio routing on STM32MP15xx DHCOM PDK2
Date:   Sun, 16 Jul 2023 21:43:30 +0200
Message-ID: <20230716194957.370752397@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 4709677151aac..46b87a27d8b37 100644
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



