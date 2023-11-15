Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBF17ED313
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjKOUqG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjKOUqE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:46:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529B71BC
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:46:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0E5C433C8;
        Wed, 15 Nov 2023 20:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081161;
        bh=BeqNORGcKWdYNrzgn4ycsLbZuMMNE3cr8PAZb//WP58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1lcZjImz13A/OGDikxO9dIyrSwu+a7AVyrVDYtKcBpZjECtOWRrSsz77+3CNQ2/B1
         9tgeB23zao7zK9645hwaq0hqvxK4IQOSLn+iBH7uGMtq1XBhxJ5pioysE1MDDCxIbe
         SAe8KzjhFMnF4yL5O1RrIWu4OmZzTKmMeima0B7c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pavel Machek <pavel@ucw.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 50/88] ledtrig-cpu: Limit to 8 CPUs
Date:   Wed, 15 Nov 2023 15:36:02 -0500
Message-ID: <20231115191429.167327925@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191426.221330369@linuxfoundation.org>
References: <20231115191426.221330369@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 66a6260919367..1fca1ad00c3b9 100644
--- a/drivers/leds/trigger/ledtrig-cpu.c
+++ b/drivers/leds/trigger/ledtrig-cpu.c
@@ -1,14 +1,18 @@
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
@@ -149,6 +153,9 @@ static int __init ledtrig_cpu_init(void)
 	for_each_possible_cpu(cpu) {
 		struct led_trigger_cpu *trig = &per_cpu(cpu_trig, cpu);
 
+		if (cpu >= 8)
+			continue;
+
 		snprintf(trig->name, MAX_NAME_LEN, "cpu%d", cpu);
 
 		led_trigger_register_simple(trig->name, &trig->_trig);
-- 
2.42.0



