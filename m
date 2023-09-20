Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B837A7DBB
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbjITMLv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjITMLt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:11:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD687DC
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:11:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DC6C433C7;
        Wed, 20 Sep 2023 12:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211901;
        bh=k9zkcSZAVnYfNNBa796/uXnxE///tubSNcMhpzBgMWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SAfIDD6UAgKz/IIDuFRLVAFfgJzKYtcCp5LnCgjv6+5SboOAn7aBJRyqMpay7yZCT
         axttWrB3/932zF2GNPtYTTh4lXPIEJy9WPCJVdQ1A4WBPvB4OTyRIOU9oUcXDngrOe
         6Z+CU32FzO+8hv/pWF5TFBLxe4tCyDIhCcBu0CEw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 078/273] arm64: dts: msm8996: thermal: Add interrupt support
Date:   Wed, 20 Sep 2023 13:28:38 +0200
Message-ID: <20230920112848.866579718@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amit Kucheria <amit.kucheria@linaro.org>

[ Upstream commit 6eb1c8ade5e8665eb97f8416eee0942c9f90b12b ]

Register upper-lower interrupts for each of the two tsens controllers.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Andy Gross <agross@kernel.org>
Stable-dep-of: 36541089c473 ("arm64: dts: qcom: msm8996: Add missing interrupt to the USB2 controller")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 3e7baabf64507..260adec7980d8 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -382,6 +382,8 @@ tsens0: thermal-sensor@4a9000 {
 			reg = <0x4a9000 0x1000>, /* TM */
 			      <0x4a8000 0x1000>; /* SROT */
 			#qcom,sensors = <13>;
+			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
@@ -390,6 +392,8 @@ tsens1: thermal-sensor@4ad000 {
 			reg = <0x4ad000 0x1000>, /* TM */
 			      <0x4ac000 0x1000>; /* SROT */
 			#qcom,sensors = <8>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.40.1



