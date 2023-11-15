Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5337ED6CD
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344305AbjKOWDi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344235AbjKOWDi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:03:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54D3193
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:03:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C288C433C8;
        Wed, 15 Nov 2023 22:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085814;
        bh=4rC5nRQHlq0unqQgjqS8qQCx+udErukNvtHHNuF0SJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PNcZBtkUa5r1lsIX6iLK2MHnqGIbaomYlG/8nJDCFm7oUm658kkKQybTdC4jLHl8v
         j4qBZOAb8J2BuvbAa27movgBXB4h+5Au9+Y1V5y1nZCAxtVNVgmZ2AzgvA6skZ+RY1
         ytI+dLRqozwjYyMfwqrPW0c769GVWV46vhyo/oFA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pavel Machek <pavel@ucw.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 070/119] ledtrig-cpu: Limit to 8 CPUs
Date:   Wed, 15 Nov 2023 17:01:00 -0500
Message-ID: <20231115220134.813826591@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
References: <20231115220132.607437515@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Machek <pavel@ucw.cz>

[ Upstream commit abcc131292aa8c7de2c5f0ed76a717436c21de63 ]

Some machines have thousands of CPUs... and trigger mechanisms was not
really meant for thousands of triggers. I doubt anyone uses this
trigger on many-CPU machine; but if they do, they'll need to do it
properly.

Signed-off-by: Pavel Machek <pavel@ucw.cz>
Stable-dep-of: ff50f5327613 ("leds: trigger: ledtrig-cpu:: Fix 'output may be truncated' issue for 'cpu'")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/trigger/ledtrig-cpu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-cpu.c b/drivers/leds/trigger/ledtrig-cpu.c
index 869976d1b734e..fca62d5035909 100644
--- a/drivers/leds/trigger/ledtrig-cpu.c
+++ b/drivers/leds/trigger/ledtrig-cpu.c
@@ -2,14 +2,18 @@
 /*
  * ledtrig-cpu.c - LED trigger based on CPU activity
  *
- * This LED trigger will be registered for each possible CPU and named as
- * cpu0, cpu1, cpu2, cpu3, etc.
+ * This LED trigger will be registered for first 8 CPUs and named
+ * as cpu0..cpu7. There's additional trigger called cpu that
+ * is on when any CPU is active.
+ *
+ * If you want support for arbitrary number of CPUs, make it one trigger,
+ * with additional sysfs file selecting which CPU to watch.
  *
  * It can be bound to any LED just like other triggers using either a
  * board file or via sysfs interface.
  *
  * An API named ledtrig_cpu is exported for any user, who want to add CPU
- * activity indication in their code
+ * activity indication in their code.
  *
  * Copyright 2011 Linus Walleij <linus.walleij@linaro.org>
  * Copyright 2011 - 2012 Bryan Wu <bryan.wu@canonical.com>
@@ -145,6 +149,9 @@ static int __init ledtrig_cpu_init(void)
 	for_each_possible_cpu(cpu) {
 		struct led_trigger_cpu *trig = &per_cpu(cpu_trig, cpu);
 
+		if (cpu >= 8)
+			continue;
+
 		snprintf(trig->name, MAX_NAME_LEN, "cpu%d", cpu);
 
 		led_trigger_register_simple(trig->name, &trig->_trig);
-- 
2.42.0



