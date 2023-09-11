Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93E079BFA2
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376444AbjIKWTl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242206AbjIKPY5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:24:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC93D8
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:24:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A596DC433C8;
        Mon, 11 Sep 2023 15:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445892;
        bh=mWGlbHWIWuug5W5Yc+SLkCTb0X8cpfcCk0tUN1YKrBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VajQ4pl4oB9vXmq9NBu5mlI7Ptq1cX+h+vf+9sFKVqrBI3eAcF6p1ATN9EgNTPSMK
         o/cFR3aU8ObnmOq/qmfiiQjmh7sQ9VigYazI7IHTCpSBV3lc4XIc0IPQ6yWqj9S8Bk
         NvitBxjiagWXQOT2/zfSzjnRqXPjBt3uypzSYPEE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 508/600] leds: Fix BUG_ON check for LED_COLOR_ID_MULTI that is always false
Date:   Mon, 11 Sep 2023 15:49:01 +0200
Message-ID: <20230911134648.613915667@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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



