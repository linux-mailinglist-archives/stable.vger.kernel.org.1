Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CF17ECC1A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjKOT07 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbjKOT0o (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:26:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E5BD5B
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:26:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EEAC433C9;
        Wed, 15 Nov 2023 19:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076401;
        bh=iwpeJ8JJhgsfVucosI/GXyy+U/mB6O8xoS+jQIPUUkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y2izEPa8COF1uA9emidJ1MiwZAHyCI2DFF4j3xreLlx6Vlr0tG/mv21BjT1wRVvHc
         fkBqFPnC0/stJC4uEKqRnzeUhJanCA0HsTiepkJ7JPSUtIbpMPrkXL6GIgJn7gPQgA
         rzxDHeer2cwmpJ5K6OsC3+GKB0maFwuEo8DaiqHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 268/550] arm64: dts: qcom: qrb2210-rb1: Swap UART index
Date:   Wed, 15 Nov 2023 14:14:12 -0500
Message-ID: <20231115191619.297054580@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 973c015facabcbd320063648010942c51992c1a1 ]

Newer RB1 board revisions have a debug UART on QUP0. Sadly, it looks
like even when ordering one in retail, customers receive prototype
boards with "Enginering Sample" written on them.

Use QUP4 for UART to make all known RB1 boards boot.

Fixes: e18771961336 ("arm64: dts: qcom: Add initial QTI RB1 device tree")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230906-topic-rb1_features_sans_icc-v1-1-e92ce6fbde16@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index ef36160932890..7eca89dc46aae 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -13,7 +13,7 @@ / {
 	compatible = "qcom,qrb2210-rb1", "qcom,qrb2210", "qcom,qcm2290";
 
 	aliases {
-		serial0 = &uart0;
+		serial0 = &uart4;
 		sdhc1 = &sdhc_1;
 		sdhc2 = &sdhc_2;
 	};
@@ -94,7 +94,7 @@ key_volp_n: key-volp-n-state {
 };
 
 /* UART connected to the Micro-USB port via a FTDI chip */
-&uart0 {
+&uart4 {
 	compatible = "qcom,geni-debug-uart";
 	status = "okay";
 };
-- 
2.42.0



