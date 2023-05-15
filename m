Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21222703A0C
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243278AbjEORru (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244750AbjEORrf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:47:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623BA18AA8
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:46:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3F9662EC4
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3058C433EF;
        Mon, 15 May 2023 17:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172774;
        bh=6dOhzkgCy06Vv2qJsKWke3On47RrByfCAYURwYKOJN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cIQ+3MBc9FgftfXHFmLwUDaBYTCuqSbDvH0Mk3atwY+eb+GNwCJ+ltuZNDgZpxQ43
         KOBfpAIgt7xKiHI7Il84caZCf/PJJbumvrnP4Q6mYmqGwv5+WTKRwumQqw46+W8kqB
         HXDLIsqMrsAv1olVmAGxuri6ppr0Pz8suXfGpGLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 263/381] dmaengine: mv_xor_v2: Fix an error code.
Date:   Mon, 15 May 2023 18:28:34 +0200
Message-Id: <20230515161748.621221585@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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
index 4800c596433ad..9f3e011fbd914 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -756,7 +756,7 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 
 	xor_dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (PTR_ERR(xor_dev->clk) == -EPROBE_DEFER) {
-		ret = EPROBE_DEFER;
+		ret = -EPROBE_DEFER;
 		goto disable_reg_clk;
 	}
 	if (!IS_ERR(xor_dev->clk)) {
-- 
2.39.2



