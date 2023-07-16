Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BB3755285
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjGPUI5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjGPUIw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:08:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D16E199
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:08:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7B4C60E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84BEC433C8;
        Sun, 16 Jul 2023 20:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538130;
        bh=sRe831DrJdiIgE09fwtktx67qKztkVDTNsm/VW7LuN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mXaW+ucEo7ff4aeX6qbq83kzJ+uzxWK0RS2nC+IYrE3d6WXMsyPtzbLPiCJnMyPoh
         0wK0zCpXHk0hfbtnMbd9ncYcPzIWwV2g3oXrGyqRKCNlLIZNelsBrNJ8e15hrUOnYN
         PmT7NQxKgHaT8JuRqnxyupoIQinGQ9lBbX6F+HDQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 340/800] ARM: dts: iwg20d-q7-common: Fix backlight pwm specifier
Date:   Sun, 16 Jul 2023 21:43:13 +0200
Message-ID: <20230716194956.978417737@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 0501fdec106a291c43b3c1b525cf22ab4c24b2d8 ]

make dtbs_check:

    arch/arm/boot/dts/renesas/r8a7743-iwg20d-q7.dtb: backlight: pwms: [[58, 0, 5000000], [0]] is too long
	    From schema: Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
    arch/arm/boot/dts/renesas/r8a7743-iwg20d-q7-dbcm-ca.dtb: backlight: pwms: [[67, 0, 5000000], [0]] is too long
	    From schema: Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
    arch/arm/boot/dts/renesas/r8a7744-iwg20d-q7-dbcm-ca.dtb: backlight: pwms: [[67, 0, 5000000], [0]] is too long
	    From schema: Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
    arch/arm/boot/dts/renesas/r8a7744-iwg20d-q7.dtb: backlight: pwms: [[58, 0, 5000000], [0]] is too long
	    From schema: Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml

PWM specifiers referring to R-Car PWM Timer Controllers should contain
only two cells.

Fix this by dropping the bogus third cell.

Fixes: 6f89dd9e9325d05b ("ARM: dts: iwg20d-q7-common: Add LCD support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/6e5c3167424a43faf8c1fa68d9667b3d87dc86d8.1684855911.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/iwg20d-q7-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index 03caea6fc6ffa..4351c5a02fa59 100644
--- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -49,7 +49,7 @@ audio_clock: audio_clock {
 	lcd_backlight: backlight {
 		compatible = "pwm-backlight";
 
-		pwms = <&pwm3 0 5000000 0>;
+		pwms = <&pwm3 0 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		enable-gpios = <&gpio5 14 GPIO_ACTIVE_HIGH>;
-- 
2.39.2



