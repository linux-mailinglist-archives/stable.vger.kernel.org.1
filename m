Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E8D79BD71
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbjIKUvU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238640AbjIKOB0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:01:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A593CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:01:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EA9C433C8;
        Mon, 11 Sep 2023 14:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440881;
        bh=nddejYUv8FsYYMK+JD0Dk4QxVf1pcnzj1XLdliTYBm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pySuLoai7RzUzuMpvoBqttKKrFSzgA2PR5EseGG8SLFcRcoBfBqm6GTEuGXNTRXmU
         UQiLTJjkJpMuy1pL/e+ZY866+NvmyC1vU2GYy4RvP4iIq/+25jQf54AxvPXVNHkBKe
         0T3HZRtXjbHEPzLAsRJiFSQXHGfuzwsbCVUoR1EE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 218/739] arm64: dts: qcom: msm8916-l8150: correct light sensor VDDIO supply
Date:   Mon, 11 Sep 2023 15:40:17 +0200
Message-ID: <20230911134657.276591767@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 6a541eaa6e8e5283efb993ae7a947bede8d01fa5 ]

liteon,ltr559 light sensor takes VDDIO, not VIO, supply:

  msm8916-longcheer-l8150.dtb: light-sensor@23: 'vio-supply' does not match any of the regexes: 'pinctrl-[0-9]+'

Fixes: 3016af34ef8d ("arm64: dts: qcom: msm8916-longcheer-l8150: Add light and proximity sensor")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Nikita Travkin <nikita@trvn.ru>
Link: https://lore.kernel.org/r/20230617171541.286957-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index 97262b8519b36..3892ad4f639a8 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -165,7 +165,7 @@ light-sensor@23 {
 		pinctrl-0 = <&light_int_default>;
 
 		vdd-supply = <&pm8916_l17>;
-		vio-supply = <&pm8916_l6>;
+		vddio-supply = <&pm8916_l6>;
 	};
 
 	gyroscope@68 {
-- 
2.40.1



