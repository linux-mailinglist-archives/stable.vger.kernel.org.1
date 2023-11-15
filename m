Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCE17ECE92
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbjKOToC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjKOToB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E728D1A8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:43:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6503AC433C8;
        Wed, 15 Nov 2023 19:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077437;
        bh=Wj0/P+khevPa4ZASUGTArAtKe6vCn5hTOt3vd/xIHUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1v578gP5W0VJ9+jUPr6VOcxt20dGRU1uaEqeyIFqDFWk2F8NKE7enkGhK9sbpsGnm
         FctLqOMMv3fA6y+NbPvD2cxbhun9YRU6tIF2cVnYA/1q/mLUquzcm6QVadl5QRFfuP
         DoL182e3yEeWM97vHIZZNkDgMzYWAc5W1O3OVKq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        =?UTF-8?q?Rapha=C3=ABl=20Gallais-Pou?= 
        <raphael.gallais-pou@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 303/603] ARM: dts: stm32: stm32f7-pinctrl: dont use multiple blank lines
Date:   Wed, 15 Nov 2023 14:14:08 -0500
Message-ID: <20231115191634.369532978@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Dario Binacchi <dario.binacchi@amarulasolutions.com>

[ Upstream commit 88bb50edb61068c4416df2e55677fb3159f647f1 ]

The patch fixes the following warning:

arch/arm/dts/stm32f7-pinctrl.dtsi:380: check: Please don't use multiple blank lines

Fixes: ba287d1a0137 ("ARM: dts: stm32: add pin map for LTDC on stm32f7")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi
index 65480a9f5cc4e..842f2b17c4a81 100644
--- a/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi
@@ -376,7 +376,6 @@ pins2 {
 				};
 			};
 
-
 			ltdc_pins_a: ltdc-0 {
 				pins {
 					pinmux = <STM32_PINMUX('E', 4, AF14)>, /* LCD_B0 */
-- 
2.42.0



