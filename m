Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEA87ED0AE
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343853AbjKOT4x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343875AbjKOT4k (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:56:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46A710D0
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:56:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A87C433C7;
        Wed, 15 Nov 2023 19:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078196;
        bh=tTRCpSbl/BdUkqM/hugkp+0KWXZ6E4nagQC+Qn1Ycj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vQL4rz9elKnVFR12tq7d/+Uikv6GsH1A+Lx4ewdxqHUePl+z+tXGVvo1S7UxkI3kf
         7k3gESnoMJDDL0wz42uI3lD0Sf0HcaUlvuxlcyoza/KRO0kwr0+R4m3phHmJRRRXv3
         MnqEsOgpPVWdeahflI2IJFSQjnA5mXZm3W9Eb4kM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 163/379] arm64: dts: qcom: msm8992-libra: drop duplicated reserved memory
Date:   Wed, 15 Nov 2023 14:23:58 -0500
Message-ID: <20231115192654.750073227@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit f32096602c19e68fb9bf04b494d13f1190602554 ]

There are two entries for similar reserved memory: qseecom@cb400000 and
audio@cb400000.  Keep the qseecom as it is longer.

  Warning (unique_unit_address_if_enabled): /reserved-memory/audio@cb400000: duplicate unit-address (also used in node /reserved-memory/qseecom@cb400000)

Fixes: 69876bc6fd4d ("arm64: dts: qcom: msm8992-libra: Fix the memory map")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230720072048.10093-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
index 3ab0ad14e8704..95eab1f379229 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
@@ -109,11 +109,6 @@ rmtfs_mem: rmtfs@ca100000 {
 			qcom,client-id = <1>;
 		};
 
-		audio_mem: audio@cb400000 {
-			reg = <0 0xcb000000 0 0x400000>;
-			no-mem;
-		};
-
 		qseecom_mem: qseecom@cb400000 {
 			reg = <0 0xcb400000 0 0x1c00000>;
 			no-mem;
-- 
2.42.0



