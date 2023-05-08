Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0006FADAB
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbjEHLgu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbjEHLgc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:36:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E083F572
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C94656329C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13CBC433EF;
        Mon,  8 May 2023 11:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545732;
        bh=qwIcqWWnU9Qw3W81wBr5G21cmfWVGr3KNvoRIR0R69I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=joW7fj8YQ7Z37oAfBuIc6xiMUFcZQkRdwFUbA6pfURe81KNaeg48XG1alyYsrgEkU
         E3+YU2Y6jn5BNamofSNZe4yq67KPH+r5ULa/mwOCLj73snztcJinRTKUf1856RSbY1
         RWfGzyJgVCO4eRzw4OkqMmwmzRVAKVhJkR+1XHow=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 136/371] platform: Provide a remove callback that returns no value
Date:   Mon,  8 May 2023 11:45:37 +0200
Message-Id: <20230508094817.443720522@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
Stable-dep-of: c766c90faf93 ("media: rcar_fdp1: Fix refcount leak in probe and remove function")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/platform.c         |  4 +++-
 include/linux/platform_device.h | 11 +++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 652531f67135a..ac5cf1a8d79ab 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1427,7 +1427,9 @@ static void platform_remove(struct device *_dev)
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
 	struct platform_device *dev = to_platform_device(_dev);
 
-	if (drv->remove) {
+	if (drv->remove_new) {
+		drv->remove_new(dev);
+	} else if (drv->remove) {
 		int ret = drv->remove(dev);
 
 		if (ret)
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 7c96f169d2740..8aefdc0099c86 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -203,7 +203,18 @@ extern void platform_device_put(struct platform_device *pdev);
 
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



