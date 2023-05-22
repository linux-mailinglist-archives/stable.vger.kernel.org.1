Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D17770C771
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbjEVT3w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjEVT3m (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:29:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3EFE6D
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:29:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41AF8628E7
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DD1C433D2;
        Mon, 22 May 2023 19:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783772;
        bh=CFe4jZ94ZwfiV/sRR5khwLMjqiAHz2p7daKcheLukNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+aTRVYxSpIMo+5FyRkgZ1Oc/q5BSMBFPYZbI6FRJelRq7g9LH7J4z3LaFU2U7tqS
         wh/MlsqWfbJ8gm6WbT9L4z95ySMd5erjV5P+9ye0jywvaksqxMEt9jj765CuXxmrkh
         czKFug6KqA6parx2VgFxtJQdBKqBx48bkMMPQXr4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 158/292] platform: Provide a remove callback that returns no value
Date:   Mon, 22 May 2023 20:08:35 +0100
Message-Id: <20230522190409.912899657@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 5c5a7680e67ba6fbbb5f4d79fa41485450c1985c ]

struct platform_driver::remove returning an integer made driver authors
expect that returning an error code was proper error handling. However
the driver core ignores the error and continues to remove the device
because there is nothing the core could do anyhow and reentering the
remove callback again is only calling for trouble.

So this is an source for errors typically yielding resource leaks in the
error path.

As there are too many platform drivers to neatly convert them all to
return void in a single go, do it in several steps after this patch:

 a) Convert all drivers to implement .remove_new() returning void instead
    of .remove() returning int;
 b) Change struct platform_driver::remove() to return void and so make
    it identical to .remove_new();
 c) Change all drivers back to .remove() now with the better prototype;
 d) drop struct platform_driver::remove_new().

While this touches all drivers eventually twice, steps a) and c) can be
done one driver after another and so reduces coordination efforts
immensely and simplifies review.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20221209150914.3557650-1-u.kleine-koenig@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 17955aba7877 ("ASoC: fsl_micfil: Fix error handler with pm_runtime_enable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/platform.c         |  4 +++-
 include/linux/platform_device.h | 11 +++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 51bb2289865c7..3a06c214ca1c6 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1416,7 +1416,9 @@ static void platform_remove(struct device *_dev)
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
 	struct platform_device *dev = to_platform_device(_dev);
 
-	if (drv->remove) {
+	if (drv->remove_new) {
+		drv->remove_new(dev);
+	} else if (drv->remove) {
 		int ret = drv->remove(dev);
 
 		if (ret)
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index b0d5a253156ec..b845fd83f429b 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -207,7 +207,18 @@ extern void platform_device_put(struct platform_device *pdev);
 
 struct platform_driver {
 	int (*probe)(struct platform_device *);
+
+	/*
+	 * Traditionally the remove callback returned an int which however is
+	 * ignored by the driver core. This led to wrong expectations by driver
+	 * authors who thought returning an error code was a valid error
+	 * handling strategy. To convert to a callback returning void, new
+	 * drivers should implement .remove_new() until the conversion it done
+	 * that eventually makes .remove() return void.
+	 */
 	int (*remove)(struct platform_device *);
+	void (*remove_new)(struct platform_device *);
+
 	void (*shutdown)(struct platform_device *);
 	int (*suspend)(struct platform_device *, pm_message_t state);
 	int (*resume)(struct platform_device *);
-- 
2.39.2



