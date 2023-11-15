Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C096D7ECC37
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjKOT1d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjKOT11 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:27:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19D412C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:27:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EE2C433CB;
        Wed, 15 Nov 2023 19:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076444;
        bh=Enq0Oo3VfY4xpQdtcxvpxqd5qsQzszq7HeFn6GMLIzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0DTBEXkmxKqWSersioD+tUuP6DT8AlgpwbsQkYI7u8ssfbpb23tsiSenC+RymAJjn
         dSSpNOxp+oZVy1XPNpzfpac6zcBcs4Fy/fd67hSjUm5T0BIwUU2UEoeM8D+UsrNZOl
         N0KLtKS+fceSBWUBLSd0zAY47FP+bY+9xIGYSOrM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 293/550] arm64: dts: imx8mn: Add sound-dai-cells to micfil node
Date:   Wed, 15 Nov 2023 14:14:37 -0500
Message-ID: <20231115191621.122722099@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Ford <aford173@gmail.com>

[ Upstream commit db1925454a2e7cadcac8756442ca7c3198332336 ]

Per the DT bindings, the micfil node should have a sound-dai-cells
entry.

Fixes: cca69ef6eba5 ("arm64: dts: imx8mn: Add support for micfil")
Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index aa38dd6dc9ba5..1bb1d0c1bae4d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -371,6 +371,7 @@ micfil: audio-controller@30080000 {
 						      "pll8k", "pll11k", "clkext3";
 					dmas = <&sdma2 24 25 0x80000000>;
 					dma-names = "rx";
+					#sound-dai-cells = <0>;
 					status = "disabled";
 				};
 
-- 
2.42.0



