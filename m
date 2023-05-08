Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358B86FAA9A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbjEHLEO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbjEHLDu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:03:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7147348BF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:03:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79C8262A6A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A5FC433D2;
        Mon,  8 May 2023 11:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543784;
        bh=9MAsqeaazGuNiXMMAm5m2ptonWtBpnOK+mSH9waaEkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FewynaTnHu9RTJzJqcdmlvqJ0+QgUuaqkeobSQDfzuZjkUSZqkJLHulB+kzRo3Nib
         iTwhQpgOF4YzcF/T5oPySuW/yAnGZlopI6VUOMPRb5st9CfnUBtfX0cRX47Uyv0vBV
         P3uk5XltYtlHwagoTuR5dhRGlmIAtap6aPAnfVWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 200/694] arm64: dts: qcom: sm8550: fix qup_spi0_cs node
Date:   Mon,  8 May 2023 11:40:35 +0200
Message-Id: <20230508094438.890991816@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Neil Armstrong <neil.armstrong@linaro.org>

[ Upstream commit 7629c7a525d163f2a3a08e260a69ff25163ab357 ]

The node is incomplete and doesn't need a subnode, add the missing
properties and move everything to the root of qup-spi0-cs-state node.

Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230308-topic-sm8550-upstream-dt-fixups-v1-2-595b02067672@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index ad42c451891d1..7da28b36470e8 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2792,10 +2792,10 @@
 			};
 
 			qup_spi0_cs: qup-spi0-cs-state {
-				cs-pins {
-					pins = "gpio31";
-					function = "qup1_se0";
-				};
+				pins = "gpio31";
+				function = "qup1_se0";
+				drive-strength = <6>;
+				bias-disable;
 			};
 
 			qup_spi0_data_clk: qup-spi0-data-clk-state {
-- 
2.39.2



