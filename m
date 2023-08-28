Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E7F78AC23
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjH1KhO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjH1KhB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:37:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F207BA6
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FEAB63ED4
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4024C433C8;
        Mon, 28 Aug 2023 10:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219018;
        bh=EWcAo6XtNI93+XLON91byq2cmpTW1NlRVD5sYLs1Fo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWSAwrzxxdJtYH5rzVQ6ycnWxxKYAec3kdUnFnkR5mtIDgELdMx1Sj4/2I2JpsrOd
         tXW/5XAc3+CeOiaOl+JsN+7g6dwZn6mq5TNBCqDrFF96DXU2GmJwVSYngzBG55R2l2
         u4m0iZbe6G2xo6fM8U33aI5dJ5KhqkQAotxfk090=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 044/158] mmc: bcm2835: fix deferred probing
Date:   Mon, 28 Aug 2023 12:12:21 +0200
Message-ID: <20230828101158.817680940@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 148414d7f0c9d..d20943e433127 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1408,8 +1408,8 @@ static int bcm2835_probe(struct platform_device *pdev)
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



