Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2D978727E
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjHXOyg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241851AbjHXOyH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:54:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAA919AA
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:54:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B5F766EF4
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B34EC433C8;
        Thu, 24 Aug 2023 14:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888843;
        bh=jgCiaBKJQgxBf3US+CRmAqYV5DSPmm6vOb6jkjH4cro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YvR0TcX4SMozAdi9fcpLIOfuG3sONbP8ND1dIU7JT0APjNdMX5Em+VQSOfpd5slPg
         yurCkRLiTPMPce/jK2tHMzbvVxACzzfvTR4zjg3CgxeiaSEQrvH5IWmQo2xxOo9Ogi
         3nKilTJLW02iDVcxWJWEbmyNuOMJ8J5qli/gE7H0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 062/139] mmc: sunxi: fix deferred probing
Date:   Thu, 24 Aug 2023 16:49:45 +0200
Message-ID: <20230824145026.338946770@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
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

[ Upstream commit c2df53c5806cfd746dae08e07bc8c4ad247c3b70 ]

The driver overrides the error codes and IRQ0 returned by platform_get_irq()
to -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
permanently instead of the deferred probing. Switch to propagating the error
codes upstream.  Since commit ce753ad1549c ("platform: finally disallow IRQ0
in platform_get_irq() and its ilk") IRQ0 is no longer returned by those APIs,
so we now can safely ignore it...

Fixes: 2408a08583d2 ("mmc: sunxi-mmc: Handle return value of platform_get_irq")
Cc: stable@vger.kernel.org # v5.19+
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Link: https://lore.kernel.org/r/20230617203622.6812-12-s.shtylyov@omp.ru
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sunxi-mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 032f2c03e8fb0..3c213816db786 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1341,8 +1341,8 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 		return ret;
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0) {
-		ret = -EINVAL;
+	if (host->irq < 0) {
+		ret = host->irq;
 		goto error_disable_mmc;
 	}
 
-- 
2.40.1



