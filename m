Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F38C7B89B5
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244254AbjJDS22 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244255AbjJDS21 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:28:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BFCAD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:28:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5282C433C8;
        Wed,  4 Oct 2023 18:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444103;
        bh=O4LO/nFypCQIteAlN6GOiYD1lgWrpbC23MqEOUzTGz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kvLK5tH9RHKzXH7GPCl0zJiK5FNFiQ7HqyWF7X1BopSjePQ34WlqWiTUgZj6K9CPa
         9iMvyKHUHZUADQD8eQoykVeSks5NnDOS1TszWheq8c60kb8LO2R/reDQALjYjSVTO0
         ycF2ohrSLn4XHCjVWLHqPVRh+fM6EMjgXeOII6I0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dhruva Gole <d-gole@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 132/321] bus: ti-sysc: Fix SYSC_QUIRK_SWSUP_SIDLE_ACT handling for uart wake-up
Date:   Wed,  4 Oct 2023 19:54:37 +0200
Message-ID: <20231004175235.346912668@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit e5deb8f76e64d94ccef715e75ebafffd0c312d80 ]

The uarts should be tagged with SYSC_QUIRK_SWSUP_SIDLE instead of
SYSC_QUIRK_SWSUP_SIDLE_ACT. The difference is that SYSC_QUIRK_SWSUP_SIDLE
is used to force idle target modules rather than block idle during usage.

The SYSC_QUIRK_SWSUP_SIDLE_ACT should disable autoidle and wake-up when
a target module is active, and configure autoidle and wake-up when a
target module is inactive. We are missing configuring the target module
on sysc_disable_module(), and missing toggling of the wake-up bit.

Let's fix the issue to allow uart wake-up to work.

Fixes: fb685f1c190e ("bus: ti-sysc: Handle swsup idle mode quirks")
Tested-by: Dhruva Gole <d-gole@ti.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 00ee7cc8248af..27c5bae85adc2 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1097,6 +1097,11 @@ static int sysc_enable_module(struct device *dev)
 	if (ddata->cfg.quirks & (SYSC_QUIRK_SWSUP_SIDLE |
 				 SYSC_QUIRK_SWSUP_SIDLE_ACT)) {
 		best_mode = SYSC_IDLE_NO;
+
+		/* Clear WAKEUP */
+		if (regbits->enwkup_shift >= 0 &&
+		    ddata->cfg.sysc_val & BIT(regbits->enwkup_shift))
+			reg &= ~BIT(regbits->enwkup_shift);
 	} else {
 		best_mode = fls(ddata->cfg.sidlemodes) - 1;
 		if (best_mode > SYSC_IDLE_MASK) {
@@ -1224,6 +1229,13 @@ static int sysc_disable_module(struct device *dev)
 		}
 	}
 
+	if (ddata->cfg.quirks & SYSC_QUIRK_SWSUP_SIDLE_ACT) {
+		/* Set WAKEUP */
+		if (regbits->enwkup_shift >= 0 &&
+		    ddata->cfg.sysc_val & BIT(regbits->enwkup_shift))
+			reg |= BIT(regbits->enwkup_shift);
+	}
+
 	reg &= ~(SYSC_IDLE_MASK << regbits->sidle_shift);
 	reg |= best_mode << regbits->sidle_shift;
 	if (regbits->autoidle_shift >= 0 &&
@@ -1518,16 +1530,16 @@ struct sysc_revision_quirk {
 static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	/* These drivers need to be fixed to not use pm_runtime_irq_safe() */
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000046, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000052, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	/* Uarts on omap4 and later */
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x50411e03, 0xffff00ff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47422e03, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47424e03, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 
 	/* Quirks that need to be set based on the module address */
 	SYSC_QUIRK("mcpdm", 0x40132000, 0, 0x10, -ENODEV, 0x50000800, 0xffffffff,
-- 
2.40.1



