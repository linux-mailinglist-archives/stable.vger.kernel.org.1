Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C6779B200
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379513AbjIKWog (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240308AbjIKOlK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:41:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEE6E6
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:41:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3993AC433C8;
        Mon, 11 Sep 2023 14:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443265;
        bh=T0DYgCpGzBtEUARPi6Dwu9Oi2GkJWM0HYvK/ZRuh2HU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LMJ5+wwTV0GA0VEyxuIXFJnMln52W6edaBB8kFRaWz4I/vzHiyJQ8TqR6j4/3pJ2J
         CU77kXhHbruX4oZzk31rakSMlWN+hg2B1JBv5oBSI+UPnNBwEkxxZo4Wc/hQjeuuSv
         lm7HsYc3fBjYfw9fE+wYpWyu35JwWBJRNnRgBy4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 299/737] arm64: dts: qcom: sm8450-hdk: remove pmr735b PMIC inclusion
Date:   Mon, 11 Sep 2023 15:42:38 +0200
Message-ID: <20230911134658.906906624@linuxfoundation.org>
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
index e931545a2cac4..50306d070883d 100644
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



