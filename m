Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FFD7A3A7C
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbjIQUEx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240382AbjIQUEk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:04:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF57103
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:04:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42FEC433C7;
        Sun, 17 Sep 2023 20:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981074;
        bh=v7W+IyRQHEJNlQ2709gQ19MhmDLDlH39PP1VCbacJx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pGI9++eiaOWDWjFhyAqF/N0xBNynMkrICLjLDjamU7Ohr65OCAYO9rCNilvWoGUui
         lgaxwhBpOqwf3Wb6xz1z2vQvzvuC3F0O7G6GKFt53wds9a6vxr5EXn12ktDILoBApE
         0ILi6T597uVk3WIhUgC/gc4vCkv1A3b6JA9GsCcY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 002/511] ARM: dts: imx7s: Drop dma-apb interrupt-names
Date:   Sun, 17 Sep 2023 21:07:09 +0200
Message-ID: <20230917191113.895524741@linuxfoundation.org>
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

From: Marek Vasut <marex@denx.de>

[ Upstream commit 9928f0a9e7c0cee3360ca1442b4001d34ad67556 ]

Drop "interrupt-names" property, since it is broken. The drivers/dma/mxs-dma.c
in Linux kernel does not use it, the property contains duplicate array entries
in existing DTs, and even malformed entries (gmpi, should have been gpmi). Get
rid of that optional property altogether.

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Stable-dep-of: be18293e47cb ("ARM: dts: imx: Set default tuning step for imx7d usdhc")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx7s.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 5951f9a22af86..5d62781451cb0 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1246,7 +1246,6 @@
 				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "gpmi0", "gpmi1", "gpmi2", "gpmi3";
 			#dma-cells = <1>;
 			dma-channels = <4>;
 			clocks = <&clks IMX7D_NAND_USDHC_BUS_RAWNAND_CLK>;
-- 
2.40.1



