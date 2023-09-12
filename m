Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E584079BE9F
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357867AbjIKWGk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239835AbjIKOaB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:30:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75798F0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:29:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C7DC433C7;
        Mon, 11 Sep 2023 14:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442597;
        bh=3bL5SEGdIm33bdeR9cv8ESqwUKrdY0qcDhdYnvGvMcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fqB7wDOsv3X1XcewPr9CCYHbhPQYSFd3E6FN8tIySjG28htNCLuF5mVVqo9QR/coC
         PMAkm2n5l9/bsp8JplA4RZbwUuMq3lCPYM7NQ8h2g6SsrMrN45byhM+ullz3RdVFWF
         DBAdOjmi0B6mJtM5UOlInHaZLSeLGUtIBSSEeqp8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 080/737] gpiolib: fix reference leaks when removing GPIO chips still in use
Date:   Mon, 11 Sep 2023 15:38:59 +0200
Message-ID: <20230911134652.746505575@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[ Upstream commit 3386fb86ecdef0d39ee3306aea8ec290e61b934f ]

After we remove a GPIO chip that still has some requested descriptors,
gpiod_free_commit() will fail and we will never put the references to the
GPIO device and the owning module in gpiod_free().

Rework this function to:
- not warn on desc == NULL as this is a use-case on which most free
  functions silently return
- put the references to desc->gdev and desc->gdev->owner unconditionally
  so that the release callback actually gets called when the remaining
  references are dropped by external GPIO users

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 5be8ad61523eb..6e7701f80929f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2175,12 +2175,18 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 
 void gpiod_free(struct gpio_desc *desc)
 {
-	if (desc && desc->gdev && gpiod_free_commit(desc)) {
-		module_put(desc->gdev->owner);
-		gpio_device_put(desc->gdev);
-	} else {
+	/*
+	 * We must not use VALIDATE_DESC_VOID() as the underlying gdev->chip
+	 * may already be NULL but we still want to put the references.
+	 */
+	if (!desc)
+		return;
+
+	if (!gpiod_free_commit(desc))
 		WARN_ON(extra_checks);
-	}
+
+	module_put(desc->gdev->owner);
+	gpio_device_put(desc->gdev);
 }
 
 /**
-- 
2.40.1



