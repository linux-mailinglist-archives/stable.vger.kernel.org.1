Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E9D788E36
	for <lists+stable@lfdr.de>; Fri, 25 Aug 2023 20:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjHYSJl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 25 Aug 2023 14:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjHYSJe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 25 Aug 2023 14:09:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49032685;
        Fri, 25 Aug 2023 11:09:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56B6A65B6C;
        Fri, 25 Aug 2023 18:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9700C433C7;
        Fri, 25 Aug 2023 18:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692986971;
        bh=3h9/Ebs5p7iL789VesMcGrC+4uZ9dac5SCMwKpEeJYE=;
        h=From:To:Cc:Subject:Date:From;
        b=Ei4axnRTcr7SO6lIMlrfzm3ZwcNZzLOtxWj7MeDBZQoHhNfH93V7C4ytEJqbqKug+
         7Yt3I1r6yMx3uRMmcX0Kr+kNw2kplOS6HGwTOB6ElUmKGda18oZD8wRGk7W4XvHnsy
         hW1uqI37KOwAY+7LB1dEbJKgaqQHpLsFAkU0iMOD6kI+6Qc7ZqPslbxi6fHDqA4H91
         Sr+jq7NF/9Hy1H4LOxmjLmW+xXoMd8J+LQpWf2j520Y9+4gSdwmq6ayP+4aWUGE2aZ
         qV0oc0DPhhOXMTmScwaaObDNvtxBkZynjSf6VjFaQtcWS+aROtOR3G1l1eCcr1Kd4T
         rl17WdLEF5Uiw==
From:   deller@kernel.org
To:     linux-parisc@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, stable@vger.kernel.org
Subject: [PATCH 1/3] parisc: led: Reduce CPU overhead for disk & lan LED computation
Date:   Fri, 25 Aug 2023 20:09:26 +0200
Message-ID: <20230825180928.205499-1-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
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

From: Helge Deller <deller@gmx.de>

Older PA-RISC machines have LEDs which show the disk- and LAN-activity.
The computation is done in software and takes quite some time, e.g. on a
J6500 this may take up to 60% time of one CPU if the machine is loaded
via network traffic.

Since most people don't care about the LEDs, start with LEDs disabled and
just show a CPU heartbeat LED. The disk and LAN LEDs can be turned on
manually via /proc/pdc/led.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org>
---
 drivers/parisc/led.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/parisc/led.c b/drivers/parisc/led.c
index 8bdc5e043831..765f19608f60 100644
--- a/drivers/parisc/led.c
+++ b/drivers/parisc/led.c
@@ -56,8 +56,8 @@
 static int led_type __read_mostly = -1;
 static unsigned char lastleds;	/* LED state from most recent update */
 static unsigned int led_heartbeat __read_mostly = 1;
-static unsigned int led_diskio    __read_mostly = 1;
-static unsigned int led_lanrxtx   __read_mostly = 1;
+static unsigned int led_diskio    __read_mostly;
+static unsigned int led_lanrxtx   __read_mostly;
 static char lcd_text[32]          __read_mostly;
 static char lcd_text_default[32]  __read_mostly;
 static int  lcd_no_led_support    __read_mostly = 0; /* KittyHawk doesn't support LED on its LCD */
@@ -589,6 +589,9 @@ int __init register_led_driver(int model, unsigned long cmd_reg, unsigned long d
 		return 1;
 	}
 	
+	pr_info("LED: Enable disk and LAN activity LEDs "
+		"via /proc/pdc/led\n");
+
 	/* mark the LCD/LED driver now as initialized and 
 	 * register to the reboot notifier chain */
 	initialized++;
-- 
2.41.0

