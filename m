Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172737ECE77
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbjKOTnS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbjKOTnR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:43:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CA39E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:43:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8AEC433C7;
        Wed, 15 Nov 2023 19:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077394;
        bh=ihucDC2Bd0+lnL4Qh1OYap97t9rylyGzH+eQV70ykYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNXH57fP4kZbPZa/D1wkgX0O3aqEytiI4VxjAqq49sBL96ySwHGO3V4/cDdW4kQJA
         XKcaGzH8kZCKBx9pMfE3LO93JIw/187p5i0nZGo9Gq7KXbk5ufWbjfjTHDvUTSnCIb
         sg4QO/fq59y/Vh8naZIP6o2+rq/PTh2sHDZfKH9k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        David Heidelberg <david@ixit.cz>,
        Stephen Boyd <swboyd@chromium.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 276/603] arm64: dts: qcom: sdm845: Fix PSCI power domain names
Date:   Wed, 15 Nov 2023 14:13:41 -0500
Message-ID: <20231115191632.468116905@linuxfoundation.org>
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

[ Upstream commit a5f01673d3946e424091e6b8ff274716f9c21454 ]

The original commit hasn't been updated according to
refactoring done in sdm845.dtsi.

Fixes: a1ade6cac5a2 ("arm64: dts: qcom: sdm845: Switch PSCI cpu idle states from PC to OSI")
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Link: https://lore.kernel.org/r/20230912071205.11502-1-david@ixit.cz
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index f86e7acdfd99f..c118d61f34dec 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -144,15 +144,15 @@ panel_in_edp: endpoint {
 };
 
 &psci {
-	/delete-node/ cpu0;
-	/delete-node/ cpu1;
-	/delete-node/ cpu2;
-	/delete-node/ cpu3;
-	/delete-node/ cpu4;
-	/delete-node/ cpu5;
-	/delete-node/ cpu6;
-	/delete-node/ cpu7;
-	/delete-node/ cpu-cluster0;
+	/delete-node/ power-domain-cpu0;
+	/delete-node/ power-domain-cpu1;
+	/delete-node/ power-domain-cpu2;
+	/delete-node/ power-domain-cpu3;
+	/delete-node/ power-domain-cpu4;
+	/delete-node/ power-domain-cpu5;
+	/delete-node/ power-domain-cpu6;
+	/delete-node/ power-domain-cpu7;
+	/delete-node/ power-domain-cluster;
 };
 
 &cpus {
@@ -338,6 +338,8 @@ flash@0 {
 
 
 &apps_rsc {
+	/delete-property/ power-domains;
+
 	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
-- 
2.42.0



