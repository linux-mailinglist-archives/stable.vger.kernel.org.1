Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB777ED09B
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343890AbjKOT4l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343914AbjKOT4Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:56:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB94D6F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:56:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929C7C433D9;
        Wed, 15 Nov 2023 19:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078178;
        bh=xCUXEEKQfE/8OvlAZDzBr4OM4F+soT1Ms29oX+IUT4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hg16G0NawEb94oNYO/sOGG2n2NyyiXTAwTEYcpqiL/1oq0IIu7fIF2oleSwnRXWNH
         1aMbhEaz5U3EvrHneF7ido7Vwex87ZbtudgyLNRr0X9c8tYJ1r+Z1QK+FZDZ++KSzB
         04la+xqU8csI0+6D8iKvx999R2Jo3QY9MgiGNjqo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 159/379] ARM: dts: renesas: blanche: Fix typo in GP_11_2 pin name
Date:   Wed, 15 Nov 2023 14:23:54 -0500
Message-ID: <20231115192654.515585520@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit edc6ef026fe69154bb6b70dd6e7f278cfd7d6919 ]

On blanche, the GPIO keyboard fails to probe with:

    sh-pfc e6060000.pinctrl: could not map pin config for "GP_11_02"

Fix this by correcting the name for this pin to "GP_11_2".

Fixes: 1f27fedead91eb60 ("ARM: dts: blanche: Configure pull-up for SOFT_SW and SW25 GPIO keys")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/203128eca2261ffc33b83637818dd39c488f42b0.1693408326.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/r8a7792-blanche.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7792-blanche.dts b/arch/arm/boot/dts/r8a7792-blanche.dts
index c66de9dd12dfc..6a83923aa4612 100644
--- a/arch/arm/boot/dts/r8a7792-blanche.dts
+++ b/arch/arm/boot/dts/r8a7792-blanche.dts
@@ -239,7 +239,7 @@ du1_pins: du1 {
 	};
 
 	keyboard_pins: keyboard {
-		pins = "GP_3_10", "GP_3_11", "GP_3_12", "GP_3_15", "GP_11_02";
+		pins = "GP_3_10", "GP_3_11", "GP_3_12", "GP_3_15", "GP_11_2";
 		bias-pull-up;
 	};
 
-- 
2.42.0



