Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAE375D475
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjGUTVd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjGUTV2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:21:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FC71727
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:21:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC20661D6D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D7FC433C8;
        Fri, 21 Jul 2023 19:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967278;
        bh=hlxwbAxZHnNv3G2CKMRV4ejAE0sEv3+SY+Nix9/tL7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z8N92/K9Ir8v8BoZ1CdEWEg8qK9cbz3pNQ2zloipb4SCmAyByAns3pbaTciyK1zhF
         ipWB4xUhC+v+GEWbhG4sCnX6Z8SAO7OKl8e7rxN+EdzTCAqqfoyFJXzawIYfdJFTml
         zaAS/AtA/gRKyELag3Uree+PTyK4ziqkG3YfhDv8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6.1 079/223] pinctrl: amd: Add fields for interrupt status and wake status
Date:   Fri, 21 Jul 2023 18:05:32 +0200
Message-ID: <20230721160524.230930854@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

commit 010f493d90ee1dbc32fa1ce51398f20d494c20c2 upstream.

If the firmware has misconfigured a GPIO it may cause interrupt
status or wake status bits to be set and not asserted. Add these
to debug output to catch this case.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20230328174231.8924-3-mario.limonciello@amd.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-amd.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -211,6 +211,8 @@ static void amd_gpio_dbg_show(struct seq
 	char *wake_cntrl1;
 	char *wake_cntrl2;
 	char *pin_sts;
+	char *interrupt_sts;
+	char *wake_sts;
 	char *pull_up_sel;
 	char *orientation;
 	char debounce_value[40];
@@ -243,7 +245,7 @@ static void amd_gpio_dbg_show(struct seq
 			continue;
 		}
 		seq_printf(s, "GPIO bank%d\n", bank);
-		seq_puts(s, "gpio\tint|active|trigger|S0i3| S3|S4/S5| Z|wake|pull|  orient|       debounce|reg\n");
+		seq_puts(s, "gpio\t  int|active|trigger|S0i3| S3|S4/S5| Z|wake|pull|  orient|       debounce|reg\n");
 		for (; i < pin_num; i++) {
 			seq_printf(s, "#%d\t", i);
 			raw_spin_lock_irqsave(&gpio_dev->lock, flags);
@@ -274,12 +276,18 @@ static void amd_gpio_dbg_show(struct seq
 				else
 					interrupt_mask = "😷";
 
-				seq_printf(s, "%s|     %s|  %s|",
+				if (pin_reg & BIT(INTERRUPT_STS_OFF))
+					interrupt_sts = "🔥";
+				else
+					interrupt_sts = "  ";
+
+				seq_printf(s, "%s %s|     %s|  %s|",
+				   interrupt_sts,
 				   interrupt_mask,
 				   active_level,
 				   level_trig);
 			} else
-				seq_puts(s, "  ∅|      |       |");
+				seq_puts(s, "    ∅|      |       |");
 
 			if (pin_reg & BIT(WAKE_CNTRL_OFF_S0I3))
 				wake_cntrl0 = "⏰";
@@ -305,6 +313,12 @@ static void amd_gpio_dbg_show(struct seq
 				wake_cntrlz = "  ";
 			seq_printf(s, "%s|", wake_cntrlz);
 
+			if (pin_reg & BIT(WAKE_STS_OFF))
+				wake_sts = "🔥";
+			else
+				wake_sts = " ";
+			seq_printf(s, "   %s|", wake_sts);
+
 			if (pin_reg & BIT(PULL_UP_ENABLE_OFF)) {
 				if (pin_reg & BIT(PULL_UP_SEL_OFF))
 					pull_up_sel = "8k";


