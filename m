Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B87E79C00E
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378834AbjIKWhf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238668AbjIKOCO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:02:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E28CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:02:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97808C433C8;
        Mon, 11 Sep 2023 14:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440930;
        bh=Q42uD0c5YFpbBRY/carmxJ4gpxwu53vIsIg74wKjq+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yswXiODbvrL9pjuKUH6i2wDVB8XExkfxwq1sqBBc/F7YwUHBx+CfcmYGbk0p1VF2F
         wnT8kCglyy/N8tzkBauDRHzJYwu1PNB+RyKQ4q0DZOa/bXd87xB7O8gnJi7UUkl2i+
         jzawMb/dzfFRcGLcGdGEv5IFA57ZlHmH2+fPLdYc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 236/739] arm64: dts: qcom: sm8450-hdk: remove pmr735b PMIC inclusion
Date:   Mon, 11 Sep 2023 15:40:35 +0200
Message-ID: <20230911134657.757097809@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 701b59db773730a914f1778cf2dd05e3a05c2c69 ]

The 8450-HDK doesn't use PMR735B PMIC. Drop its inclusion to remove the
warning during the HDK bootup.

Fixes: 30464456a1ea ("arm64: dts: qcom: sm8450-hdk: add pmic files")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230707123027.1510723-7-dmitry.baryshkov@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index bc4c125d1832e..dabb7e872f384 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -14,7 +14,6 @@
 #include "pm8450.dtsi"
 #include "pmk8350.dtsi"
 #include "pmr735a.dtsi"
-#include "pmr735b.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. SM8450 HDK";
-- 
2.40.1



