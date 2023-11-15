Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ECB7ECE81
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjKOTne (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbjKOTnd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:43:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFBEB9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:43:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CE8C433C7;
        Wed, 15 Nov 2023 19:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077410;
        bh=DRLvMXwWHEsmy++5wgz1HtzjS1LJuhRIZ97LSAc7sY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bjmP0uc5h8X1LZXQh+hcsI2tckY8XO6SpknuUPZVqljCRibIUhTYWkr+0Brh4GhBg
         5sFS987aLVF9PJFM6ws4+4I3gg7QqOgNgmFxNJh0b2uF+H0GKgCJKS7t15npgzrjZ8
         X1/QeZetkW1t9ar40lLz4Q68ikfbYcs2QkPqxbAI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Richard Acayan <mailingradian@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 285/603] arm64: dts: qcom: sdm670: Fix pdc mapping
Date:   Wed, 15 Nov 2023 14:13:50 -0500
Message-ID: <20231115191633.099942287@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit ad75cda991f7b335d3b2417f82db07680f92648a ]

As pointed out by Richard, I missed a non-continuity in one of the ranges.
Fix it.

Reported-by: Richard Acayan <mailingradian@gmail.com>
Fixes: b51ee205dc4f ("arm64: dts: qcom: sdm670: Add PDC")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Richard Acayan <mailingradian@gmail.com>
Link: https://lore.kernel.org/r/20230818-topic-670_pdc_fix-v1-1-1ba025041de7@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm670.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index 84cd2e39266fe..ba2043d67370a 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -1328,7 +1328,8 @@ pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sdm670-pdc", "qcom,pdc";
 			reg = <0 0x0b220000 0 0x30000>;
 			qcom,pdc-ranges = <0 480 40>, <41 521 7>, <49 529 4>,
-					  <54 534 24>, <79 559 30>, <115 630 7>;
+					  <54 534 24>, <79 559 15>, <94 609 15>,
+					  <115 630 7>;
 			#interrupt-cells = <2>;
 			interrupt-parent = <&intc>;
 			interrupt-controller;
-- 
2.42.0



