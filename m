Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BD077ACDA
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjHMVhw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjHMVhv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:37:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0451210DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:37:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FD59634D1
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4E3C433C8;
        Sun, 13 Aug 2023 21:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962673;
        bh=mwXPl1fmAk2/6qni2eX1lhVECipL2FkQkp6jb5pWnZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NuNk71EC3hXqI4ZiWJrXmrGOmbraJcHTJ8TRYQBQbp/u04xAsFh86pbLuDSB8zJIa
         bqov1zAU05BQcj9oKc/keistSv7bPVP7pfGchCd4zSyxWO2slRyonheOLoQ6wn4XkG
         QrmV+0h60DT6W99Z3VGzk3SDieII8bN7cD4rfw6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.1 114/149] dmaengine: mcf-edma: Fix a potential un-allocated memory access
Date:   Sun, 13 Aug 2023 23:19:19 +0200
Message-ID: <20230813211722.160736561@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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


