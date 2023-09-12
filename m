Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5766C79AEED
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376364AbjIKWTT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239862AbjIKOaf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:30:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E27E4B
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:30:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8E5C433C7;
        Mon, 11 Sep 2023 14:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442630;
        bh=q268ASpcaNfe8SeZpX/1hFOj5zA////KEyBgtSVlNT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xCNBN5FfS52fD3Ud9Q7tU8sO441F0TcGxwwlixkws+wAu9mPnfYlnj+TLql+KrKCm
         zAHYCDmvHNzCW22eXwA/2z7cfyDCH8AumFI7QgyMo8fO3DyZV9/uJX6c4G7XHyWxln
         HQK9+1U7i9onAzsx4DNVdQ2o9J/kg7HYktxb4/OU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 065/737] arm64: dts: rockchip: correct wifi interrupt flag in eaidk-610
Date:   Mon, 11 Sep 2023 15:38:44 +0200
Message-ID: <20230911134652.325907131@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 8183bb7e291b7818f49ea39687c2fafa01a46e27 ]

GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
These are simple defines so they could be used in DTS but they will not
have the same meaning: GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE.

Correct the interrupt flags, assuming the author of the code wanted same
logical behavior behind the name "ACTIVE_xxx", this is:
  ACTIVE_HIGH  => IRQ_TYPE_LEVEL_HIGH

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230707063335.13317-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts b/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
index d1f343345f674..6464ef4d113dd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
@@ -773,7 +773,7 @@
 		compatible = "brcm,bcm4329-fmac";
 		reg = <1>;
 		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "host-wake";
 		pinctrl-names = "default";
 		pinctrl-0 = <&wifi_host_wake_l>;
-- 
2.40.1



