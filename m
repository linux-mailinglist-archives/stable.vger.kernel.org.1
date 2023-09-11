Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A20779BC7B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379439AbjIKWoH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240480AbjIKOp1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:45:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854A612A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:45:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DDDC433C8;
        Mon, 11 Sep 2023 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443523;
        bh=JGevzVCL8eHFbDVb4Xw2v7OEXz6dMglJ5Zpav3EFiBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bdCpVByU3zOnjny5tds4A+deLOM7A00mm0L1l2zeY3MEzbnMF7xdaTuLzocfQsrs2
         ehBOeYslBnL4tDhf4v9bqMSdVQPRR38ou6+z/DRv0cpPqbyZC/IcGJDv0fkBbKBaGj
         pQxiOjVrw8Jxusi8Ux5cLZRpYPhAeBVKDwrGYHnI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 390/737] ARM: dts: qcom: sdx65-mtp: Update the pmic used in sdx65
Date:   Mon, 11 Sep 2023 15:44:09 +0200
Message-ID: <20230911134701.486327768@linuxfoundation.org>
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

From: Rohit Agarwal <quic_rohiagar@quicinc.com>

[ Upstream commit f636d6c356b339b0d29eed025f8bf9efcb6eb274 ]

Update the pmic used in sdx65 platform to pm7250b.

Fixes: 26380f298b2b (ARM: dts: qcom: sdx65-mtp: Add pmk8350b and pm8150b pmic)
Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/1691415534-31820-7-git-send-email-quic_rohiagar@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
index 57bc3b03d3aac..4264ace66b295 100644
--- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
@@ -7,7 +7,7 @@
 #include "qcom-sdx65.dtsi"
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <arm64/qcom/pmk8350.dtsi>
-#include <arm64/qcom/pm8150b.dtsi>
+#include <arm64/qcom/pm7250b.dtsi>
 #include "qcom-pmx65.dtsi"
 
 / {
-- 
2.40.1



