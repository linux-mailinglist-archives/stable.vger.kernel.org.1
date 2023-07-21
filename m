Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5C075D467
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjGUTU4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjGUTUu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:20:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDCF2D45
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A23A461D54
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF500C433C8;
        Fri, 21 Jul 2023 19:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967247;
        bh=jzLWWHc7xTJ2XkJrLS8uNpnBTKOp1HB5GDhHbN3jPPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PHYElsCBNiNi/jIKPEjQvjzGzG+ZfzA5LGVh3mSJxR8LCGRLwqU/5aCRKhb7pT8PB
         G93GphGTAMRgEhoZnmjv6P7Ry8wR/6GFYMrk8vlaDipkeZPuaPxKxDHsZ9T0nhs3J7
         6wmI4Wg9kPwxmYurVaZ/aRoHHkC/y6CrQtC7gtYg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6.1 078/223] pinctrl: amd: Adjust debugfs output
Date:   Fri, 21 Jul 2023 18:05:31 +0200
Message-ID: <20230721160524.188874591@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

commit 75358cf3319d5fed595946019deda5c2c26a203d upstream.

More fields are to be added, so to keep the display from being
too busy, adjust it.

1) Add a header to all columns
2) Except for interrupt, when fields have no data show empty
3) Remove otherwise blank whitespace

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20230328174231.8924-2-mario.limonciello@amd.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-amd.c |   76 ++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 46 deletions(-)

--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -206,15 +206,12 @@ static void amd_gpio_dbg_show(struct seq
 
 	char *level_trig;
 	char *active_level;
-	char *interrupt_enable;
 	char *interrupt_mask;
 	char *wake_cntrl0;
 	char *wake_cntrl1;
 	char *wake_cntrl2;
 	char *pin_sts;
 	char *pull_up_sel;
-	char *pull_up_enable;
-	char *pull_down_enable;
 	char *orientation;
 	char debounce_value[40];
 	char *debounce_enable;
@@ -246,6 +243,7 @@ static void amd_gpio_dbg_show(struct seq
 			continue;
 		}
 		seq_printf(s, "GPIO bank%d\n", bank);
+		seq_puts(s, "gpio\tint|active|trigger|S0i3| S3|S4/S5| Z|wake|pull|  orient|       debounce|reg\n");
 		for (; i < pin_num; i++) {
 			seq_printf(s, "#%d\t", i);
 			raw_spin_lock_irqsave(&gpio_dev->lock, flags);
@@ -255,7 +253,6 @@ static void amd_gpio_dbg_show(struct seq
 			if (pin_reg & BIT(INTERRUPT_ENABLE_OFF)) {
 				u8 level = (pin_reg >> ACTIVE_LEVEL_OFF) &
 						ACTIVE_LEVEL_MASK;
-				interrupt_enable = "+";
 
 				if (level == ACTIVE_LEVEL_HIGH)
 					active_level = "↑";
@@ -272,65 +269,54 @@ static void amd_gpio_dbg_show(struct seq
 				else
 					level_trig = " edge";
 
-			} else {
-				interrupt_enable = "∅";
-				active_level = "∅";
-				level_trig = "    ∅";
-			}
+				if (pin_reg & BIT(INTERRUPT_MASK_OFF))
+					interrupt_mask = "😛";
+				else
+					interrupt_mask = "😷";
 
-			if (pin_reg & BIT(INTERRUPT_MASK_OFF))
-				interrupt_mask = "😛";
-			else
-				interrupt_mask = "😷";
-			seq_printf(s, "int %s (%s)| active-%s| %s-⚡| ",
-				   interrupt_enable,
+				seq_printf(s, "%s|     %s|  %s|",
 				   interrupt_mask,
 				   active_level,
 				   level_trig);
+			} else
+				seq_puts(s, "  ∅|      |       |");
 
 			if (pin_reg & BIT(WAKE_CNTRL_OFF_S0I3))
 				wake_cntrl0 = "⏰";
 			else
-				wake_cntrl0 = " ∅";
-			seq_printf(s, "S0i3 %s| ", wake_cntrl0);
+				wake_cntrl0 = "  ";
+			seq_printf(s, "  %s| ", wake_cntrl0);
 
 			if (pin_reg & BIT(WAKE_CNTRL_OFF_S3))
 				wake_cntrl1 = "⏰";
 			else
-				wake_cntrl1 = " ∅";
-			seq_printf(s, "S3 %s| ", wake_cntrl1);
+				wake_cntrl1 = "  ";
+			seq_printf(s, "%s|", wake_cntrl1);
 
 			if (pin_reg & BIT(WAKE_CNTRL_OFF_S4))
 				wake_cntrl2 = "⏰";
 			else
-				wake_cntrl2 = " ∅";
-			seq_printf(s, "S4/S5 %s| ", wake_cntrl2);
+				wake_cntrl2 = "  ";
+			seq_printf(s, "   %s|", wake_cntrl2);
 
 			if (pin_reg & BIT(WAKECNTRL_Z_OFF))
 				wake_cntrlz = "⏰";
 			else
-				wake_cntrlz = " ∅";
-			seq_printf(s, "Z %s| ", wake_cntrlz);
+				wake_cntrlz = "  ";
+			seq_printf(s, "%s|", wake_cntrlz);
 
 			if (pin_reg & BIT(PULL_UP_ENABLE_OFF)) {
-				pull_up_enable = "+";
 				if (pin_reg & BIT(PULL_UP_SEL_OFF))
 					pull_up_sel = "8k";
 				else
 					pull_up_sel = "4k";
-			} else {
-				pull_up_enable = "∅";
-				pull_up_sel = "  ";
+				seq_printf(s, "%s ↑|",
+					   pull_up_sel);
+			} else if (pin_reg & BIT(PULL_DOWN_ENABLE_OFF)) {
+				seq_puts(s, "   ↓|");
+			} else  {
+				seq_puts(s, "    |");
 			}
-			seq_printf(s, "pull-↑ %s (%s)| ",
-				   pull_up_enable,
-				   pull_up_sel);
-
-			if (pin_reg & BIT(PULL_DOWN_ENABLE_OFF))
-				pull_down_enable = "+";
-			else
-				pull_down_enable = "∅";
-			seq_printf(s, "pull-↓ %s| ", pull_down_enable);
 
 			if (pin_reg & BIT(OUTPUT_ENABLE_OFF)) {
 				pin_sts = "output";
@@ -345,7 +331,7 @@ static void amd_gpio_dbg_show(struct seq
 				else
 					orientation = "↓";
 			}
-			seq_printf(s, "%s %s| ", pin_sts, orientation);
+			seq_printf(s, "%s %s|", pin_sts, orientation);
 
 			db_cntrl = (DB_CNTRl_MASK << DB_CNTRL_OFF) & pin_reg;
 			if (db_cntrl) {
@@ -364,19 +350,17 @@ static void amd_gpio_dbg_show(struct seq
 						unit = 61;
 				}
 				if ((DB_TYPE_REMOVE_GLITCH << DB_CNTRL_OFF) == db_cntrl)
-					debounce_enable = "b +";
+					debounce_enable = "b";
 				else if ((DB_TYPE_PRESERVE_LOW_GLITCH << DB_CNTRL_OFF) == db_cntrl)
-					debounce_enable = "↓ +";
+					debounce_enable = "↓";
 				else
-					debounce_enable = "↑ +";
-
+					debounce_enable = "↑";
+				snprintf(debounce_value, sizeof(debounce_value), "%06u", time * unit);
+				seq_printf(s, "%s (🕑 %sus)|", debounce_enable, debounce_value);
 			} else {
-				debounce_enable = "  ∅";
-				time = 0;
+				seq_puts(s, "               |");
 			}
-			snprintf(debounce_value, sizeof(debounce_value), "%u", time * unit);
-			seq_printf(s, "debounce %s (🕑 %sus)| ", debounce_enable, debounce_value);
-			seq_printf(s, " 0x%x\n", pin_reg);
+			seq_printf(s, "0x%x\n", pin_reg);
 		}
 	}
 }


