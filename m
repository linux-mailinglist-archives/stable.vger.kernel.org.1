Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0776A6FA464
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjEHJ6v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbjEHJ6t (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:58:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A0730DF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:58:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E44B62284
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F390C433D2;
        Mon,  8 May 2023 09:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539927;
        bh=+HQnJgix8pwhMmSOAInhoofFCfAZmmCHaVx8o8W+seE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zzCVzIWHqjst7tJc2vRzMbahYhGrHVTDR5cgwDq+GQm7Kn/gfhURpr3826hoJmwVV
         TsoqCKttMUiCiQqXvCGD3vrh7X2O5ZFAP0bKuMyyKahuV4u8KFycNb2oVpsUhLK60f
         Pg06b3OQvVERNaK0eFhqvxwn+9/eukG8Y7uJg8vg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 183/611] arm64: dts: qcom: sm8350-microsoft-surface: fix USB dual-role mode property
Date:   Mon,  8 May 2023 11:40:25 +0200
Message-Id: <20230508094428.314586812@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 0beda02e530f8fc571877939645cb20ade113027 ]

The "dr_mode" is a property of USB DWC3 node, not the Qualcomm wrapper
one:
  sm8350-microsoft-surface-duo2.dtb: usb@a6f8800: 'dr_mode' does not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'

Fixes: c16160cfa565 ("arm64: dts: qcom: add minimal DTS for Microsoft Surface Duo 2")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230304130315.51595-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts b/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
index 9c4cfd995ff29..e87514d8fd84e 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
@@ -341,6 +341,9 @@
 
 &usb_1 {
 	status = "okay";
+};
+
+&usb_1_dwc3 {
 	dr_mode = "peripheral";
 };
 
-- 
2.39.2



