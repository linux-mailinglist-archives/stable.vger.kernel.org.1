Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AF475D45D
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjGUTUX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjGUTUW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF08273F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3440A61B1C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47674C433C8;
        Fri, 21 Jul 2023 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967218;
        bh=8ryoyp9p1FLTIgoJ7+V29JsBT72Rm9wfJiO8W22obeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yDU5cSxxNSLrXiJ+zjDrOO47k/3UXm6gh1vkREaIbd+KOtzOGcerZZoeo0mzT4Fy5
         IDsIMQGrmp0+4kCpB0WPP0vKlJQy4JN84phlXr/X5SnP/oD2HJG1htPvjsh7FvVFM+
         DPQsiirPcN+entJDvlzWpewg9yBRR8de8saD16V8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jan Visser <starquake@linuxeverywhere.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6.1 086/223] pinctrl: amd: Drop pull up select configuration
Date:   Fri, 21 Jul 2023 18:05:39 +0200
Message-ID: <20230721160524.529997746@linuxfoundation.org>
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

commit 3f62312d04d4c68aace9cd06fc135e09573325f3 upstream.

pinctrl-amd currently tries to program bit 19 of all GPIOs to select
either a 4kΩ or 8hΩ pull up, but this isn't what bit 19 does.  Bit
19 is marked as reserved, even in the latest platforms documentation.

Drop this programming functionality.

Tested-by: Jan Visser <starquake@linuxeverywhere.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20230705133005.577-4-mario.limonciello@amd.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-amd.c |   16 ++++------------
 drivers/pinctrl/pinctrl-amd.h |    1 -
 2 files changed, 4 insertions(+), 13 deletions(-)

--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -209,7 +209,6 @@ static void amd_gpio_dbg_show(struct seq
 	char *pin_sts;
 	char *interrupt_sts;
 	char *wake_sts;
-	char *pull_up_sel;
 	char *orientation;
 	char debounce_value[40];
 	char *debounce_enable;
@@ -317,14 +316,9 @@ static void amd_gpio_dbg_show(struct seq
 			seq_printf(s, "   %s|", wake_sts);
 
 			if (pin_reg & BIT(PULL_UP_ENABLE_OFF)) {
-				if (pin_reg & BIT(PULL_UP_SEL_OFF))
-					pull_up_sel = "8k";
-				else
-					pull_up_sel = "4k";
-				seq_printf(s, "%s ↑|",
-					   pull_up_sel);
+				seq_puts(s, "  ↑ |");
 			} else if (pin_reg & BIT(PULL_DOWN_ENABLE_OFF)) {
-				seq_puts(s, "   ↓|");
+				seq_puts(s, "  ↓ |");
 			} else  {
 				seq_puts(s, "    |");
 			}
@@ -751,7 +745,7 @@ static int amd_pinconf_get(struct pinctr
 		break;
 
 	case PIN_CONFIG_BIAS_PULL_UP:
-		arg = (pin_reg >> PULL_UP_SEL_OFF) & (BIT(0) | BIT(1));
+		arg = (pin_reg >> PULL_UP_ENABLE_OFF) & BIT(0);
 		break;
 
 	case PIN_CONFIG_DRIVE_STRENGTH:
@@ -798,10 +792,8 @@ static int amd_pinconf_set(struct pinctr
 			break;
 
 		case PIN_CONFIG_BIAS_PULL_UP:
-			pin_reg &= ~BIT(PULL_UP_SEL_OFF);
-			pin_reg |= (arg & BIT(0)) << PULL_UP_SEL_OFF;
 			pin_reg &= ~BIT(PULL_UP_ENABLE_OFF);
-			pin_reg |= ((arg>>1) & BIT(0)) << PULL_UP_ENABLE_OFF;
+			pin_reg |= (arg & BIT(0)) << PULL_UP_ENABLE_OFF;
 			break;
 
 		case PIN_CONFIG_DRIVE_STRENGTH:
--- a/drivers/pinctrl/pinctrl-amd.h
+++ b/drivers/pinctrl/pinctrl-amd.h
@@ -36,7 +36,6 @@
 #define WAKE_CNTRL_OFF_S4               15
 #define PIN_STS_OFF			16
 #define DRV_STRENGTH_SEL_OFF		17
-#define PULL_UP_SEL_OFF			19
 #define PULL_UP_ENABLE_OFF		20
 #define PULL_DOWN_ENABLE_OFF		21
 #define OUTPUT_VALUE_OFF		22


