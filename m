Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7E96FA8CC
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbjEHKpb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbjEHKpL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:45:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB3327F17
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:44:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 529AE62870
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434B0C433EF;
        Mon,  8 May 2023 10:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542640;
        bh=cJxbrZfrrGZx450lTtkk/L2AgLRoHvlx4qXGzT0h1CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dyn9uU09dth4WA7PIylWHakSKGCGYdg1rv6KGHk9on8Avbs4ykatpJuGXJRcyDM7z
         hID0NpMvGGWcAwQNd7aHDA8iaHHk78ZGW9BrJOPweWvP9vAYnno1+KNN5b4Bxwtkvl
         iOxpMxoJCn0Qu5atlZV2PuvWXdNoIKJNl10CxEgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 501/663] fbdev: mmp: Fix deferred clk handling in mmphw_probe()
Date:   Mon,  8 May 2023 11:45:27 +0200
Message-Id: <20230508094444.814201311@linuxfoundation.org>
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

[ Upstream commit b3a7a9ab65ae2f2626c7222fb79cdd433f8c5252 ]

When dev_err_probe() is called, 'ret' holds the value of the previous
successful devm_request_irq() call.
'ret' should be assigned with a meaningful value before being used in
dev_err_probe().

While at it, use and return "PTR_ERR(ctrl->clk)" instead of a hard-coded
"-ENOENT" so that -EPROBE_DEFER is handled and propagated correctly.

Fixes: 81b63420564d ("fbdev: mmp: Make use of the helper function dev_err_probe()")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
index a9df8ee798102..51fbf02a03430 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
@@ -514,9 +514,9 @@ static int mmphw_probe(struct platform_device *pdev)
 	/* get clock */
 	ctrl->clk = devm_clk_get(ctrl->dev, mi->clk_name);
 	if (IS_ERR(ctrl->clk)) {
+		ret = PTR_ERR(ctrl->clk);
 		dev_err_probe(ctrl->dev, ret,
 			      "unable to get clk %s\n", mi->clk_name);
-		ret = -ENOENT;
 		goto failed;
 	}
 	clk_prepare_enable(ctrl->clk);
-- 
2.39.2



