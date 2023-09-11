Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C30279ADE0
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343629AbjIKVMI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240389AbjIKOnD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:43:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA6A12A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:42:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00527C433C8;
        Mon, 11 Sep 2023 14:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443378;
        bh=n+x1/EaGEnhoY3z1i571AVa4MfL8WR3ABuEAMtXJcUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cbdEvDkRVeKShfnn5nOPqUCx1idG5HqDuLV5mTc9+7JCqNQbAjrfO+4mWDTfK2ocP
         rySBRwQni+sxnjokJNql1gHQ8+o4dZmQUpWPIHwAirqbr1BXcz2cs35SwqrxDE1J9I
         dpRymzWFf19mHVK7Nar9yExReMg5131kCEMh5InI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 356/737] arm64: dts: qcom: sm8550-mtp: Add missing supply for L1B regulator
Date:   Mon, 11 Sep 2023 15:43:35 +0200
Message-ID: <20230911134700.464801052@linuxfoundation.org>
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

From: Abel Vesa <abel.vesa@linaro.org>

[ Upstream commit 2c9e45dfeed126488aa73e7b82b3576c4c6f1036 ]

Even though currently there is no consumer for L1B, add the supply
for it anyway.

Fixes: 71342fb91eae ("arm64: dts: qcom: Add base SM8550 MTP dts")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20230801095246.2884770-1-abel.vesa@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index e2b9bb6b1e279..ea304d1e6f8f6 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -79,6 +79,7 @@ regulators-0 {
 
 		vdd-bob1-supply = <&vph_pwr>;
 		vdd-bob2-supply = <&vph_pwr>;
+		vdd-l1-l4-l10-supply = <&vreg_s6g_1p8>;
 		vdd-l2-l13-l14-supply = <&vreg_bob1>;
 		vdd-l3-supply = <&vreg_s4g_1p3>;
 		vdd-l5-l16-supply = <&vreg_bob1>;
-- 
2.40.1



