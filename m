Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E3479BAB3
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358391AbjIKWIr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241698AbjIKPMS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:12:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCA2FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:12:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5336DC433C8;
        Mon, 11 Sep 2023 15:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445133;
        bh=6kYQyLvlOn9AazoFmfmJflotJn3RXqJFleqyPAdU9gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1svxmceYdyeFa34vzsFbXfRMXUpHrF/47qLy1sQCRz1QPbrOk3XBKT7CmNiaE69gn
         ef/KcoXfKJuRtVfAr/hP4oF48wrn5b92KlbekmkHrbM8CX3eGBGjLvrSOUsfFj7DfY
         Ua5iI02t07eo1YQBf5YQT3IxIoDtVTiCc4gd6QJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 238/600] arm64: dts: qcom: pmr735b: fix thermal zone name
Date:   Mon, 11 Sep 2023 15:44:31 +0200
Message-ID: <20230911134640.627969166@linuxfoundation.org>
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

[ Upstream commit 99f8cf491d546cd668236f573c7d846d3e94f2d6 ]

The name of the thermal zone in pmr735b.dtsi (pmr735a-thermal) conflicts
with the thermal zone in pmr735a.dtsi. Rename the thermal zone according
to the chip name.

Fixes: 6f3426b3dea4 ("arm64: dts: qcom: pmr735b: add temp sensor and thermal zone config")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230707123027.1510723-5-dmitry.baryshkov@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/pmr735b.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pmr735b.dtsi b/arch/arm64/boot/dts/qcom/pmr735b.dtsi
index ec24c4478005a..f7473e2473224 100644
--- a/arch/arm64/boot/dts/qcom/pmr735b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmr735b.dtsi
@@ -8,7 +8,7 @@
 
 / {
 	thermal-zones {
-		pmr735a_thermal: pmr735a-thermal {
+		pmr735b_thermal: pmr735b-thermal {
 			polling-delay-passive = <100>;
 			polling-delay = <0>;
 			thermal-sensors = <&pmr735b_temp_alarm>;
-- 
2.40.1



