Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3385479B411
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239530AbjIKUzE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241672AbjIKPLg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:11:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8E1FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:11:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDB1C433C8;
        Mon, 11 Sep 2023 15:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445091;
        bh=Vd06oWSu2mhjizJKKq/PMzrmG/lwZezzHaXJolkna84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BCxfbb9sOurjA8aw8iXKDVfW1U1uZlRvuBUGg7EIPWJUni6wINQ4TI5Num97kF5XM
         f/P1ojN+YaoS0eMPcCnQsFNDlwvJzKPwN2XxC/jNVFhhmsNRXBG3TZ0lZkxh4ZZ0+f
         VmjA5RxWQHbyj81sJAqgG2sW/SO3awqTbF7iaSFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 225/600] arm64: dts: qcom: msm8916-l8150: correct light sensor VDDIO supply
Date:   Mon, 11 Sep 2023 15:44:18 +0200
Message-ID: <20230911134640.255214528@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index d85e7f7c0835a..75f7b4f35fe82 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -163,7 +163,7 @@ light-sensor@23 {
 		pinctrl-0 = <&light_int_default>;
 
 		vdd-supply = <&pm8916_l17>;
-		vio-supply = <&pm8916_l6>;
+		vddio-supply = <&pm8916_l6>;
 	};
 
 	gyroscope@68 {
-- 
2.40.1



