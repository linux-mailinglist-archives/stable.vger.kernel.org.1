Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E4C6FAAB0
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjEHLFj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjEHLFX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5034131EDE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 201BC6260A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1501BC433EF;
        Mon,  8 May 2023 11:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543859;
        bh=mpTes964mqXXGyctO4vhDHifhhAQxSchPulv0ClTJys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HHYsiqLX56AGeR0Jx4xnw1e/v02LMIMhw60aAaTXknUyHXfYO3ZbAS7JFLf4hQLJm
         c2yu+pueFnbV9RsB12j0O1tmbq9AId8KHdXkvGeDIoQ+9M419E4+vna5p1jc2E6GFE
         yeUDO2Ofo+YVR6ZpBN7s6mlzEkOwagYDMGlDk5iI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 225/694] arm64: dts: qcom: sm8450: fix pcie1 gpios properties name
Date:   Mon,  8 May 2023 11:41:00 +0200
Message-Id: <20230508094439.663374721@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Neil Armstrong <neil.armstrong@linaro.org>

[ Upstream commit e57430d2483506f046e39bf8c61159dde88aede2 ]

Add the final "s" to the pgio properties and fix the invalid "enable"
name to the correct "wake", checked against the HDK8450 schematics.

Fixes: bc6588bc25fb ("arm64: dts: qcom: sm8450: add PCIe1 root device")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-4-0ca1bea1a843@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index bcb0eac83ef01..243ef642fcef6 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1917,8 +1917,8 @@
 			phys = <&pcie1_lane>;
 			phy-names = "pciephy";
 
-			perst-gpio = <&tlmm 97 GPIO_ACTIVE_LOW>;
-			enable-gpio = <&tlmm 99 GPIO_ACTIVE_HIGH>;
+			perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
+			wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie1_default_state>;
-- 
2.39.2



