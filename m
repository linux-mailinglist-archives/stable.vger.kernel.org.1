Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4728679AD09
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359734AbjIKWSc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241803AbjIKPO7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:14:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FBD12E
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:14:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D73BC433C8;
        Mon, 11 Sep 2023 15:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445294;
        bh=v6eYp5LfGQwTTZiHiko82uAvLH5lOiaXy8VHbcrcmZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m0MnaT9/AFzmieb8KZgj/LdHU0nIqRNF/tkYgDwfG9Ob4+uaWtFwQdGAsRUd+gxC/
         ifhrMCZewcolkeIbhwAol9fFVSFs683UirSyL96JGN2zv7lTXdPeHT8ubRYZ2o+VsC
         MwpIXUz/CEGodW69edOSVN+z1GLveS1/HsnTH3FY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 257/600] arm64: dts: qcom: pm660l: Add missing short interrupt
Date:   Mon, 11 Sep 2023 15:44:50 +0200
Message-ID: <20230911134641.196286523@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 9a4ac09db3c7413e334b4abd6b2f6de8930dd781 ]

Add the missing short interrupt. This fixes the schema warning:

wled@d800: interrupt-names: ['ovp'] is too short

Fixes: 7b56a804e58b ("arm64: dts: qcom: pm660l: Add WLED support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230626-topic-bindingsfixups-v1-4-254ae8642e69@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/pm660l.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm660l.dtsi b/arch/arm64/boot/dts/qcom/pm660l.dtsi
index 8aa0a5078772b..88606b996d690 100644
--- a/arch/arm64/boot/dts/qcom/pm660l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660l.dtsi
@@ -74,8 +74,9 @@ pm660l_lpg: pwm {
 		pm660l_wled: leds@d800 {
 			compatible = "qcom,pm660l-wled";
 			reg = <0xd800>, <0xd900>;
-			interrupts = <0x3 0xd8 0x1 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "ovp";
+			interrupts = <0x3 0xd8 0x1 IRQ_TYPE_EDGE_RISING>,
+				     <0x3 0xd8 0x2 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ovp", "short";
 			label = "backlight";
 
 			status = "disabled";
-- 
2.40.1



