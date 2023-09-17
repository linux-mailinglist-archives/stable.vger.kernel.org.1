Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48927A37A3
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbjIQTXM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239478AbjIQTWs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:22:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324A9DB
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:22:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BFCC433CC;
        Sun, 17 Sep 2023 19:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978562;
        bh=S4H5XDjPzZOnTQWh++bzDZvrrIS2CotBLe4yxfDUBws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dMko4KqwsJSShVxMK9JNIbiONGDZWTjXsZ/r3/0vWwXfWjmcNxcnXRCrf4FQr017E
         tGPZNdfNZ6GeM4y6L4rbVtQTc+hLPisiSLJj2EAUmUvgxeWoXLHdlYxPZJMhYgsSJR
         oAy+fm5UWE5oHUdT+9i49BZenhGSNYNB0GmpqvS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 095/406] crypto: stm32 - Properly handle pm_runtime_get failing
Date:   Sun, 17 Sep 2023 21:09:09 +0200
Message-ID: <20230917191103.638489100@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit aec48805163338f8413118796c1dd035661b9140 ]

If pm_runtime_get() (disguised as pm_runtime_resume_and_get()) fails, this
means the clk wasn't prepared and enabled. Returning early in this case
however is wrong as then the following resource frees are skipped and this
is never catched up. So do all the cleanups but clk_disable_unprepare().

Also don't emit a warning, as stm32_hash_runtime_resume() already emitted
one.

Note that the return value of stm32_hash_remove() is mostly ignored by
the device core. The only effect of returning zero instead of an error
value is to suppress another warning in platform_remove(). So return 0
even if pm_runtime_resume_and_get() failed.

Fixes: 8b4d566de6a5 ("crypto: stm32/hash - Add power management support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/stm32/stm32-hash.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index 16bb52836b28d..2f2a426a6cd5c 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -1565,9 +1565,7 @@ static int stm32_hash_remove(struct platform_device *pdev)
 	if (!hdev)
 		return -ENODEV;
 
-	ret = pm_runtime_resume_and_get(hdev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_sync(hdev->dev);
 
 	stm32_hash_unregister_algs(hdev);
 
@@ -1583,7 +1581,8 @@ static int stm32_hash_remove(struct platform_device *pdev)
 	pm_runtime_disable(hdev->dev);
 	pm_runtime_put_noidle(hdev->dev);
 
-	clk_disable_unprepare(hdev->clk);
+	if (ret >= 0)
+		clk_disable_unprepare(hdev->clk);
 
 	return 0;
 }
-- 
2.40.1



