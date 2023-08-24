Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A77787353
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 17:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242031AbjHXPCM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 11:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236349AbjHXPB7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 11:01:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B64CC
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 08:01:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 714BA624B7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 15:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DDDC433C7;
        Thu, 24 Aug 2023 15:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889316;
        bh=aDpB3OaRvrB7O2Z9HZD08X2koNwzi92/PheiDRjOymI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l6Sl32H22JI3kyvOyQeDTw3hYQCFk/vZuWeDQFbjnuBHciLmgS+PRFhFndK7ifF1N
         GLokLoOOilzb2LA0WyZNJC247t8Cmp1jTr51FFqLvyg+LcOAfk72gUPTvhiuG02gyC
         l2vkXiDFZNuAmMYo7zlGD151MkSmO5ufc/xL8b7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 063/135] mmc: meson-gx: fix deferred probing
Date:   Thu, 24 Aug 2023 16:50:06 +0200
Message-ID: <20230824145029.600735914@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145027.008282920@linuxfoundation.org>
References: <20230824145027.008282920@linuxfoundation.org>
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

From: Sergey Shtylyov <s.shtylyov@omp.ru>

[ Upstream commit b8ada54fa1b83f3b6480d4cced71354301750153 ]

The driver overrides the error codes and IRQ0 returned by platform_get_irq()
to -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
permanently instead of the deferred probing. Switch to propagating the error
codes upstream.  Since commit ce753ad1549c ("platform: finally disallow IRQ0
in platform_get_irq() and its ilk") IRQ0 is no longer returned by those APIs,
so we now can safely ignore it...

Fixes: cbcaac6d7dd2 ("mmc: meson-gx-mmc: Fix platform_get_irq's error checking")
Cc: stable@vger.kernel.org # v5.19+
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20230617203622.6812-3-s.shtylyov@omp.ru
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/meson-gx-mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 8a345ee2e6cf5..1992eea8b777e 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1159,8 +1159,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
 		return PTR_ERR(host->regs);
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0)
-		return -EINVAL;
+	if (host->irq < 0)
+		return host->irq;
 
 	host->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (IS_ERR(host->pinctrl))
-- 
2.40.1



