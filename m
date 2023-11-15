Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2FB7ED4D3
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344592AbjKOU7S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344769AbjKOU6C (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:58:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA161BF4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994BBC4E755;
        Wed, 15 Nov 2023 20:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081500;
        bh=c57IkESthBvfa1dipUbxwO45RKDjznhupsn6mu+looE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQMG3HWzrjPcYXWu7WmO2y8k1V1F4f6sxH+FRGkJWTqGih5FBlDZvp9BgOIOlYU1Z
         4QgHZ2qpmZooUmEXmtKwIDi31lvO11D4zxeDMuHql8SS2aFdKpNZRaE/zlWFfWUkjj
         iSN8R5r9B1mT3AKVcvkM/LzU6FCkPRVxbA6GJkUU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 166/244] leds: trigger: ledtrig-cpu:: Fix output may be truncated issue for cpu
Date:   Wed, 15 Nov 2023 15:35:58 -0500
Message-ID: <20231115203558.315741180@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit ff50f53276131a3059e8307d11293af388ed2bcd ]

In order to teach the compiler that 'trig->name' will never be truncated,
we need to tell it that 'cpu' is not negative.

When building with W=1, this fixes the following warnings:

  drivers/leds/trigger/ledtrig-cpu.c: In function ‘ledtrig_cpu_init’:
  drivers/leds/trigger/ledtrig-cpu.c:155:56: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 5 [-Werror=format-truncation=]
    155 |                 snprintf(trig->name, MAX_NAME_LEN, "cpu%d", cpu);
        |                                                        ^~
  drivers/leds/trigger/ledtrig-cpu.c:155:52: note: directive argument in the range [-2147483648, 7]
    155 |                 snprintf(trig->name, MAX_NAME_LEN, "cpu%d", cpu);
        |                                                    ^~~~~~~
  drivers/leds/trigger/ledtrig-cpu.c:155:17: note: ‘snprintf’ output between 5 and 15 bytes into a destination of size 8
    155 |                 snprintf(trig->name, MAX_NAME_LEN, "cpu%d", cpu);
        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 8f88731d052d ("led-triggers: create a trigger for CPU activity")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/3f4be7a99933cf8566e630da54f6ab913caac432.1695453322.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/trigger/ledtrig-cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-cpu.c b/drivers/leds/trigger/ledtrig-cpu.c
index 8af4f9bb9cde8..05848a2fecff6 100644
--- a/drivers/leds/trigger/ledtrig-cpu.c
+++ b/drivers/leds/trigger/ledtrig-cpu.c
@@ -130,7 +130,7 @@ static int ledtrig_prepare_down_cpu(unsigned int cpu)
 
 static int __init ledtrig_cpu_init(void)
 {
-	int cpu;
+	unsigned int cpu;
 	int ret;
 
 	/* Supports up to 9999 cpu cores */
@@ -152,7 +152,7 @@ static int __init ledtrig_cpu_init(void)
 		if (cpu >= 8)
 			continue;
 
-		snprintf(trig->name, MAX_NAME_LEN, "cpu%d", cpu);
+		snprintf(trig->name, MAX_NAME_LEN, "cpu%u", cpu);
 
 		led_trigger_register_simple(trig->name, &trig->_trig);
 	}
-- 
2.42.0



