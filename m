Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6426FAA9E
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjEHLEa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbjEHLEM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:04:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C827F1A480
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:03:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6E14611F6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68E8C433D2;
        Mon,  8 May 2023 11:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543794;
        bh=B/ReKX88RM0PtQZM1w8RndsuF/jF2Qt+kHQrX7M+pEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hESpOMmErYuvEK+HPmELdbM71vKynjy547VoRfNJ4P+VnuZyeGwmMfRSKCPiT7+ex
         Z2RRnCyMSGTUFl7OijfjWUFKpMOB+wczF5+RhA5kGkBel1KxNQZXllMmedaLeygpcJ
         dnTBJqvl+TrqulKdqRJtvCp8uZG7hWKxJmCCL+m0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 203/694] arm64: dts: qcom: sc8280xp: fix external display power domain
Date:   Mon,  8 May 2023 11:40:38 +0200
Message-Id: <20230508094438.977528680@linuxfoundation.org>
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

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit cf386126aef92256245adc8be686f2df4b837013 ]

Fix the external display controller nodes which erroneously described
the controllers as belonging to CX rather than MMCX.

Fixes: 19d3bb90754f ("arm64: dts: qcom: sc8280xp: Add USB-C-related DP blocks")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230316141252.2436-1-johan+linaro@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 60433c810f23f..80401834bb063 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3253,7 +3253,7 @@
 				#sound-dai-cells = <0>;
 
 				operating-points-v2 = <&mdss0_dp0_opp_table>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd SC8280XP_MMCX>;
 
 				status = "disabled";
 
@@ -3331,7 +3331,7 @@
 				#sound-dai-cells = <0>;
 
 				operating-points-v2 = <&mdss0_dp1_opp_table>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd SC8280XP_MMCX>;
 
 				status = "disabled";
 
-- 
2.39.2



