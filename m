Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF18761454
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjGYLSL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbjGYLSE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:18:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6028E7
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:18:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FCCB61683
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA4FC433C7;
        Tue, 25 Jul 2023 11:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283882;
        bh=x2LscMmUGPs+gIvgslsFANM3AmcMJxlbUZ5RB8uwFyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=szI8C+JSKo0cbrmLW+AXsdDEzsMIb6jYf7Q0AWKFIbn1sMqGqRqGirfa4XqvOrEln
         KU7iokDoDeVbsv4FqLbIpIdnjM74DwuggNWVk7REN5oipBMOsCEzg05rnHghu85ybD
         qZkQAP3N6f0MxiK9Duo/cheosdWUyigep1hhs+0k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 127/509] ARM: dts: stm32: Shorten the AV96 HDMI sound card name
Date:   Tue, 25 Jul 2023 12:41:06 +0200
Message-ID: <20230725104559.513090091@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Marek Vasut <marex@denx.de>

[ Upstream commit 0cf765e598712addec34d0208cc1418c151fefb2 ]

Fix the following error in kernel log due to too long sound card name:
"
asoc-audio-graph-card sound: ASoC: driver name too long 'STM32MP1-AV96-HDMI' -> 'STM32MP1-AV96-H'
"

Fixes: e027da342772 ("ARM: dts: stm32: Add bindings for audio on AV96")
Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
index c43cf62736a6f..d8547307a9505 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
@@ -88,7 +88,7 @@ sd_switch: regulator-sd_switch {
 
 	sound {
 		compatible = "audio-graph-card";
-		label = "STM32MP1-AV96-HDMI";
+		label = "STM32-AV96-HDMI";
 		dais = <&sai2a_port>;
 		status = "okay";
 	};
-- 
2.39.2



