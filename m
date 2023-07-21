Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20D775D290
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjGUTBA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjGUTBA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:01:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DF930CF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:00:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DCAE61D5F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F54AC433C8;
        Fri, 21 Jul 2023 19:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966058;
        bh=/78/qhcMa4y6aBTxScimRcTrwwt75RaAY1kWMjSizCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=goMACUgeUpadkXLW2kS+vYPnBZNyH1t2Rn+HSudDt3HPMyyykdejTE6DmZMrWBGDG
         Xld9G3BqbVBYYpBGYPQmBI4bbjH1n7m8IMktTEvjCwp/XK69Wgb0XZucEMJ224mus2
         WN8d6e64hHAtvJDSapb9FZLS1mAOtltGsElp3Blk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fei Shao <fshao@chromium.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 192/532] clk: Fix memory leak in devm_clk_notifier_register()
Date:   Fri, 21 Jul 2023 18:01:36 +0200
Message-ID: <20230721160624.824080771@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Fei Shao <fshao@chromium.org>

[ Upstream commit 7fb933e56f77a57ef7cfc59fc34cbbf1b1fa31ff ]

devm_clk_notifier_register() allocates a devres resource for clk
notifier but didn't register that to the device, so the notifier didn't
get unregistered on device detach and the allocated resource was leaked.

Fix the issue by registering the resource through devres_add().

This issue was found with kmemleak on a Chromebook.

Fixes: 6d30d50d037d ("clk: add devm variant of clk_notifier_register")
Signed-off-by: Fei Shao <fshao@chromium.org>
Link: https://lore.kernel.org/r/20230619112253.v2.1.I13f060c10549ef181603e921291bdea95f83033c@changeid
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0674dbc62eb55..5eba83745d8de 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4504,6 +4504,7 @@ int devm_clk_notifier_register(struct device *dev, struct clk *clk,
 	if (!ret) {
 		devres->clk = clk;
 		devres->nb = nb;
+		devres_add(dev, devres);
 	} else {
 		devres_free(devres);
 	}
-- 
2.39.2



