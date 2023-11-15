Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463CA7ECE18
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbjKOTk0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjKOTkW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:40:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513CA1A3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:40:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB44C433C7;
        Wed, 15 Nov 2023 19:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077218;
        bh=Jqp7PqDDKntga1Z3SoBTt6lSQJBat9dnaKiMMdF6SW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RrpAsfjvBbWomsoaBisi6aX+PElFbwthmC6cL1Slps4eLOTrHb6k1Iauw0P0w9kmQ
         UEed/xZPQnYQTzZAEMKNjZKieKpSjMyiTvTs9HfgzE7oxN17GZe6agPdQRErY2LM5M
         H1qRCdWZu//EoLf5NZ/Sbif8VtqMgH2aTeEaYYRs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peng Fan <peng.fan@nxp.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 170/603] clk: imx: imx8: Fix an error handling path if devm_clk_hw_register_mux_parent_data_table() fails
Date:   Wed, 15 Nov 2023 14:11:55 -0500
Message-ID: <20231115191624.968901659@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 9a0108acdb1b6189dcc8f9318edfc6b7e0281df4 ]

If a devm_clk_hw_register_mux_parent_data_table() call fails, it is likely
that the probe should fail with an error code.

Set 'ret' before leaving the function.

Fixes: d3a0946d7ac9 ("clk: imx: imx8: add audio clock mux driver")
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx8-acm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-acm.c
index 87025a6772d0e..73b3b53549517 100644
--- a/drivers/clk/imx/clk-imx8-acm.c
+++ b/drivers/clk/imx/clk-imx8-acm.c
@@ -373,6 +373,7 @@ static int imx8_acm_clk_probe(struct platform_device *pdev)
 										sels[i].shift, sels[i].width,
 										0, NULL, NULL);
 		if (IS_ERR(hws[sels[i].clkid])) {
+			ret = PTR_ERR(hws[sels[i].clkid]);
 			pm_runtime_disable(&pdev->dev);
 			goto err_clk_register;
 		}
-- 
2.42.0



