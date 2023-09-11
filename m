Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BF079AF96
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348985AbjIKVcE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238743AbjIKOEC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:04:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5043EE40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:03:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962A5C433C7;
        Mon, 11 Sep 2023 14:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441038;
        bh=QBsyPj7URXWvaPfqZYgSZNQ14jIVe97cACDAh3TJ/jY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q2Ssu+RL4vU4pN2qcwW1lKZAoQ2nvxiyhG/Lg+Ux7RoHJZqn7G2m/WYa0oADloAi7
         IBO7p31fRQKjwfsStnZKkIBcAd0i1KaR7z3HGmk5Hos9Fq5rlObsUur7mF15ZEX71b
         +cBcgERQE0+NeJU8jgul63Sn/QBykM6zSP3EwDHM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 273/739] arm64: dts: qcom: msm8996-gemini: fix touchscreen VIO supply
Date:   Mon, 11 Sep 2023 15:41:12 +0200
Message-ID: <20230911134658.754213622@linuxfoundation.org>
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

[ Upstream commit 21fc24ee9c5943732c9ae538766c9be93d70d936 ]

According to bindings and Linux driver, there is no VDDA but VIO supply.

Fixes: 4ac46b3682c5 ("arm64: dts: qcom: msm8996: xiaomi-gemini: Add support for Xiaomi Mi 5")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230720115335.137354-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
index bdedcf9dff032..d1066edaea471 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
@@ -82,7 +82,7 @@ synaptics@20 {
 		#size-cells = <0>;
 		interrupt-parent = <&tlmm>;
 		interrupts = <125 IRQ_TYPE_LEVEL_LOW>;
-		vdda-supply = <&vreg_l6a_1p8>;
+		vio-supply = <&vreg_l6a_1p8>;
 		vdd-supply = <&vdd_3v2_tp>;
 		reset-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
 
-- 
2.40.1



