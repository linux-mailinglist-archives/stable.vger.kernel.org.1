Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA15174C2FF
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjGIL1E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjGIL1D (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5250C18F
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:27:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBD7260B51
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D4EC433C8;
        Sun,  9 Jul 2023 11:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902021;
        bh=mCfmWSYhv56RD89u+ky0qYW3sEC7TN1vzfyn2y/L/Hw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LfYfhELWFoBIRFgEQPCd36/BDWAfRN65zDqsr+a4WarMe27JFKlVD1zI5Hzg5CT4a
         MFWbQqM5nGyB7AkfGzYBOpj/x4glQD0KF+V6cHzh+eNT1S1VxGSvlX9FX6n9VupmzF
         uJEKvuX2GFCJbZZs+7RQ0WwZr51R1YbjM/hUQT6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 228/431] arm64: dts: qcom: msm8916: correct WCNSS unit address
Date:   Sun,  9 Jul 2023 13:12:56 +0200
Message-ID: <20230709111456.511930303@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 1f9a41bb0bba7b373c26a6f2cc8d35cc3159c861 ]

Match unit-address to reg entry to fix dtbs W=1 warnings:

  Warning (simple_bus_reg): /soc@0/remoteproc@a21b000: simple-bus unit address format error, expected "a204000"

Fixes: 88106096cbf8 ("ARM: dts: msm8916: Add and enable wcnss node")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230419211856.79332-4-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 80f210e55657c..7cc3d0d92cb9e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1870,7 +1870,7 @@ usb_hs_phy: phy {
 			};
 		};
 
-		wcnss: remoteproc@a21b000 {
+		wcnss: remoteproc@a204000 {
 			compatible = "qcom,pronto-v2-pil", "qcom,pronto";
 			reg = <0x0a204000 0x2000>, <0x0a202000 0x1000>, <0x0a21b000 0x3000>;
 			reg-names = "ccu", "dxe", "pmu";
-- 
2.39.2



