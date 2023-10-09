Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814007BE069
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377328AbjJINjv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377331AbjJINjt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:39:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE39CF
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:39:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6B6C433B7;
        Mon,  9 Oct 2023 13:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858785;
        bh=i04vgsjDH+JatnqxBrVbzVKb3swo5tEml8CjahMrnOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DIvynnKWo+lgQA+OmbTuYoMkRRfanJ98/W1ZB5n+PGT6Y5blwzaxs1IGbuM5pJA/+
         q6H0GZH6RKx2usLaq2w+IqCECToKc5eqd+0JuxfJzLmVyZ1aOmUtlUN1OqOzCI9SzQ
         NF8nEra/P8GvDydDx2WlAczgDO06rvONtfGbKcEU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dhruva Gole <d-gole@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 100/226] bus: ti-sysc: Fix SYSC_QUIRK_SWSUP_SIDLE_ACT handling for uart wake-up
Date:   Mon,  9 Oct 2023 15:01:01 +0200
Message-ID: <20231009130129.390397418@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 5dba06ed61bf8..ef8c7bfd79a8f 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1114,6 +1114,11 @@ static int sysc_enable_module(struct device *dev)
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
@@ -1234,6 +1239,13 @@ static int sysc_disable_module(struct device *dev)
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
@@ -1497,16 +1509,16 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	SYSC_QUIRK("smartreflex", 0, -ENODEV, 0x38, -ENODEV, 0x00000000, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
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



