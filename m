Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDBA73E97B
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjFZSgd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjFZSgc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:36:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660E8AC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:36:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAE9360F24
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3097C433C8;
        Mon, 26 Jun 2023 18:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804590;
        bh=pzvipQI5gdM4zQa8rxd2UayZ8f9PGI24eOKOoeY5FXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EZlrKyLrkaId52niMwcxi0tAPighbx0mtVYD3O0G2Uh/erq3x16uye4YvcojBYPbl
         QkyRCuYEWIPucXXDsAc/J5QLQqLlDB2dieo/hXg6W4H57cq8E7z1YyrUEHvj68/Ys/
         UXVAwvMa/t/H/GPs2wVKmvkF2PhC2KCswyy0l6LI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 36/60] mmc: usdhi60rol0: fix deferred probing
Date:   Mon, 26 Jun 2023 20:12:15 +0200
Message-ID: <20230626180741.003871337@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180739.558575012@linuxfoundation.org>
References: <20230626180739.558575012@linuxfoundation.org>
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

[ Upstream commit 413db499730248431c1005b392e8ed82c4fa19bf ]

The driver overrides the error codes returned by platform_get_irq_byname()
to -ENODEV, so if it returns -EPROBE_DEFER, the driver will fail the probe
permanently instead of the deferred probing.  Switch to propagating error
codes upstream.

Fixes: 9ec36cafe43b ("of/irq: do irq resolution in platform_get_irq")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/20230617203622.6812-13-s.shtylyov@omp.ru
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/usdhi6rol0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 96b0f81a20322..56d131183c1e4 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1743,8 +1743,10 @@ static int usdhi6_probe(struct platform_device *pdev)
 	irq_cd = platform_get_irq_byname(pdev, "card detect");
 	irq_sd = platform_get_irq_byname(pdev, "data");
 	irq_sdio = platform_get_irq_byname(pdev, "SDIO");
-	if (irq_sd < 0 || irq_sdio < 0)
-		return -ENODEV;
+	if (irq_sd < 0)
+		return irq_sd;
+	if (irq_sdio < 0)
+		return irq_sdio;
 
 	mmc = mmc_alloc_host(sizeof(struct usdhi6_host), dev);
 	if (!mmc)
-- 
2.39.2



