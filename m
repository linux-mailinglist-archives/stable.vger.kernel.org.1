Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53F17A3A81
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbjIQUFW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240375AbjIQUEy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:04:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BAEEE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:04:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCF0C433C7;
        Sun, 17 Sep 2023 20:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981088;
        bh=RFTX+JDsTL9lEanEfvctsikny6AOZXur9xTBweMDhGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxXxxVv3pSH+RlIQCm0X+QOLXgbYW6ChGJhDY2umnIgk/aISBvTMUeeXn3TllhZqk
         WG7/nrVSETvNnmtBmU3kmd+FT6jFZEC0d5jv2KJKwNLBRaXbhZLo0sGlukDDM1i+S0
         PVq7rr1ARk+IcqG+C4Izzq6hFNM9G409YZDX9Asw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiaolei Wang <xiaolei.wang@windriver.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 004/511] ARM: dts: imx: Set default tuning step for imx7d usdhc
Date:   Sun, 17 Sep 2023 21:07:11 +0200
Message-ID: <20230917191113.941455162@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiaolei Wang <xiaolei.wang@windriver.com>

[ Upstream commit be18293e47cbca7c6acee9231fc851601d69563a ]

If the tuning step is not set, the tuning step is set to 1.
For some sd cards, the following Tuning timeout will occur.

Tuning failed, falling back to fixed sampling clock
mmc0: Tuning failed, falling back to fixed sampling clock

So set the default tuning step. This refers to the NXP vendor's
commit below:

https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/
arch/arm/boot/dts/imx7s.dtsi#L1216-L1217

Fixes: 1e336aa0c025 ("mmc: sdhci-esdhc-imx: correct the tuning start tap and step setting")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx7s.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 1055a1013fd00..c978aab1d0e3d 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1166,6 +1166,8 @@
 					<&clks IMX7D_USDHC1_ROOT_CLK>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
@@ -1178,6 +1180,8 @@
 					<&clks IMX7D_USDHC2_ROOT_CLK>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
@@ -1190,6 +1194,8 @@
 					<&clks IMX7D_USDHC3_ROOT_CLK>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
-- 
2.40.1



