Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0420D79BE11
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345918AbjIKVWk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241696AbjIKPMM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:12:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D346FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:12:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6761C433C7;
        Mon, 11 Sep 2023 15:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445128;
        bh=Xj3Wbhd5WKySP5f1iYsJuOSqYDlaB/5C4qacAk7oq/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0c4xU9GuFTf7HxqqQ4yMaO9fYG/4ew4+NIUDQD/5B6pN5qgTDVkxYae4kS/kIlvVU
         fCln/8yBzlRHF2O4V3aI8cNcYdV38iev5XbzCMqMQu01WI8ZUjY22+Q05Vi6jim20P
         u5NxXZxkxhK2o7YNj1/E3NKmI5nQW7L/r14mArLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 236/600] arm64: dts: qcom: pm8350: fix thermal zone name
Date:   Mon, 11 Sep 2023 15:44:29 +0200
Message-ID: <20230911134640.568365886@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 64f19c06f704846db5e4885ca63c689d9bef5723 ]

The name of the thermal zone in pm8350.dtsi (pm8350c-thermal) conflicts
with the thermal zone in pm8350c.dtsi. Rename the thermal zone according
to the chip name.

Fixes: 7a79b95f4288 ("arm64: dts: qcom: pm8350: add temp sensor and thermal zone config")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230707123027.1510723-3-dmitry.baryshkov@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/pm8350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8350.dtsi b/arch/arm64/boot/dts/qcom/pm8350.dtsi
index 2dfeb99300d74..9ed9ba23e81e4 100644
--- a/arch/arm64/boot/dts/qcom/pm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8350.dtsi
@@ -8,7 +8,7 @@
 
 / {
 	thermal-zones {
-		pm8350_thermal: pm8350c-thermal {
+		pm8350_thermal: pm8350-thermal {
 			polling-delay-passive = <100>;
 			polling-delay = <0>;
 			thermal-sensors = <&pm8350_temp_alarm>;
-- 
2.40.1



