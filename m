Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F1D7ED070
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbjKOTzE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbjKOTzC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:55:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0DB1AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:54:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A07C433C9;
        Wed, 15 Nov 2023 19:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078098;
        bh=tkJAR12LY+c2zZo+vUN/kMEwZhbMgZK3eLEviq3sLcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5APWXdYenSPxvOeH+qZnLyMXIaRegh4f6c0YUZOnDjPACbb0Y3qEBHT/wh/ncI4G
         N5cth/J+LBEP1kS7sA6roqXz0R3EEqgqbu3r74wCuW1ydn/Ve3P9nVSCvPPRH1zqnw
         fSaV4re/UHZ/2NOAE07a2KUxFDZJdg2ipwEKvR9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 084/379] clk: imx: Select MXC_CLK for CLK_IMX8QXP
Date:   Wed, 15 Nov 2023 14:22:39 -0500
Message-ID: <20231115192650.106759337@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abel Vesa <abel.vesa@linaro.org>

[ Upstream commit 317e69c49b4ceef8aebb47d771498ccb3571bdf9 ]

If the i.MX8QXP clock provider is built-in but the MXC_CLK is
built as module, build fails:

aarch64-linux-ld: drivers/clk/imx/clk-imx8-acm.o: in function `imx8_acm_clk_probe':
clk-imx8-acm.c:(.text+0x3d0): undefined reference to `imx_check_clk_hws'

Fix that by selecting MXC_CLK in case of CLK_IMX8QXP.

Fixes: c2cccb6d0b33 ("clk: imx: add imx8qxp clk driver")
Closes: https://lore.kernel.org/all/8b77219e-b59e-40f1-96f1-980a0b2debcf@infradead.org/
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 25785ec9c2762..f219004b8a337 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -96,6 +96,7 @@ config CLK_IMX8QXP
 	depends on (ARCH_MXC && ARM64) || COMPILE_TEST
 	depends on IMX_SCU && HAVE_ARM_SMCCC
 	select MXC_CLK_SCU
+	select MXC_CLK
 	help
 	  Build the driver for IMX8QXP SCU based clocks.
 
-- 
2.42.0



