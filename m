Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B42C7872B3
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241892AbjHXO4R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241978AbjHXO4E (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:56:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA3E10D7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD9BC61642
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941CCC433C7;
        Thu, 24 Aug 2023 14:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888960;
        bh=uTS0kjiWMXlTTwXEeTl1krt6KyuJJOocOgYGfIyqVdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wEY5TeA4wgwFCKIzOo42MvkgUt2gLe9ABu9pXKoJJwnfESWAQ5fXwQFaQTJyARWXs
         0En0llViq/TTlRJ+mSBBwgfR6hsGq/ZKG4hw4AZuS87GqmGQuy8NGf5MvoiJfT+s2O
         LtLuQpNXfe6oV2Ad2jER1ic3O2Lv7kkJcx2WfApo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiaolei Wang <xiaolei.wang@windriver.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 103/139] ARM: dts: imx: Set default tuning step for imx6sx usdhc
Date:   Thu, 24 Aug 2023 16:50:26 +0200
Message-ID: <20230824145028.031248869@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Xiaolei Wang <xiaolei.wang@windriver.com>

[ Upstream commit 0a2b96e42a0284c4fc03022236f656a085ca714a ]

If the tuning step is not set, the tuning step is set to 1.
For some sd cards, the following Tuning timeout will occur.

Tuning failed, falling back to fixed sampling clock

So set the default tuning step. This refers to the NXP vendor's
commit below:

https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/
arch/arm/boot/dts/imx6sx.dtsi#L1108-L1109

Fixes: 1e336aa0c025 ("mmc: sdhci-esdhc-imx: correct the tuning start tap and step setting")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6sx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 8bef5440278ba..3e779fd0a3961 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -981,6 +981,8 @@
 					 <&clks IMX6SX_CLK_USDHC1>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-start-tap = <20>;
+				fsl,tuning-step= <2>;
 				status = "disabled";
 			};
 
@@ -993,6 +995,8 @@
 					 <&clks IMX6SX_CLK_USDHC2>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-start-tap = <20>;
+				fsl,tuning-step= <2>;
 				status = "disabled";
 			};
 
@@ -1005,6 +1009,8 @@
 					 <&clks IMX6SX_CLK_USDHC3>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-start-tap = <20>;
+				fsl,tuning-step= <2>;
 				status = "disabled";
 			};
 
-- 
2.40.1



