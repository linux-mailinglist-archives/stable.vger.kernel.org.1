Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C86C73EA3A
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjFZSor (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjFZSon (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:44:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7198810B
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:44:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFA2D60F51
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8A1C433C8;
        Mon, 26 Jun 2023 18:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687805081;
        bh=pQns4SttK3iPAYZKZeTvQ+NlSsNOrLEhqmKRuHUQxPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HXL27W1pwZoJStlB27nX6ntpcDTUV2X8hCHlfrkHyGXc+tmyT2ARWeMTu1gn1NVEK
         zgVBSwluXyLM1Wvs4Ztk9GkY2BfZqEJyH8vcikZYeiz60e5v8xOJW2fH68rhdvyr35
         W3tjpDi3DSza/3IWJTuAm9euOxG+CvDCqULlO1Yc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 44/81] mmc: omap: fix deferred probing
Date:   Mon, 26 Jun 2023 20:12:26 +0200
Message-ID: <20230626180746.274460594@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180744.453069285@linuxfoundation.org>
References: <20230626180744.453069285@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sergey Shtylyov <s.shtylyov@omp.ru>

[ Upstream commit aedf4ba1ad00aaa94c1b66c73ecaae95e2564b95 ]

The driver overrides the error codes returned by platform_get_irq() to
-ENXIO, so if it returns -EPROBE_DEFER, the driver will fail the probe
permanently instead of the deferred probing. Switch to propagating the
error codes upstream.

Fixes: 9ec36cafe43b ("of/irq: do irq resolution in platform_get_irq")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/20230617203622.6812-6-s.shtylyov@omp.ru
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 6aa0537f1f847..eb978b75d8e78 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1344,7 +1344,7 @@ static int mmc_omap_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return -ENXIO;
+		return irq;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->virt_base = devm_ioremap_resource(&pdev->dev, res);
-- 
2.39.2



