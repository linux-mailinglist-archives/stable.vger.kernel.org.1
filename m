Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99B57A3BA7
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240778AbjIQUUY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240832AbjIQUUN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:20:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F39210E
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:20:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E77C433C9;
        Sun, 17 Sep 2023 20:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982006;
        bh=0rcik/4Vv7I/6RpILEDRp0A+/z0KpqI85adwQEDcwPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xf+EhwOR9rZmnOg0618wjPFtcnz7zaogd7pTLlNjeffDSXZPpIdXZPHvjeU3tAYwi
         i3nRh1J7/fbMmCMoFBRmDS4Cf+pedHEB5xU57FSjBK0WtFDlUXif5dOk4PEqeui6yh
         PMKPpwhXbSBkrTgplpGADIgzLHKq1+a3SHeJq37E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 138/511] arm64: dts: qcom: pmk8350: fix ADC-TM compatible string
Date:   Sun, 17 Sep 2023 21:09:25 +0200
Message-ID: <20230917191117.194987716@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 435a73d7377ceb29c1a22d2711dd85c831b40c45 ]

The commit b2de43136058 ("arm64: dts: qcom: pmk8350: Add peripherals for
pmk8350") for the ADC TM (thermal monitoring device) have used the
compatible string from the vendor kernel ("qcom,adc-tm7"). Use the
proper compatible string that is defined in the upstream kernel
("qcom,spmi-adc-tm5-gen2").

Fixes: b2de43136058 ("arm64: dts: qcom: pmk8350: Add peripherals for pmk8350")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230707123027.1510723-6-dmitry.baryshkov@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/pmk8350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
index fc38f77d12a36..9e99fcf269dfd 100644
--- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
@@ -45,7 +45,7 @@ pmk8350_vadc: adc@3100 {
 		};
 
 		pmk8350_adc_tm: adc-tm@3400 {
-			compatible = "qcom,adc-tm7";
+			compatible = "qcom,spmi-adc-tm5-gen2";
 			reg = <0x3400>;
 			interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "threshold";
-- 
2.40.1



