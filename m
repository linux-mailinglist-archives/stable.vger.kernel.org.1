Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9C07A3C8D
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239666AbjIQUdF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241077AbjIQUcf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:32:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2463CCC7
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:32:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513FEC433C8;
        Sun, 17 Sep 2023 20:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982727;
        bh=JXOdTE8QBhyXsxg1aD99qPJ8JK8p013Z0tOJtZkIVI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BGiS5hXK1T42MiUztQ35bT5bpIXut85RPS5eGFxuZifdDugfTz50ZNEm1VVWqLooC
         j+mPe7IcOBQvaq19scN4tUFv6HTn4mR9fTaVLoleLWRYX7GJzNFkhBJ3k5AVzZWJcu
         AJyfylKf7TL1Wlho1mGddhoeATfUwHsJvfZPjCoc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 308/511] leds: Fix BUG_ON check for LED_COLOR_ID_MULTI that is always false
Date:   Sun, 17 Sep 2023 21:12:15 +0200
Message-ID: <20230917191121.264976185@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Behún <kabel@kernel.org>

[ Upstream commit c3f853184bed04105682383c2971798c572226b5 ]

At the time we call
    BUG_ON(props.color == LED_COLOR_ID_MULTI);
the props variable is still initialized to zero.

Call the BUG_ON only after we parse fwnode into props.

Fixes: 77dce3a22e89 ("leds: disallow /sys/class/leds/*:multi:* for now")
Signed-off-by: Marek Behún <kabel@kernel.org>
Link: https://lore.kernel.org/r/20230801151623.30387-1-kabel@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/led-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index 4a97cb7457888..aad8bc44459fe 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -419,15 +419,15 @@ int led_compose_name(struct device *dev, struct led_init_data *init_data,
 	struct fwnode_handle *fwnode = init_data->fwnode;
 	const char *devicename = init_data->devicename;
 
-	/* We want to label LEDs that can produce full range of colors
-	 * as RGB, not multicolor */
-	BUG_ON(props.color == LED_COLOR_ID_MULTI);
-
 	if (!led_classdev_name)
 		return -EINVAL;
 
 	led_parse_fwnode_props(dev, fwnode, &props);
 
+	/* We want to label LEDs that can produce full range of colors
+	 * as RGB, not multicolor */
+	BUG_ON(props.color == LED_COLOR_ID_MULTI);
+
 	if (props.label) {
 		/*
 		 * If init_data.devicename is NULL, then it indicates that
-- 
2.40.1



