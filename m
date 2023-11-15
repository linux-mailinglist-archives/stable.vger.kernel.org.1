Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868037ECEB3
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjKOTob (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbjKOTo3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B2919F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1625AC433C9;
        Wed, 15 Nov 2023 19:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077466;
        bh=guBa8Bbwm32D3t1uDqXFHRK+NBop4oS4T0HvZr74SNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YsTD48CQPVQDDzUQvIecS8sshRm0TVqczGIwiNmok59EuyzUCCD2cx00fPJgBAEKj
         c8odEW5uAFWno8q7VMyStjLK2WfWfLYntcP48L6JH4v3nACm3GtpPOxYj19QW9PKQb
         LZ06Grm8pi0lk+YVcBFJ0pWK3HWSv4VRdwQPLsQU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephan Gerhold <stephan@gerhold.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 295/603] arm64: dts: qcom: apq8016-sbc: Add missing ADV7533 regulators
Date:   Wed, 15 Nov 2023 14:14:00 -0500
Message-ID: <20231115191633.793160578@linuxfoundation.org>
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

From: Stephan Gerhold <stephan@gerhold.net>

[ Upstream commit 33e9032a1875bb1aee3c68a4540f5a577ff44130 ]

Add the missing regulator supplies to the ADV7533 HDMI bridge to fix
the following dtbs_check warnings. They are all also supplied by
pm8916_l6 so there is no functional difference.

apq8016-sbc.dtb: bridge@39: 'dvdd-supply' is a required property
apq8016-sbc.dtb: bridge@39: 'pvdd-supply' is a required property
apq8016-sbc.dtb: bridge@39: 'a2vdd-supply' is a required property
        from schema display/bridge/adi,adv7533.yaml

Fixes: 28546b095511 ("arm64: dts: apq8016-sbc: Add HDMI display support")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230922-db410c-adv7533-regulators-v1-1-68aba71e529b@gerhold.net
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 4f5541e9be0e9..dabe9f42a63ad 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -172,6 +172,9 @@ adv_bridge: bridge@39 {
 		pd-gpios = <&tlmm 32 GPIO_ACTIVE_HIGH>;
 
 		avdd-supply = <&pm8916_l6>;
+		a2vdd-supply = <&pm8916_l6>;
+		dvdd-supply = <&pm8916_l6>;
+		pvdd-supply = <&pm8916_l6>;
 		v1p2-supply = <&pm8916_l6>;
 		v3p3-supply = <&pm8916_l17>;
 
-- 
2.42.0



