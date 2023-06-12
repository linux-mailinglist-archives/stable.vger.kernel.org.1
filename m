Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7703272C22F
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbjFLLDU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbjFLLDG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:03:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA667AB1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AD4362521
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E91C433D2;
        Mon, 12 Jun 2023 10:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686567042;
        bh=1eijrB3wxQKuauEEgovy1DTPpS9JdklbokDB1iqawNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8fpHQhzSfxm/SkG+D0PuZYnHWGkUFvOgoXnkwyo9iAxEfLTmXEGPpwduQqz7RYM3
         7JXfDqFH9IQmzzJ3ssj8k+8inj/QYMVigOPUbhwQhWH72HwOmi6hXRs2SfxMA+tfIQ
         8WL1ELvpdgFJghmbzV9mEsHGu45IuYpolxTiYjtI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shenwei Wang <shenwei.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 129/160] arm64: dts: imx8-ss-dma: assign default clock rate for lpuarts
Date:   Mon, 12 Jun 2023 12:27:41 +0200
Message-ID: <20230612101720.964904897@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shenwei Wang <shenwei.wang@nxp.com>

[ Upstream commit ca50d7765587fe0a8351a6e8d9742cfd4811d925 ]

Add the assigned-clocks and assigned-clock-rates properties for the
LPUARTx nodes. Without these properties, the default clock rate
used would be 0, which can cause the UART ports to fail when open.

Fixes: 35f4e9d7530f ("arm64: dts: imx8: split adma ss into dma and audio ss")
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index a943a1e2797f4..21345ae14eb25 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -90,6 +90,8 @@ lpuart0: serial@5a060000 {
 		clocks = <&uart0_lpcg IMX_LPCG_CLK_4>,
 			 <&uart0_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
+		assigned-clocks = <&clk IMX_SC_R_UART_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <80000000>;
 		power-domains = <&pd IMX_SC_R_UART_0>;
 		status = "disabled";
 	};
@@ -100,6 +102,8 @@ lpuart1: serial@5a070000 {
 		clocks = <&uart1_lpcg IMX_LPCG_CLK_4>,
 			 <&uart1_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
+		assigned-clocks = <&clk IMX_SC_R_UART_1 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <80000000>;
 		power-domains = <&pd IMX_SC_R_UART_1>;
 		status = "disabled";
 	};
@@ -110,6 +114,8 @@ lpuart2: serial@5a080000 {
 		clocks = <&uart2_lpcg IMX_LPCG_CLK_4>,
 			 <&uart2_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
+		assigned-clocks = <&clk IMX_SC_R_UART_2 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <80000000>;
 		power-domains = <&pd IMX_SC_R_UART_2>;
 		status = "disabled";
 	};
@@ -120,6 +126,8 @@ lpuart3: serial@5a090000 {
 		clocks = <&uart3_lpcg IMX_LPCG_CLK_4>,
 			 <&uart3_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
+		assigned-clocks = <&clk IMX_SC_R_UART_3 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <80000000>;
 		power-domains = <&pd IMX_SC_R_UART_3>;
 		status = "disabled";
 	};
-- 
2.39.2



