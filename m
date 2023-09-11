Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2498E79B431
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbjIKV6X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240439AbjIKOoP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:44:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E79512A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:44:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B377AC433C8;
        Mon, 11 Sep 2023 14:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443450;
        bh=rRYKM6yTdyOQkS4v1BuMygkh7GfXx2JpJvbIthNK9cM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UcjB9jomI+4AiPbdeKV0U0SrnJx26IcqRWSCkQMbSxkbD5jyxh7oAgCfODn1Qm77N
         rzz+HXBPd6ld8tw+BOJtI5lpj1CpvEkayQyjIxnK8VjX+9Kd1AqupelgTnEbM1vtW9
         bv4QQB6aD3zWeC7DpLN1IHvZuz7QPiLZ2G4Q/4oY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bryan ODonoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 381/737] arm64: dts: qcom: apq8016-sbc: Fix ov5640 regulator supply names
Date:   Mon, 11 Sep 2023 15:44:00 +0200
Message-ID: <20230911134701.216893488@linuxfoundation.org>
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

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

[ Upstream commit 43a684580819e7f35b6cb38236be63c4cba26ef4 ]

The ov5640 driver expects DOVDD, AVDD and DVDD as regulator supply names.

The ov5640 has depended on these names since the driver was committed
upstream in 2017. Similarly apq8016-sbc.dtsi has had completely different
regulator names since its own initial commit in 2020.

Perhaps the regulators were left on in previous 410c bootloaders. In any
case today on 6.5 we won't switch on the ov5640 without correctly naming
the regulators.

Fixes: 39e0ce6cd1bf ("arm64: dts: qcom: apq8016-sbc: Add CCI/Sensor nodes")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230811234738.2859417-3-bryan.odonoghue@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 3ec449f5cab78..7261cfc99f9fa 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -285,9 +285,9 @@ camera_rear@3b {
 		clock-names = "xclk";
 		clock-frequency = <23880000>;
 
-		vdddo-supply = <&camera_vdddo_1v8>;
-		vdda-supply = <&camera_vdda_2v8>;
-		vddd-supply = <&camera_vddd_1v5>;
+		DOVDD-supply = <&camera_vdddo_1v8>;
+		AVDD-supply = <&camera_vdda_2v8>;
+		DVDD-supply = <&camera_vddd_1v5>;
 
 		/* No camera mezzanine by default */
 		status = "disabled";
-- 
2.40.1



