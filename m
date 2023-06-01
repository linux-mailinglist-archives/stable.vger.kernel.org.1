Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7A8719E17
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjFAN3H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjFAN2q (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:28:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40E1E57
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:28:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7C35644E0
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5831C433EF;
        Thu,  1 Jun 2023 13:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626103;
        bh=uJ8L7AO4wzVHur2033HwHSDDb6sceRbhHHm6R832R2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O5dhTmtHhhyMF7sCtN4B+eh6h9aKf0uSKqnGRnM/XoQ/z9s/icFCAorLTrFHFSD2j
         a2avTrZEkK4Is5h+dnNBv6HXmChKP4Ir7YjEUN8yTh8Hj4dec0GWrEbQ+P6nEEJ/iW
         kQZ1r37XuRsQ6CTmMeTur0v3BGE8/BMrkyIBgZ+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 31/42] dmaengine: at_xdmac: disable/enable clock directly on suspend/resume
Date:   Thu,  1 Jun 2023 14:21:40 +0100
Message-Id: <20230601131940.438303233@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit 2de5ddb5e68c94b781b3789bca1ce52000d7d0e0 ]

Runtime PM APIs for at_xdmac just plays with clk_enable()/clk_disable()
letting aside the clk_prepare()/clk_unprepare() that needs to be
executed as the clock is also prepared on probe. Thus instead of using
runtime PM force suspend/resume APIs use
clk_disable_unprepare() + pm_runtime_put_noidle() on suspend and
clk_prepare_enable() + pm_runtime_get_noresume() on resume. This
approach as been chosen instead of using runtime PM force suspend/resume
with clk_unprepare()/clk_prepare() as it looks simpler and the final
code is better.

While at it added the missing pm_runtime_mark_last_busy() on suspend before
decrementing the reference counter.

Fixes: 650b0e990cbd ("dmaengine: at_xdmac: add runtime pm support")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230214151827.1050280-2-claudiu.beznea@microchip.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: 44fe8440bda5 ("dmaengine: at_xdmac: do not resume channels paused by consumers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/at_xdmac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index bfc8ae2143957..7f7557e4c31d7 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1993,6 +1993,7 @@ static int __maybe_unused atmel_xdmac_suspend(struct device *dev)
 
 	at_xdmac_off(atxdmac);
 	clk_disable_unprepare(atxdmac->clk);
+
 	return 0;
 }
 
@@ -2009,6 +2010,8 @@ static int __maybe_unused atmel_xdmac_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	pm_runtime_get_noresume(atxdmac->dev);
+
 	at_xdmac_axi_config(pdev);
 
 	/* Clear pending interrupts. */
-- 
2.39.2



