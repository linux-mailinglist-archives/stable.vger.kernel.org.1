Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B2F6FADA8
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbjEHLgp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbjEHLgY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:36:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCECA3F577
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:36:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3173963305
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330ACC433D2;
        Mon,  8 May 2023 11:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545725;
        bh=LJfx972Bbrujfue6EhNh/disZ9cXPZhVESrKR23aVcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gfkSAoc70FvklMZHdrVP+ZDcAgwvpOl+RsI5+2k/OU4Z3v8lSYJcJ1bRNMOqVZAck
         ED3NTEmHxIvpLp7sDJjtSQ8Nbuir0HmOibv5OU8K2JbrWl6IN+59b1lA5eLbiAk/WP
         p2AUCMIkFpks8qxH0+CD6jiiqGxg24MLiCDxNGvo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 094/371] arm64: dts: qcom: msm8998: Fix stm-stimulus-base reg name
Date:   Mon,  8 May 2023 11:44:55 +0200
Message-Id: <20230508094815.781027099@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit b5d08f08377218b1d2ab4026e427a7788b271c8e ]

The name stm-data-base comes from ancient (msm-3.10 or older)
downstream kernels. Upstream uses stm-stimulus-base instead. Fix it.

Fixes: 783abfa2249a ("arm64: dts: qcom: msm8998: Add Coresight support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230213210331.2106877-1-konrad.dybcio@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 5350b911f4f6c..5ddf9fa904aba 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1473,7 +1473,7 @@
 			compatible = "arm,coresight-stm", "arm,primecell";
 			reg = <0x06002000 0x1000>,
 			      <0x16280000 0x180000>;
-			reg-names = "stm-base", "stm-data-base";
+			reg-names = "stm-base", "stm-stimulus-base";
 			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
-- 
2.39.2



