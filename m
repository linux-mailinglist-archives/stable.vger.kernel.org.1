Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AE77ECC11
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjKOT0r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjKOT0c (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:26:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080BED56
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:26:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CC0C433C7;
        Wed, 15 Nov 2023 19:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076388;
        bh=mKJB6wgoKI96AfRhjgDItfS4HE6Vj887+8S2Z/0I0zE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJ3sQuLDyZbMdMdgJ0P7cLch1HqEETYhPsUAUJffbWgkW/ZNNYDwJg03Pd6eDYfUF
         cIhOVhZkHRaSPmcfj7ZizgHcwmZkFo614inWPqv/XlLmhDIY6SxLk7iUSXdQl4QZoh
         MMfmLdPnv2caA+R193Rw/pcFvKL69rOOLNKDxY/w=
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
Subject: [PATCH 6.5 261/550] arm64: dts: qcom: sdm845: Fix PSCI power domain names
Date:   Wed, 15 Nov 2023 14:14:05 -0500
Message-ID: <20231115191618.803610561@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index 1ce413263b7f9..617be27e79523 100644
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



