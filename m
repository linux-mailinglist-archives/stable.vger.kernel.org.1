Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C086FA936
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjEHKtZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbjEHKtH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:49:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90122D7B7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:48:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C85EB628FA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F6EC433D2;
        Mon,  8 May 2023 10:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542905;
        bh=H4mBNpuNDP+TJFYMQqT8Cn0Ck3hMBeuEaT73Ti527dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pJhGC1kz/fRyU9w9t3IliNR4zh0+pdSwqlWhD95sSXqc0P7vcGGWD+zq8QLdM474u
         90+Ji2cNua/p5AoLHWqQJaMuoIdzbLIdGpZHOQAtqwAKNuRZLpU2Nr8yam9VmOFOq9
         lSNqBONdDY2njE0SVEkMJvxOPbh/d+2IxBDyAntg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 585/663] dmaengine: mv_xor_v2: Fix an error code.
Date:   Mon,  8 May 2023 11:46:51 +0200
Message-Id: <20230508094448.346432336@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 827026ae2e56ec05ef1155661079badbbfc0b038 ]

If the probe is deferred, -EPROBE_DEFER should be returned, not
+EPROBE_DEFER.

Fixes: 3cd2c313f1d6 ("dmaengine: mv_xor_v2: Fix clock resource by adding a register clock")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/201170dff832a3c496d125772e10070cd834ebf2.1679814350.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/mv_xor_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 113834e1167b6..d086ff1824f82 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -755,7 +755,7 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 
 	xor_dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (PTR_ERR(xor_dev->clk) == -EPROBE_DEFER) {
-		ret = EPROBE_DEFER;
+		ret = -EPROBE_DEFER;
 		goto disable_reg_clk;
 	}
 	if (!IS_ERR(xor_dev->clk)) {
-- 
2.39.2



