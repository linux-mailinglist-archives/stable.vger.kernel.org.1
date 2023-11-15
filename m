Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7967ECE17
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjKOTkZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjKOTkU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:40:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E518A4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:40:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C80C433C8;
        Wed, 15 Nov 2023 19:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077217;
        bh=5tWMWvVCnJRCfjMUmJ5qzJGQD4juheEfmKKfg4cSZJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1mGdK9aiskaMNDKkvjxublKRYEQqvMUPLowy1xs5+S9yMl9zT4Wx5rKH3K6Zgiy7R
         sa0z2sszGF1dGcboijx17TL8EzeSRPNUbyZ+W4pwU9qfg0uuIDOJlbADvrDPsjV8RQ
         /AottJLFg2lzeFb2j/Rv2KQxAN91q9xTpwrUm8VQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peng Fan <peng.fan@nxp.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 169/603] clk: imx: imx8: Fix an error handling path in clk_imx_acm_attach_pm_domains()
Date:   Wed, 15 Nov 2023 14:11:54 -0500
Message-ID: <20231115191624.902327190@linuxfoundation.org>
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

[ Upstream commit 156624e2cf815ce98fad5a24f04370f4459ae6f4 ]

If a dev_pm_domain_attach_by_id() call fails, previously allocated
resources need to be released.

Fixes: d3a0946d7ac9 ("clk: imx: imx8: add audio clock mux driver")
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx8-acm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-acm.c
index 1e82f72b75c67..87025a6772d0e 100644
--- a/drivers/clk/imx/clk-imx8-acm.c
+++ b/drivers/clk/imx/clk-imx8-acm.c
@@ -279,8 +279,10 @@ static int clk_imx_acm_attach_pm_domains(struct device *dev,
 
 	for (i = 0; i < dev_pm->num_domains; i++) {
 		dev_pm->pd_dev[i] = dev_pm_domain_attach_by_id(dev, i);
-		if (IS_ERR(dev_pm->pd_dev[i]))
-			return PTR_ERR(dev_pm->pd_dev[i]);
+		if (IS_ERR(dev_pm->pd_dev[i])) {
+			ret = PTR_ERR(dev_pm->pd_dev[i]);
+			goto detach_pm;
+		}
 
 		dev_pm->pd_dev_link[i] = device_link_add(dev,
 							 dev_pm->pd_dev[i],
-- 
2.42.0



