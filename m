Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825627ED28C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbjKOTk6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbjKOTku (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:40:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6EED7A
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:40:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9341BC433C7;
        Wed, 15 Nov 2023 19:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077246;
        bh=nfxFBvV+VAhr9TwZb9eCBZfkyUsZ2R2EcQcvOSKhob8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUCRprTgAshA9reBw1DxNNqyGr35Ml/1EWcLHkri7lNz1JHUBl+b80rTCqaEB+ADZ
         3H8vk2/R17amf0Na9qzwgDlWZQG9hMKtnVPqzxXw6RwbHqkFXZcbAP7q+6ApyKV2Z1
         1nLjh3nLiPF0vDP4T7V3tFEH7dek0z0rtoiuWUJA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 166/603] gpio: sim: initialize a managed pointer when declaring it
Date:   Wed, 15 Nov 2023 14:11:51 -0500
Message-ID: <20231115191624.683273514@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[ Upstream commit 9f93f18305f5777820491e6ab9b34422c160371b ]

Variables managed with __free() should typically be initialized where
they are declared so that the __free() callback is paired with its
counterpart resource allocator. Fix the second instance of using
__free() in gpio-sim to follow this pattern.

Fixes: 3faf89f27aab ("gpio: sim: simplify code with cleanup helpers")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-sim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 44bf1709a6488..a8e5ac95cf170 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -1438,10 +1438,10 @@ static const struct config_item_type gpio_sim_device_config_group_type = {
 static struct config_group *
 gpio_sim_config_make_device_group(struct config_group *group, const char *name)
 {
-	struct gpio_sim_device *dev __free(kfree) = NULL;
 	int id;
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	struct gpio_sim_device *dev __free(kfree) = kzalloc(sizeof(*dev),
+							    GFP_KERNEL);
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.42.0



