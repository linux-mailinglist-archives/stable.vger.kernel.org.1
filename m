Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B37E79B83E
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242443AbjIKU55 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbjIKNym (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:54:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA12FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:54:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58A4C433C8;
        Mon, 11 Sep 2023 13:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440478;
        bh=0kv8ppBhLIaGdi02fvUtQm9ITZrHaXG02QXdxVnuTUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0tqmQz1anStBSF9AIobR6/I5h0bnJXHUXOM49bcFBx0j+1L4lJM3y6y2p230UBmGy
         NilxrnTcZpw+uhJ9hT/868YP13As97ImEalnQ0UB6GJeJ9f2e/whSwPn01VWi+zt6a
         yzKbXa8VrDB9pCmm1+Yv/uOBL1mHVXVlOp84kCOU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin Kaiser <martin@kaiser.cx>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 075/739] hwrng: nomadik - keep clock enabled while hwrng is registered
Date:   Mon, 11 Sep 2023 15:37:54 +0200
Message-ID: <20230911134653.210751894@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kaiser <martin@kaiser.cx>

[ Upstream commit 039980de89dc9dd757418d6f296e4126cc3f86c3 ]

The nomadik driver uses devres to register itself with the hwrng core,
the driver will be unregistered from hwrng when its device goes out of
scope. This happens after the driver's remove function is called.

However, nomadik's clock is disabled in the remove function. There's a
short timeframe where nomadik is still registered with the hwrng core
although its clock is disabled. I suppose the clock must be active to
access the hardware and serve requests from the hwrng core.

Switch to devm_clk_get_enabled and let devres disable the clock and
unregister the hwrng. This avoids the race condition.

Fixes: 3e75241be808 ("hwrng: drivers - Use device-managed registration API")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/nomadik-rng.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/char/hw_random/nomadik-rng.c b/drivers/char/hw_random/nomadik-rng.c
index e8f9621e79541..3774adf903a83 100644
--- a/drivers/char/hw_random/nomadik-rng.c
+++ b/drivers/char/hw_random/nomadik-rng.c
@@ -13,8 +13,6 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 
-static struct clk *rng_clk;
-
 static int nmk_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
 	void __iomem *base = (void __iomem *)rng->priv;
@@ -36,21 +34,20 @@ static struct hwrng nmk_rng = {
 
 static int nmk_rng_probe(struct amba_device *dev, const struct amba_id *id)
 {
+	struct clk *rng_clk;
 	void __iomem *base;
 	int ret;
 
-	rng_clk = devm_clk_get(&dev->dev, NULL);
+	rng_clk = devm_clk_get_enabled(&dev->dev, NULL);
 	if (IS_ERR(rng_clk)) {
 		dev_err(&dev->dev, "could not get rng clock\n");
 		ret = PTR_ERR(rng_clk);
 		return ret;
 	}
 
-	clk_prepare_enable(rng_clk);
-
 	ret = amba_request_regions(dev, dev->dev.init_name);
 	if (ret)
-		goto out_clk;
+		return ret;
 	ret = -ENOMEM;
 	base = devm_ioremap(&dev->dev, dev->res.start,
 			    resource_size(&dev->res));
@@ -64,15 +61,12 @@ static int nmk_rng_probe(struct amba_device *dev, const struct amba_id *id)
 
 out_release:
 	amba_release_regions(dev);
-out_clk:
-	clk_disable_unprepare(rng_clk);
 	return ret;
 }
 
 static void nmk_rng_remove(struct amba_device *dev)
 {
 	amba_release_regions(dev);
-	clk_disable_unprepare(rng_clk);
 }
 
 static const struct amba_id nmk_rng_ids[] = {
-- 
2.40.1



