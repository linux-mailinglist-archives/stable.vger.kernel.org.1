Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C1F77575C
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjHIKpG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjHIKpF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:45:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAB21702
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56E8963118
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658F2C433C8;
        Wed,  9 Aug 2023 10:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577903;
        bh=IGhvm9sViu1MAR70/SYTI9ifqTjpsV5BUus8Pm3Wzt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ArEKuGyUEjhMYHXvalGjzH/w32+jmT2AOu9tZiWZIG5ZlrED/JJlxxJq1AbjHImUB
         B6qYj25cdYojNjlh5vJR/QSg4bybk3DJ8/Qao1TU4rjptO1l7TC0UuznwddWjFmC8W
         qcocW7P0mjbwTyNDhBP6r2JegB+8cmc/Vp4sFw9s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yashwanth Varakala <y.varakala@phytec.de>,
        Cem Tenruh <c.tenruh@phytec.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 008/165] arm64: dts: phycore-imx8mm: Label typo-fix of VPU
Date:   Wed,  9 Aug 2023 12:38:59 +0200
Message-ID: <20230809103643.030585154@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yashwanth Varakala <y.varakala@phytec.de>

[ Upstream commit cddeefc1663294fb74b31ff5029a83c0e819ff3a ]

Corrected the label of the VPU regulator node (buck 3)
from reg_vdd_gpu to reg_vdd_vpu.

Fixes: ae6847f26ac9 ("arm64: dts: freescale: Add phyBOARD-Polis-i.MX8MM support")
Signed-off-by: Yashwanth Varakala <y.varakala@phytec.de>
Signed-off-by: Cem Tenruh <c.tenruh@phytec.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
index 92616bc4f71f5..2dd179ec923d7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
@@ -210,7 +210,7 @@
 				};
 			};
 
-			reg_vdd_gpu: buck3 {
+			reg_vdd_vpu: buck3 {
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-max-microvolt = <1000000>;
-- 
2.40.1



