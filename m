Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA9979B8BC
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359417AbjIKWQe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240253AbjIKOj4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:39:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F88F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:39:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6C6C433C8;
        Mon, 11 Sep 2023 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443192;
        bh=iwWBU2crDzdP1UM+BHJrCFNVRiaKq/iMqsAZ+jjy2i0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M5khV896mRqShp9L6y86l2eqnyfFaIsaWEmKxHgjLS59t3zMiubCBfSkEFuMBp2mk
         /Ajlq9jIhH/kpbzm5CfALVsMjMV/ArOkfa418/py+nnjdHPLTaEBSg450/hHYGiajI
         IarUU+inL6vf2GO9sqs6G/Urnirww6VyWMZCUwIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 290/737] arm64: dts: qcom: msm8996: Add missing interrupt to the USB2 controller
Date:   Mon, 11 Sep 2023 15:42:29 +0200
Message-ID: <20230911134658.663269282@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 36541089c4733355ed844c67eebd0c3936953454 ]

The interrupt line was previously not described. Take care of that.

Fixes: 1e39255ed29d ("arm64: dts: msm8996: Add device node for qcom,dwc3")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230627-topic-more_bindings-v1-11-6b4b6cd081e5@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 25fe2b8552fc7..157d2a2ec32ad 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3336,6 +3336,9 @@ usb2: usb@76f8800 {
 			#size-cells = <1>;
 			ranges;
 
+			interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq";
+
 			clocks = <&gcc GCC_PERIPH_NOC_USB20_AHB_CLK>,
 				<&gcc GCC_USB20_MASTER_CLK>,
 				<&gcc GCC_USB20_MOCK_UTMI_CLK>,
-- 
2.40.1



