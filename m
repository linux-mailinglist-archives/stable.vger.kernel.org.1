Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8B87872CA
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241890AbjHXO5R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241943AbjHXO4z (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:56:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0229E10D7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:56:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 928BB66FD3
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A4DC433C7;
        Thu, 24 Aug 2023 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889009;
        bh=ayBJRZCvt2084hc1IRrtsSpfdEvtOtwkL+oa3E/MWV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rGx8rpUUslWCXKCLaVpzGx+UuC8siNuuZx3jdnXPm2aCGSpvKkq/uwhOvBaWHzxJJ
         tpQQd3G4FJ32x9NmaVGDRDtTjyGSuBf0a0LqCP29jaCQFtNnOzd5AW8TKkweBj+Ta4
         an65rw+ySkjWZe7LVaVTF6jL7KN4WmeOCRdpUDBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Yangtao Li <frank.li@vivo.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.15 122/139] mmc: f-sdh30: fix order of function calls in sdhci_f_sdh30_remove
Date:   Thu, 24 Aug 2023 16:50:45 +0200
Message-ID: <20230824145028.800092574@linuxfoundation.org>
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

From: Yangtao Li <frank.li@vivo.com>

commit 58abdd80b93b09023ca03007b608685c41e3a289 upstream.

The order of function calls in sdhci_f_sdh30_remove is wrong,
let's call sdhci_pltfm_unregister first.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Fixes: 5def5c1c15bf ("mmc: sdhci-f-sdh30: Replace with sdhci_pltfm")
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230727070051.17778-62-frank.li@vivo.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci_f_sdh30.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -188,12 +188,14 @@ static int sdhci_f_sdh30_remove(struct p
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
-
-	clk_disable_unprepare(priv->clk_iface);
-	clk_disable_unprepare(priv->clk);
+	struct clk *clk_iface = priv->clk_iface;
+	struct clk *clk = priv->clk;
 
 	sdhci_pltfm_unregister(pdev);
 
+	clk_disable_unprepare(clk_iface);
+	clk_disable_unprepare(clk);
+
 	return 0;
 }
 


