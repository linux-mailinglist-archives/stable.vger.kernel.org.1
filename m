Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254F278727D
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241841AbjHXOyh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241845AbjHXOyH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:54:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE4D1BD6
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:54:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50BB166EBF
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61701C433C7;
        Thu, 24 Aug 2023 14:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888840;
        bh=FrpZHTJLGrYQpFhA02gC1dQNXv1veS1RTtlq/oHNi5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x5p2gDu55Lkbv9fgSQ2oAlSk+tV559A1o+C1MtYzMdqSXGHd22gAPrk/SVo4mVPCq
         kMyK0Kb4FZKI9LfI+iiGoz5+L4lUKZ4waLnix+1dnpR5uZNbWdlcCipbmmjMy+XmW8
         ycuBpxJ2bJkePH3tGgXQBn4e4yilAHo5TouX13wQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 061/139] mmc: bcm2835: fix deferred probing
Date:   Thu, 24 Aug 2023 16:49:44 +0200
Message-ID: <20230824145026.291371275@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sergey Shtylyov <s.shtylyov@omp.ru>

[ Upstream commit 71150ac12558bcd9d75e6e24cf7c872c2efd80f3 ]

The driver overrides the error codes and IRQ0 returned by platform_get_irq()
to -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
permanently instead of the deferred probing. Switch to propagating the error
codes upstream.  Since commit ce753ad1549c ("platform: finally disallow IRQ0
in platform_get_irq() and its ilk") IRQ0 is no longer returned by those APIs,
so we now can safely ignore it...

Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost controller.")
Cc: stable@vger.kernel.org # v5.19+
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/20230617203622.6812-2-s.shtylyov@omp.ru
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/bcm2835.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 8c2361e662774..985079943be76 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1413,8 +1413,8 @@ static int bcm2835_probe(struct platform_device *pdev)
 	host->max_clk = clk_get_rate(clk);
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0) {
-		ret = -EINVAL;
+	if (host->irq < 0) {
+		ret = host->irq;
 		goto err;
 	}
 
-- 
2.40.1



