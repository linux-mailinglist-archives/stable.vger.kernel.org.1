Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A58C7831CD
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjHUUKL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjHUUKL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:10:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EE7129
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84A2064AC2
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDA3C433C8;
        Mon, 21 Aug 2023 20:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648606;
        bh=o7nT4Zrc1pDIbDcfBFItJZFhhUBPPU/8IOFgmQrSO58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qSMBwxSMldk4/SR15q1N1HsHcGFTIcg4XXIH6VdU45h7TIaSmJWupHfTBTu0eNYls
         7UrguMwXUKd9LFBzRSTtGOWlINTTu/frExUrix/+cudavPqfkQyJewa4AyVDo5wpKh
         V6z7hEapeKQY0LDx5HtbXt84ARxxJ/xnh6u78Qz4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.4 219/234] mmc: sunplus: Fix error handling in spmmc_drv_probe()
Date:   Mon, 21 Aug 2023 21:43:02 +0200
Message-ID: <20230821194138.557036328@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
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

From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

commit cf3f15b8c6601c1dc70f85949788ee993dd9a439 upstream.

When mmc allocation succeeds, the error paths are not freeing mmc.

Fix the above issue by changing mmc_alloc_host() to devm_mmc_alloc_host()
to simplify the error handling. Remove label 'probe_free_host' as devm_*
api takes care of freeing, also remove mmc_free_host() from remove
function as devm_* takes care of freeing.

Fixes: 4e268fed8b18 ("mmc: Add mmc driver for Sunplus SP7021")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/a3829ed3-d827-4b9d-827e-9cc24a3ec3bc@moroto.mountain/
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230809071812.547229-1-harshit.m.mogalapalli@oracle.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sunplus-mmc.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
index a55a87f64d2a..2bdebeb1f8e4 100644
--- a/drivers/mmc/host/sunplus-mmc.c
+++ b/drivers/mmc/host/sunplus-mmc.c
@@ -863,11 +863,9 @@ static int spmmc_drv_probe(struct platform_device *pdev)
 	struct spmmc_host *host;
 	int ret = 0;
 
-	mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
-		goto probe_free_host;
-	}
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(struct spmmc_host));
+	if (!mmc)
+		return -ENOMEM;
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
@@ -938,11 +936,6 @@ static int spmmc_drv_probe(struct platform_device *pdev)
 
 clk_disable:
 	clk_disable_unprepare(host->clk);
-
-probe_free_host:
-	if (mmc)
-		mmc_free_host(mmc);
-
 	return ret;
 }
 
@@ -956,7 +949,6 @@ static int spmmc_drv_remove(struct platform_device *dev)
 	pm_runtime_put_noidle(&dev->dev);
 	pm_runtime_disable(&dev->dev);
 	platform_set_drvdata(dev, NULL);
-	mmc_free_host(host->mmc);
 
 	return 0;
 }
-- 
2.41.0



