Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3A06FA494
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbjEHKBF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjEHKBC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:01:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3EE2E051
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:01:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8555622A1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3BDC433EF;
        Mon,  8 May 2023 10:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540059;
        bh=HEjMVt6eg9+7Bfdh+LVYmI3FS0FXpR+FmZYb1shKdaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LA9amb+IE8nYgJcxsjbVhCdhFvn0/vQ/CRTtOhApmjMNUXDVvfrUFzkFRk6ZVpyp5
         2ctfJDmeOJppQrcBxQXV838X4kFpak9iRpGFg6Uw6dtAAZcSBmqZFH9dLq1j3yE+YP
         q7uCuqYg16nMD+AwHrnvxjpeG105JaqSgOc2ewp4=
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
Subject: [PATCH 6.1 208/611] arm64: dts: qcom: sc7280-herobrine-villager: correct trackpad supply
Date:   Mon,  8 May 2023 11:40:50 +0200
Message-Id: <20230508094429.145559414@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit de88b1759b35086d5e63736fb604ea2d06486b1a ]

The hid-over-i2c takes VDD, not VCC supply.  Fix copy-pasta from other
Herobrine boards which use elan,ekth3000 with valid VCC:

  sc7280-herobrine-villager-r1-lte.dtb: trackpad@2c: 'vcc-supply' does not match any of the regexes: 'pinctrl-[0-9]+'

Fixes: ee2a62116015 ("arm64: dts: qcom: sc7280: Add device tree for herobrine villager")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230312183622.460488-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi
index 4566722bf4ddf..8f5d82885e447 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi
@@ -33,7 +33,7 @@ ap_tp_i2c: &i2c0 {
 		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
 
 		hid-descr-addr = <0x20>;
-		vcc-supply = <&pp3300_z1>;
+		vdd-supply = <&pp3300_z1>;
 
 		wakeup-source;
 	};
-- 
2.39.2



