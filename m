Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2105A7ECE78
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbjKOTnV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbjKOTnU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:43:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3DA19F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:43:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84F5C433C7;
        Wed, 15 Nov 2023 19:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077396;
        bh=NT7gCb/kBdsfFZ958oP4tuy6PZoOVht8f6++hW+uBIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hS0h+eCAsehoIOERy1I1khK2yntrT2zO7L58JtYlCVQJdGi9X0xTe8YhmvkyL/qHR
         LAwAcTY5g/XlExYvBFWvO6COEcwis2DDHdkjs1y33E+vUNAVfnjgNI2J57inVBk63e
         uj2+GZW8Rfs9654jeujEn391MxWRNhIGDK3fiLDw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 277/603] arm64: dts: qcom: sdm845: cheza doesnt support LMh node
Date:   Wed, 15 Nov 2023 14:13:42 -0500
Message-ID: <20231115191632.534194225@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Heidelberg <david@ixit.cz>

[ Upstream commit 197ae69d1caedb3203e0b189a39efb820675fd5c ]

Cheza firmware doesn't allow controlling LMh from the operating system.

Fixes: 36c6581214c4 ("arm64: dts: qcom: sdm845: Add support for LMh node")
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/20230912071205.11502-2-david@ixit.cz
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index c118d61f34dec..0ab5e8f53ac9f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -143,6 +143,10 @@ panel_in_edp: endpoint {
 	};
 };
 
+&cpufreq_hw {
+	/delete-property/ interrupts-extended; /* reference to lmh_cluster[01] */
+};
+
 &psci {
 	/delete-node/ power-domain-cpu0;
 	/delete-node/ power-domain-cpu1;
@@ -275,6 +279,14 @@ &BIG_CPU_SLEEP_1
 			   &CLUSTER_SLEEP_0>;
 };
 
+&lmh_cluster0 {
+	status = "disabled";
+};
+
+&lmh_cluster1 {
+	status = "disabled";
+};
+
 /*
  * Reserved memory changes
  *
-- 
2.42.0



