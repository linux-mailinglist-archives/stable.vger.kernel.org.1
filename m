Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F70B783308
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjHUT7a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjHUT7a (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:59:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0571F128
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:59:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F59D64721
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC94C433C7;
        Mon, 21 Aug 2023 19:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647964;
        bh=ayBJRZCvt2084hc1IRrtsSpfdEvtOtwkL+oa3E/MWV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDPVguhFxW2k/OGCjVSKcDSp8ftQjxXJUmC+1YPhHPkaxGFpLNlQVswXcZ9L1O2U0
         rXdwd13yBHfVO2Aqmfni+twOPo/6E6rHZk/nbby4TEsVn9uPny+SO30tOxiJCcRT97
         IHD23GB+Zjm9I+WgiJINbm/ss16YeAO8eC9UnWZk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Yangtao Li <frank.li@vivo.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.1 194/194] mmc: f-sdh30: fix order of function calls in sdhci_f_sdh30_remove
Date:   Mon, 21 Aug 2023 21:42:53 +0200
Message-ID: <20230821194131.233840269@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
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
 


