Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09ED77AD1C
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjHMVsG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjHMVpb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:45:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935052D57
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:45:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27A7960CA3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E45C433C8;
        Sun, 13 Aug 2023 21:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963129;
        bh=mwXPl1fmAk2/6qni2eX1lhVECipL2FkQkp6jb5pWnZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CPTaCsSSFCsMVdYxM+PouHzsMaDXehk4lZzd4WcgkT4S3g/+GKtl2DOQO0WqoSrIr
         CD/6OjDwTZlXUSHQNI16RP6MZL0SY2a07jo7RtKqLQs9dj5m/D4sKf87kq9v10hKlL
         Xl1aga277tC56ecG3yyuiE2Wk3kYtjr/K4H6jmQ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.15 64/89] dmaengine: mcf-edma: Fix a potential un-allocated memory access
Date:   Sun, 13 Aug 2023 23:19:55 +0200
Message-ID: <20230813211712.706569285@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
References: <20230813211710.787645394@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 0a46781c89dece85386885a407244ca26e5c1c44 upstream.

When 'mcf_edma' is allocated, some space is allocated for a
flexible array at the end of the struct. 'chans' item are allocated, that is
to say 'pdata->dma_channels'.

Then, this number of item is stored in 'mcf_edma->n_chans'.

A few lines later, if 'mcf_edma->n_chans' is 0, then a default value of 64
is set.

This ends to no space allocated by devm_kzalloc() because chans was 0, but
64 items are read and/or written in some not allocated memory.

Change the logic to define a default value before allocating the memory.

Fixes: e7a3ff92eaf1 ("dmaengine: fsl-edma: add ColdFire mcf5441x edma support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/f55d914407c900828f6fad3ea5fa791a5f17b9a4.1685172449.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/mcf-edma.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/dma/mcf-edma.c
+++ b/drivers/dma/mcf-edma.c
@@ -191,7 +191,13 @@ static int mcf_edma_probe(struct platfor
 		return -EINVAL;
 	}
 
-	chans = pdata->dma_channels;
+	if (!pdata->dma_channels) {
+		dev_info(&pdev->dev, "setting default channel number to 64");
+		chans = 64;
+	} else {
+		chans = pdata->dma_channels;
+	}
+
 	len = sizeof(*mcf_edma) + sizeof(*mcf_chan) * chans;
 	mcf_edma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
 	if (!mcf_edma)
@@ -203,11 +209,6 @@ static int mcf_edma_probe(struct platfor
 	mcf_edma->drvdata = &mcf_data;
 	mcf_edma->big_endian = 1;
 
-	if (!mcf_edma->n_chans) {
-		dev_info(&pdev->dev, "setting default channel number to 64");
-		mcf_edma->n_chans = 64;
-	}
-
 	mutex_init(&mcf_edma->fsl_edma_mutex);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);


