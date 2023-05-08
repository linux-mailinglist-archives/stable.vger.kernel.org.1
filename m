Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5536F6FA469
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjEHJ7D (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjEHJ7B (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:59:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71952CD08
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:59:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69F3562295
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C360C433EF;
        Mon,  8 May 2023 09:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539939;
        bh=qaaGFzkd5C1WurAly2ZQcDF49OS1ckNg1aMmD1BRaxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vSOU6ki7icP4sOKWZvQa14HmI6ZAPGua/u/JcOa6ufZ9fm185gI8GrVbacCZx9CwD
         twjRtXeP3lDBV3KFbmeYhiIlsZ+wG5FaZM3jqBuPhPi0H5n4x2UDwgB54vSDCYDAcF
         eoXxNvZU5FWVG3WdM8rUjOQNEQQm1cxPZeZM8O6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 187/611] arm64: dts: qcom: sm8450: fix pcie1 gpios properties name
Date:   Mon,  8 May 2023 11:40:29 +0200
Message-Id: <20230508094428.446079225@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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
index acaa674a5fcce..128542582b3d8 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1879,8 +1879,8 @@
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



