Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDD47ECE76
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbjKOTnQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbjKOTnQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:43:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15747B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:43:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B61C433CB;
        Wed, 15 Nov 2023 19:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077392;
        bh=/EXX0BYUpakuFipRy2UimW0wE2to2gKIdZFdpmJlQv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aM6t8jkyPRM5DQb2IIK6/7Qh0nTgQovSLNCVLJq6KbEkb9/Im4JsfF6kMmqXOB1V8
         1xgvFzhAU3qxU844MrKPn3OD2SlNiGjEpAj/YTfAZcpLrPYtjDC/vI/jn78T+G7dhY
         oGpvARbrInQAi1tskoYitjA8Fc2WQeFbhUJrH7xY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 275/603] ARM: dts: renesas: blanche: Fix typo in GP_11_2 pin name
Date:   Wed, 15 Nov 2023 14:13:40 -0500
Message-ID: <20231115191632.384085908@linuxfoundation.org>
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
 arch/arm/boot/dts/renesas/r8a7792-blanche.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/renesas/r8a7792-blanche.dts b/arch/arm/boot/dts/renesas/r8a7792-blanche.dts
index c66de9dd12dfc..6a83923aa4612 100644
--- a/arch/arm/boot/dts/renesas/r8a7792-blanche.dts
+++ b/arch/arm/boot/dts/renesas/r8a7792-blanche.dts
@@ -239,7 +239,7 @@ du1_pins: du1 {
 	};
 
 	keyboard_pins: keyboard {
-		pins = "GP_3_10", "GP_3_11", "GP_3_12", "GP_3_15", "GP_11_02";
+		pins = "GP_3_10", "GP_3_11", "GP_3_12", "GP_3_15", "GP_11_2";
 		bias-pull-up;
 	};
 
-- 
2.42.0



