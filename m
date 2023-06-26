Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C5973E7BF
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjFZSS0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjFZSS0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:18:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2FC99
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:18:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF75860F40
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4ECC433C0;
        Mon, 26 Jun 2023 18:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803504;
        bh=5u1krze54Vr3YCW2gn+XDn86yQzfX3k9QSKmUf/cDRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cgJ3nrJ/+6MvWmQcVNlaV/V8JSpVSDjMyQ50S0B1dsv7q102ONvID4qNEE4q7Frz9
         tS3WHRc7dpCy5GNqaNUtinyP2/HZ2w3cLbTdrKP/nuGnLNR0gX8nuUwRcrRrXV0okW
         hDPk3sw3/t3rnjmlP0u33gqKTNxOKbHYzLdZ7ErM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.3 083/199] mmc: bcm2835: fix deferred probing
Date:   Mon, 26 Jun 2023 20:09:49 +0200
Message-ID: <20230626180809.233568844@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

commit 71150ac12558bcd9d75e6e24cf7c872c2efd80f3 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/bcm2835.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1403,8 +1403,8 @@ static int bcm2835_probe(struct platform
 	host->max_clk = clk_get_rate(clk);
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0) {
-		ret = -EINVAL;
+	if (host->irq < 0) {
+		ret = host->irq;
 		goto err;
 	}
 


