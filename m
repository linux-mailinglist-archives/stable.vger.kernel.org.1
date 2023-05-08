Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3386FA751
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbjEHK30 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjEHK3O (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:29:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D26325245
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:29:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D4FF6266D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DEAC433EF;
        Mon,  8 May 2023 10:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541751;
        bh=aHRk0qezGA9Wl1a3lQ4lKIOVMda2VzdL4zUAQ7eltqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zkpAk/PzmhbhUReaQ87i4tBNXQ5aDpdFyeYpqt++tDzifX2iTdx0BPpQ6nvUV6KcZ
         Mnqgrdx38bT5vxKq5sQsK4soKiJW5/k93qR+ujj8gBX4LSB1QDtjf8Wuxb7MFi46hf
         JVxlFXFcUH8F8c5LJclZRk0qNf8Kd2zU7D/gY6+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 216/663] arm64: dts: qcom: sc7180-trogdor-lazor: correct trackpad supply
Date:   Mon,  8 May 2023 11:40:42 +0200
Message-Id: <20230508094435.358139878@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 52e2996f253d82520011340d40dbc1c76ea79208 ]

The hid-over-i2c takes VDD, not VCC supply.  Fix copy-pasta from other
boards which use elan,ekth3000 with valid VCC:

  sc7180-trogdor-lazor-limozeen-nots-r4.dtb: trackpad@2c: 'vcc-supply' does not match any of the regexes: 'pinctrl-[0-9]+'

Fixes: 2c26adb8dbab ("arm64: dts: qcom: Add sc7180-lazor-limozeen skus")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230312183622.460488-3-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dts     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dts
index 850776c5323d1..70d5a7aa88735 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dts
@@ -26,7 +26,7 @@
 		interrupt-parent = <&tlmm>;
 		interrupts = <58 IRQ_TYPE_EDGE_FALLING>;
 
-		vcc-supply = <&pp3300_fp_tp>;
+		vdd-supply = <&pp3300_fp_tp>;
 		hid-descr-addr = <0x20>;
 
 		wakeup-source;
-- 
2.39.2



