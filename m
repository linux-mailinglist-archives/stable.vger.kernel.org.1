Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25CF7BDDA1
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376690AbjJINLh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376889AbjJINLJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:11:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BBAD56
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:10:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D5AC433C8;
        Mon,  9 Oct 2023 13:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857034;
        bh=XmLt1JsT9DUeZsWZhZZ5lZGEzBGz1o8WKUaPkHbGig8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtmVRzt57xVreo7KIrKUyWTVhnU/dc+NRI/vMGEkgGORVbhXeyS2IaW3VjMGU6WHE
         GSKfn1Fvw8Ga2eFmJvnH//odTbE6xS/4NaQnTQbt2wLDlCzlRVSSDIt9FTmqDgxZ4C
         vh8+CeJopgRS7N5OULwjXgHCPnkPRyTIfZy4U6nY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Da Xue <da@libre.computer>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 074/163] leds: Drop BUG_ON check for LED_COLOR_ID_MULTI
Date:   Mon,  9 Oct 2023 15:00:38 +0200
Message-ID: <20231009130126.095937802@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Behún <kabel@kernel.org>

[ Upstream commit 9dc1664fab2246bc2c3e9bf2cf21518a857f9b5b ]

Commit c3f853184bed ("leds: Fix BUG_ON check for LED_COLOR_ID_MULTI that
is always false") fixed a no-op BUG_ON. This turned out to cause a
regression, since some in-tree device-tree files already use
LED_COLOR_ID_MULTI.

Drop the BUG_ON altogether.

Fixes: c3f853184bed ("leds: Fix BUG_ON check for LED_COLOR_ID_MULTI that is always false")
Reported-by: Da Xue <da@libre.computer>
Closes: https://lore.kernel.org/linux-leds/ZQLelWcNjjp2xndY@duo.ucw.cz/T/
Signed-off-by: Marek Behún <kabel@kernel.org>
Link: https://lore.kernel.org/r/20230918140724.18634-1-kabel@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/led-core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index 04f9ea675f2ce..214ed81eb0e92 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -479,10 +479,6 @@ int led_compose_name(struct device *dev, struct led_init_data *init_data,
 
 	led_parse_fwnode_props(dev, fwnode, &props);
 
-	/* We want to label LEDs that can produce full range of colors
-	 * as RGB, not multicolor */
-	BUG_ON(props.color == LED_COLOR_ID_MULTI);
-
 	if (props.label) {
 		/*
 		 * If init_data.devicename is NULL, then it indicates that
-- 
2.40.1



