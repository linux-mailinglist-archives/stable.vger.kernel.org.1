Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56C16FAA5D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjEHLCg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbjEHLB3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:01:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7954D16358
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:00:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A21D62A18
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11D7C4339B;
        Mon,  8 May 2023 11:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543642;
        bh=hNwT2XPXfrM0qa/w+rJHWnhrTUuC/p2Z9y753f/6sVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LOTlYw35knrDIF6VjWX1jqDAwDPeNOOmIMM9jTO3ntdhH/mBALJ7YcxRF39yWWsW3
         uHXE9vUgKcNIeHWMrOw8tCK6VpY/tgFswjZfLH9DfCcCTmn2SUgmiu14kcPkOZXhgu
         G7Q/NGzyj+EvOTUmr6fgI+FHcl6rA4L1y0Ny8X6g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 155/694] arm64: dts: amlogic: meson-g12b-radxa-zero2: fix pwm clock names
Date:   Mon,  8 May 2023 11:39:50 +0200
Message-Id: <20230508094437.462300276@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Neil Armstrong <neil.armstrong@linaro.org>

[ Upstream commit db217e84d0a3f4183ea5b6d5929e55b73128fcb2 ]

Fixes the following bindings check error:
 - pwm@2000: clock-names: 'oneOf' conditional failed, one must be fixed:
	['clkin4'] is too short
	'clkin4' is not one of ['clkin0', 'clkin1']
	'clkin0' was expected
 - pwm@7000: clock-names: 'oneOf' conditional failed, one must be fixed:
	['clkin3'] is too short
	'clkin3' is not one of ['clkin0', 'clkin1']
	'clkin0' was expected
 - pwm@19000: clock-names: 'oneOf' conditional failed, one must be fixed:
	['clkin2'] is too short
	'clkin2' is not one of ['clkin0', 'clkin1']
	'clkin0' was expected

Fixes: d747e7f76a5f ("arm64: dts: meson: add support for Radxa Zero2")
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Link: https://lore.kernel.org/r/20230207-b4-amlogic-bindings-fixups-v2-v1-4-93b7e50286e7@linaro.org
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
index 9a60c5ec20725..890f5bfebb030 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
@@ -360,7 +360,7 @@
 	pinctrl-0 = <&pwm_e_pins>;
 	pinctrl-names = "default";
 	clocks = <&xtal>;
-	clock-names = "clkin2";
+	clock-names = "clkin0";
 	status = "okay";
 };
 
@@ -368,7 +368,7 @@
 	pinctrl-0 = <&pwm_ao_a_pins>;
 	pinctrl-names = "default";
 	clocks = <&xtal>;
-	clock-names = "clkin3";
+	clock-names = "clkin0";
 	status = "okay";
 };
 
@@ -376,7 +376,7 @@
 	pinctrl-0 = <&pwm_ao_d_e_pins>;
 	pinctrl-names = "default";
 	clocks = <&xtal>;
-	clock-names = "clkin4";
+	clock-names = "clkin1";
 	status = "okay";
 };
 
-- 
2.39.2



